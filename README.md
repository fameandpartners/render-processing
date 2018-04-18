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
