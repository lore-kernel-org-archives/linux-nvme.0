From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 12:19:24 +0100
Subject: [PATCH v3 2/3] nvme-rdma: don't complete requests before a
 send work request has completed
In-Reply-To: <20171120105324.GA31524@lst.de>
References: <20171120104156.31344-1-sagi@grimberg.me>
 <20171120104156.31344-3-sagi@grimberg.me> <20171120105324.GA31524@lst.de>
Message-ID: <20171120111924.GA32087@lst.de>

On Mon, Nov 20, 2017@11:53:24AM +0100, Christoph Hellwig wrote:
> > +	req->cqe.status = cqe->status;
> > +	req->cqe.result = cqe->result;
> 
> I think we'll need to do a memcpy of the whole CQE here.

Or we could just store the status and results fields in the
nvme_rdma_request.
