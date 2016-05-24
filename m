From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 May 2016 02:19:17 -0700
Subject: [PATCH] NVMe: Only release requested regions
In-Reply-To: <20160524091552.wmquryos2itoi767@c203.arch.suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
 <20160524091552.wmquryos2itoi767@c203.arch.suse.de>
Message-ID: <20160524091917.GA10185@infradead.org>

On Tue, May 24, 2016@11:15:52AM +0200, Johannes Thumshirn wrote:
> As I've probably missed v4.7, is it possible to get it for v4.8?
> Or should I take on the PCI helper functions Christoph suggested first?

Let's get the quick fix in first, and I think it's still 4.7 material.
