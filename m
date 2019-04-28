From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 28 Apr 2019 19:32:32 +0000
Subject: [PATCH 1/2] nvme: improve logging
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
 <20190425024041.17657-2-chaitanya.kulkarni@wdc.com>
 <20190428120546.GB9759@infradead.org>
Message-ID: <SN6PR04MB452781752A97CA874A973C7186380@SN6PR04MB4527.namprd04.prod.outlook.com>

On 4/28/19 5:05 AM, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019@07:40:40PM -0700, Chaitanya Kulkarni wrote:
>> Currently nvme is very reluctant if it comes to logging anything,
>> _unless_ it's an ANA AEN. So this patch tries to remedy this by
>> decreasing the priority for the ANA AEN logging message, and improve
>> the logging when calling nvme_reset_ctrl().
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> If this is originally from Hannes it also needs a From: tag in the
> body so that git attribute it to him.
> 
> Also please add a changelog vs Hannes v1 in the cover letter.
Okay.
> 
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
> 
> Can we move this array outside the function?  Yes, with the static
> it doesn't really make a difference, but it just feels nicer to me.
I've actually suggested that in my review but then it is static 
afterall. I'll move it to header near NVME_CTRL_XXX definitions.
Let me know if you prefer any other place.
> 
>> +	const char *state_name = nvme_ctrl_state_name(ctrl);
>>   
>> +	return sprintf(buf, "%s\n", state_name);
> 
> I don't think we even need the state_name local variable here.
> 
Okay, will send out next version.
