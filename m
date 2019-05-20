From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 May 2019 13:16:01 +0200
Subject: [PATCH] nvme-pci: fix single segment optimization
In-Reply-To: <20190517225035.25008-1-ming.lei@redhat.com>
References: <20190517225035.25008-1-ming.lei@redhat.com>
Message-ID: <20190520111601.GC5137@lst.de>

Given that the code only showed up in 5.2 I'd rather try to fix the
block layer issue, lets see what Jens says.  But if not I defintively
want the comment from my earlier patch, and to me the
!req->bio->bi_next && req->bio->bi_vcnt == 1 check also seems slighly
easier to parse.
