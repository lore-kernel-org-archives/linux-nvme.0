From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Aug 2015 02:40:03 -0700
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55ABBFB1.7070201@dev.mellanox.co.il>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
Message-ID: <20150819094003.GB14734@infradead.org>

On Sun, Jul 19, 2015@06:18:09PM +0300, Sagi Grimberg wrote:
> I'll centralize the checks. No problem.

Did you get a chance to respin these patches?  It would be
good to get them in this merge window.
