Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8965EC7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=SpZmMrhqZT0nkw08s/nxDM/sCl
	mHNTP+y7NmVXV0lOi1E2h56NzV/QdykaXUUUQHUzt2YXAJ7hkn/5dNXMoi9x4yotp1e3FB0Csc8c+
	pC7rXdrg3FreKg99CnVrGW1kVTs8cRquJoS856vV9WAJUSj2sioYPaMMy0A7bubC17agIMZXodZ16
	Ffz7nrO4BRlwq0atIxEd651mZYzi/lOCkzEFnxirOhDZj8jVa2rhIuXVOnbswbSzJsI9vpBv2/9f5
	wHwU+N0mf91+JMzy9MG/dpqENxdQgG/Q9Ne5ygqFcJjdQwMbiu5FbM3Jy9EhnsFYpYspXOe9qgXlC
	nRjEWt4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4pK-004pMr-1q;
	Wed, 05 Apr 2023 15:13:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4pI-004pM3-1M;
	Wed, 05 Apr 2023 15:13:32 +0000
Date: Wed, 5 Apr 2023 08:13:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Tom Yan <tom.ty89@gmail.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] nvme: fix discard support without oncs
Message-ID: <ZC2QHME14K/yhsMG@infradead.org>
References: <20230403200925.1641963-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403200925.1641963-1-kbusch@meta.com>
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

