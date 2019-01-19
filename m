From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 19 Jan 2019 05:34:10 -0800
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <20190103173531.7987-1-rajur@chelsio.com>
References: <20190103173531.7987-1-rajur@chelsio.com>
Message-ID: <20190119133410.GA6963@infradead.org>

This looks ok to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

In the long run I wonder if we should get rid of the ?tatic
preallocation entirely and just use a free pool to avoid constant
reallocations..
