From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 08:22:47 -0700
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
In-Reply-To: <alpine.LNX.2.00.1506111350580.15930@localhost.lm.intel.com>
References: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
 <20150610190812.GA6200@infradead.org>
 <alpine.LNX.2.00.1506110020180.15930@localhost.lm.intel.com>
 <20150611073826.GA27065@infradead.org>
 <alpine.LNX.2.00.1506111350580.15930@localhost.lm.intel.com>
Message-ID: <20150611152247.GA1292@infradead.org>

On Thu, Jun 11, 2015@02:10:17PM +0000, Keith Busch wrote:
> Right, I think Jon's patch captures that. If there are not enough for
> 1:1, the irqs are shared modulo the number of vectors, so the first
> shared vector is the admin queue's vector 0.

Right.  Reading through it that's indeed the case, it's just the
description that confused me.
