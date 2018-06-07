From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 7 Jun 2018 04:08:36 -0700
Subject: [PATCH] nvme-core: fix nvme_setup_cmd trace call
In-Reply-To: <20180607072112.pqqp4zvyc5imdoqh@linux-x5ow.site>
References: <20180607063501.4361-1-chaitanya.kulkarni@wdc.com>
 <20180607072112.pqqp4zvyc5imdoqh@linux-x5ow.site>
Message-ID: <20180607110836.GA22473@infradead.org>

On Thu, Jun 07, 2018@09:21:12AM +0200, Johannes Thumshirn wrote:
> On Thu, Jun 07, 2018@02:35:01AM -0400, Chaitanya Kulkarni wrote:
> > This patch fixes the trace_nvme_setup_admin_cmd() call, now we use NULL
> > in place of ns->disk->disk_name when ns variable is NULL.
> 
> Oops, good catch,
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

There is no point in ever in the NULL argument to the admin cmd
tracer.  I've dropped the original patch from nvme-4.18, let's redo it
properly for 4.19.
