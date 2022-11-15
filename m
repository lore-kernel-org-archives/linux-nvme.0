Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1475C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=WLLbE7vnFearAvD04SNsUkBeKK
	jhcyTE6RAteDgE9F44rJBnKZTYWjjo75rDCZVWJYqxnnDgzP1HmN1+dcAMYk7PYYIFQNiDyFss4jF
	IdQlCbZg7cfoK9iiKcp0n2jzBRUrv997FvMu0d3CUq3F9C5ybQSEAVCh63pFYz9tz2EIqXHEuO7PG
	E4BHeYk3DfbJKyKFMXtU3P4Z5cgtcH4jK/30g59P1FSPAiLwEYTlX12OUekR8BGVlMNuozkio4znG
	puwh+DzHyRfPLUaJ12gJ4k7mtKU1lb3Ium6zmLd9mc+Je+BOYYj22nxyvQ/T4t2ewJ8Y8cFRDCxuI
	WUAgwdJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousxe-009mCn-Lu; Tue, 15 Nov 2022 10:14:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousZB-009Zha-3l
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 09:49:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CC0567373; Tue, 15 Nov 2022 10:49:13 +0100 (CET)
Date: Tue, 15 Nov 2022 10:49:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bean Huo <beanhuo@iokpp.de>
Cc: beanhuo@micron.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro
Message-ID: <20221115094913.GB25284@lst.de>
References: <20221114134852.73402-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114134852.73402-1-beanhuo@iokpp.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_014917_334876_8243F1C9 
X-CRM114-Status: UNSURE (   8.61  )
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

applied to nvme-6.1.

