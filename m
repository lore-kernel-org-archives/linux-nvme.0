Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14848C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dm3gbV5vp8K9QnDNayoXSsOiHgTs/9NmRp+0YwXH4hs=; b=LtTLwT4b77nUJl7lYZ463gmNEI
	n+jNpO7aBlZdtfFX9LWwYp9GOAvgdiJY639P1ZvO7Ptav/+ZxwCdBFB2OTvl9YvkMdc5jpCU6lohy
	mYp8eQzDgjUsU2SiKPt9hEERU04AEqNBHeKp/6669Q+goOMHUQFJK1chRcIasus1MZIqhzDRK9gTZ
	XwApdsLmgSLHOtpA+PWxmGJp2F4yW5TqZa9NF3UPTT5RoZl53NFkxPWdAXwhlYugGRgqS3d9hCPQi
	8PGiJ80XKVXvdWxAIdxVV0o4bCqVD3ucSzRbAsXE0TUX1eyDLgVhhGhx6WMIpMsRFmv2hmk4H9Xel
	PZDB/q5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T9a-004dAy-P1; Tue, 06 Dec 2022 08:18:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T9Y-004d9u-0e
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:18:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44DAB68B05; Tue,  6 Dec 2022 09:18:09 +0100 (CET)
Date: Tue, 6 Dec 2022 09:18:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: remove path cleanups
Message-ID: <20221206081808.GA8738@lst.de>
References: <20221129132208.4337-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_001812_217951_F0EA3FCB 
X-CRM114-Status: UNSURE (   8.84  )
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

Any comments on this series?

