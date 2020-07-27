Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D8C433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C45B208E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3W238Sis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C45B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bq1DWHe0zvmmNpWHrm6sX5I5zZ3+uMWMiqLDAwyZ7FY=; b=3W238SisY2tAtIcF7Z9S7ZZQ4
	TdxpU1/B07dbW+QEcib/LosVrSDuEdQj1pQ5KAoWkHakRJUcGJQISfVYsQTQYrtN61Z6Bpr8ONYj4
	Z6e963NIatmA0AFbcXyyn69XAs4mYkfccS2aMC247W6u+SjXmLZ12CsOMPQqeZaHnzfJvy6yD0b9Q
	vJxDx7+FtxKoxQM6Du+lqDWMLHOeTBW/WM2ieQB3gP9ZV6BdM9zSEMg+T13avZ+BgD8fiF/d7Oz23
	kQAtFqPyzFUvB0MrJc+6wNoFtk8ZduQgt0bcm30QJEvoA4egjVa4YMxih6XZqlg9Y3Hb1A1WRc+ni
	0x+sI7w+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0BkH-0001HT-Vw; Mon, 27 Jul 2020 22:37:22 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0BkG-0001Gf-Af
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 22:37:21 +0000
Received: by mail-pg1-f194.google.com with SMTP id z5so10785652pgb.6
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 15:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=udsqUlm/RI+XzTKnm1HlW31DB2b2GvdRLvcgicwmbAQ=;
 b=D2qMffZMVgPeqszKXIF2JEx6+rfmBO6QUN2ICKATRNARSuyzLiZOx26nCiIygi0TVg
 lCswk/uaHuHo8F5wtsKmFkiqwNpc1SMiBK6mmZTWQ6fqdH21dKVB5ThTFmCBPfJjhTlh
 Enrta1VR2jQEXMR8ETOH0uk4Z6fNVGtQqIKuFgWLJ5DHzaL8qbE43tKy6N18TEzuiFnA
 cqjZGGZXpUeVyCaW80qHm07QVUi4wYO0XKZi9AgpouVLe5vulxBB5oEI9ALWdtqTpIHX
 Lyefuj01wOjFtyGEFmdg4vadzqHviwpo1tew2EjOk2LOzK31Mj84kPRRXSTVIyUBolBw
 6OaA==
X-Gm-Message-State: AOAM531+8kxTKdBxJ7o95hsqHOkrh7UfN6X+j+mI/T9RnVtN5WCznv3z
 oKT/fZkBGRJLAtnf+4GgAn4=
X-Google-Smtp-Source: ABdhPJxk3IVLLbhbUvFNyuOn4JiCSchcWX0Kdx54AHKTrmfJjm9h9KSz7N4QExx9mZVz29Xz0K5dow==
X-Received: by 2002:aa7:949a:: with SMTP id z26mr19906034pfk.171.1595889439015; 
 Mon, 27 Jul 2020 15:37:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id y24sm16202665pfp.217.2020.07.27.15.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 15:37:18 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blk-mq: add async quiesce interface
To: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200727220717.278116-1-sagi@grimberg.me>
 <20200727220717.278116-2-sagi@grimberg.me>
 <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e22c2f2f-6924-0090-d841-da2d84c606ae@grimberg.me>
Date: Mon, 27 Jul 2020 15:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_183720_454428_D086BCDA 
X-CRM114-Status: GOOD (  24.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +	int rcu = false;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>> +		if (!hctx->rcu_sync) {
>> +			/* fallback to serial rcu sync */
>> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +				synchronize_srcu(hctx->srcu);
>> +			else
>> +				rcu = true;
>> +		} else {
>> +			init_completion(&hctx->rcu_sync->completion);
>> +			init_rcu_head(&hctx->rcu_sync->head);
>> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
>> +					wakeme_after_rcu);
>> +			else
>> +				call_rcu(&hctx->rcu_sync->head,
>> +					wakeme_after_rcu);
>> +		}
>> +	}
>> +	if (rcu)
>> +		synchronize_rcu();
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> 
> This won't always be async, and that might matter to some users. I think
> it'd be better to put the fallback path into the _wait() part instead,
> since the caller should expect that to be blocking/waiting as the name
> implies.
> 
> Nit picking, but...

Makes sense..

I thought more about Keith suggestion for an interface that accepts a
tagset. It allows us to decide what we do based on the tagset itself
which is now passed in the interface.

What do you think about:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d4b24aa1a766 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,43 @@ void blk_mq_quiesce_queue_nowait(struct 
request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

+static void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       blk_mq_quiesce_queue_nowait(q);
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+                       continue;
+
+               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), 
GFP_KERNEL);
+               if (!hctx->rcu_sync)
+                       continue;
+
+               init_completion(&hctx->rcu_sync->completion);
+               init_rcu_head(&hctx->rcu_sync->head);
+               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+                               wakeme_after_rcu);
+       }
+}
+
+static void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!hctx->rcu_sync) {
+                       synchronize_srcu(hctx->srcu);
+                       continue;
+               }
+               wait_for_completion(&hctx->rcu_sync->completion);
+               destroy_rcu_head(&hctx->rcu_sync->head);
+       }
+}
+
  /**
   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have 
finished
   * @q: request queue.
@@ -2884,6 +2921,39 @@ static void queue_set_hctx_shared(struct 
request_queue *q, bool shared)
         }
  }

+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+       struct request_queue *q;
+
+       mutex_lock(&set->tag_list_lock);
+       list_for_each_entry(q, &set->tag_list, tag_set_list) {
+               if (!(set->flags & BLK_MQ_F_BLOCKING))
+                       blk_mq_quiesce_queue_nowait(q);
+               else
+                       blk_mq_quiesce_queue_async(q);
+       }
+
+       if (!(set->flags & BLK_MQ_F_BLOCKING)) {
+               synchronize_rcu();
+       } else {
+               list_for_each_entry(q, &set->tag_list, tag_set_list)
+                       blk_mq_quiesce_queue_async_wait(q);
+       }
+       mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+       struct request_queue *q;
+
+       mutex_lock(&set->tag_list_lock);
+       list_for_each_entry(q, &set->tag_list, tag_set_list)
+               blk_mq_unquiesce_queue(q);
+       mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
  static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
                                         bool shared)
  {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..a85f2dedc947 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
  #include <linux/blkdev.h>
  #include <linux/sbitmap.h>
  #include <linux/srcu.h>
+#include <linux/rcupdate_wait.h>

  struct blk_mq_tags;
  struct blk_flush_queue;
@@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
          */
         struct list_head        hctx_list;

+       struct rcu_synchronize  *rcu_sync;
         /**
          * @srcu: Sleepable RCU. Use as lock when type of the hardware 
queue is
          * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
@@ -532,6 +534,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int 
nr_hw_queues);

  void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct request_queue *q);
+void blk_mq_unquiesce_tagset(struct request_queue *q);

  unsigned int blk_mq_rq_cpu(struct request *rq);
--


And then nvme will use it:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..c41df20996d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);

  void nvme_stop_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_quiesce_tagset(ctrl->tagset);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);

  void nvme_start_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_unquiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_unquiesce_tagset(ctrl->tagset);
  }
  EXPORT_SYMBOL_GPL(nvme_start_queues);
--

Thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
