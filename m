From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:30:09 +0200
Subject: [PATCH] nvme: don't rely on the changed namespace list log
In-Reply-To: <20180606123742.4805-1-hch@lst.de>
References: <20180606123742.4805-1-hch@lst.de>
Message-ID: <20180611143009.GA14441@lst.de>

Keith, you asked for this so it would be good to get a review.

That being said I'm still not sure this patch is the right thing.
Compared to userspace deleting I/O queues reading the changed ns
log seems pretty harmless, especially given that we can easily
force a manual rescan.
