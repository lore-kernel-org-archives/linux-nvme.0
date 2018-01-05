From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 5 Jan 2018 12:49:26 -0700
Subject: [PATCH v4 0/5] Introduce sgl_alloc() and sgl_free()
In-Reply-To: <20180105162650.31083-1-bart.vanassche@wdc.com>
References: <20180105162650.31083-1-bart.vanassche@wdc.com>
Message-ID: <a5f80b53-397b-057e-d2c2-5b132982d83a@kernel.dk>

On 1/5/18 9:26 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> As you know there are multiple drivers that both allocate a scatter/gather
> list and populate that list with pages. This patch series moves the code for
> allocating and freeing such scatterlists from several drivers into
> lib/scatterlist.c. Please consider this patch series for kernel v4.16.

Thanks Bart, applied for 4.16.

-- 
Jens Axboe
