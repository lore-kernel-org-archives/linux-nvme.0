From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:35:37 +0200
Subject: [RFC PATCH 0/8] nvmet: implement target passthru commands support
In-Reply-To: <e089febc-577f-354d-dceb-0410d9115e1f@grimberg.me>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <e089febc-577f-354d-dceb-0410d9115e1f@grimberg.me>
Message-ID: <20180413173537.GD23674@lst.de>

On Wed, Apr 04, 2018@02:44:11PM +0300, Sagi Grimberg wrote:
> So for normal IO commands, I would simply move the bio construction loop
> to shared code and call it from either the normal nvmet_execute_* or
> nvmet_execute_passthru_io_cmd. I still don't understand what that buys
> us... I guess one benefit would be to utilize ranged (merged) discards
> instead of executing them range by range...

What are "normal" I/O commands?  There can be vendor defined I/O
commands that can do all kinds of weird things the block layer can't
do.  Hell, there are plenty of NVMe defined I/O commands that map to
nothing the block layer could deal with.

We'll need an implementation that can deal with anything thrown at
it, and Chaitanya has written that (turns out that part looks fairly
trivial, it's all the setup around it that is a bit of a mess).

> For admin commands I would do something different though, why not simply
> exporting __nvme_passthru_cmd (portion of nvme_user_cmd) and simply call
> that with a bit of tweaks to the host memory layout. That would
> eliminate the re-code in nvmet_execute_admin_cmd() Thoughts?

Why?  Not really much simpler, probably much slower due to the synchronous
nature, and it also requires reshuffling the on the wire format of the
SQe into another form just to unpack it again.

> We need code to exclude more than a single access to the same passthru
> controller (or subsystem in fact). Otherwise we might be exposing the
> user to lots of troubles...

Only to the same controller I think, and then only allow one fabrics
controller to be created for it.

> Its also odd that a namespace is given a passthru access to a
> controller. Maybe we need to add a configfs interface for passthru
> subsystems? (under subsystems/ we have passthru file that takes the
> controller name or subsystem id or something)
>
> Then automatically all the namespaces of that controller will be exposed
> via the subsystem

Sounds reasonable. 

> So namespace management needs a mechanism to add the new namespace via
> the fabrics target. This would require adding an event client mechanism
> to nvme that will create that namespace in nvmet before issuing the
> AEN.

Yeah, for now we should simply disallow it.  Unfortunatelt it turns out
the whole NVMe architecture isn't really well suitable for any kind of
tunneling.
