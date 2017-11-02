From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 2 Nov 2017 10:54:31 -0600
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <026401d353fb$24d56d60$6e804820$@opengridcomputing.com>
References: <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <20171101165036.GD1030@ziepe.ca>
 <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>
 <20171101175819.GG1030@ziepe.ca>
 <5810bb05-fffd-a0f2-3509-9d9b89a2ef32@grimberg.me>
 <20171102151254.GE18874@ziepe.ca>
 <022e01d353f6$3fcbafd0$bf630f70$@opengridcomputing.com>
 <20171102163614.GK18874@ziepe.ca>
 <026401d353fb$24d56d60$6e804820$@opengridcomputing.com>
Message-ID: <20171102165431.GN18874@ziepe.ca>

On Thu, Nov 02, 2017@11:53:44AM -0500, Steve Wise wrote:
> I think the nvmf target doesn't post the SEND_W_INVALIDATE (NVMF CQE) until the
> RDMA READ(s) (and back end BIO submission) complete. 

Ah! That makes sense for a storage use case

Thanks,
Jason
