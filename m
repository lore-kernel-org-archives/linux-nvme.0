From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Feb 2018 08:05:34 -0700
Subject: [PATCH] nvme: Fix discard buffer overrun
In-Reply-To: <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
References: <20180201000158.23012-1-keith.busch@intel.com>
 <9d61fdbe-ff60-2cf7-0d57-0bbb7133473f@oracle.com>
Message-ID: <20180201150533.GG27735@localhost.localdomain>

On Thu, Feb 01, 2018@10:55:30PM +0800, jianchao.wang wrote:
> Hi Keith
> 
> Since each discard bio merged into a request is counted as one segment,
> why not let blk_rq_nr_discard_segments return numbers of bios directly.

Right, I'm all for fixing the discard segment count. At the same time,
I don't want to depend on it's correctness to not access out-of-bounds
array indices.
