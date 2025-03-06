Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27126C282EC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aR/efFzBdjIziM7HhfuGfEifwF
	jHbJ+PTQ9FyDbeQuX0Rgwxlw0Z40x6aJh7bu2o5A4rlE+Ryi+LgOshU95CQzBYuIKSXIsRBTcU5rv
	GmqojictoHz+nBe5IKbqx5OK5EVk+9HjdleHHuR3QKXmUPp1rdqclsCtzfe37Rtx7+J4RJrjWcci7
	o5QZtQHyS2aJ7xXXzwhQdsz9rGG40VvdTO0A30EkmK93LKL875HdSRPwONydydgLcpWlEefFEJuup
	HAx3Hn5j0S0pW+fBusDoKfMsVclIjFnUsIcm3l5AEcAmyBbIuIN+OlAG4li3zQrfUGObrT/9VFAfw
	cxIpLSkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqBzC-0000000BASk-3goq;
	Thu, 06 Mar 2025 14:14:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqBz9-0000000BARL-1kwh
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 14:14:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF55968AA6; Thu,  6 Mar 2025 15:13:51 +0100 (CET)
Date: Thu, 6 Mar 2025 15:13:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: remove stale comment
Message-ID: <20250306141351.GA21296@lst.de>
References: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_061403_592698_A77F8C82 
X-CRM114-Status: UNSURE (   9.96  )
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


