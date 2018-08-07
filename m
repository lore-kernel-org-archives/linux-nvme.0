From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Aug 2018 14:47:44 +0200
Subject: [PATCH] nvme: fixup crash on failed discovery
In-Reply-To: <f85b69d4-c72c-9c04-6a66-80e4acbb58dd@suse.com>
References: <20180807104342.44367-1-hare@suse.de>
 <20180807114613.GA8905@lst.de>
 <f85b69d4-c72c-9c04-6a66-80e4acbb58dd@suse.com>
Message-ID: <20180807124744.GA10051@lst.de>

On Tue, Aug 07, 2018@02:01:09PM +0200, Hannes Reinecke wrote:
> On 08/07/2018 01:46 PM, Christoph Hellwig wrote:
> > On Tue, Aug 07, 2018@12:43:42PM +0200, Hannes Reinecke wrote:
> >> When the initial discovery fails the subsystem hasn't been setup,
> >> and we'll encounter a kernel oops during shutdown.
> > 
> > This looks ok, but I'm curious where we even call nvme_ctrl_use_ana
> > if we fail early.
> > 
> This is called via
> nvme_sysfs_delete()->nvme_ctrl_delete()->nvme_stop_ctrl()->nvme_mpath_stop()
> called from 'nvme discover' on a failing controller.

Thanks.  Applied with a slightly updated changelog.
