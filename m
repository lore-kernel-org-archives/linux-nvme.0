Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE567CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3trVrrdax10FZKdXjtwDTMG3YFJ7fS0s6ViiPu5BHA=; b=aTFB0tPmkh6OTTBsYTwsCNUBmt
	f7GMUetUJxUcTH/LMqj15rphYVg3ffeJaHLQ7V0MWNEF+TfMOb7V6a045dHAvJyrmSWP3S8TkV9BS
	GDVihZ2t416YLzDpGVlPMOkKhv0syeW7cMZHp6RawWPUMmp5vbqVo4BRJdo+bcLpApInt//gW0URU
	Q+WrJFToXt3vaTNUTZjCuUi1CGXRDjpyhN0rXPN5+xaXWK4PPhQbZKvzat5GxC4dimZAjnLztf3YM
	GsSIDcqroRo5n+2/nrPoS+ixYLDsmxRrInryY7UmDCz7O8HRz3TqWyX3V7taSeM+k0XNpP33pPx8L
	zLPNQJhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zdk-00000008WAF-2hbY;
	Wed, 01 Oct 2025 16:25:16 +0000
Received: from mta-01.yadro.com ([195.3.219.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zdh-00000008W9L-32d7
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 16:25:15 +0000
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id C643F20011;
	Wed,  1 Oct 2025 19:25:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com C643F20011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1759335904; bh=z3trVrrdax10FZKdXjtwDTMG3YFJ7fS0s6ViiPu5BHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=yRnSNY0xPrAsOlIvc21vdIlxivEzTjjBCkVcpDFhvRNg4RZnQsRdR1oz3okSyBoIx
	 kbO3xdJNWJ34hxADqhhRS2HhTcQd0X98rg8rQSw4uMtbxyHc4b+KZidleGTJPXAiTf
	 ayR3vkOwfHKaEPftfHrp3OsmsHYT02QMENotZFZZLeG4r3ogdY7HXaVejZkOBrFe8I
	 t8lPJ8DlhfRhU8I0stL5CbKMUbZyVryT/PvXTkZ3j3D+7Qz4/OvAJG4ptk1SbWcWzj
	 gdCXuSVuTb2gPdunOpbHzpER9UIVRhASgbr2LIYPtl25TitSVGXLIC6PYBuj6t9jsF
	 jWqO4FomhTvQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1759335904; bh=z3trVrrdax10FZKdXjtwDTMG3YFJ7fS0s6ViiPu5BHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=YglptEjK2TXWhCGZqHah1tlH1bgRhKVwM0HebuyHqWTs4eCr0oFewE9uxiJ9AV+Ic
	 XuPOwj5mgaUb1GgfY5Enm88Okx+BfgOzrtfUsM87acG46aLYk95b8pYefMfI9uAhfs
	 d1SCKS3Xsu8JmdFx+6J/+/7ETOD80zYJe3NlefRlZb5l7RDwMMuUwaH6gunkrQtjS6
	 JK87OhZF0AWeCkqH1/AZBW17tev2wa4+BcPmv30hCWw4XJzP5Jb1WCHrLAfnlcvtCy
	 OzXwdR5M+AMUSakzXoK5eiJ14aZHw9z5+S40e3C8Zrzv0fjqJPfbukF8sUYjyL+ddS
	 hxXBBOG4bAPMQ==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Wed,  1 Oct 2025 19:25:01 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Oct 2025 19:25:01 +0300
Received: from yadro.com (172.17.34.51) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Oct
 2025 19:25:00 +0300
Date: Wed, 1 Oct 2025 19:24:59 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Chris Leech <cleech@redhat.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux@yadro.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: switch to per-cpu page_frag_cache
Message-ID: <20251001162459.GA4234@yadro.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
 <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
X-Originating-IP: [172.17.34.51]
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/01 16:02:00 #27871772
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_092514_440284_E2E2598E 
X-CRM114-Status: GOOD (  27.01  )
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

On Tue, Sep 30, 2025 at 11:34:14PM -0700, Chris Leech wrote:
> 
> nvme-tcp uses page_frag_cache to preallocate PDU for each preallocated
> request of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
>         tcp_sendmsg_locked+0x782/0xce0
>         tcp_sendmsg+0x27/0x40
>         sock_sendmsg+0x8b/0xa0
>         nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by switching from having a per-queue page_frag_cache to a
> per-cpu page_frag_cache.
> 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Reported-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d52..a4c4ace5be0f4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -174,7 +174,6 @@ struct nvme_tcp_queue {
>         __le32                  recv_ddgst;
>         struct completion       tls_complete;
>         int                     tls_err;
> -       struct page_frag_cache  pf_cache;
> 
>         void (*state_change)(struct sock *);
>         void (*data_ready)(struct sock *);
> @@ -201,6 +200,7 @@ struct nvme_tcp_ctrl {
> 
>  static LIST_HEAD(nvme_tcp_ctrl_list);
>  static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static DEFINE_PER_CPU(struct page_frag_cache, pf_cache);
>  static struct workqueue_struct *nvme_tcp_wq;
>  static const struct blk_mq_ops nvme_tcp_mq_ops;
>  static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -556,7 +556,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>         struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>         u8 hdgst = nvme_tcp_hdgst_len(queue);
> 
> -       req->pdu = page_frag_alloc(&queue->pf_cache,
> +       req->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
>                 sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>                 GFP_KERNEL | __GFP_ZERO);

I am not good at scheduler subsystem, but as far as I understand,
workqueues may execute its work items in parallel up to max_active work
items on the same CPU. It means that this solution does not fix the
issue of parallel usage of the same variable.
Can anyone comment on this?

>         if (!req->pdu)
> @@ -1420,7 +1420,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>         struct nvme_tcp_request *async = &ctrl->async_req;
>         u8 hdgst = nvme_tcp_hdgst_len(queue);
> 
> -       async->pdu = page_frag_alloc(&queue->pf_cache,
> +       async->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
>                 sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>                 GFP_KERNEL | __GFP_ZERO);

This line is executed in a different(parallel) context comparing to
nvme_tcp_init_request.

>         if (!async->pdu)
> @@ -1439,7 +1439,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>         if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>                 return;
> 
> -       page_frag_cache_drain(&queue->pf_cache);
> +       page_frag_cache_drain(this_cpu_ptr(&pf_cache));

This line is also definitely processed in other(parallel) context comparing
to nvme_tcp_init_request. And frees the still used pages by other queues.

>         noreclaim_flag = memalloc_noreclaim_save();
>         /* ->sock will be released by fput() */
> --
> 2.50.1
> 

In total, my patch with a mutex looks more appropriate and more error-proof.

BR,
 Dmitry

