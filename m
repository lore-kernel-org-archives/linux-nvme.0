From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Dec 2016 16:37:31 +0100
Subject: [PATCH 3/3] nvme: Make controller state visible via sysfs
In-Reply-To: <1480936146-6406-4-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-4-git-send-email-sagi@grimberg.me>
Message-ID: <20161205153731.GB6529@lst.de>

> +	return sprintf(buf, "%s\n",
> +		       (unsigned)ctrl->state < ARRAY_SIZE(state_name) ?
> +		       state_name[ctrl->state] : "???");

I'd use an if here instead of the ? : and print unknown instead of the ???

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
