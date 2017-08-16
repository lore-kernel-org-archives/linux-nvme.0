From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Aug 2017 16:51:31 +0300
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <20170816104935.GA30525@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
Message-ID: <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>


> Did you get a chance to take a look at converting PCIe over?

I started to play around with it, not anywhere near getting it in
shape though...

> A lot of the design decisions seem to be driven by allowing PCIe
> as well,

That's true.

> and I'd like to see if that's possible / useful to start
> with.
 From what my radar got, it seems feasible. If you look at the nvme-core
routines, they really consists of the abstract part of the controller
initiation. From what I've seen so far, PCIe will require some extra
hooks on top of what we have now (some portion of nvme_pci_enable will
probably need to be added as well, and we'll need some generic
representation for pci device error states). I do expect nvme-core
changes for PCIe, but I don't expect the teardown/initiation structure
to change.

The only real design choice taken to accommodate PCIe was to manage
admin and io queues in the transports instead of nvme-core as queues
release procedure is different in PCIe.

I think its a very desirable goal to have PCIe consolidate with fabrics
here, so I'd like to shoot for that and backoff later (and change again
where makes sense).

Having said that, I'm very much open to suggestions if you have anything
better in mind...
