From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 12 Jun 2018 20:35:55 -0400
Subject: [PATCH 08/17] nvme: limit integrity segments to be <= data
 segments
In-Reply-To: <694e0f4e-bf79-6139-e5ba-86c01fcce4b2@mellanox.com> (Max
 Gurtovoy's message of "Sat, 9 Jun 2018 04:33:58 +0300")
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-9-git-send-email-maxg@mellanox.com>
 <19c8562a-8478-196c-c9f5-385d2076448e@grimberg.me>
 <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com>
 <yq17ena9mxc.fsf@oracle.com>
 <694e0f4e-bf79-6139-e5ba-86c01fcce4b2@mellanox.com>
Message-ID: <yq1po0vttec.fsf@oracle.com>


Max,

> I agree, but do you think it's reasonable to set max_integrity_segments 
> > max_segments ?

The upper bound for max_integrity_segments is number of sectors in the
I/O.

That's clearly a pathological corner case. But we used to be able to hit
it with the "right" choice of kernel memory allocator and dd with bs=512
(effectively because the allocator always allocated backwards in memory
so no two 8-byte PI allocations for a 512-byte buffer_head could be
combined into one contiguous segment).

-- 
Martin K. Petersen	Oracle Linux Engineering
