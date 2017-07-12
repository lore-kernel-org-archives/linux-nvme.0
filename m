From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Jul 2017 19:24:26 -0400
Subject: [PATCH] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <20170712221101.1715-1-jonathan.derrick@intel.com>
References: <20170712221101.1715-1-jonathan.derrick@intel.com>
Message-ID: <20170712232425.GC8388@localhost.localdomain>

On Wed, Jul 12, 2017@04:11:01PM -0600, Jon Derrick wrote:
> +void nvme_set_timestamp(struct nvme_ctrl *ctrl)
> +{
> +	u64 cur_ms;
> +	u8 ts[8] = { 0, };
> +	int status;
> +	u32 result;
> +
> +	cur_ms = ktime_to_ms(ktime_get_real());
> +	put_unaligned_le64(cur_ms, &ts[0]);
> +
> +	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, ts, 8,
> +			&result);
> +	if (status < 0)
> +		dev_warn_once(ctrl->device,
> +			"could not set timestamp (%08x)\n", result);
> +}

We don't actually need 'result' for this feature. It won't mean anything
for the feature, and it's actually not going to be set if status < 0,
but we'd want see the value of 'status' if it's != 0.
