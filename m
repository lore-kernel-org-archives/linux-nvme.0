From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Jun 2017 10:27:06 -0400
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <5943E3BC.6050807@hpe.com>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain>
 <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
 <20170616083151.GB14698@infradead.org> <5943E3BC.6050807@hpe.com>
Message-ID: <20170620142706.GC22260@localhost.localdomain>

On Fri, Jun 16, 2017@09:57:16AM -0400, Linda Knippers wrote:
> David Milburn's patch is very simple.  Can we please fix the bug for now
> so we have a little time to fix our tools?

But if we applied this one, we'd implicitly concede this ill conceived
component is being maintained, and we'd forever have to apply "one more"
patch when we're trying to get rid of the need.
