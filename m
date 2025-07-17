Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B503C83F1A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyDGedYrP4k8Aszf5hpD4KCimePEOpFHiQOOiG+glm4=; b=WAGGC/QuzLnrXPtYi3H6y+COOC
	QjNCOIe9YSoqqy93pUem7r4OOJt9YLch2m+ZGSFEV7DmWu9T5kf9SZevuf+rHmhQrHBNcS7Vixgr6
	+I7MCNZqdLGMbgiUHIQNITsoblYZLkIawuAf8tBycxhPg8CZkFbJcU/dSMo9pQOfpNS/ucbX3Q57x
	WZo/+w92+pfyY9IB9qgAU7hrejZP/BWEt8SbJZRuIzIk9hTAzSNshoeHndQzJQluqNNC57P0Z1Z33
	O2KyIvCVRxPRFbOvWD/2KeLV/n7KehLlUSgvr8mERbaEYh2Cw6TYj7hjtlZyRiyWK13wb4nHh+n3u
	BsuDGKMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucOFc-0000000ACCq-3SFT;
	Thu, 17 Jul 2025 13:02:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMyv-00000009zzc-2fOL
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 11:40:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C88CB227A87; Thu, 17 Jul 2025 13:40:42 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:40:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] nvmet: pci-epf: Do not complete commands twice
 if nvmet_req_init() fails
Message-ID: <20250717114042.GA18331@lst.de>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_044057_815742_3B597FB9 
X-CRM114-Status: UNSURE (   8.76  )
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

applied to nvme-6.17.


