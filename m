From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 07 Jun 2018 19:50:07 -0400
Subject: [PATCH 08/17] nvme: limit integrity segments to be <= data
 segments
In-Reply-To: <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com> (Max
 Gurtovoy's message of "Thu, 7 Jun 2018 16:02:23 +0300")
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-9-git-send-email-maxg@mellanox.com>
 <19c8562a-8478-196c-c9f5-385d2076448e@grimberg.me>
 <f7bf4e84-f403-7576-299f-63b0c4aa6f1b@mellanox.com>
Message-ID: <yq17ena9mxc.fsf@oracle.com>


Max,

> This is for good practice, I don't think the block layer will/can send
> us more integrity_segments than data_segments.

They are orthogonal. The number of integrity segments is gated by the
max_integrity_segments queue limit.

-- 
Martin K. Petersen	Oracle Linux Engineering
