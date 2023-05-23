Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F7C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FoIH90YrsJqmLdNcFJnZhP/eiH
	feErwtCJaisdu5x2wanYaTBeNNCLW68ra46keC2S1a9L1w2M3vCFsJzGjOMHb4tOLpFvPo2jm5Cgq
	r1ZLUfWrM6WAlFq7vJE4xVZbTkhF+KgK2QXO94HKVUn09J73S0ubPOEpV6teKnZ91jEnm9i38McAN
	fwdiiK4hyvSnNfQ68Rwoy3D+xxlP0vtNXfQyrHLF42DtQz4mP7N/hSCk3ye03xvk7AkUVlE48Lnao
	xX9FeVLIv8OF6aPR4+K11FMqOvThnF/mbcPQNx9lZHEYg26tps4GRN+dqMIh/D2Lqmdrx6WAHXhk/
	u9lzNu+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LIT-0093E1-1Q;
	Tue, 23 May 2023 06:15:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LIP-0093Cq-2r
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:14:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EF4A67373; Tue, 23 May 2023 08:14:50 +0200 (CEST)
Date: Tue, 23 May 2023 08:14:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tatsuki Sugiura <sugi@nemui.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] NVMe: Add MAXIO 1602 to bogus nid list.
Message-ID: <20230523061450.GA6334@lst.de>
References: <87ttw7i6p7.wl-sugi@nemui.org> <20230520122350.2232956-1-sugi@nemui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520122350.2232956-1-sugi@nemui.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_231458_096123_1C4E99C1 
X-CRM114-Status: GOOD (  10.38  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

