From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 11:35:59 -0700
Subject: [PATCH 1/3] nvme: NUMA locality information for fabrics
In-Reply-To: <20181026125718.122767-2-hare@suse.de>
References: <20181026125718.122767-1-hare@suse.de>
 <20181026125718.122767-2-hare@suse.de>
Message-ID: <4c130c7f-ef74-d451-bf6e-5e3814c2e4ad@grimberg.me>


>   static ssize_t nvme_sysfs_delete(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
> @@ -2845,6 +2846,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_subsysnqn.attr,
>   	&dev_attr_address.attr,
>   	&dev_attr_state.attr,
> +	&dev_attr_node_id.attr,

Maybe call it numa_node to align with other devices sysfs attributes?

Otherwise looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
