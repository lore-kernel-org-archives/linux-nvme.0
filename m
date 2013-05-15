From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 May 2013 14:57:42 -0600 (MDT)
Subject: Expected behaviour for device hang
In-Reply-To: <OF5FBD14D9.6D2E87EF-ON86257B6C.006CDB74-86257B6C.006F6E86@hgst.com>
References: <OF5FBD14D9.6D2E87EF-ON86257B6C.006CDB74-86257B6C.006F6E86@hgst.com>
Message-ID: <alpine.LRH.2.03.1305151451090.7010@localhost.localdom>

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
