From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 12:56:24 +0200
Subject: [PATCH v2] nvmet: filter newlines from user input
In-Reply-To: <20180606091049.12661-1-sagi@grimberg.me>
References: <20180606091049.12661-1-sagi@grimberg.me>
Message-ID: <20180606105624.GA11670@lst.de>

> +	ret = sscanf(page, "%s\n", port->disc_addr.traddr);
> +	if (ret < 1)
> +		return -EINVAL;
> +
> +	return count;

I think this should be:

	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1))
		return -EINVAL;
	return count;

Same for the other instances.

>  	ret = -ENOMEM;
> -	ns->device_path = kstrdup(page, GFP_KERNEL);
> -	if (!ns->device_path)
> +	s = kstrdup(page, GFP_KERNEL);
> +	if (!s)
>  		goto out_unlock;
>  
> +	ns->device_path = strsep(&s, "\n");

I'd just go for something like

	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
