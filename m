Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46296C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=Nw6uu0EPYDyIbUnXwaU536B4B5
	uWd10xjm1wrJ4RWUD1+Wan/GXRHLNDTv4upPjyj/KjkZwti0eELamDZFROHUYzbqBHG/ZPCyRVhqS
	onbAWg0lUQHKWU4NQK58Vbhpmz3IOJe8p2rQRC/2T89kOKh/yMATw15qCWORDd0dXCxr5DRCu2C+b
	3sX+Ke/N4jmyV56NugpJi/ECfcvIU0hzadnSrz3WHKZC3rFajFOjwu7eNmU87FI8q4WZArIqtczTC
	lniPzStbRK06cdhC3m3nydm5ofCglsvRoVZ2fEePhTkGuImrLW//S0deLUQnaOGdVpGfF6m3eYsBA
	C13qx7sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGK-0054bP-2s;
	Wed, 03 May 2023 16:23:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGH-0054b6-1h
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:23:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4117468B05; Wed,  3 May 2023 18:23:22 +0200 (CEST)
Date: Wed, 3 May 2023 18:23:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Andrey God <andreygod83@protonmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE
 2048G
Message-ID: <20230503162322.GA2028@lst.de>
References: <20230503155733.866408-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503155733.866408-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_092325_724485_D3E29A5F 
X-CRM114-Status: UNSURE (   9.86  )
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

applied to nvme-6.3.

