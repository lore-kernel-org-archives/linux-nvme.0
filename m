From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Dec 2018 09:52:46 -0700
Subject: [PATCH v3 2/6] block: make request_to_qc_t public
In-Reply-To: <20181213213410.9841-3-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-3-sagi@grimberg.me>
Message-ID: <81f1587c-a8e0-8b6d-5cab-c6b2a6fff276@kernel.dk>

On 12/13/18 2:34 PM, Sagi Grimberg wrote:
> block consumers will need it for polling requests that
> are sent with blk_execute_rq_nowait. Also, get rid of
> blk_tag_to_qc_t and open-code it instead.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
