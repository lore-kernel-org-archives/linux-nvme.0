Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF520CD6E55
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wu48l5iD1Sov15+RYdIkVil0yO
	ySDDQp5PRsM7eLLGUM3EJIT1gzD1TYki4Nsw9vsdu/vOo/QIhIGqyZMd/6SS7NG0KMD/m6gQ6DKu5
	kCZtd7BIPw+bXYM/K1Xe/eQRD/wllh+ZRynzY+8gVCSkT0fbrJTp2XzC90OmhodY1j3Gq488lSxZo
	WVlM+amEZqj3G4uYXqVDAp9+2gZHspPt2O3c7Q//pQ3ISzGaQeiFH2FImqFMqqpOzHbRL0UOHGF9c
	9JydqKwAkaRV3XBr2VjuBL1D+uZsWlUfb86q+r1wmYN8huS+ngT1zueh2FUadPade4kxUt4W8zn5L
	JiJE2Ogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3sl-0000000BJ5E-3XEw;
	Mon, 01 Jun 2026 14:44:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3sg-0000000BJ4a-3njh
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 14:44:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C64668B05; Mon,  1 Jun 2026 16:44:38 +0200 (CEST)
Date: Mon, 1 Jun 2026 16:44:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: dayou5941@163.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, liyouhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] nvme-multipath: require exact iopolicy names for
 module parameter
Message-ID: <20260601144438.GA5054@lst.de>
References: <20260529085143.2016914-1-dayou5941@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529085143.2016914-1-dayou5941@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_074445_425364_B522841D 
X-CRM114-Status: UNSURE (   8.55  )
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


