From: hare@suse.de (Hannes Reinecke)
Date: Sun, 13 May 2018 12:33:12 +0200
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180512133123.GA10849@lst.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de> <20180512133123.GA10849@lst.de>
Message-ID: <0b03084b-5206-a4e9-5788-e3fa7454f7f8@suse.de>

On 05/12/2018 03:31 PM, Christoph Hellwig wrote:
>> +static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> 
> Passing a ns to the function reading the ANA log doesn't make any
> sense.  The ANA log page is global to the controller, so we should
> only read it when rescanning the controller, or when the AER
> triggers.
> 
>> +static void nvme_get_full_ana_log(struct nvme_ctrl *ctrl)
>> +{
>> +	int i, j;
>> +	struct nvme_ns *ns;
>> +	struct nvmf_ana_rsp_page_header *ana_log;
>> +	size_t ana_log_size = 4096;
> 
> This needs to be size based on the MNAN and NANAGRPID fields.
> 
Yes, already fixed up for the next round.

>> +
>> +	ana_log = kzalloc(ana_log_size, GFP_KERNEL);
>> +	if (!ana_log)
>> +		return;
> 
> Please preallocate a per-controller buffer at controller scanning
> time for this.  By the time path changes hit we might be under
> sever memory pressure and want things to just work.
> 
Okay, will do.

>> +
>> +	if (nvme_get_log(ctrl, NVME_LOG_ANA, ana_log, ana_log_size))
>> +		dev_warn(ctrl->device,
>> +			 "Get ANA log error\n");
> 
> I think we need some sane error handling here.
> 
True; the next round will have an error handling here.

>> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
>> +		for (i = 0; i < ana_log->grpid_num; i++) {
>> +			struct nvmf_ana_group_descriptor *desc =
>> +				&ana_log->desc[i];
>> +			for (j = 0; j < desc->nsid_num; j++) {
>> +				if (desc->nsid[j] == ns->head->ns_id) {
>> +					ns->ana_state = desc->ana_state;
>> +					ns->ana_group = desc->groupid;
> 
> What protects us from concurrent updates?  You only hold the
> shared semaphore in the caller (which probably should move into
> the function to start with).
> 
I'll be moving the function to get the ANA log page to a workqueue, so 
we'll get an implicit serialisation from there.
And obviously we need to get the namespace mutex when traversing the 
list of namspaces.

>> +	if ((a == &dev_attr_ana_state.attr) ||
>> +	    (a == &dev_attr_ana_group.attr)) {
> 
> No need for the inner braces.
> 
Ok.

>> +	/* First round: select from all ANA optimized paths */
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> -		if (ns->ctrl->state == NVME_CTRL_LIVE) {
>> +		if (ns->ctrl->state == NVME_CTRL_LIVE &&
>> +		    ns->ana_state == NVME_ANA_STATE_OPTIMIZED) {
>> +			rcu_assign_pointer(head->current_path, ns);
>> +			return ns;
>> +		}
>> +	}
>> +	/* Second round: select from all ANA non-optimized paths */
>> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +		if (ns->ctrl->state == NVME_CTRL_LIVE &&
>> +		    ns->ana_state == NVME_ANA_STATE_NONOPTIMIZED) {
>>   			rcu_assign_pointer(head->current_path, ns);
>>   			return ns;
> 
> Based on the last setences in section 8.18.3.3 of the ANA spec
> we should also do a last restort attempt at inaccseesible paths.
> 
Okay; no problem with that.

> Also I think we should just pass the state to __nvme_find_path and
> retry in the caller to avoid code duplication.
> 
Hmm. Not sure if it that really simplifies things, but I'll have a look.

> Note that this code seems to miss any handling of the transitioning
> state and the error codes related to it, and also doesn't work around
> the nasty bit in the spec that allows inaccesible states to report
> incorrect capacity, which we'll need to work around by stealing that
> data from other namespaces.
> 
Yeah, that's particularly mean. I've added some code the nvmet, though, 
so we should be able to test this one.

Cheers,

Hannes
