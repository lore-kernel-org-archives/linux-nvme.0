From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 14:46:32 +0200
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible
 sleep for ever
In-Reply-To: <20170601123650.GA18883@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
 <20170601123650.GA18883@dhcp-216.srv.tuxera.com>
Message-ID: <20170601124631.GA28652@lst.de>

On Thu, Jun 01, 2017@03:36:50PM +0300, Rakesh Pandit wrote:
> Also Sagi pointed out that user space set_features ioctl if fired up
> in a window after nvme_removal it can also result in this issue seems
> to be correct.  I would prefer to keep this as it is and introduce
> similar check higher up in nvme_ioctrl instead so that we don't send
> sync commands if queues are killed already.
> 
> Would you prefer a patch ? Thanks,

If we want to kill everyone we probably should do it in ->queue_rq.
Or is the block layer blocking you somewhere else?
