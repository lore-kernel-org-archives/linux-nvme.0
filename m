From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Dec 2017 13:56:17 +0100
Subject: [BUG] NULL pointer dereference in nvme_setup_streams_ns
In-Reply-To: <b70776c2-5781-9f65-9ab7-ebb81a86d46d@samsung.com>
References: <CGME20171214125019epcas2p3bde40201e0ba4833214c64637d67b24d@epcas2p3.samsung.com>
 <b70776c2-5781-9f65-9ab7-ebb81a86d46d@samsung.com>
Message-ID: <20171214125617.GA10616@lst.de>


Try moving the call to nvme_setup_streams_ns until after the call to
nvme_init_ns_head.  I'll prepare a formal patch in a bit when I'm not on the
run.
