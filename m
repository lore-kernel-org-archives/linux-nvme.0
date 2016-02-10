From: mlin@kernel.org (Ming Lin)
Date: Wed, 10 Feb 2016 07:37:28 -0800
Subject: [PATCH v2 0/5] split pci module out of core module
In-Reply-To: <20160210082146.GA9171@lst.de>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
 <20160210082146.GA9171@lst.de>
Message-ID: <CAF1ivSYhZUXZEK74CWPy4fq-vyOE=++gxgJqngnUbSqMFwEoeQ@mail.gmail.com>

On Wed, Feb 10, 2016@12:21 AM, Christoph Hellwig <hch@lst.de> wrote:
> Patch 3 still says "export more symbols" while it exports the first
> symbols.  Maybe it's better to just gold patch 3 into patch 5 where
> the exports are use?

Patch 2 exports the first symbols.

EXPORT_SYMBOL_GPL(admin_timeout);
EXPORT_SYMBOL_GPL(nvme_io_timeout);

>
> Otherwise looks fine,
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
