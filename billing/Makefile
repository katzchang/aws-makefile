
dateformat := +%Y-%m-%dT00:00:00Z
start-time := $(shell date -u -d "7 days ago" $(dateformat))
end-time := $(shell date -u $(dateformat))

namespace := AWS/Billing
metric := EstimatedCharges
period := 86400
profile-option :=

get-estimated-charges:
	echo $(dateformat)
	aws cloudwatch get-metric-statistics $(profile-option) \
		--region us-east-1 \
		--namespace $(namespace) \
		--metric-name $(metric) \
		--start-time $(start-time) \
		--end-time $(end-time) \
		--period $(period) \
		--statistics "Maximum" \
		--dimensions Name=Currency,Value=USD \
		| jq '.Datapoints | sort_by(.Timestamp)'
