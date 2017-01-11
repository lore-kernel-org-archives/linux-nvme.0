From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 11 Jan 2017 16:08:31 +0000
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <20170111134312.GH6286@linux-x5ow.site>
References: <20170111134312.GH6286@linux-x5ow.site>
Message-ID: <1484150893.2619.1.camel@sandisk.com>

On Wed, 2017-01-11@14:43 +0100, Johannes Thumshirn wrote:
> I'd like to attend LSF/MM and would like to discuss polling for block
> drivers.
> 
> Currently there is blk-iopoll but it is neither as widely used as NAPI in
> the networking field and accoring to Sagi's findings in [1] performance
> with polling is not on par with IRQ usage.
> 
> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
> more block drivers and how to overcome the currently seen performance
> issues.
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2016-October/006975.ht
> ml

A typical Ethernet network adapter delays the generation of an interrupt
after it has received a packet. A typical block device or HBA does not delay
the generation of an interrupt that reports an I/O completion. I think that
is why polling is more effective for network adapters than for block
devices. I'm not sure whether it is possible to achieve benefits similar to
NAPI for block devices without implementing interrupt coalescing in the
block device firmware. Note: for block device implementations that use the
RDMA API, the RDMA API supports interrupt coalescing (see also
ib_modify_cq()).

An example of the interrupt coalescing parameters for a network adapter:

# ethtool -c em1 | grep -E 'rx-usecs:|tx-usecs:'
rx-usecs: 3
tx-usecs: 0

Bart.
