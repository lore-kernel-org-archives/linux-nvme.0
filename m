From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Jun 2018 13:12:43 +0200
Subject: [PATCH] nvme-core: fix nvme_setup_cmd trace call
In-Reply-To: <20180607110836.GA22473@infradead.org>
References: <20180607063501.4361-1-chaitanya.kulkarni@wdc.com>
 <20180607072112.pqqp4zvyc5imdoqh@linux-x5ow.site>
 <20180607110836.GA22473@infradead.org>
Message-ID: <20180607111243.gikw7ybt6wn6snl2@linux-x5ow.site>

On Thu, Jun 07, 2018@04:08:36AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 07, 2018@09:21:12AM +0200, Johannes Thumshirn wrote:
> > On Thu, Jun 07, 2018@02:35:01AM -0400, Chaitanya Kulkarni wrote:
> > > This patch fixes the trace_nvme_setup_admin_cmd() call, now we use NULL
> > > in place of ns->disk->disk_name when ns variable is NULL.
> > 
> > Oops, good catch,
> > Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> There is no point in ever in the NULL argument to the admin cmd
> tracer.  I've dropped the original patch from nvme-4.18, let's redo it
> properly for 4.19.

Thinking more of it, it's probably best to supply the print the
controller name only. The nvm command tracer would print the NSID
anyways.

Printing the controller name can be done for admin and NVM commands
and should be enough if we really want to distinguish between commands
for different devices.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
