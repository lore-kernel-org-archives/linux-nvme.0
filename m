Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=uJjcZ8/lHwEe40A4Qx+F5zWfTw
	FByuY6AbNs6VAsrfhSMMelB7MItBe7NoJJ+sBYuH4uOu/mRQECPGDwFWuS+f9f1PXfmTF2hjzMUJo
	BQKjjYcT0a4Ext4h89VoJiRAhFrpzstNc3qeaRO5Q7x9e7IO/df3yg8hrMiBFXnfphsZGeKcdkR0x
	PWAlSdMDZ0XCoSqMXFBz7AvDCKfMO0MgnbBdfzrhkug3apX1SZOwpy4G0MnxV75MP5sY32v200Kl2
	8NhW7vlkZSE4ds5X4MJ/mPerV64fQxQCfnBZU3Fw4jvobP3aTvch43or8dzxBRnhysbiksPEcwEtl
	S7pAL1gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJCz-0007RB-Dv; Tue, 10 May 2022 06:18:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJCu-0007Q0-3w
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:18:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5560C68AFE; Tue, 10 May 2022 08:18:48 +0200 (CEST)
Date: Tue, 10 May 2022 08:18:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
 hch@lst.de
Subject: Re: [PATCH] nvme: mark internal passthru request RQF_QUIET
Message-ID: <20220510061848.GA11094@lst.de>
References: <20220419225351.29762-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419225351.29762-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_231852_337450_4A6F0C14 
X-CRM114-Status: UNSURE (   7.30  )
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

Thanks,

applied to nvme-5.19.

