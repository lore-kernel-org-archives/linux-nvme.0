Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E48C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioDFt/GJJXjNHz4wX9wD3jb3DzC27IHBQWeq+vGfnSo=; b=C5m/pfeRcLGhQ4aEqQlrJevtXU
	V87DKR1CliDs6+bEKvZshCyPEzEsqQyG/+NVGY63NuPOL2lyYV61DsGUYCR+mcjFVPNVZ3Ws3c5H+
	7VqIyMOnm4umXBjh7S7qU0b+TeOowhbjZH9d61aPq8tYNoLjle+GwjhOs2s1JLXTOWB/J9H8IjrsD
	09fgVCekoEyZg3d9XGTAtMEWrALJYD7IRuuVcU8Ns1kSvUV7G7ra5ebVk33HlhObuIPgYARRSYflc
	BtyjD/P6RSB12kFqp0whSdMjCLpk85ibe67aVPGIAgSK/fHKMTxp6yWtpFtVZoYtXSJQddj0yEoiG
	o7RdY5ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCvUU-00000009MSO-2KWM;
	Fri, 31 May 2024 06:11:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCvUR-00000009MRS-2ofZ
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 06:11:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F19E768BFE; Fri, 31 May 2024 08:11:42 +0200 (CEST)
Date: Fri, 31 May 2024 08:11:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240531061142.GB17723@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530183906.4534c029@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_231147_885439_3FCA2C99 
X-CRM114-Status: UNSURE (   9.74  )
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

FYI, I still absolutely detest this code.  I know people want to
avoid the page copy for NVMe over TCP (or any TCP based storage
protocols for that matter), but having these weird vendors specific
hooks all the way up into the application protocol are just horrible.

IETF has standardized a generic data placement protocol, which is
part of iWarp.  Even if folks don't like RDMA it exists to solve
exactly these kinds of problems of data placement.   And if we can't
arse folks into standard data placement methods we at least need it
vendor independent and without hooks into the actual protocol
driver.


