From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Mar 2018 10:08:13 +0200
Subject: [PATCH] nvme-loop: fix kernel oops in case of unhandled command
In-Reply-To: <20180326033937.7866-1-ming.lei@redhat.com>
References: <20180326033937.7866-1-ming.lei@redhat.com>
Message-ID: <20180328080813.GD20373@lst.de>

The patch looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Buy can you trim the long but not very useful trace from the commit log?
