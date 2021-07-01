Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0FC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 09:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B20261452
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 09:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B20261452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/jsqaMK3FY5NKMKh94UwcK2jC/c6AzQWJmVesIr4XNg=; b=jkB6v6tsv9G+kS
	xlWyTy+hD+tVwqHj7wDnh/tDWEQ4NRwXqCdeQySQZ+9aiVlzZLVfLWepCDZK3M+w1amEUxHj6TWFL
	pk5NQitliJgV7CW0NGT4Lj723elJHJy/t/8afWijVGz+vbSg/Ul49QE2VgcjczTeYYSyMCb4mmMho
	n7/tu0XwTnx5njD+odRrpYu3FkQgxEaV/bbbJueoQaEe52Qwd7+J/ahHNunIA6yjVFUuUNdIbzxhh
	5f6dHUe8RitZGoCVofnff0epAa92k/uXZv0mjnLkCUmH1XOoe6w5lJUys/ub4aFwPq/7LlBLhaBXc
	H2Qm+9XDZghz7XXpK7MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lytN8-00GqYu-PV; Thu, 01 Jul 2021 09:52:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lytN5-00GqX6-Hs
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 09:52:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 188EF6736F; Thu,  1 Jul 2021 11:52:27 +0200 (CEST)
Date: Thu, 1 Jul 2021 11:52:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <20210701095226.GB2066@lst.de>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com> <YNu7rs7j5/KtQjAi@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNu7rs7j5/KtQjAi@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_025235_767877_00EFC950 
X-CRM114-Status: GOOD (  13.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 30, 2021 at 08:32:46AM +0800, Ming Lei wrote:
> Indeed, we may replace BLK_MQ_F_STACKING with BLK_MQ_F_NOT_USE_MANAGED_IRQ
> (BLK_MQ_F_NO_MANAGED_IRQ) too, and the latter is one general solution.

And now turn the polarity around and make it a BLK_MQ_F_MANAGED_IRQ set
by the map_queue helpers that rely on managed irqs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
