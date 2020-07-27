Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A62C433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:00:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABB420729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="muAfK7Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABB420729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DCTRBweeydzHXLwSpjVm2ed25b2wA1ItJmsOw8uMO7s=; b=muAfK7Pqh8PgLng6InZZ+X+cL
	HhsVgIcGKPleDjsAUfMo0kW5FEjugBKl8BrG2qrFKED9GoSA96Em/neQyeiwypTS1UKCbtr68gsJ0
	x5HKpj3yEPkKBRp6jpTNT3sfUvbjXtUV86L6ZLz9xeAYU/wRSGvefDN61sfg6oxdkAdopO1ihlRRa
	nAcNdnMD7EfJOOauFwz19aGuUCJ90GP9Uo2sOvgpaveIVvxVbKIUzsTpRI7LZpFb2AwZ2mPbbtHhT
	GZkrB3z11dO12QKfLAx7ud2aCake11mhi8UPvs4jrK/pmWqZhR0fM48tHAfI5/yrJBHKDLFqNjbwd
	AVjfDUe4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0AEP-00074g-Ab; Mon, 27 Jul 2020 21:00:21 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0AEM-00073w-H4
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 21:00:19 +0000
Received: by mail-pl1-f195.google.com with SMTP id b9so8802920plx.6
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 14:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+otlVdaFoXEGuYCKdx8dfww2sRITf488l6Vbt3WHVic=;
 b=hsHgrQH3jAKO10OT7izWwiQXE4gyI13SGo/eDtmPfhl5/Rb8CNYlx4fZr0zIBjuHWL
 zPvFLGZ0c8uIEz+kIFdEvsZ2p+VD3LODDPhzge0l4CSezmtnmpgSIpFBYXLRonqXKmLu
 Ah6MOFbzURX9egGv76tF8rJlLhOmrDNgVyi/2ThEbzvIo/no8GXvBh6wt5N75Zmq33BT
 k88XM/4uZs1R8qBE61L9g/VVfk8+VnGfWSr4A3RyjQTHZfvd1IK4xJyQ0t6pipSKIHfh
 0KGCEnXDPVUMMaArxbmC5hv5k1c8Oluig2krKdvy8Lh3ujXORtC63B4NZnyjv0qsfwKd
 evyg==
X-Gm-Message-State: AOAM530UXZaaBJWX3rDUhtb35S2DJrTBufKEWQOa3h0U0fXfr6O0oLaA
 ICtPvM8iW9HSyHgS5erwjis=
X-Google-Smtp-Source: ABdhPJyV65Q5RssUBbTuzAfqUTr62UEgn0j5b4lnIrOzLGrgwA1mDb4FpLpzbhg+KgPyYjNXTODTlg==
X-Received: by 2002:a17:90a:764c:: with SMTP id
 s12mr995386pjl.201.1595883617250; 
 Mon, 27 Jul 2020 14:00:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id 204sm16097933pfx.3.2020.07.27.14.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 14:00:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
Date: Mon, 27 Jul 2020 14:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_170018_595558_C62E4C30 
X-CRM114-Status: GOOD (  24.53  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>>> +{
>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>> +	unsigned int i;
>>>>>> +
>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>> +
>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>>> +				wakeme_after_rcu);
>>>>>> +		else
>>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>>> +				wakeme_after_rcu);
>>>>>> +	}
>>>>>
>>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>>
>>>> That's true, but I want a single interface for both. v2 had exactly
>>>> that, but I decided that this approach is better.
>>>
>>> Not sure one new interface is needed, and one simple way is to:
>>>
>>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>>
>>> 2) wait in driver specific way
>>>
>>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>>> then you may add per-tagset APIs for the waiting.
>>
>> Because it puts assumptions on how quiesce works, which is something
>> I'd like to avoid because I think its cleaner, what do others think?
>> Jens? Christoph?
> 
> I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
> call that.

I agree with this approach as well.

Jens, this mean that we use the call_rcu mechanism also for non-blocking
hctxs, because the caller  will call it for multiple request queues (see
patch 2) and we don't want to call synchronize_rcu for every request
queue serially, we want it to happen in parallel.

Which leaves us with the patchset as it is, just to convert the
rcu_synchronize structure to be dynamically allocated on the heap
rather than keeping it statically allocated in the hctx.

This is how it looks:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d913924117d2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct 
request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+       int rcu = false;
+
+       blk_mq_quiesce_queue_nowait(q);
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), 
GFP_KERNEL);
+               if (!hctx->rcu_sync) {
+                       /* fallback to serial rcu sync */
+                       if (hctx->flags & BLK_MQ_F_BLOCKING)
+                               synchronize_srcu(hctx->srcu);
+                       else
+                               rcu = true;
+               } else {
+                       init_completion(&hctx->rcu_sync->completion);
+                       init_rcu_head(&hctx->rcu_sync->head);
+                       if (hctx->flags & BLK_MQ_F_BLOCKING)
+                               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+                                       wakeme_after_rcu);
+                       else
+                               call_rcu(&hctx->rcu_sync->head,
+                                       wakeme_after_rcu);
+               }
+       }
+       if (rcu)
+               synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!hctx->rcu_sync)
+                       continue;
+               wait_for_completion(&hctx->rcu_sync->completion);
+               destroy_rcu_head(&hctx->rcu_sync->head);
+       }
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
  /**
   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have 
finished
   * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..7213ce56bb31 100644
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
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);

  unsigned int blk_mq_rq_cpu(struct request *rq);
--

and in nvme:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..e8cc728dee46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4561,7 +4561,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)

         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
+               blk_mq_quiesce_queue_async(ns->queue);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               blk_mq_quiesce_queue_async_wait(ns->queue);
         up_read(&ctrl->namespaces_rwsem);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

Agreed on this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
