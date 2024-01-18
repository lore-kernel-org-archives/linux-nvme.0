Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A59C4725D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/Mec/5p9+EKLAFCABKLzW46J1sVgHE5SuS/MOmf2rY=; b=A/Qgba2axiDMp6JDZRvledBsO+
	hX96rkVOUVZn7fAjzsJ3AWl0dzkQUYfFIoTv0wNPBuYmGM8LjCxYqELMbqQo/6ujBessOwBD5UCyN
	wL/s08tV5dWUbXGkZxyPmrUUtrGHuXKHwCVImB6fXr1uCA1iGHbtNsKPutiPeFOuUfVVDI2htMPGY
	f6yD0yOliwlfyofq+/wDvVR1Xcp6Xw2Hl4R9DeEbutP/FJB/saqq4V3SXN9/JtfoYuzpqXvn3abig
	dicebbYL5dOnn+f1O+AF8PfASuNnqbX+1cLgQwxSUF5hwIXZIKTcvfSZbbL/xMZCFr/2aWlOD3McF
	Ge377RvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGVL-001D8i-0i;
	Thu, 18 Jan 2024 00:43:35 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGVI-001D8D-0y
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 00:43:33 +0000
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5f10052easo11214575ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 16:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538611; x=1706143411;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Mec/5p9+EKLAFCABKLzW46J1sVgHE5SuS/MOmf2rY=;
        b=xHKwhW6i2QY3VlwyeT4cJgf7+dzx01AiAa+0q+uWWNqowH69/KtInxiEyc6lpdnnOy
         xQ4Udx4ge7a5DtLu72ybrV5E2P4YVw9hkPOTaN1CrWZfH9KGW3Rc/Cp48xwLXH5Cw10t
         xfOssa8ettdhJEm/cEaRXJyPqqmsij9lDwxuL+1WbocOI5le3i9W0k02xmzbnjiEV2QQ
         qyK5E0VxLwIY+xx1bg0ZElcjzSMeDk1Ace8W4zXZPJnH+zmmdC4ymniScWAIBUBcD8gb
         mgl5RA+RERp4aeogi3Dj1bgijWsbapUDxwsNkb2Mf3jqZY/Ot+TeF6ITSxQ7jbh3o1+U
         WJNA==
X-Gm-Message-State: AOJu0Yyqe9CCuBO8eq9jTifdq3gfBT3E9IpVhsGknkAJMuiurSFiaIld
	2hyFo+MTRRFjw2G7Dz/wrCkaWs8KW5npofWYzzAkgNf0kxeD1n4r
X-Google-Smtp-Source: AGHT+IHapUT+JiDEqszaul6msXCqfsq0Mpjjz9hiim4Ceamg2aEC5IDtO0+h7Jgsa5NB8G+B/jANwg==
X-Received: by 2002:a17:902:f551:b0:1d5:746a:de1 with SMTP id h17-20020a170902f55100b001d5746a0de1mr143778plf.64.1705538610518;
        Wed, 17 Jan 2024 16:43:30 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id lg15-20020a170902fb8f00b001d5e996ed4bsm229711plb.263.2024.01.17.16.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:43:30 -0800 (PST)
Message-ID: <08d22893-9a05-415e-a610-9b1ceaaba96a@acm.org>
Date: Wed, 17 Jan 2024 16:43:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
 <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
 <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
 <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
 <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
 <90de77e4-ed8a-47be-b5df-2178913ec115@kernel.dk>
Content-Language: en-US
In-Reply-To: <90de77e4-ed8a-47be-b5df-2178913ec115@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_164332_365379_8958EDF6 
X-CRM114-Status: GOOD (  21.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/17/24 13:40, Jens Axboe wrote:
> On 1/17/24 2:33 PM, Bart Van Assche wrote:
>> Please note that whether or not spin_trylock() is used, there is a
>> race condition in this approach: if dd_dispatch_request() is called
>> just before another CPU calls spin_unlock() from inside
>> dd_dispatch_request() then some requests won't be dispatched until the
>> next time dd_dispatch_request() is called.
> 
> Sure, that's not surprising. What I cared most about here is that we
> should not have a race such that we'd stall. Since we haven't returned
> this request just yet if we race, we know at least one will be issued
> and we'll re-run at completion. So yeah, we may very well skip an issue,
> that's well known within that change, which will be postponed to the
> next queue run.
> 
> The patch is more to demonstrate that it would not take much to fix this
> case, at least, it's a proof-of-concept.

The patch below implements what has been discussed in this e-mail
thread. I do not recommend to apply this patch since it reduces single-
threaded performance by 11% on an Intel Xeon Processor (Skylake, IBRS):


diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..d83831ced69a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -84,6 +84,10 @@ struct deadline_data {
  	 * run time data
  	 */

+	spinlock_t lock;
+	spinlock_t dispatch_lock;
+	spinlock_t zone_lock;
+
  	struct dd_per_prio per_prio[DD_PRIO_COUNT];

  	/* Data direction of latest dispatched request. */
@@ -100,9 +104,6 @@ struct deadline_data {
  	int front_merges;
  	u32 async_depth;
  	int prio_aging_expire;
-
-	spinlock_t lock;
-	spinlock_t zone_lock;
  };

  /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -600,6 +601,16 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  	struct request *rq;
  	enum dd_prio prio;

+	/*
+	 * Reduce lock contention on dd->lock by re-running the queue
+	 * asynchronously if another CPU core is already executing
+	 * dd_dispatch_request().
+	 */
+	if (!spin_trylock(&dd->dispatch_lock)) {
+		blk_mq_delay_run_hw_queue(hctx, 0);
+		return NULL;
+	}
+
  	spin_lock(&dd->lock);
  	rq = dd_dispatch_prio_aged_requests(dd, now);
  	if (rq)
@@ -617,6 +628,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)

  unlock:
  	spin_unlock(&dd->lock);
+	spin_unlock(&dd->dispatch_lock);

  	return rq;
  }
@@ -723,6 +735,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
  	dd->fifo_batch = fifo_batch;
  	dd->prio_aging_expire = prio_aging_expire;
  	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->dispatch_lock);
  	spin_lock_init(&dd->zone_lock);

  	/* We dispatch from request queue wide instead of hw queue */


