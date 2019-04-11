From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 Apr 2019 07:54:22 +0200
Subject: [PATCH] nvme: improve logging
In-Reply-To: <SN6PR04MB452763FD855023876A5C3AA5862E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190410141706.146455-1-hare@suse.de>
 <SN6PR04MB452763FD855023876A5C3AA5862E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <3de17b5d-0816-bbc8-fd55-95dae169f004@suse.de>

On 4/10/19 8:37 PM, Chaitanya Kulkarni wrote:
> On 04/10/2019 07:17 AM, Hannes Reinecke wrote:
>> Currently nvme is very reluctant if it comes to logging anything,
>> _unless_ it's an ANA AEN. So this patch tries to remedy this by
>> decreasing the priority for the ANA AEN logging message, and improve
>> the logging when calling nvme_reset_ctrl().
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>    drivers/nvme/host/core.c      | 44 +++++++++++++++++++++++++++++--------------
>>    drivers/nvme/host/multipath.c |  5 ++++-
>>    2 files changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 8d285bfcd352..98260b2c7a6f 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -94,6 +94,24 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>>    static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>    					   unsigned nsid);
>>
>> +static const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
>> +{
>> +	static const char *const state_name[] = {
>> +		[NVME_CTRL_NEW]		= "new",
>> +		[NVME_CTRL_LIVE]	= "live",
>> +		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
>> +		[NVME_CTRL_RESETTING]	= "resetting",
>> +		[NVME_CTRL_CONNECTING]	= "connecting",
>> +		[NVME_CTRL_DELETING]	= "deleting",
>> +		[NVME_CTRL_DEAD]	= "dead",
>> +	};
>> +
> I know initially this array was defined in the function, but now since
> we are making this change: all the state macors are present in the
> nvme.h, can you please declare this array near all the NVME_CTRL_XXX
> macros in the same file
> so it will be easier to maintain ?
>> +	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
> May be unsigned int in the above line to avoid any possible warnings ?
> Also it will be great if we can add WARN_ON()
> 
Hmm. Okay, will be doing so.

> if "if (unsigned)ctrl->state < ARRAY_SIZE(state_name)" -> false and
> return from there.
> 
>> +	    state_name[ctrl->state])
>> +		return state_name[ctrl->state];
>> +	return NULL;
>> +}
>> +
>>    static void nvme_set_queue_dying(struct nvme_ns *ns)
>>    {
>>    	/*
>> @@ -119,10 +137,17 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
>>
>>    int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>>    {
>> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
>> +		const char *state_name = nvme_ctrl_state_name(ctrl);
>> +
>> +		dev_warn(ctrl->device, "cannot reset ctrl in state %s\n",
>> +			 state_name ? state_name : "unknown");
>>    		return -EBUSY;
>> -	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>> +	}
>> +	if (!queue_work(nvme_reset_wq, &ctrl->reset_work)) {
>> +		dev_dbg(ctrl->device, "ctrl reset already queued\n");
>>    		return -EBUSY;
>> +	}
>>    	return 0;
>>    }
>>    EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
>> @@ -2971,19 +2996,10 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>>    				     char *buf)
>>    {
>>    	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -	static const char *const state_name[] = {
>> -		[NVME_CTRL_NEW]		= "new",
>> -		[NVME_CTRL_LIVE]	= "live",
>> -		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
>> -		[NVME_CTRL_RESETTING]	= "resetting",
>> -		[NVME_CTRL_CONNECTING]	= "connecting",
>> -		[NVME_CTRL_DELETING]	= "deleting",
>> -		[NVME_CTRL_DEAD]	= "dead",
>> -	};
>> +	const char *state_name = nvme_ctrl_state_name(ctrl);
>>
>> -	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
>> -	    state_name[ctrl->state])
>> -		return sprintf(buf, "%s\n", state_name[ctrl->state]);
>> +	if (state_name)
>> +		return sprintf(buf, "%s\n", state_name);
>>
>>    	return sprintf(buf, "unknown state\n");
>>    }
> 
> Can we move following change into the separate patch ?
> 
Sure.

Will be resending the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
