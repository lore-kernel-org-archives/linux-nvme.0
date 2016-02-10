From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Feb 2016 17:11:08 +0100
Subject: [PATCH v2 0/5] split pci module out of core module
In-Reply-To: <CAF1ivSYhZUXZEK74CWPy4fq-vyOE=++gxgJqngnUbSqMFwEoeQ@mail.gmail.com>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
 <20160210082146.GA9171@lst.de>
 <CAF1ivSYhZUXZEK74CWPy4fq-vyOE=++gxgJqngnUbSqMFwEoeQ@mail.gmail.com>
Message-ID: <20160210161108.GB17241@lst.de>

On Wed, Feb 10, 2016@07:37:28AM -0800, Ming Lin wrote:
> On Wed, Feb 10, 2016@12:21 AM, Christoph Hellwig <hch@lst.de> wrote:
> > Patch 3 still says "export more symbols" while it exports the first
> > symbols.  Maybe it's better to just gold patch 3 into patch 5 where
> > the exports are use?
> 
> Patch 2 exports the first symbols.
> 
> EXPORT_SYMBOL_GPL(admin_timeout);
> EXPORT_SYMBOL_GPL(nvme_io_timeout);

Ok, let's move all the exports into a single patch then.
