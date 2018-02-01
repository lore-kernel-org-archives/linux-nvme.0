From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 1 Feb 2018 08:27:33 -0700
Subject: [PATCH] nvme: Fix discard buffer overrun
In-Reply-To: <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
References: <20180201000158.23012-1-keith.busch@intel.com>
 <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
Message-ID: <1d659e2b-42a4-f453-c85b-5d58c6c01f40@kernel.dk>

On 2/1/18 7:55 AM, jianchao.wang wrote:
> Hi Keith
> 
> Since each discard bio merged into a request is counted as one segment,
> why not let blk_rq_nr_discard_segments return numbers of bios directly.

That's a good idea, but for now this looks fine. Both this and the
core block hole can be fixed, and then someone can hopefully work
on making discards behave a bit more nicely after that.

-- 
Jens Axboe
