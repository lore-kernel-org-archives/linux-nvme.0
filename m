From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 12 May 2019 07:34:03 -0700
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <20190511072258.GB14764@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <20190511072258.GB14764@lst.de>
Message-ID: <efc9d481-d2cf-93bc-b640-849892421941@grimberg.me>


>> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
>> +{
>> +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_set_power);
>> +
>> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
>> +{
>> +	struct nvme_command c;
>> +	union nvme_result res;
>> +	int ret;
>> +
>> +	if (!result)
>> +		return -EINVAL;
>> +
>> +	memset(&c, 0, sizeof(c));
>> +	c.features.opcode = nvme_admin_get_features;
>> +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
>> +
>> +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
>> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
>> +	if (ret >= 0)
>> +		*result = le32_to_cpu(res.u32);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_get_power);
> 
> At this point I'd rather see those in the PCIe driver.  While the
> power state feature is generic in the spec I don't see it actually
> being used anytime anywhere else any time soon.
> 
> But maybe we can add a nvme_get_features helper ala nvme_set_features
> in the core to avoid a little boilerplate code for the future?

+1 on this comment.
