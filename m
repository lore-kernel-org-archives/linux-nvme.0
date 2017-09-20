From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 10:50:18 -0700
Subject: [PATCH v3 1/3] nvme_fc: create fc class and transport device
In-Reply-To: <20170920103041.idkzk5kerewgv5yk@linux-x5ow.site>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-2-jsmart2021@gmail.com>
 <20170918161330.GC310@infradead.org>
 <20170920103041.idkzk5kerewgv5yk@linux-x5ow.site>
Message-ID: <20170920175018.GA8962@infradead.org>

On Wed, Sep 20, 2017@12:30:41PM +0200, Johannes Thumshirn wrote:
> the problem with libfc currently is it is made for fcoe, despite being named
> libfc.

Well, that's my point - we should be able to use more bits in a common
FC layer.  I don't really care about the exact name.

> The other hand it is hard-wired to FCP so bringing NVMe into it is a
> bit challanging, BTDT.

FC-NVMe layers on top of FCP.
