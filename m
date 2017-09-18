From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 09:13:30 -0700
Subject: [PATCH v3 1/3] nvme_fc: create fc class and transport device
In-Reply-To: <20170914173843.3195-2-jsmart2021@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-2-jsmart2021@gmail.com>
Message-ID: <20170918161330.GC310@infradead.org>

Looks ok,

although I really wish we could come up with some common FC code,
including making the existing FC drivers use more infrastructure
from libfc..

Reviewed-by: Christoph Hellwig <hch at lst.de>
