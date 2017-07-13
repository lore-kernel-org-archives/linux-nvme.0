From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 15:30:39 +0300
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <20170713104806.12353-1-jthumshirn@suse.de>
References: <20170713104806.12353-1-jthumshirn@suse.de>
Message-ID: <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>


> +static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
> +					     char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
> +}
> +
> +static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
> +					      const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	down_write(&nvmet_config_sem);
> +	sscanf(page, "%llx\n", &subsys->serial);
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_serial);

It seems weird that a subsystem has a serial.

I'm not sure that a dynamic controller should maintain
a serial. Dynamic controllers by definition are allocated
on demand with no state of prior associations. But not sure
if a serial is a state (it probably isn't). The area is a little
fuzzy for me.
