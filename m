From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 May 2018 13:46:19 -0500
Subject: [PATCH RFC 0/2] 8K Inline Support
In-Reply-To: <cover.1525880285.git.swise@opengridcomputing.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
Message-ID: <190dc0f4-35c0-7424-8b38-6ff27ef255d7@opengridcomputing.com>



On 5/9/2018 10:38 AM, Steve Wise wrote:
> For small nvmf write IO over the rdma transport, it is advantagous to
> make use of inline mode to avoid the latency of the target issuing an
> rdma read to fetch the data.  Currently inline is used for <= 4K writes.
> 8K, though, requires the rdma read.  For iWARP transports additional
> latency is incurred because the target mr of the read must be registered
> with remote write access.  By allowing 2 pages worth of inline payload,
> I see a reduction in 8K nvmf write latency of anywhere from 2-7 usecs
> depending on the RDMA transport..
>
> Is this a worthwhile change?  I think it is.  Please comment!
>
> Thanks,
>
> Steve


By the way, this patch series is untested on the current top-of-tree; I
ported it from an older 4.9 kernel where I was doing the performance
testing.? As the series is RFC, I'm just looking for whether folks think
this is a "good idea" or not.?? So I'll post something that is ready to
merge if I get positive feedback on moving forward.


Steve.
