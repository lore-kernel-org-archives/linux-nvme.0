From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Jan 2018 16:11:32 +0100
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
Message-ID: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>

In NVMe over Fabrics we currently perform target discovery by running either
one of 'nvme discover' or 'nvme connect-all' (with or without the use of an
appropriate /etc/nvme/discovery.conf).

This is well suited for the RDMA transport, which has no idea of the
underlying fabric and it's connections. To automatically connect to an RDMA
target Sagi proposed a systemd one-shot service in [1]. 

The Fibre Channel transport on the other hand does already know it's mapping
of rports to lports and thus could automatically connect to the target (with a
little help from udev) as shown in [2].

Unfortunately the method for FC is not possible with RDMA and the currently
used 'nvme discover/connect/connect-all' method is extremely cumbersome with
Fibre Channel, especially as no special setup was/is needed for SCSI devices
over Fibre Channel and administrators thus expect it for NVMe as well.

Other downside of the "RDMA version" are 1) once the network topology and thus
/etc/nvme/discovery.conf changes one has to rebuild the initrd if nvme is to
be started from the initrd and 2) if we use the one-shot systemd service there
is no way to automatically re-try the discovery/connect.

I'm hoping we have developers from the RDMA and Fibre Channel transports, as
well as seasoned Storage developers with a SCSI Fibre Channel and RDMA
knowledge and Distribution Maintainers around to discuss a way to address this 
problem is a user-friendly way.

Byte,
	Johannes

[1] http://lists.infradead.org/pipermail/linux-nvme/2017-September/012976.html
[2] http://lists.infradead.org/pipermail/linux-nvme/2017-December/014324.html

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
