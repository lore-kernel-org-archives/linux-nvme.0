From: josef@toxicpanda.com (Josef Bacik)
Date: Wed, 5 Jul 2017 14:08:28 -0400
Subject: [PATCH v3 6/8] nbd: quiesce request queues to make sure no
 submissions are inflight
In-Reply-To: <1499274037-17438-7-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-7-git-send-email-sagi@grimberg.me>
Message-ID: <20170705180827.GA18539@destiny>

On Wed, Jul 05, 2017@08:00:35PM +0300, Sagi Grimberg wrote:
> Unlike blk_mq_stop_hw_queues, blk_mq_quiesce_queue respects the
> submission path rcu grace. quiesce the queue before iterating
> on live tags.
> 
> Reviewed-by: Ming Lei <ming.lei at redhat.com>
> Cc: Josef Bacik <jbacik at fb.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Sounds fine by me, you can add

Acked-by: Josef Bacik <jbacik at fb.com>

Thanks,

Josef
