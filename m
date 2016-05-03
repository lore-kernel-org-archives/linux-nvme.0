From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 3 May 2016 16:37:56 -0500
Subject: [PATCH 6/8] pci: provide sensible irq vector alloc/free routines
In-Reply-To: <20160503211945.GA25167@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
 <1460770552-31260-7-git-send-email-hch@lst.de>
 <20160429211638.GB28261@localhost> <20160501180149.GA11131@lst.de>
 <20160502131124.GA18527@localhost> <20160502144203.GA32221@lst.de>
 <20160502152929.GA24851@localhost> <20160503211945.GA25167@lst.de>
Message-ID: <20160503213756.GA17170@localhost>

On Tue, May 03, 2016@11:19:46PM +0200, Christoph Hellwig wrote:
> Hi Bjorn,
> 
> I've implemented your suggestion and I'm getting ready to send out
> a new version.  One thing that came to mind is:  do you prefer this
> code in irq.c or would you rather have it in msi.c?  While it
> also has a legacy irq fallback most of it tied pretty closely to
> the msi.c code, so I wonder if we should group them together.

Good question.  There isn't much in irq.c, and the interesting bits
are the MSI-related things, so maybe msi.c would make more sense.

Bjorn
