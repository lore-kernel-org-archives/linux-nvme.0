Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAE3EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bIsUfNXHjhT33QbV0wAFJ52K1z
	KcYDzVGzzEitf2y55uea6DSp+3Dn4X9fa+9CGZ9JSm4q8RWtR8BWEMlG9Fe7ozygE3i/tcoT1PETK
	J0UL5vGQ6gr+fPrTvKRDCMcIOTQCN7zv7BWsMEtKvpGHPm70k7IhjpmEr5tEsOEvf+4J6eh3whm1f
	A78LqehNgceRybU4RYYsR2rr7cmTOSSEK58dwTGwNpfbm4ytCN0dMFMmdcljSRJwdx2fEWTw0eOfp
	gJHrnRYbpYQ998F56XzM2pqF7A4wIecDtjw9c4g98r7bUb15bSTADWOHqjDTWEzVMqeycW7xqQe6O
	IY4cGk4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJc1J-000P0z-1x;
	Wed, 12 Jul 2023 15:44:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJc1G-000P02-2k
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 15:44:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19A5067373; Wed, 12 Jul 2023 17:44:43 +0200 (CEST)
Date: Wed, 12 Jul 2023 17:44:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCHv2] nvme: warn only once for legacy uuid attribute
Message-ID: <20230712154442.GA26931@lst.de>
References: <20230712152639.281545-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712152639.281545-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_084447_033856_C05E49B6 
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

