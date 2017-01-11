From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 11 Jan 2017 16:26:40 +0000
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <2aff05af-5e83-7d3d-f879-2cce02b6d88c@suse.de>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
 <20170111161238.GA18881@infradead.org>
 <2aff05af-5e83-7d3d-f879-2cce02b6d88c@suse.de>
Message-ID: <1484151982.2619.6.camel@sandisk.com>

On Wed, 2017-01-11@17:22 +0100, Hannes Reinecke wrote:
> On 01/11/2017 05:12 PM, hch@infradead.org wrote:
> > On Wed, Jan 11, 2017@04:08:31PM +0000, Bart Van Assche wrote:
> > > A typical Ethernet network adapter delays the generation of an
> > > interrupt
> > > after it has received a packet. A typical block device or HBA does not
> > > delay
> > > the generation of an interrupt that reports an I/O completion.
> > 
> > NVMe allows for configurable interrupt coalescing, as do a few modern
> > SCSI HBAs.
> 
> Essentially every modern SCSI HBA does interrupt coalescing; otherwise
> the queuing interface won't work efficiently.

Hello Hannes,

The first e-mail in this e-mail thread referred to measurements against a
block device for which interrupt coalescing was not enabled. I think that
the measurements have to be repeated against a block device for which
interrupt coalescing is enabled.

Bart.
