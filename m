From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 11 Jul 2019 21:41:16 +0900
Subject: [PATCH rfc 3/6] nvme-cli: allow discover to address discovery
 controller by persistent name
In-Reply-To: <20190710232740.26734-4-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-4-jsmart2021@gmail.com>
Message-ID: <20190711124116.GC8398@minwoo-desktop>

On 19-07-10 16:27:37, James Smart wrote:
> To support discovery (connect/connect-all) to operate against a
> persistent discovery controller, let the discovery controller to
> be specified by its device node name rather than new connection
> attributes.
> 
> Example:
>   nvme connect-all ... --device=nvme5
> 
> Also centralize extraction of controller instance from the controller
> name to a common helper.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

Hi Sagi and James,

I think it might be too late review on this, but please have a look my
comments below :)

> +static int ctrl_instance(char *device)
> +{
> +	int ret, instance;
> +
> +	device = basename(device);
> +	ret = sscanf(device, "nvme%d", &instance);
> +	if (ret < 0)
> +		return ret;

It's just nitpick, but could we just do like:

	ret = sscanf(device, "nvme%d", &instance);
	if (ret < 0)
		return -errno;

> +	if (!ret)
> +		return -1;

Same here.  Can we please do:

	if (!ret)
		return -EINVAL;


These two things are not from this commit, but if you don't like it to
be involved in this scope of the commit, I think I can make it later, if
you don't mind.

> +	return instance;
> +}

I have a doubt here.  In case of multipath, if this function is given an
argument like "nvme0n1", Is "0" really an instance of that controller?
I think it could be an instance of the subsystem.  If so, can we just
prevent the argstr as a namespace node?

Please correct me if I'm wrong here.
