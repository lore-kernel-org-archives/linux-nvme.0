From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:10:12 +0200
Subject: [PATCH] nvme: drop WARN_ON() when processing ANA AEN
In-Reply-To: <20180726105702.80794-1-hare@suse.de>
References: <20180726105702.80794-1-hare@suse.de>
Message-ID: <20180726151012.GA7655@lst.de>

I've just manually removed the WARN_ONs here and in nvme_failover_req,
thanks!
