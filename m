From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Dec 2015 06:24:24 -0800
Subject: [PATCH RFC 1/4] blk-mq: Export a busy tagset iterator helper
In-Reply-To: <1450956241-4626-2-git-send-email-sagig@mellanox.com>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
 <1450956241-4626-2-git-send-email-sagig@mellanox.com>
Message-ID: <20151224142424.GC2646@infradead.org>

Looks okay to me, although I'm not really sold on absolutely
needing this helper..
