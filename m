From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Wed, 15 May 2013 17:01:17 -0500
Subject: Expected behaviour for device hang
In-Reply-To: <alpine.LRH.2.03.1305151451090.7010@localhost.localdom>
Message-ID: <OFA797561F.3B6507BC-ON86257B6C.007592B5-86257B6C.0078F7A9@hgst.com>

Thanks Keith,

Is there a more targeted reset that we could try first after an I/O times 
out? We are worried about the case when the device has multiple 
namespaces. Depending on the H/W design, its possible that I/O to one 
namespace could hang while I/O to others continues to work. If we reset 
the controler, that would disrupt the working namespaces. Maybe we can try 
an abort first, if that times out, try to re-create the I/O queues 
associated with the stuck namespace, and if that doesn't work, reset the 
controller?

Another question. The NVME spec states that a subsystem reset may be 
initiated by, among other things, 'a vendor specific event', and that the 
CSTS.NSSRO bit indicates that a subsystem reset has happened.  Are there 
places that the driver should be checking this bit? Perhaps after I/O 
timeouts or other odd failures. If the bit is set, the driver could post 
an error and begin recovery without worrying that other parts of the 
device may still be working. 
 



Keith Busch <keith.busch at intel.com> 
05/15/2013 03:57 PM

To
David.Darrington at hgst.com
cc
linux-nvme at lists.infradead.org
Subject
Re: Expected behaviour for device hang






On Wed, 15 May 2013, David.Darrington@hgst.com wrote:
> What is the expected behaviour of the driver if a device hangs? If  a
> device stops processing commands, the commands will eventually timeout,
> which is handled in 'nvme_kthread' with a call to 'nvme_cancel_ios'.
> However, this is not calling bio_completion. Every second the cycle
> repeats, cancelling the same I/Os and syslog fills up with the message
> 'Cancelling I/O xx'. I was expecting that the ios that timeout would be
> completed as failed and freed.

bio_endio is called using the 'fn' callback after cancelling the command,
but the command id is not freed sense the controller still technically
owns it.

As fas as "Cancelling I/O' over and over, that should have been fixed
in this patch:

http://merlin.infradead.org/pipermail/linux-nvme/2013-April/000215.html

I thought that one was applied in the last merge, but looks like it was
missed. :(

> Is there something that is still TBD, or am I just missing something.

I think we may still have a probelm since ending the request releases the
mapped resources and the controller may still dma to/from there. I have
another patch to just reset the controller when an IO times out, but it is
pending on the power management set since it is basically the same thing.
