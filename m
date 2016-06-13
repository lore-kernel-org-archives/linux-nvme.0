From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Jun 2016 17:15:39 +0200
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160611011449.GJ16462@localhost>
References: <20160511085049.GA20279@lst.de>
 <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
 <20160512073552.GA4027@lst.de>
 <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com>
 <20160512110318.GA9192@lst.de>
 <20160512121155.GB8681@agordeev.lab.eng.brq.redhat.com>
 <20160512121933.GA11084@lst.de> <20160512142902.GA14166@lst.de>
 <20160513082947.GB14671@agordeev.lab.eng.brq.redhat.com>
 <20160611011449.GJ16462@localhost>
Message-ID: <20160613151539.GA6540@lst.de>

On Fri, Jun 10, 2016@08:14:50PM -0500, Bjorn Helgaas wrote:
> Hi Christoph,
> 
> Where are we at with this?  Did I miss a newer version?

I've been respinning the whole MSI-X spreading series after a discussion
with Thomas.  I'll be able to post it soon.
