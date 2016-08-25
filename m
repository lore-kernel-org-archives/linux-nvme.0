From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Aug 2016 09:38:10 +0200
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
Message-ID: <20160825073810.GA18622@lst.de>

Ooops, yes.

Are you looking into new nvme_set_features users?  Another thing
we need to tackle is either replacing dma_addr argument with a
a real kernel pointer (or just kill it until users show up)
