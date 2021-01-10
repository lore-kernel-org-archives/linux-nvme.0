Return-Path: <SRS0=Xmhu=GN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE17C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 08:07:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF78323B02
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 08:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF78323B02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/DVzB8+vNeJttA3mTzDlHTZLsjB1KC/DC8B0GTbou/s=; b=mymzoqe7ef4l8HGrEcDyn8DKg
	0AL08IlIwQtPz92mVyRAeSQ4iM3WJeNbFuiAG8UW4E7OZ2uhzhoJ3bQR7mPTmTdjPGm25sG8nPIib
	sfNl/KNzbsN6dqJkZJpgyiPwlGOABl0bfeLSGMBCdiWkGOjPgkgcV6omCNtkE+jnYWB87HsWFVeCe
	FSvXQPFSeM+OEOOUAk3s3FjuTih8sVfcXDH5kSY203c/XCH4R2rVd1JG3oKiB5kBsLOSgOUndWRLO
	UiFiRvtCkgTAtcAmeb64UuTADrrDc1ODfSyGFU58IGj9/nmABpHTkknh8Ml81GsexYXPDyDM6M/mf
	0T+29b6QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyVkk-0003Fr-KH; Sun, 10 Jan 2021 08:07:10 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyVkf-0003Dw-LU
 for linux-nvme@lists.infradead.org; Sun, 10 Jan 2021 08:07:06 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id w127so13823967ybw.8
 for <linux-nvme@lists.infradead.org>; Sun, 10 Jan 2021 00:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6SynVo8msW0U7oUuxBPHsDBxiZxwhvdV7Q3p6COSBM8=;
 b=qUBEsF9y5BBgc/5bs3bPLdgrMy7UfBEMT4PjEo2DyoGhrWbTE3eSewhgsul3IuO9h2
 ZYMms/P8RS3L343//f9XStjNSU5PVqkyyMrcf0j1NKNuSKJqosZRl7m/yApXniHni/57
 sN9VysdVng5Xj6+RPUTmOaZFjWVO8o+btq2He2ReM7URSQC9KZU5/Ox5ftGsA8pzYomt
 lrNkgMW3uuZNkYN8Dx97ZtIW7t6FwpXxqPyjNXA+Bq+sZtbH2+92hpG5d5eT8XF5mSLA
 DGorE/sjqZ6ps73AhG8hHNb09RFrSvC4iB7KklXYmAf68h3ukDuO/Ss1WPAqFS8T7FU7
 tMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6SynVo8msW0U7oUuxBPHsDBxiZxwhvdV7Q3p6COSBM8=;
 b=C/yOqQGdDDZjCmrYPVE8JSPiMX06hl4DYU5sz4HgdZjuzxEGH0SSeHDep1mjHUL64z
 Gk26WrmkPN8E8a7C9iT2VKWtPbTDIk5ymV1jOwdKTbcMryY06BkV6K1930EGv94S+oGW
 eRvKN/mYQISTVYiddRgezrZKDaAKVMHFvJNb3YeLM3VKEOMeuhzMCK4de7K7bY99xpe+
 ctsaCX/tUuQ2S5F1ud2+O/LsBywqck9zZTVXe6hQymqwrdKw6Z6yrClCYjGx+3MTXRQv
 oGVQH9fp+9ECs/L2D05DB1ONdA/P/IA78pmeLNVxWDhzv2kCi4TcCKN70yAPHrYu51ky
 g6Wg==
X-Gm-Message-State: AOAM531l6Tw/rk0r4nhtjvjTbeYAUEtOBHfJ8u2ZMj4vneFCraSHfuwW
 by0XtD92SPTco851Re4L73FGqsiUuL8NRq6T7ms=
X-Google-Smtp-Source: ABdhPJzAbBDG2KXR6bVLMnXqLmfV6I+HrXnsoYIbTxpFOStSgB0JxTQBV4WEvs7jnT7V96klt4HV1MWvF5obEtxbaRA=
X-Received: by 2002:a25:e68d:: with SMTP id
 d135mr16944771ybh.329.1610266022123; 
 Sun, 10 Jan 2021 00:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20201221080339.945164-1-sagi@grimberg.me>
 <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
 <e206eb55-8792-b9c2-64cb-bd76ed09e12e@grimberg.me>
In-Reply-To: <e206eb55-8792-b9c2-64cb-bd76ed09e12e@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 10 Jan 2021 10:06:51 +0200
Message-ID: <CAJ3xEMj_GYOQA3hisdAPw3ybR55Un24+_9M51kvwiAkqvUOojg@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210110_030705_959564_20D68436 
X-CRM114-Status: GOOD (  17.69  )
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

On Fri, Jan 8, 2021 at 10:20 PM Sagi Grimberg <sagi@grimberg.me> wrote:

> Well, this is a heuristic anyways, too bad we need to
> disable preemption just for this...
>
> I'm assuming that this makes the issue go away?
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index cf856103025a..ea07336ca179 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -281,8 +281,11 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>                  bool sync, bool last)
>   {
>          struct nvme_tcp_queue *queue = req->queue;
> +       int cpu;
>          bool empty;
>
> +       cpu = get_cpu();
> +       put_cpu();
>          empty = llist_add(&req->lentry, &queue->req_list) &&
>                  list_empty(&queue->send_list) && !queue->request;
>
> @@ -291,8 +294,8 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>           * directly, otherwise queue io_work. Also, only do that if we
>           * are on the same cpu, so we don't introduce contention.
>           */
> -       if (queue->io_cpu == smp_processor_id() &&
> -           sync && empty && mutex_trylock(&queue->send_mutex)) {
> +       if (queue->io_cpu == cpu && sync && empty &&


if preemption happens here, the value returned by get_cpu() is not where
we run when the actual comparison takes place. So what you are saying
is that overall correctness will not be hurt? worth putting a comment
here for readers / future modifiers of the code

> +           mutex_trylock(&queue->send_mutex)) {
>                  queue->more_requests = !last;
>                  nvme_tcp_send_all(queue);
>                  queue->more_requests = false;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
