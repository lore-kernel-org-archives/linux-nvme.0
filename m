From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Sep 2017 15:37:12 -0600
Subject: [GIT PULL] nvme fixes for 4.14-rc2
In-Reply-To: <20170920212928.wfzm34jajrpzmmdy@infradead.org>
References: <20170920212928.wfzm34jajrpzmmdy@infradead.org>
Message-ID: <ca8b404a-10e8-9ec1-11b0-54c765b81b61@kernel.dk>

On 09/20/2017 03:29 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a couple nvme fixes for -rc2 are below:
> 
>  - fixes for the Fibre Channel host/target to fix spec compliance
>  - allow a zero keep alive timeout
>  - make the debug printk for broken SGLs work better
>  - fix queue zeroing during initialization

Pulled, thanks.

-- 
Jens Axboe
