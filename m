From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 19:00:32 +0200
Subject: [PATCH v3 1/6] rdma_cm: add rdma_reject_msg() helper function
In-Reply-To: <ca2185d1f1e9008922d1b344f3887d400a1d6053.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <ca2185d1f1e9008922d1b344f3887d400a1d6053.1477336045.git.swise@opengridcomputing.com>
Message-ID: <20161025170032.GA9732@lst.de>

On Mon, Oct 24, 2016@11:59:03AM -0700, Steve Wise wrote:
> rdma_reject_msg() returns a pointer to a string message associated with
> the transport reject reason codes.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

(and /me notes the difference in error numbers between iWarp and the IB
universe..  Stunning)
