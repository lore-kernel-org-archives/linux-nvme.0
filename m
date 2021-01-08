Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B72C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 20:20:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8245723AC0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 20:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245723AC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=05JWI6d0qNdKHr6PbMy41l0mjO/GVLmdF2xHfe63Ov0=; b=AbjGyJtBdYoZHu0sOJSWnq4G7
	qVzSSzXDf8LkS0hVNRi0DTw98s/YM6lE5JIzXHi1H94yiACdmz1E6JK7Z0vdgRwve8D5qGh/SXRtS
	3bMD8XKWSG3uf7vHyOaATFfTyU2hyXbTlJNl748M5RocF1uEL/3Mf0CjTW+KdEkl7KZggVY57MKUK
	oIF2atZAAbvcJd/9WpbRZab5YNW8KfNQyAQt1vIC7fvHAQ9ILtEtDDmDBtTgQA9kbE3RYEJctuh9t
	qbgBL02vlVqgOGyr+PGW5owF2VUCJdWM86wDqfs7b5jp4NeBBcKeubskDW4OzD5hgmTiCXocASIQL
	Rf/n5ZBrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxyFI-0003AA-1y; Fri, 08 Jan 2021 20:20:28 +0000
Received: from mail-oi1-f181.google.com ([209.85.167.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxyFD-00038t-GI
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 20:20:24 +0000
Received: by mail-oi1-f181.google.com with SMTP id x13so12734751oic.5
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 12:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u+FQiCN2E00Q71ctkpKMaqXwGxda5BVBlS6+lfb5V5U=;
 b=jkpEfDz18/cRdq0zCHyU/7MiQpyNp+0iQwvlEVoKAq+De1WqBklh+uQrgh6vWqK6Ag
 V8Q/81Lq4gVyFGUUm5hr9BN/HTkbY1021CVT2TCRT81i4gXfdLVZKS5ruaWbatzskG6M
 9W1UrZt+xaRW44JdxdKI+EDUgAMqRGmgtfEVfby9KT94nsUsKKziZyCrc6t+90O631y0
 udkVh0ZVE6K0Rtu4nRwE6b3pdgfiYpHebHLxk+gPtfGcByZpxfi1SXbIo3fZkR/K5bsK
 UtZz2pCh/CAtXAssFgCHYlhmVgDpDOvy8Alm3rwUDRMiTD0HG0IMPJSLFRupJ5tnxEaL
 RxLQ==
X-Gm-Message-State: AOAM533RqPPx1931daMT+n6guW9oywsqWYdcNiN/jEYZ8eih+vhM0OgC
 tvK/UExX33lDrrjMtt6x2vI=
X-Google-Smtp-Source: ABdhPJwbHPBS2/Aam6uACMtnCoHf8WJBFUtF/mnTyZ6rPjtvYzCWDbgicu9eFuc3LkQ2PXBM4CG1lA==
X-Received: by 2002:aca:f382:: with SMTP id r124mr3461303oih.175.1610137218343; 
 Fri, 08 Jan 2021 12:20:18 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:bedd:602e:8a53:5431?
 ([2600:1700:65a0:78e0:bedd:602e:8a53:5431])
 by smtp.gmail.com with ESMTPSA id 73sm1984792otv.26.2021.01.08.12.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 12:20:17 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
To: Or Gerlitz <gerlitz.or@gmail.com>
References: <20201221080339.945164-1-sagi@grimberg.me>
 <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e206eb55-8792-b9c2-64cb-bd76ed09e12e@grimberg.me>
Date: Fri, 8 Jan 2021 12:20:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_152023_583396_5E790063 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: Keith Busch <kbusch@kernel.org>, Boris Pismenny <borispismenny@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Ben Ben-ishay <benishay@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
> 
>> @@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>>          if (queue->io_cpu == smp_processor_id() &&
>>              sync && empty && mutex_trylock(&queue->send_mutex)) {
> 
> but we can't rely on the processor id if we are on preemptible state..
> 
>    373.940336] BUG: using smp_processor_id() in preemptible [00000000]
> code: kworker/u8:4/457
> [  373.942037] caller is nvme_tcp_submit_async_event+0x4da/0x690 [nvme_tcp]
> [  373.942144] CPU: 0 PID: 457 Comm: kworker/u8:4 Not tainted 5.11.0-rc1+ #116
> [  373.942171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [  373.942196] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
> [  373.942259] Call Trace:
> [  373.942286]  dump_stack+0xd0/0x119
> [  373.942346]  check_preemption_disabled+0xec/0xf0
> [  373.942397]  nvme_tcp_submit_async_event+0x4da/0x690 [nvme_tcp]
> [  373.942449]  nvme_async_event_work+0x11d/0x1f0 [nvme_core]
> [  373.942496]  ? nvme_ctrl_loss_tmo_show+0x140/0x140 [nvme_core]
> [  373.942576]  process_one_work+0x9f3/0x1630
> [  373.942649]  ? pwq_dec_nr_in_flight+0x330/0x330
> [  373.942765]  worker_thread+0x9e/0xf60
> [  373.942849]  ? process_one_work+0x1630/0x1630
> [  373.942889]  kthread+0x362/0x480
> [  373.942918]  ? kthread_create_on_node+0x100/0x100

Well, this is a heuristic anyways, too bad we need to
disable preemption just for this...

I'm assuming that this makes the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cf856103025a..ea07336ca179 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -281,8 +281,11 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
                 bool sync, bool last)
  {
         struct nvme_tcp_queue *queue = req->queue;
+       int cpu;
         bool empty;

+       cpu = get_cpu();
+       put_cpu();
         empty = llist_add(&req->lentry, &queue->req_list) &&
                 list_empty(&queue->send_list) && !queue->request;

@@ -291,8 +294,8 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
          * directly, otherwise queue io_work. Also, only do that if we
          * are on the same cpu, so we don't introduce contention.
          */
-       if (queue->io_cpu == smp_processor_id() &&
-           sync && empty && mutex_trylock(&queue->send_mutex)) {
+       if (queue->io_cpu == cpu && sync && empty &&
+           mutex_trylock(&queue->send_mutex)) {
                 queue->more_requests = !last;
                 nvme_tcp_send_all(queue);
                 queue->more_requests = false;

--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
