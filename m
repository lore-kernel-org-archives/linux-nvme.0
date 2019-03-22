From: axboe@fb.com (Jens Axboe)
Date: Fri, 22 Mar 2019 15:44:11 +0000
Subject: [RFC] optimize nvme single segment I/O
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>

On 3/21/19 5:10 PM, Christoph Hellwig wrote:
> Hi all,
> 
> with all the discussion on small I/O performance lately I thought
> it was time off to dust my old idea to optimize this path a bit
> by avoiding to build a scatterlist.  I've only done very basic
> testing because I've been a bit busy, but I thought it might be
> worthwhile to get it out for feedback.

I ran this through some quick testing, and it's a big win for 4k
IOs here. Around an 8% improvement for cases that are CPU bound.

-- 
Jens Axboe
