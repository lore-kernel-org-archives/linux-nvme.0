Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 19:06:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0359B2343E
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 19:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0359B2343E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WnDfND/dSkqCRybrhbZKqs9HEpO95PfypZIpLCcmfa8=; b=LjMWPEPVYR3KhB/HjwWgkKoU9
	Hl4FwKMxkiN0Kg+0qiZSGT7VV/xvhiP9/qmvFayX9tEMGyvsi8T358gZ0FKdMESeReg1OX45FJXoV
	xnc9X0/jxP+Buc8961B5d5gQR7KaLbcuHTCTqbgAwU39jTCPHOo+Fdi/2xawCwWLjAp3z+9sccLot
	MMVYrTsRlaGoivYqIiFKz9yx2pkf7rUW025EWR8dM2Spp5TnhwAvNyqK063dMi9qth1Auua6mwZbJ
	ipVp2G1VaMJL1cQgQDekfCE9kxI+NcPW9hH4L/AU8EPuYN7HmsLN+USCz8/3qLvFjNvUNxMqpmf7p
	YZVQa+0WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxabY-00086E-0N; Thu, 07 Jan 2021 19:05:52 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxabT-00085X-Ns
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 19:05:49 +0000
Received: by mail-yb1-xb35.google.com with SMTP id d37so7107405ybi.4
 for <linux-nvme@lists.infradead.org>; Thu, 07 Jan 2021 11:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R8XV0IMywYtoEC7O4tTrb29F3LsdpHm75IuB8mGGcKI=;
 b=c/83JJRXt/pFMsG4X2fBSWBPyYmGoxM52/Eiwv960YqSfdPM/mXfqv/0wmp5FzRXmd
 xJhPJ9gbrD79+53rTJx/Kjhn/LRhxdy4yrCIX7/126jqF4QlEONCCoC0sw7kAPZRkGff
 RQBlMUToMRVNT7IBcjoRYMvFaThEkfx6ONXBwj6WT0HK6w+2ZH8c+ENvmJxQ3IcYgoSa
 IoFpgM599jVp5NZQKifnvYyavKnqssf/eaVv4owb1Cr5cnDiJN700AU4IuhM40PSGe2y
 RM4F7CCE5a2F+CRdgPuEWHLIRcBuFhpNUyzpAGJLw4v2OgHYp56kK+BZH2QC06J7vV8j
 6ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R8XV0IMywYtoEC7O4tTrb29F3LsdpHm75IuB8mGGcKI=;
 b=EMjqryYzC34/6fKPuARDtrH+kyn+eCDdGh8oO5zW0kcOO4yCmmVuwCN6LbhdICPEdp
 QsewCYWNVDatvJu1ehrGtqOyc42sZT1TdpdwOIG/Z/uEL2SGqvOLbWs7tUQKhkeMsW6h
 8eM8QUTYy1VazIncN2MBImdxCAeqJ0v0H4VsrNyQNWlT4x/BTDfWR6XLbTIJa2TmF9EG
 vP9IufA0dRbDxWxuN2ktLI98hwAiwlPUkkT0OR7FXx3LoXlrcDzXVhWzTko6s/G+9FRM
 HTcF1tUG29O0ddhu1kgbZpR5DiQ2PQlSG7wrEYPtd2FEdY4ymddFay0fT/0f5wgTIRmi
 8hJw==
X-Gm-Message-State: AOAM530A4adHRKg2PcCWgLdAnmu99p12x9TZWBbGZo7qK6tbpeA4aeeR
 7WiacK7U8P/VTCoNWHmARalHHcRzx6PqZw4u/Oc=
X-Google-Smtp-Source: ABdhPJyvddzCHeWo3s50/2j4cxNV5qdkitMCQRU425iyWF1iVvEFEt2BaV0zDIwtiEaRAGrLmb4qtC7CSUT9yLOn5qM=
X-Received: by 2002:a25:6902:: with SMTP id e2mr318491ybc.97.1610046344201;
 Thu, 07 Jan 2021 11:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20201221080339.945164-1-sagi@grimberg.me>
In-Reply-To: <20201221080339.945164-1-sagi@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 7 Jan 2021 21:05:32 +0200
Message-ID: <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_140547_883768_1615806C 
X-CRM114-Status: GOOD (  17.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 21, 2020 at 10:06 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> We may send a request (with or without its data) from two paths:
> 1. From our I/O context nvme_tcp_io_work which is triggered from:
> - queue_rq
> - r2t reception
> - socket data_ready and write_space callbacks

> 2. Directly from queue_rq if the send_list is empty (because
> we want to save the context switch associated with scheduling
> our io_work).

> Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
> Reported-by: Potnuri Bharat Teja <bharat@chelsio.com>
> Reported-by: Samuel Jones <sjones@kalrayinc.com>

> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c

> @@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>         if (queue->io_cpu == smp_processor_id() &&
>             sync && empty && mutex_trylock(&queue->send_mutex)) {

but we can't rely on the processor id if we are on preemptible state..

  373.940336] BUG: using smp_processor_id() in preemptible [00000000]
code: kworker/u8:4/457
[  373.942037] caller is nvme_tcp_submit_async_event+0x4da/0x690 [nvme_tcp]
[  373.942144] CPU: 0 PID: 457 Comm: kworker/u8:4 Not tainted 5.11.0-rc1+ #116
[  373.942171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[  373.942196] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
[  373.942259] Call Trace:
[  373.942286]  dump_stack+0xd0/0x119
[  373.942346]  check_preemption_disabled+0xec/0xf0
[  373.942397]  nvme_tcp_submit_async_event+0x4da/0x690 [nvme_tcp]
[  373.942449]  nvme_async_event_work+0x11d/0x1f0 [nvme_core]
[  373.942496]  ? nvme_ctrl_loss_tmo_show+0x140/0x140 [nvme_core]
[  373.942576]  process_one_work+0x9f3/0x1630
[  373.942649]  ? pwq_dec_nr_in_flight+0x330/0x330
[  373.942765]  worker_thread+0x9e/0xf60
[  373.942849]  ? process_one_work+0x1630/0x1630
[  373.942889]  kthread+0x362/0x480
[  373.942918]  ? kthread_create_on_node+0x100/0x100

       /*
+        * if we're the first on the send_list and we can try to send
+        * directly, otherwise queue io_work. Also, only do that if we
+        * are on the same cpu, so we don't introduce contention.
+        */
+       if (queue->io_cpu == smp_processor_id() &&
+           sync && empty && mutex_trylock(&queue->send_mutex)) {
+               nvme_tcp_try_send(queue);
+               mutex_unlock(&queue->send_mutex);
+       } else {
+               queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+       }

so before this patch that check was not needed? I was not sure re all
the involved contexts and how to fix that.. so just sending the report

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
