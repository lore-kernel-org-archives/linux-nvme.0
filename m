Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B5C11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9E1613FD
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9E1613FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=751+xofRyIaob75Y9ICnTf9bbiNVxY0HRoLO8u4ErxI=; b=MiqxaeCfOwF728
	SoSz7cJYy3A2l4NcbLGH7CCdAcEl0UVDDeYSsljZA/zN1U1saIAWsoMZlOxCK5gxwuWUqsV+m05wD
	DdQ91PhRMzrF+hMVaEJFPTR5toYX4BCQBDzWx/Syg+72N46edO/JUY7KPAQra0dBBFev7jDER7G1q
	SP+TmMe5ytWRP7PWVI8gDiMJYyWHoUm+0O1IF/915RuSFpk2I4stUgBbHFBUJD+VCC4ZS0MDbatDc
	0Kt8z0uGxQ6gDDDMc++Zuw3KeB0sW3g432Cssrh1qC7TA2TlXf7n9SQaJYLW+oIu4C0RbwTB7LwPK
	8p6iSLEtKdMTtVShHlgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lywqS-00HUGv-HV; Thu, 01 Jul 2021 13:35:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lywqP-00HUFG-Ce
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 13:35:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 442AC68AFE; Thu,  1 Jul 2021 15:35:03 +0200 (CEST)
Date: Thu, 1 Jul 2021 15:35:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 kuba@kernel.org, smalin@marvell.com, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v4 03/20] nvme-fabrics: Expose
 nvmf_check_required_opts() globally
Message-ID: <20210701133501.GC18548@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-4-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210629124743.6898-4-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_063505_628290_68EB7B5A 
X-CRM114-Status: UNSURE (   8.65  )
X-CRM114-Notice: Please train this message.
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

This and the previous patch are pretty much two sides of the same coin
and belong together.  But without the registration indirection they
wouldn't even be needed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
