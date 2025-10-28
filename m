Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4EACCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6DWKCrqeMd8yEie8ux+bImvLbKULsBRhRlilfIMAOc=; b=Nftye9bgkV7zsavA2QE4qEZEj5
	Y3zEeAEo98tM0u0t9l6V4tGeFjv/xibCPUQKzjNbPMhnn/Wj37FM5vl8Gh39wZe2A6bJmUl/AY7Sx
	TI7oRFIeGZWKlm+8TuZ5ChVYU2K+yWpqZtP13UAFCtzkZva5rVSuBAWTn36YkOchVXnY4SqfZv56/
	41XqW7TLITQjyCtoqp3YIWTv7eWG1cnR/qELCDImZH+L1/4m9xyHQgI0/2cg4/biKyeiz8zLO5hIE
	sF3gdvzAv/mXRakiKQa5IMf+acTomd5TDhTcz20EsWL4p1EEYBBA4Gtn7GDzK36pl/Rp5cC1cxtmg
	LzTS8t3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDecW-0000000FUh2-3xdo;
	Tue, 28 Oct 2025 07:59:56 +0000
Received: from [195.3.219.148] (helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDecT-0000000FUfn-2Gca
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 07:59:55 +0000
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 2320520006;
	Tue, 28 Oct 2025 10:59:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 2320520006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1761638371; bh=C6DWKCrqeMd8yEie8ux+bImvLbKULsBRhRlilfIMAOc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=wW8s3UMt9YkpLDmA8dnGrRYvWBq5XJoXtVqgbcr78PCCKGClf8vzNvk23W0cROX4R
	 MQCm7zjT00VdWQKK9dOv2DxBUNyZBG4dYomaUaKR+xj3NrCQO9vhLQUoUCIKJX7d0O
	 Gv9MndjlkW1xD3m6+WFL34hXK0Uq9SMGyaTTTUXoOfwdngLdW+b4Kx5Kzjue2CUS6Q
	 L7PfOgij7DyZ+VRE/RHk7lGKU2R+TZNzWjfWFAwd6l9GOpDzlQw8LecRrZKOJTXdsL
	 NxfEVf8p55W6GSOlCysymTFrX2OXyV4nimwKjiJTinjoRXPWQt+TXXc4IjJ78CtlHs
	 v9Wi4ezxLMCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1761638371; bh=C6DWKCrqeMd8yEie8ux+bImvLbKULsBRhRlilfIMAOc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=hD1NkpdScXWFkWQbIKfU5Zi9iCBTPjUAMf06Pel1c+5+V4pBQYfUrGy51sHYUKdBE
	 zd517/sZswtybZvck+paZu4gsnAu5KQymBaZ8kee/jZXn+2NOKDlUo3XkW/81ePeri
	 aPiWOefE6rKEeWG4mXAqZBQm7y9TbIjq0yMIz2rAV6vYNP+D09BoKB6yJXRivoHzrM
	 lEhZe7GBrN+SglVNV048riNNlm0cEl9ivZh6vW/i34Nubzg+lAZeORo9MIUXAHF3aB
	 H0oXkdN79sSwOSnBeWkYL75kcSjFdHIqDU7hbwj0ljB+uenHQWvCxn7kB9D03x+C6/
	 Vj0yEqg8uAQ9A==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 10:59:28 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 10:59:26 +0300
Received: from yadro.com (172.17.34.55) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 28 Oct
 2025 10:59:25 +0300
Date: Tue, 28 Oct 2025 10:59:18 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, Stuart Hayes <stuart.w.hayes@gmail.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux@yadro.com>, <stable@vger.kernel.org>
Subject: Re: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20251028075918.GA14902@yadro.com>
References: <20251027163627.12289-1-d.bogdanov@yadro.com>
 <aP-m9btCap_dt32Y@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aP-m9btCap_dt32Y@kbusch-mbp>
X-Originating-IP: [172.17.34.55]
X-ClientProxiedBy: RTM-EXCH-01.corp.yadro.com (10.34.9.201) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/28 03:53:00 #27799916
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_005954_425760_21A802F7 
X-CRM114-Status: GOOD (  26.54  )
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

On Mon, Oct 27, 2025 at 11:08:05AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 07:36:27PM +0300, Dmitry Bogdanov wrote:
> > nvme uses page_frag_cache to preallocate PDU for each preallocated request
> > of block device. Block devices are created in parallel threads,
> > consequently page_frag_cache is used in not thread-safe manner.
> > That leads to incorrect refcounting of backstore pages and premature free.
> >
> > That can be catched by !sendpage_ok inside network stack:
> >
> > WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> >       tcp_sendmsg_locked+0x782/0xce0
> >       tcp_sendmsg+0x27/0x40
> >       sock_sendmsg+0x8b/0xa0
> >       nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> > Then random panic may occur.
> >
> > Fix that by serializing the usage of page_frag_cache.
> >
> > Cc: stable@vger.kernel.org # 6.12
> > Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> > Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> > ---
> >  drivers/nvme/host/tcp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 1413788ca7d52..823e07759e0d3 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -145,6 +145,7 @@ struct nvme_tcp_queue {
> >
> >       struct mutex            queue_lock;
> >       struct mutex            send_mutex;
> > +     struct mutex            pf_cache_lock;
> >       struct llist_head       req_list;
> >       struct list_head        send_list;
> >
> > @@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
> >       struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
> >       u8 hdgst = nvme_tcp_hdgst_len(queue);
> >
> > +     mutex_lock(&queue->pf_cache_lock);
> >       req->pdu = page_frag_alloc(&queue->pf_cache,
> >               sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
> >               GFP_KERNEL | __GFP_ZERO);
> > +     mutex_unlock(&queue->pf_cache_lock);
> >       if (!req->pdu)
> >               return -ENOMEM;
> 
> Just a bit confused by this. Everything related to a specific TCP queue
> should still be single threaded on the initialization of its tagset, so
> there shouldn't be any block devices accessing the queue's driver
> specific data before the tagset is initialized.

Hmm, we are both right. You are right that the preallocated requests that
are part of hw queue's tagset are preallocated at hw queue creation.
But there is one(per hw queueue actually) more request objects that
are preallocated for each block device - it's hctx->fq->flush_rq. I am
talking about that one.

The call stack is the following:
nvme_scan_ns_list =parallel on all CPUs=>
 nvme_scan_ns_async->nvme_scan_ns -> nvme_alloc_ns -> nvme_alloc_ns ->
 __blk_mq_alloc_disk -> blk_mq_alloc_queue -> blk_mq_init_allocated_queue ->
 blk_mq_realloc_hw_ctxs for each hw(TCP) queue do ->
  blk_mq_alloc_and_init_hctx(queue) -> blk_mq_init_hctx ->
  blk_mq_init_request(flush_rq) -> nvme_tcp_init_request ->
  page_frag_alloc(tcp_queue)



BR,
 Dmitry

