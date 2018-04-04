From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 14:44:11 +0300
Subject: [RFC PATCH 0/8] nvmet: implement target passthru commands support
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <e089febc-577f-354d-dceb-0410d9115e1f@grimberg.me>


> Hi,

Hi Chaitanya,

> This patchset implements NVMeOF target passthrough commands support.
> 
> In current implementation on the target side, NVMe command is mapped on the
> block layer request which allows the target to use generic block device.

So for normal IO commands, I would simply move the bio construction loop
to shared code and call it from either the normal nvmet_execute_* or
nvmet_execute_passthru_io_cmd. I still don't understand what that buys
us... I guess one benefit would be to utilize ranged (merged) discards
instead of executing them range by range...

For admin commands I would do something different though, why not simply
exporting __nvme_passthru_cmd (portion of nvme_user_cmd) and simply call
that with a bit of tweaks to the host memory layout. That would
eliminate the re-code in nvmet_execute_admin_cmd() Thoughts?

> With the help of passthrough interface, it can now identify the NVMe controller
> and allow the host to issue NVMe commands along with the VUCs on the
> target side.

We need code to exclude more than a single access to the same passthru
controller (or subsystem in fact). Otherwise we might be exposing the
user to lots of troubles...

Its also odd that a namespace is given a passthru access to a
controller. Maybe we need to add a configfs interface for passthru
subsystems? (under subsystems/ we have passthru file that takes the
controller name or subsystem id or something)

Then automatically all the namespaces of that controller will be exposed
via the subsystem (or fail if namespaces are already attached to
other subsystems).

> For example with this feature, depending on the target controller
> support host can issue namespace management commands,
> Vendor unique commands etc.

So namespace management needs a mechanism to add the new namespace via
the fabrics target. This would require adding an event client mechanism
to nvme that will create that namespace in nvmet before issuing the
AEN.
