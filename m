From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:58:33 +0100
Subject: [PATCH V2 2/6] blk-mq: support concurrent blk_mq_quiesce_queue()
In-Reply-To: <20171214023103.18272-3-ming.lei@redhat.com>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-3-ming.lei@redhat.com>
Message-ID: <20171229095833.GB24507@lst.de>

The quiesce count looks good to me.  But I'm really worried about
the force unquiesce in nvme.  I'd feel much better if we could find
a way to move this into the core.
