From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 18 Apr 2017 01:08:54 -0700
Subject: [PATCH V2] nvme: make use of nvme error status codes in block
 layer
In-Reply-To: <1492434939-12308-1-git-send-email-guanjunxiong@huawei.com>
References: <1492434939-12308-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170418080854.GA21059@infradead.org>

NAK.  Please don't start exposing random error codes to the block
layer.  There are a few (very few) with special meaning in the block
layer, mostly just for multipathing.  If you have an actual,
demonstrated need for those we can add it.  Otherwise you're just
creating noise.
