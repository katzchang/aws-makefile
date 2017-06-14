
aws-option :=
stream-name :=

timestamp=$(shell date -d '10 minute ago' +%Y-%m-%dT%H:%M:%S%:z)
shard-id=$(shell aws kinesis describe-stream $(aws-option) --stream-name $(stream-name) | jq -r ".StreamDescription.Shards[0].ShardId")

get-records: .$(stream-name).$(shard-id).iter
	aws kinesis get-records $(aws-option) \
	  --shard-iterator `cat $^` \
	  | jq -r ".Records[].Data" \
		| bash ./base64decode.sh \
		>> $(stream-name).data.log

.$(stream-name).$(shard-id).iter:
	aws kinesis get-shard-iterator $(aws-option) \
	  --stream-name $(stream-name) \
	  --shard-id $(shard-id) \
	  --shard-iterator-type AT_TIMESTAMP \
	  --timestamp $(timestamp) \
	| jq ".ShardIterator" \
	> $@

clean:
	rm -f .*.iter
