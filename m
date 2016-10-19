From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:39:39 +0200
Subject: [PATCH v3 10/11] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <39c07429-2508-4123-8fe1-ecf407f8571d@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <39c07429-2508-4123-8fe1-ecf407f8571d@sandisk.com>
Message-ID: <20161019133939.GC6809@lst.de>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
