From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Nov 2015 06:13:55 +0100
Subject: [RFC PATCH 4/9] nvmet: add a controller "start" hook
In-Reply-To: <1447978868-17138-5-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <1447978868-17138-5-git-send-email-mlin@kernel.org>
Message-ID: <20151120051355.GA19405@lst.de>

On Thu, Nov 19, 2015@04:21:03PM -0800, Ming Lin wrote:
>  #define NVMET_SUBSYS_NAME_LEN		256
>  	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
> +
> +	void			*opaque;
> +	void			(*start)(void *);
>  };

Why can't vhost use container_of to get at the containing structure
similar to what the loop driver does?

In addition I think we'll eventually need an ops structure here,
but I can take care of that later.
