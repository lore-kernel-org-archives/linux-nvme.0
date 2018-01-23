From: bart.vanassche@wdc.com (Bart Van Assche)
Date: Tue, 23 Jan 2018 08:09:15 -0800
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
Message-ID: <464f1939-e3e6-95bc-f3d4-fcb83dfbf075@wdc.com>



On 01/23/18 07:11, Johannes Thumshirn wrote:
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
> 
> Byte,
> 	Johannes
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2017-September/012976.html
> [2] http://lists.infradead.org/pipermail/linux-nvme/2017-December/014324.html

Hello Johannes,

Can you have a look at the SSDP and SLP protocols and see whether one of 
these protocols or an alternative is appropriate? See also 
https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol and 
https://en.wikipedia.org/wiki/Service_Location_Protocol.

Thanks,

Bart.
