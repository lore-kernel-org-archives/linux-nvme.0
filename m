From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Jun 2018 13:16:58 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
Message-ID: <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>

On 6/20/18 1:10 PM, Jens Axboe wrote:
> This begs the question is we should limit the size in general. The
> command overhead is low enough that I think we should default to
> something sane that doesn't require _any_ > 0 order allocations.
> 
> Our default 1280kb will require 10248 bytes of iod, which is an
> order 2 allocation.... That's not helping tail latencies in
> data centers, where memory is always full and fragmented.

In terms of sizing, defaulting to 256kb might not be a bad idea.
That'd be 2056 bytes for a normal config. Alternatively we could
go 1280/4 == 320k, which would be 2568 bytes.

In any case, I think it's something that's worth doing.

-- 
Jens Axboe
