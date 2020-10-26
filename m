Return-Path: <SRS0=2QKc=EB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE38FC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 10:28:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3184C2076D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hw6+7KFn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="E2zfUpFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3184C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kHGKKHihD8klD5xCF38nqgtBauypSBOdzx4sLh0oXn0=; b=hw6+7KFnWViRDq4/Qzc5q5Ooi
	eQhn8EGeQ4vpSK7W5HMZgvOziqArLgeS/+o4V3IAsgTYVkQe+jXA+rCTVqwa4D3XLSO0MfIaBHCo4
	ffYFAtGQ7O4ndNCcXqMb0qGo15Unn8BRtBpUBtPMgt3eRpqRHwM+A7f06MRzZ5iyp5MWNcn/stQ4M
	iCGW3FnGmjOzXIGhzSfKjnHu1fNeRBCA94l0lGccjmCV78pt2Xh5rfOl63l/Z9ZbnAIsxFKYZfNug
	xzpX9uKDgvTSxzpy0NsuOcMyHi7umxbe6I+4Qo6ijTtDjeY2PQZLC5aHOyH2qQs03hgGelDGF4Zux
	qWIuCLMrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWzjX-0007iD-2c; Mon, 26 Oct 2020 10:28:11 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWzjT-0007he-UY
 for linux-nvme@lists.infradead.org; Mon, 26 Oct 2020 10:28:08 +0000
Received: by mail-ed1-x52f.google.com with SMTP id l16so8700996eds.3
 for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2020 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=copLvvrJbazdXyqzCxJJdZkQMy9u28Uu7XeADF/luNk=;
 b=E2zfUpFIQqp9ywAEKRF009lVB3iwH3Qp3TrUZvNi3W+LCCdLdbt7WIwrnuVgZ2uZAf
 lNy4UYrAKpZxovIDLGKtY2AzlXbyAdLNU168hFv3Jb7NLdLYEgb9Tlw6Yx3NOf6TTRcn
 urIuno0pIpKuBn/vmrMuaTePlB17Mm2KFZ8Vu9EFKBjMSZYWbUitFEcQ/UtGenhm2S8/
 abqGffkI59+heAKtty/eR5jpwMBK+31Vp29Dmo1grr1u/gPUtYaga3jbuQIurXtggqkX
 N+SvEeNvHq03anJfjLNvuykhGOh6VTM5xvNRQVspCrnFJqIhNrFOYf8dDHN7CHPF6OVf
 GfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=copLvvrJbazdXyqzCxJJdZkQMy9u28Uu7XeADF/luNk=;
 b=igDx3d1GqoQr1KdPz+mPPwmNPnv0IdIz5Rdc5Nf6u9MGOiXhgUrwg+TEIWGyR2aB3o
 NvSg/qbCUoEvxHU+55vjYKKhbpcBu+PS4MYLvsrmmxrLBJzjghiuTl53OQEArrNbCzGO
 LDcoJ+uEhQpfhLFNY7MVJJ9tjSIX9uzUaRAxCSXQK51XU2obplO/dOswHqVkcHgluUSr
 mjbkTcGoKhLfD9OOnWqTu3MVD4+1YMhwcKkt+GFUqIQoBnvaCn+9NalVbpWiRtu5vvUU
 dZgBHsS+gGYWcyMWKsYFBFEFsX4BWnyzwKZ9dYf0iV2ysfvt+KrwnldGZxw6hjh19eGG
 oGoA==
X-Gm-Message-State: AOAM532iz2hYzBA1K6xVwjew9aUKDd252V9yCTOtPRFyT8r12jrmfN7v
 R7NKVrpUKPiy3dAHHCq12RVignz8CVQK+UN7PUb45Q==
X-Google-Smtp-Source: ABdhPJyngwSjrj4+Ve317ZAwKZ3iD+W162+gtyDMEc4SXEItx+azXITt68u4mP+DKn08ouZvlbqXGGoeRQDQe45qfKU=
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr13942233edy.3.1603708085000; 
 Mon, 26 Oct 2020 03:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
In-Reply-To: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Mon, 26 Oct 2020 15:57:53 +0530
Message-ID: <CAJpMwyhONwT6mYzOazjuWS01AVSd4bu=K33-LYk=ZygP021V4w@mail.gmail.com>
Subject: Re: Lock issue with 2a7cec53816 ("RDMA/cma: Fix locking for the
 RDMA_CM_CONNECT state")
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201026_062808_002730_97128253 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>, linux-nvme@lists.infradead.org,
 Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 26, 2020 at 1:50 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi Jason & Leon,
>
>
> [Sorry to send again since the previous mail didn't hit the list]
>
> With the mentioned commit, I got the below calltraces.
>
> [ 1209.544359] INFO: task kworker/u8:3:615 blocked for more than 120
> seconds.
> [ 1209.545170]       Tainted: G           O      5.9.0-rc8+ #30
> [ 1209.545341] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1209.545814] task:kworker/u8:3    state:D stack:    0 pid:  615
> ppid:     2 flags:0x00004000
> [ 1209.547601] Workqueue: rdma_cm cma_work_handler [rdma_cm]
> [ 1209.548645] Call Trace:
> [ 1209.552120]  __schedule+0x363/0x7b0
> [ 1209.552903]  schedule+0x44/0xb0
> [ 1209.553093]  schedule_preempt_disabled+0xe/0x10
> [ 1209.553253]  __mutex_lock.isra.10+0x26d/0x4e0
> [ 1209.553421]  __mutex_lock_slowpath+0x13/0x20
> [ 1209.553596]  ? __mutex_lock_slowpath+0x13/0x20
> [ 1209.553751]  mutex_lock+0x2f/0x40
> [ 1209.554045]  rdma_connect+0x52/0x770 [rdma_cm]
> [ 1209.554215]  ? vprintk_default+0x1f/0x30
> [ 1209.554359]  ? vprintk_func+0x62/0x100
> [ 1209.554532]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.554688]  ? printk+0x52/0x6e
> [ 1209.554852]  rtrs_clt_rdma_cm_handler+0x393/0x8b0 [rtrs_client]
> [ 1209.555056]  cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.561823]  ? cma_comp_exch+0x4e/0x60 [rdma_cm]
> [ 1209.561883]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.561940]  cma_work_handler+0x89/0xc0 [rdma_cm]
> [ 1209.561988]  process_one_work+0x20c/0x400
> [...]
> [ 1209.562323] INFO: task bash:630 blocked for more than 120 seconds.
> [ 1209.562368]       Tainted: G           O      5.9.0-rc8+ #30
> [ 1209.562404] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1209.562456] task:bash            state:D stack:    0 pid:  630
> ppid:   618 flags:0x00004000
> [ 1209.562515] Call Trace:
> [ 1209.562559]  __schedule+0x363/0x7b0
> [ 1209.562603]  schedule+0x44/0xb0
> [ 1209.562642]  schedule_preempt_disabled+0xe/0x10
> [ 1209.562685]  __mutex_lock.isra.10+0x26d/0x4e0
> [ 1209.562727]  ? vprintk_func+0x62/0x100
> [ 1209.562765]  ? vprintk_default+0x1f/0x30
> [ 1209.562806]  __mutex_lock_slowpath+0x13/0x20
> [ 1209.562847]  ? __mutex_lock_slowpath+0x13/0x20
> [ 1209.562887]  mutex_lock+0x2f/0x40
> [ 1209.562936]  rdma_destroy_id+0x31/0x60 [rdma_cm]
> [ 1209.562983]  destroy_cm.isra.24+0x2d/0x50 [rtrs_client]
> [ 1209.563586]  init_sess+0x23b/0xac0 [rtrs_client]
> [ 1209.563691]  ? wait_woken+0x80/0x80
> [ 1209.563742]  rtrs_clt_open+0x27f/0x540 [rtrs_client]
> [ 1209.563791]  ? remap_devs+0x150/0x150 [rnbd_client]
> [ 1209.563867]  find_and_get_or_create_sess+0x4a1/0x5e0 [rnbd_client]
> [ 1209.563921]  ? remap_devs+0x150/0x150 [rnbd_client]
> [ 1209.563966]  ? atomic_notifier_call_chain+0x1a/0x20
> [ 1209.564011]  ? vt_console_print+0x203/0x3d0
> [ 1209.564051]  ? up+0x32/0x50
> [ 1209.564093]  ? __irq_work_queue_local+0x4f/0x60
> [ 1209.564132]  ? irq_work_queue+0x1a/0x30
> [ 1209.564169]  ? wake_up_klogd.part.28+0x34/0x40
> [ 1209.564208]  ? vprintk_emit+0x126/0x2b0
> [ 1209.564249]  ? vprintk_default+0x1f/0x30
> [ 1209.564292]  rnbd_clt_map_device+0x74/0x7b0 [rnbd_client]
> [ 1209.564341]  rnbd_clt_map_device_store+0x39e/0x6c0 [rnbd_client]
>
>  From my understanding, it is caused by the rdma_connect need to hold
> the handler_mutex
> again in the path.
>
> cma_ib_handler -> mutex_lock(&id_priv->handler_mutex)
> -> cma_cm_event_handler
>                      -> id_priv->id.event_handler = rtrs_clt_rdma_cm_handler
> -> rdma_connect
> -> mutex_lock(&id_priv->handler_mutex)

I think its coming from

cma_work_handler() -> cma_cm_event_handler() ->
id_priv->id.event_handler = rtrs_clt_rdma_cm_handler
rtrs_rdma_route_resolved
-> rdma_connect tries to get the same lock again
                                       -> mutex_lock(&id_priv->handler_mutex)

Since, cma_ib_handler() doesn't handle and forward the
RDMA_CM_EVENT_ROUTE_RESOLVED event.
And cma_work_handler() also holds the mutex before calling
cma_cm_event_handler()

It probably starts with,

After RDMA_CM_EVENT_ADDR_RESOLVED comes to rtrs_clt_rdma_cm_handler,
rdma_resolve_route() -> cma_resolve_ib_route() -> cma_query_ib_route() --> ...
(callback) cma_work_handler()

>
>
> And seems nvme rdma could have the same issue since rdma_connect is
> called by
> nvme_rdma_cm_handler -> nvme_rdma_route_resolved.
>
> Thanks,
> Guoqing



-- 

Regards
-Haris

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
