From: hare@suse.de (Hannes Reinecke)
Date: Sat, 5 May 2018 15:23:01 +0200
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <SN6PR06MB3984921468FB9721423BD0ED8C860@SN6PR06MB3984.namprd06.prod.outlook.com>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
 <SN6PR06MB3984921468FB9721423BD0ED8C860@SN6PR06MB3984.namprd06.prod.outlook.com>
Message-ID: <a5fa01aa-d4c4-1ada-cc99-d267250042cd@suse.de>

On 05/05/2018 12:11 AM, Schremmer, Steven wrote:
>>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>>   {
>> @@ -1488,6 +1489,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>>   		goto out;
>>   	}
>>
>> +	if (ctrl->subsys->cmic & (1 << 3))
>> +		nvme_get_ana_log(ctrl, ns);
>> +
> If __nvme_revalidate_disk() would save the groupid from the Identify Namespace data,
> then finding the ANA state in the log page could be done more quickly.
> 
Good idea. Will be doing it.

>>   	__nvme_revalidate_disk(disk, id);
>>   	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
>>   	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
>> @@ -2276,6 +2280,61 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>>   	return ret;
>>   }
>>
>> +static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
>> +{
>> +	int i, j;
>> +	struct nvmf_ana_rsp_page_header *ana_log;
>> +	size_t ana_log_size = 4096;
>> +
>> +	ana_log = kzalloc(ana_log_size, GFP_KERNEL);
>> +	if (!ana_log)
>> +		return;
>> +
>> +	if (nvme_get_log(ctrl, NVME_LOG_ANA, ana_log, ana_log_size))
>> +		dev_warn(ctrl->device,
>> +			 "Get ANA log error\n");
>> +	for (i = 0; i < ana_log->grpid_num; i++) {
>> +		struct nvmf_ana_group_descriptor *desc =
>> +			&ana_log->desc[i];
>> +		for (j = 0; j < desc->nsid_num; j++) {
>> +			if (desc->nsid[j] == ns->head->ns_id) {
>> +				ns->ana_state = desc->ana_state;
>> +				ns->ana_group = desc->groupid;
> Maybe jump out of the for loops here?
> 
Yes, should be doing so.

>> @@ -3370,6 +3485,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>>   	case NVME_AER_NOTICE_FW_ACT_STARTING:
>>   		queue_work(nvme_wq, &ctrl->fw_act_work);
>>   		break;
>> +	case NVME_AER_NOTICE_ANA_CHANGE:
>> +		dev_info(ctrl->device, "ANA state change\n");
>> +		queue_work(nvme_wq, &ctrl->ana_change_work);
>> +		break;
> I think eventually we'll need a way for the AER work to potentially force a call to
> __nvme_find_path() to choose a better current_path based on the updated ANA states.
> 
Actually, it should be sufficient to just unset the current path; the 
algorithm will find the next best path then.
But yes, true, we should be doing it.
(I had the Optimized/Inaccessible scenario in mind here; there the new 
path will be selected automatically as we'd be getting an error from the 
Inaccessible path. But for Optimized/non-optimized the new path won't be 
chosen automatically as the original path remains valid.)

Thanks for the hints.

Cheers,

Hannes
