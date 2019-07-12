From: minwoo.im@samsung.com (Minwoo Im)
Date: Fri, 12 Jul 2019 10:34:00 +0900
Subject: [PATCH rfc v2 03/10] nvme-cli: allow discover to address
 discovery controller by persistent name
In-Reply-To: <20190712003140.16221-4-jsmart2021@gmail.com>
References: <20190712003140.16221-4-jsmart2021@gmail.com>
 <20190712003140.16221-1-jsmart2021@gmail.com>
 <CGME20190712003326epcas4p2b04fa5bb94140e84c16ed0014228d5e3@epcms2p1>
Message-ID: <20190712013400epcms2p1eb152f52850b0c93414ec239e67b1917@epcms2p1>

> diff --git a/fabrics.c b/fabrics.c
> index 75dedf8..d92c2ff 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -190,6 +190,21 @@ static const char *cms_str(__u8 cm)
> 
>  static int do_discover(char *argstr, bool connect);
> 
> +static int ctrl_instance(char *device)
> +{
> +	char d[64];
> +	int ret, instance;
> +
> +	device = basename(device);
> +	ret = sscanf(device, "nvme%d", &instance);
> +	if (ret <= 0)
> +		return -EINVAL;
> +	if (snprintf(d, sizeof(d), "nvme%d", instance) <= 0 ||
> +	    strcmp(device, d))
> +		return -EINVAL;

Okay, I think it looks better :).  Also it would be better if it
Can provide error messages here to say to give controller instance
Instead of blkdev, But it can be made later time.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
