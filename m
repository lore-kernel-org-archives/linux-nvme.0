From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 05 Aug 2017 07:42:09 -0700
Subject: [PATCH v2 00/13] mpt3sas driver NVMe support:
In-Reply-To: <20170805135353.GA7526@infradead.org>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <e679a449-90c3-d2e1-2b31-1387cf414e09@suse.de>
 <20170805135353.GA7526@infradead.org>
Message-ID: <1501944129.3649.9.camel@HansenPartnership.com>

On Sat, 2017-08-05@06:53 -0700, Christoph Hellwig wrote:
> On Wed, Aug 02, 2017@10:14:40AM +0200, Hannes Reinecke wrote:
> > 
> > I'm not happy with this approach.
> > NVMe devices should _not_ appear as SCSI devices; this will just
> > confuse matters _and_ will be incompatible with 'normal' NVMe
> > devices.
> > 
> > Rather I would like to see the driver to hook into the existing
> > NVMe framework (which essentially means to treat the mpt3sas as a
> > weird NVMe-over-Fabrics HBA), and expose the NVMe devices like any
> > other NVMe HBA.
> 
> That doesn't make any sense.??The devices behind the mpt adapter
> don't look like NVMe devices at all for the hosts - there are no NVMe
> commands or queues involved at all, they hide behind the same
> somewhat leaky scsi abstraction as other devices behind the mpt
> controller.

You might think about what we did for SAS: split the generic handler
into two pieces, libsas for driving the devices, which mpt didn't need
because of the fat firmware and the SAS transport class so mpt could at
least show the same sysfs files as everything else for SAS devices.

Fortunately for NVMe it's very simple at the moment its just a couple
of host files and wwid on the devices.

James


> The only additional leak is that the controller now supports NVMe-
> like PRPs in additions to its existing two SGL formats.
> 
