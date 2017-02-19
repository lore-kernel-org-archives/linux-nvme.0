From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 19 Feb 2017 09:12:08 -0800
Subject: [PATCH] Detect NVMe controller in recent MacBooks
In-Reply-To: <3815714.Y54y20dpT8@buzzard>
References: <3815714.Y54y20dpT8@buzzard>
Message-ID: <20170219171208.GA10310@infradead.org>

On Fri, Feb 17, 2017@10:25:58PM +0100, Daniel Roschka wrote:
> Adds support for detection of the NVMe controller found in the 
> following recent MacBooks:
> - Retina MacBook 2016 (MacBook9,1)
> - 13" MacBook Pro 2016 without Touch Bar (MacBook13,1)
> - 13" MacBook Pro 2016 with Touch Bar (MacBook13,2)

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Just curious: what class code do the Apple controllers display?
