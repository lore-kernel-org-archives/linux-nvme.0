Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE316D49C69
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 07:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uh32/EDIQFDFOnj8fdFERKIKqaaMmN6sE/HYcKgTjVw=; b=g7/Vw6B0Yg6BhcrHtqQZwK+iBT
	dnxM6vde0qnW+eL23DyvC2Hzu4Q5qK7l/zN96cIQFeRdcW25hNn68kH23BbCwoUmIUoKcywVfsdAB
	lg/yQrmxl7uz7wtiJRP0jinygcZbkCKDOg026baL3dWYf+bGxkmh1frCncGqqaZGhnPMGEoauXbL6
	cnusaX/KxDIQqF6XsT54EIDnvGbbnPZPdILGNIFraZT6Xe2zQdx4ekz/qz0qhIPBud6aJpRhh1a7U
	fRlmRSnv+vrQ2Mh3syie9Pul0uF98NoFLJu/Ou0Bqg86WnLNLsD4/gzPbe8+cLmtKWImdJcYHkZsy
	jE+jekrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vljCN-000000019xd-1qFO;
	Fri, 30 Jan 2026 07:45:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vljCJ-000000019xE-48tH
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 07:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769759141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh32/EDIQFDFOnj8fdFERKIKqaaMmN6sE/HYcKgTjVw=;
	b=SuOQ44lL+FMxaF9Sf1EMkeIY1Ni6UN3utZhaAm2I5pPiyFRprGvQBxMuLlm81CGYI+f/gv
	2JSa7+huWbjaOKsDHryAuv+G6jwY7MpP2XG5jaofh/Ih3sBgIB9pBJ8vgDdjNVvD4j7Shu
	FpoFePQ6FISMxz6/JqvD+HaDDMFjXG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-10YjuT3uPGq_m-7LVpifxA-1; Fri,
 30 Jan 2026 02:45:35 -0500
X-MC-Unique: 10YjuT3uPGq_m-7LVpifxA-1
X-Mimecast-MFC-AGG-ID: 10YjuT3uPGq_m-7LVpifxA_1769759134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6D719560B5;
	Fri, 30 Jan 2026 07:45:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D09AE180086E;
	Fri, 30 Jan 2026 07:45:27 +0000 (UTC)
Date: Fri, 30 Jan 2026 15:45:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
Message-ID: <aXxhkUXXOlrRw1sG@fedora>
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
 <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
 <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_234544_094716_5F743F00 
X-CRM114-Status: GOOD (  15.02  )
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

On Thu, Jan 15, 2026 at 05:24:58PM +0800, Yi Zhang wrote:
> Hi Justin and Chaitanya
> 
> It turns out that the kmemleak was caused by nvme-loop. It was
> observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
> log was reported during the nvme/fc test. That's why I didn't
> reproduce it with the stress nvme/fc test before.
> 
> [1]
> nvme_trtype=loop ./check nvme/
> nvme_trtype=tcp ./check nvme/
> nvme_trtype=fc ./check nvme/
> 
> unreferenced object 0xffff8881295fd000 (size 1024):
>   comm "nvme", pid 101335, jiffies 4299282670
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
>   backtrace (crc 414bcfcd):
>     __kmalloc_cache_node_noprof+0x5f9/0x840
>     blk_mq_alloc_hctx+0x52/0x810
>     blk_mq_alloc_and_init_hctx+0x5b9/0x840
>     __blk_mq_realloc_hw_ctxs+0x20a/0x610
>     blk_mq_init_allocated_queue+0x2e9/0x1210
>     blk_mq_alloc_queue+0x17f/0x230
>     nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
>     nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
>     nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
>     nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
>     nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
>     vfs_write+0x1d0/0xfd0
>     ksys_write+0xf9/0x1d0
>     do_syscall_64+0x95/0x520
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

It seems regression from 03b3bcd319b3 ("nvme: fix admin request_queue
lifetime"), can you try the following fix?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..64db8e3d8fd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4848,6 +4848,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	struct queue_limits lim = {};
 	int ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q) {
+		blk_put_queue(ctrl->admin_q);
+		ctrl->admin_q = NULL;
+	}
+
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;




Thanks,
Ming


