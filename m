From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 21:11:46 +0100
Subject: [PATCH] nvme-pci: remove an unnecessary variable
 initialization in HMB code
In-Reply-To: <CAA7jztd=fbtacLjOn5B04Nf2x-gzYr1qGiiuDZh-vK_SfiTwvg@mail.gmail.com>
References: <1512279430-2806-1-git-send-email-minwoo.im.dev@gmail.com>
 <CAA7jztd=fbtacLjOn5B04Nf2x-gzYr1qGiiuDZh-vK_SfiTwvg@mail.gmail.com>
Message-ID: <20171204201145.GD17023@lst.de>

On Sun, Dec 03, 2017@02:56:24PM +0900, Minwoo Im wrote:
> Sorry for making confusions. The following patch is good to be reviewed.
> + Added one more removal for an unnecessary variable initialization in
> nvme_setup_host_mem()
> 
> 
> The local variable __size__ and __ret__ will be set a bit later.
> Remove the explicit initialization at the beginning of those functions.

This one looks fine, but please resend it in in its own thread in
proper formatting.
