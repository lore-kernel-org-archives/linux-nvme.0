From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 1 Dec 2015 11:59:06 -0500 (EST)
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
 target
In-Reply-To: <1448987171.3041.2.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
 <56531F5F.3050709@redhat.com> <1448925639.27669.7.camel@ssi>
 <565DC48B.6030903@redhat.com> <1448987171.3041.2.camel@hasee>
Message-ID: <998355860.30506151.1448989146641.JavaMail.zimbra@redhat.com>


> What do you think about virtio-nvme+vhost-nvme?

What would be the advantage over virtio-blk?  Multiqueue is not supported
by QEMU but it's already supported by Linux (commit 6a27b656fc).

To me, the advantage of nvme is that it provides more than decent performance on
unmodified Windows guests, and thanks to your vendor extension can be used
on Linux as well with speeds comparable to virtio-blk.  So it's potentially
a very good choice for a cloud provider that wants to support Windows guests
(together with e.g. a fast SAS emulated controller to replace virtio-scsi,
and emulated igb or ixgbe to replace virtio-net).

Which features are supported by NVMe and not virtio-blk?

Paolo

> I also have patch for vritio-nvme:
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio
> 
> Just need to change vhost-nvme to work with it.
> 
> > 
> > Paolo
> > 
> > > Still tuning.
> 
> 
> 
