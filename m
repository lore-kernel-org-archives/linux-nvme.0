From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Jul 2017 09:20:18 +0200
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
In-Reply-To: <20170629172624.GA17319@localhost.didichuxing.com>
References: <20170629172624.GA17319@localhost.didichuxing.com>
Message-ID: <20170712072018.GA5739@lst.de>

On Fri, Jun 30, 2017@01:26:24AM +0800, weiping zhang wrote:
> Simplify nvme ctrl register r/w code.
> 
> Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>

This seems generally useful, especially with more consolidation
of code to the core.  Sagi - do you want to integrate this into
your consolidation series and fixup any clashes?
