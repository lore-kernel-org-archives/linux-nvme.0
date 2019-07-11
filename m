From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Jul 2019 02:08:51 +0900
Subject: [PATCH] nvme: tcp: depends on CRYPTO_HASH2 for nvme-tcp
In-Reply-To: <d67b7a73-0061-202c-457d-93bc4cd06122@grimberg.me>
References: <20190711151338.16810-1-minwoo.im.dev@gmail.com>
 <d67b7a73-0061-202c-457d-93bc4cd06122@grimberg.me>
Message-ID: <20190711170851.GA17328@minwoo-desktop>

Hi Sagi,

Thanks for your review on this.

On 19-07-11 09:05:28, Sagi Grimberg wrote:
> Hi Minwoo,
> 
> > The tcp host module is now taking those APIs from crypto ahash:
> > 	(1) crypto_ahash_final()
> > 	(2) crypto_ahash_digest()
> > 	(3) crypto_alloc_ahash()
> > 
> > nvme-tcp should depends on CRYPTO_HASH2.
> 
> It actually should depend on CRYPTO_CRC32C because
> it needs CRC32C.

Okay.  That looks right for this commit's goal..

> > 
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: Sagi Grimberg <sagi at grimberg.me>
> > Cc: Jens Axboe <axboe at fb.com>
> > Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> > ---
> >   drivers/nvme/host/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> > index ec43ac9199e2..711d3ea5143f 100644
> > --- a/drivers/nvme/host/Kconfig
> > +++ b/drivers/nvme/host/Kconfig
> > @@ -63,6 +63,7 @@ config NVME_TCP
> >   	tristate "NVM Express over Fabrics TCP host driver"
> >   	depends on INET
> >   	depends on BLK_DEV_NVME
> > +	depends on CRYPTO_HASH2
> 
> Lets make it select instead.

Oh, That would be much easier to use them.  Will prepare updated patch
soon.

Thanks,
