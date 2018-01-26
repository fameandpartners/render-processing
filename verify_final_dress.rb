dress_id = ARGV.first

results = `aws s3 ls s3://mkt-fameandpartners/renders/composites/fp-dr1005-102/800x800`

results = results.split("\n")
puts results.count
