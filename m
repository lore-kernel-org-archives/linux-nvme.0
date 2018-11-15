From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:35:55 -0800
Subject: [PATCH 1/2] nvme-multipath: add 'iopolicy' subsystem attribute
In-Reply-To: <20181115122927.40431-2-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-2-hare@suse.de>
Message-ID: <4e31f5b2-077b-8ed6-7b9e-3ffcb4948d68@grimberg.me>


> +static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	unsigned int iopolicy = NVME_IOPOLICY_UNKNOWN;
> +
> +	if (!strncmp(buf, "none", 4))
> +		iopolicy = NVME_IOPOLICY_NONE;
> +	else if (!strncmp(buf, "numa", 4))
> +		iopolicy = NVME_IOPOLICY_NUMA;
> +
> +	if (iopolicy == NVME_IOPOLICY_UNKNOWN)
> +		return -EINVAL;

Missed assignment to subsys->iopolicy?
