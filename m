Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A7DD3B7DD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcHlKfbZ3ErJB8QEORDi+NuyYT/9PoaTne1p7qZ4TSs=; b=uB+PTmoHL3SEgY8XJFZiaRMuqJ
	PjRdpH/PPGnaxZXypmHGT91qKjlw+6XeYFUZ/q6uqxlO2nJWyUSvws340ek9GJ9BXJMq3bV+nVB3f
	6szlh5I3PAecF6ZoPcuh1h6kC27fTXIvkx0agYXBiyDyIz4uRnzx+DszSs+Mdg39p5Mp3hklI5xAW
	Eh4m3gl/T41N+qhXiDcwNbhCsKhid5pkgO55B4VGZ8OU2zu3sEZCUDrl+NgYHGDMf7pb5aUfAiN0q
	IKtCiCl0L3jlh3Re1e5pzkRntNvB5H23yaX/yDH7wItf5QvLP5913zZHczo9kzWgLDpkEVFIbMwi8
	IBdfH4aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFT1D-00000007CTD-0Tmq;
	Mon, 25 Nov 2024 06:56:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFT1A-00000007CSo-27ua
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 06:56:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB86168D09; Mon, 25 Nov 2024 07:56:17 +0100 (CET)
Date: Mon, 25 Nov 2024 07:56:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: handle rw's limited retry flag
Message-ID: <20241125065617.GA15161@lst.de>
References: <20241121102454.122247-1-kanie@linux.alibaba.com> <20241122120959.GA25831@lst.de> <a336007f-88c1-41e3-826b-e080a4d78213@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a336007f-88c1-41e3-826b-e080a4d78213@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_225620_685744_63725C98 
X-CRM114-Status: UNSURE (   9.30  )
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

Can you add this to the commit log, please?


