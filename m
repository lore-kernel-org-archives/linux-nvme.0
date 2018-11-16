From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 09:26:59 +0100
Subject: [PATCH 0/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181115122927.40431-1-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
Message-ID: <20181116082659.GA14334@lst.de>

On Thu, Nov 15, 2018@01:29:25PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> after my NUMA path balancing patch hasn't met with universal approval,

Were there any good arguments against it vs just my implementation
nitpicks?

> here's now my take on a 'real' round-robin I/O scheduler for NVMe multipathing.
> With this patch I'm able to boost I/O performance from 127k/127k randrw
> to 156k/156k randrw (as measured by fio).

Either way that is some horribly bad performance.  How much can
you get by driving one namespace on each path invididually?
