From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 May 2015 00:21:53 -0700
Subject: [PATCH v3 1/7] bio: Introduce LightNVM payload
In-Reply-To: <5550997B.1000609@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
 <1429712816-10336-2-git-send-email-m@bjorling.me>
 <20150509160007.GA16058@infradead.org>
 <5550997B.1000609@bjorling.me>
Message-ID: <20150512072153.GA25438@infradead.org>

On Mon, May 11, 2015@01:58:51PM +0200, Matias Bj?rling wrote:
> >Can you explain why this needs to be done on a per-bio instead of a
> >per-request level?  I don't really think a low-level driver should add
> >fields to struct bio as that can be easily remapped.
> 
> When a bio is submitted through the block layer, it can be merged/splitted
> on going through the block layer. Thus, we don't know the number of physical
> addresses that must be mapped before its on the other side.

For any sort of passthrough bios that should not be the case.  It's not
for BLOCK_PC, it's not for my new pass through NVMe commands and I don't
think it should be in this case.
