From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:28:15 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170601114338.GA24855@lst.de>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
Message-ID: <bb2780a8-63af-4d58-6c78-b03152de0439@grimberg.me>


> I think we need the NVME_CTRL_SCHED_RESET state.  In fact I'm pretty
> sure some time in the past I already had it in a local tree as a
> generalization of rdma and loop already use NVME_CTRL_RESETTING
> (they set it before queueing the reset work).

I don't remember having it, but I might be wrong...

Can you explain again why you think we need it? Sorry for being
difficult, but I'm not exactly sure why it makes things better
or simpler.
