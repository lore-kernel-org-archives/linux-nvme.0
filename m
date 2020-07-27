Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62421C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:32:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316A420809
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YxNsVcFO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DstyR3C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316A420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zqWMY4Ml85BfJ91KTj9/aWREwkiftEjZDPKHYi/imbo=; b=YxNsVcFOtNwxvxVJgOa5hVH+m
	QiHlBIY5TnKFrD9KwAsvys2sYioC+4/VpyPQldwOUpd6imz2/DgUuV8e7RWP4O70B5Ma4VDWxq49I
	r2kEmrPesonmyX9fREMHw4e0wf4NK8CAxf5Ag3TgDXZd6eP81ZezqbTrtvWhv8tzwlQbqLqC/99yy
	6FF6uSyNz/G7wHUUbtUD7pUJbBhqoNKWi5O3m3F2QRcGN8rdJJG9uj9ypGEP30sw+RO1uNQQFXN8n
	6FBFBE8w/vzOnp0rkD+fRrX+4Q34eoIAUAtbsP7duCF+EC8ew/prvlGPwVw5CPG/kpRmqswzmk4IE
	m21wOkcCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Cbu-0002rj-EY; Mon, 27 Jul 2020 23:32:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Cbs-0002rF-RE
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 23:32:45 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A203D20809;
 Mon, 27 Jul 2020 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595892764;
 bh=nKW56Q6BNIKHv+MQ+ujARc43W9v1hzOqKRZunVSdth0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DstyR3C2B3OCwIoZ/pcQIHgqjrstS0tWunDJnFBhM+bboTiuiDhJo0++zHLD+J4lK
 x9jqt+t8owg+UgJM3SFyRHBaCiByZR6XYje7WZMAQrlZmjoi1GMbEnIBGLghEI9C1z
 l5wp+2BLv41TIAtAOZEwVP3nMjrnNFzfoXLKcJUE=
Date: Mon, 27 Jul 2020 16:32:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727231022.307602-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_193244_954498_CB969D26 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> +static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> +		if (!hctx->rcu_sync) {
> +			synchronize_srcu(hctx->srcu);
> +			continue;
> +		}
> +		wait_for_completion(&hctx->rcu_sync->completion);
> +		destroy_rcu_head(&hctx->rcu_sync->head);

Leaking rcu_sync, and not clearing it across quiesce contexts. Needs:

		kfree(hctx->rcu_sync);
		hctx->rcu_sync = NULL;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
