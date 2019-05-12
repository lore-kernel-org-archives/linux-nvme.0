From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 15:20:59 +0000
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190512143056.GA7761@minwooim-desktop>
Message-ID: <SN6PR04MB45276B524D255F667A6BE29E860E0@SN6PR04MB4527.namprd04.prod.outlook.com>

Disregard my comment.

On 5/12/19 7:31 AM, Minwoo Im wrote:
>>> +	union nvme_result res;
>>> +	int ret;
>>> +
>>> +	if (!result)
>>> +		return -EINVAL;
>>> +
>>> +	memset(&c, 0, sizeof(c));
>>> +	c.features.opcode = nvme_admin_get_features;
>>> +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
>>> +
>>> +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
>>> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
>>> +	if (ret >= 0)
>>> +		*result = le32_to_cpu(res.u32);
>> May be add a check for result here in above if before deref pointer :-
>> 	if (ret >= 0 && result)
>>
> 'result' already has been checked in a few lines above.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
