From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 7 May 2019 14:31:41 -0600
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
Message-ID: <a4ec2c1a-1ff7-52fe-07bd-179613411536@intel.com>



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> +
> +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
> +					 size_t bytes, loff_t offset)
> +{
> +	const size_t chunk_size = ctrl->max_hw_sectors * ctrl->page_size;

Just curious if chunk_size is correct since page size and block size can
be different.


> +	loff_t pos = 0;
> +
> +	while (pos < bytes) {
> +		size_t size = min_t(size_t, bytes - pos, chunk_size);
> +		int ret;
> +
> +		ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_TELEMETRY_CTRL,
> +				   0, buf + pos, size, offset + pos);
> +		if (ret)
> +			return ret;
> +
> +		pos += size;
> +	}
> +
> +	return 0;
> +}
