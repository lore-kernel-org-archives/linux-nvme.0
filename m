From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 28 Mar 2019 11:22:04 -0600
Subject: [GIT PULL] nvme fixes for 5.1
In-Reply-To: <20190328171928.GA26641@infradead.org>
References: <20190328171928.GA26641@infradead.org>
Message-ID: <12ed0279-03f1-91ad-c69c-d97f57642134@kernel.dk>

On 3/28/19 11:19 AM, Christoph Hellwig wrote:
> A few accumulated small fixes:
> 
>  - fix an endianess misannotation that sneaked in this merge window in
>    nvme-tcp (me)
>  - fix nvme-loop to handle multi-page segments (Ming)
>  - fix error handling in the nvmet configfs code (Max)
>  - add a missing requeue point in the multipath code (Martin George)

Pulled, thanks.

-- 
Jens Axboe
