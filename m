From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 11:53:24 +0100
Subject: [PATCH v3 2/3] nvme-rdma: don't complete requests before a
 send work request has completed
In-Reply-To: <20171120104156.31344-3-sagi@grimberg.me>
References: <20171120104156.31344-1-sagi@grimberg.me>
 <20171120104156.31344-3-sagi@grimberg.me>
Message-ID: <20171120105324.GA31524@lst.de>

> +	req->cqe.status = cqe->status;
> +	req->cqe.result = cqe->result;

I think we'll need to do a memcpy of the whole CQE here.
