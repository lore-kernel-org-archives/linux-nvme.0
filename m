From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jul 2017 10:15:28 +0300
Subject: [PATCH v2 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
In-Reply-To: <20170705071257.GA11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-2-git-send-email-sagi@grimberg.me>
 <20170705071257.GA11084@ming.t460p>
Message-ID: <c349a9f0-d4cb-e19a-acc9-2b7157f6ec21@grimberg.me>


> As I commented yesterday, blk_mq_kick_requeue_list() isn't needed.

I commented in the cover-letter, I am removing it a two steps to keep
bisection. I'm only allowed to remove it in patch 5/8.
