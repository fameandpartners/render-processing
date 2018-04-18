## Purpose
The purpose of these scripts was two fold.  First there are a set of scripts that were dedicated to moving raw renders into Caddy, in their individual pieces.  Second there are a set of scripts dedicated to combining all of the raw renders, which are just pieces of a complete render, together into a complete set of images representing all possible combinations.  This second case also outputs a number of different cuts for use on the website. 

Please note that all of this is based on the pre-heirarchy model for customizing bridesmaids dresses and will need to be radically re-written to make work with the heirarchical based customization system now being used by the bridesmaids project.

## AMI
All of these scritps are meant to run on a specific AMI snapshot stored in the Northern California AWS Region.  The latest version of this instance is called "20180123 Image Processing".  They were being launched on at least m5.xlarge due to their high bandwidth requirements for downloading files from dropbox and uploading files to s3.  At one point there were a dozen instances running all processing files in parallel.

Please not that after reconstituting one of these boxes the connect information from AWS says you can ssh in using root but you can't, you have to connect as ubuntu.

### Dropbox
Dropbox is connected to this machine (as Doug's user).  It's managed by the dropbox script (/usr/bin/dropbox).  Upon connection it's a good idea to do a "dropbox start" and then a "dropbox status" to see how far behind it is.  Dropbox has been configured to only mount Dave's render directories - they use a massive amount of disk space.  Disk space should be carefully monitored on these boxes as it's easy to run out (even though they 700G+ mounted).

### Fuse
The s3 bucket for the renders is mounted via fuse in ~/s3.  Fuse is very tempermental / slow and should only be used for careful browsing and individual file manipulation.  Fuse normally starts in a bad state.  So upon connecting you have to do a "sudo umount -l s3" followed by a "sudo mount -l s3".

### AWS CLI
All mass manipulation of S3 should be done through the AWS CLI.  This is the most performant way to do any of these mass file manipulations.  The basic pattern that is used is generate image files to local disk, then sync using the aws cli to s3.  The AWS CLI is already configured on this machine.  

#### Examples of Useful commands
`aws s3 ls s3://mkt-fameandpartners/renders/`

`aws s3 sync . s3://mkt-fameandpartners/renders/composites/fp-dr1003-102/800x800`

### Git
Git is installed and the keys are setup to be connected to the git account "douglasjsellers".  Source changes were being synced to the directory ~/code/render-processing via Git.

## Render compression / combination process
Please keep in mind that this process will, most likely, need to be totally redone to work with the new bridesmaid heirarchy.


### Step 1: Getting individual render files into 
The goal of this step was to compress and organize the render files produced by Dave P. and his team to allow them to be referenced by Caddy.  Once this is done Caddy then simulated how the renders would look when they were combined for each Customization Combination.  Using this the individual render files could be QA'ed and changes could be made before the, expensive, process of combining them occurred.  Most of the problems revealed in this stage were related to the way that the indivual renderers (people) named the output files when conflicting combinations or layer combinations were needed.

Here was the basic process that was used:

1. Make a description file that tells all the scripts about the file.  See fp-dr1001-102.rb as an example.
2. Run compress-files.rb. Command looks something like this: `ruby compress-files.rb fp-dr1001-102 ./output`
3. Sync that output to s3. Command looks something like this: `aws s3 sync ./output/* s3://mkt-fameandpartners/renders/caddy/fp-dr1001-102`
4. You will need to generate a list of all of the render files to feed into the JSON generating script in the next step. There is a script to do this: list_all_files.rb.  Example command is: `ruby list_all_files.rb ~/Dropbox/renderfiles/Bridesmaid\ Collection/11.\ Models\ and\ Customisations/The\ Column\ Dress\ and\ Jump\ Suit/Rendered\ PNG\'s/TAKE\ SYSTEM\ 6K > all_files.txt`
4. JSON describing the images then needs to be imported into caddy. The JSON can be generated with the generate-json-from-images.rb script. Example command looks something like this: `ruby generate-json-from-images fp-dr1002-102 all_files.txt`. This will output a big blob of JSON that could be imported directly into Firebase to make Caddy work.

That's it. Your ready for QA. Simple.

### Step 2: Generating all the composite
Once all of the renders have been QA'ed then it's time to generate all of the composite files. The composite files are simply an image for every possible customization combination. This is a few hundred thousand files per style. Generally this process takes twelve to twenty four hours. 

Here was the basic process that was used:
1. Export all of the combinations for a style for a given height from Caddy to a CSV. See csvs/FP-DR1002-102-Ankle.csv for an example.
2. Modify squash.rb so that it imports the style that you want on line 1.
3. Run squash.rb on the csv. Command looks something like this: `ruby squash.rb ./csvs/FP-DR1002-102-Micro-Mini.csv micro_mini ./output ./temp`.  The temp directory is used for intermediate image magick files. The size is what is encoded into the final file name. This command takes forever so it helps to output the results to a log file, background process it and then disown it.
4. Sync the results to s3.  Command looks something like this: `aws s3 sync . s3://mkt-fameandpartners/renders/composites/fp-dr1003-102/800x800`. The output directory looks like whatever the front end is expecting
5. This process only generates the combination images, not the default images. To generate the default images you need to run render_default_images.rb. Command looks something like this: `ruby render_default_images.rb fp-dr1002-102 ./output`.
6. Then sync the resulting default images. Command looks something like this: `aws s3 sync . s3://mkt-fameandpartners/renders/composites/fp-dr1003-102/800x800`.

