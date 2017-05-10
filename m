From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 09:55:31 -0700
Subject: [PATCH] nvmet: release the sq ref on rdma read errors
In-Reply-To: <014901d2c528$ec347430$c49d5c90$@attalasystems.com>
References: <CAN9s3O597CB9d2BoPx1gL5a7NnqhxrXYMhE==Q3E8+BoDxRFiQ@mail.gmail.com>
 <01cb01d2c446$20cd83a0$62688ae0$@attalasystems.com>
 <01d601d2c446$b087cb90$119762b0$@attalasystems.com>
 <da2ec86f-3c22-30a0-0e9b-f4c0fdf5eabb@grimberg.me>
 <00d6f8bf-07bd-03ca-3060-fd3def1ef1d7@grimberg.me>
 <20170504085631.GA5584@lst.de>
 <5e0ca611-97d8-8884-abc3-c0f3b6172a21@grimberg.me>
 <014901d2c528$ec347430$c49d5c90$@attalasystems.com>
Message-ID: <20170510165531.GB7992@infradead.org>

On Thu, May 04, 2017@03:51:09PM -0700, Vijay Immanuel wrote:
> Thanks for the feedback. Here's an updated patch.
> ----
> 
> On rdma read errors, release the sq ref that was taken
> when the req was initialized. This avoids a hang in
> nvmet_sq_destroy() when the queue is being freed.
> 
> Signed-off-by: Vijay Immanuel <vijayi at attalasystems.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
