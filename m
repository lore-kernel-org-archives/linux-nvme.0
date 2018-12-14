From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Dec 2018 16:43:35 +0100
Subject: [PATCH v3 2/6] block: make request_to_qc_t public
In-Reply-To: <20181213213410.9841-3-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-3-sagi@grimberg.me>
Message-ID: <20181214154335.GA24417@lst.de>

On Thu, Dec 13, 2018@01:34:06PM -0800, Sagi Grimberg wrote:
> block consumers will need it for polling requests that
> are sent with blk_execute_rq_nowait. Also, get rid of
> blk_tag_to_qc_t and open-code it instead.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
