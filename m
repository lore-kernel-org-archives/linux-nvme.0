From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 12:59:30 +0200
Subject: [PATCH v2] blk-mq: Allow timeouts to run while queue is freezing
In-Reply-To: <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
References: <1469767356-25193-1-git-send-email-krisman@linux.vnet.ibm.com>
 <81fa2a75-1da8-aeb6-dcce-3ae245810234@kernel.dk>
 <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
Message-ID: <20160801105930.GA16141@lst.de>

I think this looks fine, especially with the detailed comment:

Reviewed-by: Christoph Hellwig <hch at lst.de>
