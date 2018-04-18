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
3. Sync that output to s3. Command looks something like this: `aws s3 synce ./output/* s3://mkt-fameandpartners/renders/caddy/fp-dr1001-102`

That's it.  Caddy would automatically look in the outputted bucket structure so no changes were necessary on that side.
