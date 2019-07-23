From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Wed, 24 Jul 2019 00:14:24 +0800
Subject: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
In-Reply-To: <20190722053954.25423-5-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
Message-ID: <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>

Hi Ming,

On 07/22/2019 01:39 PM, Ming Lei wrote:
> When aborting in-flight request for recoverying controller, we have

recovering

> maken sure that queue's complete function is called on completed
> request before moving one. For example, the warning of
> WARN_ON_ONCE(qp->mrs_used > 0) in ib_destroy_qp_user() may be triggered.
> 
> Fix this issue by using blk_mq_tagset_drain_completed_request.
> 

Should be blk_mq_tagset_wait_completed_request but not
blk_mq_tagset_drain_completed_request?

Dongli Zhang
