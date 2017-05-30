From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 13:09:02 +0300
Subject: [PATCH V3] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170528094043.GA14199@lst.de>
References: <20170526201351.GA21847@dhcp-216.srv.tuxera.com>
 <20170528094043.GA14199@lst.de>
Message-ID: <b91063aa-05a3-2fd2-8366-58eadbbdc643@grimberg.me>

> Hi Rkesh,
>
> this looks reasonable, but we'll need to also adopt the non-PCI
> driver to the new state machine.  I can give this a spin.
>
> At that point we probably want to move nvme_reset into common
> code somehow.

Hi Guys, sorry for barging in late, I've been way too busy with
internal stuff lately...

I think that adding a new state should (a) be added with careful
understanding that its absolutely needed and (b) does not complicate
the state machine.

I honestly think that adding a new state that says "we scheduled a
reset" to address a synchronization issue is not what we should do.

1. I think that state NVME_CTRL_RESETTING semantically means that
the reset flow has been scheduled and the state transition atomicity
suffices for synchronization. So nvme_reset should change the state
and if it succeeded, schedule the reset_work instead of changing the
state inside reset_work (like we do in fabrics). At this point we should
lose the WARN_ON.

2. I personally think that nvme_probe shouldn't necessarily trigger
controller reset, if we can split reset to a couple of useful routines
we can reuse them in nvme_probe. The reason is that for reset we need
to address various conditions (errors, ongoing traffic etc...) that
are not relevant at all for probe. Not sure if anyone agrees with me
on this one.



I started to experiment with trying to move some of this to nvme core[1]
(rdma and loop) but has yet to fully convert pci which is a bit more
complicated.

[1] git://git.infradead.org/users/sagi/linux.git 
nvme-central-reset-delete-err
