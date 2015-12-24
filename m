From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Dec 2015 06:56:47 -0800
Subject: [PATCH RFC 3/4] nvme: Move IO termination code to the core
In-Reply-To: <567C06DC.10904@dev.mellanox.co.il>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
 <1450956241-4626-4-git-send-email-sagig@mellanox.com>
 <20151224142528.GD2646@infradead.org>
 <567C06DC.10904@dev.mellanox.co.il>
Message-ID: <20151224145647.GA21803@infradead.org>

On Thu, Dec 24, 2015@04:53:16PM +0200, Sagi Grimberg wrote:
> I just figured that it'd be nice to have a meaningfully named helpers,
> it's not uncommon in the kernel...
> 
> I have no problem losing them anyways so unless someone votes to keep
> them I'll remove them in v1.

Yeah.  Let's keep blk_mq_tagset_busy_iter and kill these wrappers.
