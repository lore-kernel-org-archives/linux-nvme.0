From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 03 Dec 2018 14:42:56 -0800
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
Message-ID: <1543876976.185366.175.camel@acm.org>

On Thu, 2018-11-29@09:18 -0800, Chaitanya Kulkarni wrote:
>  static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>  {
> -	struct nvme_command c = { };
> +	struct nvme_command c;
>  	int error;
>  
> +	memset(&c, 0, sizeof(c));

Please drop this and all similar changes. I think the preferred style in the Linux
kernel for structure initialization is to use "= { }" instead of memset().

Thanks,

Bart.
