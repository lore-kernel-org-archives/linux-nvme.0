From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jan 2018 20:42:18 +0200
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
Message-ID: <64ee446d-118d-364a-e9bb-bcbf80b8135b@grimberg.me>

Hi Johannes,

> In NVMe over Fabrics we currently perform target discovery by running either
> one of 'nvme discover' or 'nvme connect-all' (with or without the use of an
> appropriate /etc/nvme/discovery.conf).
> 
> This is well suited for the RDMA transport, which has no idea of the
> underlying fabric and it's connections. To automatically connect to an RDMA
> target Sagi proposed a systemd one-shot service in [1].
> 
> The Fibre Channel transport on the other hand does already know it's mapping
> of rports to lports and thus could automatically connect to the target (with a
> little help from udev) as shown in [2].
> 
> Unfortunately the method for FC is not possible with RDMA and the currently
> used 'nvme discover/connect/connect-all' method is extremely cumbersome with
> Fibre Channel, especially as no special setup was/is needed for SCSI devices
> over Fibre Channel and administrators thus expect it for NVMe as well.
> 
> Other downside of the "RDMA version" are 1) once the network topology and thus
> /etc/nvme/discovery.conf changes one has to rebuild the initrd if nvme is to
> be started from the initrd and 2) if we use the one-shot systemd service there
> is no way to automatically re-try the discovery/connect.
> 
> I'm hoping we have developers from the RDMA and Fibre Channel transports, as
> well as seasoned Storage developers with a SCSI Fibre Channel and RDMA
> knowledge and Distribution Maintainers around to discuss a way to address this
> problem is a user-friendly way.

Discovery enhancements is a subject the NVMe TWG will be working on in
the near future, and "discovery of the  the discovery service" is indeed
a sub-topic IIRC. I'm not sure LSF would be the appropriate forum for
this.

What we do need to have, is a way to support existing devices. I think
its acceptable that FC and Ethernet based transports diverge in their
implementations for this.

For Ethernet based transports we could follow the open-iscsi model which
has discoveryd service which periodically polls predefined addresses. As
for updating initramfs, maybe we can live with this limitation for the
time being?

FC can keep doing its own thing...
