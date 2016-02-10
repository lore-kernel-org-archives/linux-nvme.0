From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Feb 2016 17:22:33 +0100
Subject: [PATCH v2 0/5] split pci module out of core module
In-Reply-To: <CAF1ivSZxXypVYQ_vpSS41ObBsL0Fi1r+6T3FYF6X9n6bh5nDaA@mail.gmail.com>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
 <20160210082146.GA9171@lst.de>
 <CAF1ivSYhZUXZEK74CWPy4fq-vyOE=++gxgJqngnUbSqMFwEoeQ@mail.gmail.com>
 <20160210161108.GB17241@lst.de>
 <CAF1ivSZxXypVYQ_vpSS41ObBsL0Fi1r+6T3FYF6X9n6bh5nDaA@mail.gmail.com>
Message-ID: <20160210162233.GA17738@lst.de>

On Wed, Feb 10, 2016@08:20:19AM -0800, Ming Lin wrote:
> > Ok, let's move all the exports into a single patch then.
> 
> OK. I'll merge patch 2 & 3.

Can I suggest the following:

 - patch 1: as-is
 - patch 2: drop the exports, just do the move
 - patch 3: fold into patch 5
 - patch 4: as-is
 - patch 5: all existing changes, plus all exports
