Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1A5D40CF7
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=InA/SFc6GPZCfxt4IUwVU8pWfF
	BzhMOlrgUviHrrSGqgroZqHPTq/t/LtE9tTaPIlytLkeokz0z+D2QAC2CSimPkfq4S1Tzj+byOclO
	g51J3c7U4/wleRiQ2vKQ3P6USHNm15sjlyNE0RfO3zjMX1CTc+7VFYQOYYKFL/DgOci3jDnDRLidp
	sA4qgnUa2gLAsx19Z91jKd+aDo+bRaDmfmUlSATNZD8Qu8+p0tWKfCylaJ6dLMEp0+/xLMGs6U5o8
	UUDzHmShX0ZXVKKqumKiSyxGumh0TOYCO1HIkStVsfhmsWmcMnZ7DZRYlJQo41nTebWtt7/a3seMy
	2Nzlmn1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yka-00000001sdd-2skX;
	Wed, 06 Nov 2024 05:38:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YkY-00000001scx-2C2P
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:38:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A0E068AFE; Wed,  6 Nov 2024 06:38:35 +0100 (CET)
Date: Wed, 6 Nov 2024 06:38:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 02/11] nvmet: implement active command set ns list
Message-ID: <20241106053835.GB31330@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174904.3612888-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_213838_732722_1F755EB8 
X-CRM114-Status: UNSURE (   8.71  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


