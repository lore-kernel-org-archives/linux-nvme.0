From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 18 Jul 2017 15:13:10 -0600
Subject: [PATCH] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <20170713073500.GD12984@lst.de>
References: <20170712221101.1715-1-jonathan.derrick@intel.com>
 <20170713073500.GD12984@lst.de>
Message-ID: <8fcc46b3-558b-df7e-b875-fec445246029@intel.com>

On 07/13/2017 01:35 AM, Christoph Hellwig wrote:
> On Wed, Jul 12, 2017@04:11:01PM -0600, Jon Derrick wrote:
>> NVME's Timestamp feature allows controllers to be aware of the epoch
>> time in milliseconds. This patch adds the set features hook for various
>> transports. It also wires it up to the pci reset path, so that resets
>> and resumes can update the controller as necessary.
> 
> Please find a way to do this entirely from common code, currently you
> miss out on all the non-PCIe transports.
> 
>> +	u64 cur_ms;
>> +	u8 ts[8] = { 0, };
>> +	int status;
>> +	u32 result;
>> +
>> +	cur_ms = ktime_to_ms(ktime_get_real());
>> +	put_unaligned_le64(cur_ms, &ts[0]);
>> +
>> +	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, ts, 8,
> 
> I think this could simply be something like:
> 
> 	__le64 ts;
> 
> 	ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
> 	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, &ts,
> 			sizeof(ts),
> 
>> +			&result);
>> +	if (status < 0)
>> +		dev_warn_once(ctrl->device,
>> +			"could not set timestamp (%08x)\n", result);
>> +}
> 
> The Timestamp feature does not define a result, so you should just
> pass NULL for the result parameter.  And if you want to print something
> on error the status value is probably more useful.
> 
>> +	if (dev->ctrl.vs >= NVME_VS(1, 3, 0) &&
>> +	    dev->ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)
>> +		nvme_set_timestamp(&dev->ctrl);
> 
> No need to check for the version - NVMe TPs also apply to all previous
> versions if they are backwards compatible, which this one is.
> 

Thanks for the tips
