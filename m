Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62080D35694
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0CTSEzLZSKHBJeG1ky+2kquyqG
	GMMUaUwUc8i5KUOXBH3xjTWtx67HJWFdbU3RofZEClwVbeQiBTIZ4WOjc5nz6RlK6G5iiA0AJkiL+
	7QJ0Hswtp0M/zf/VIK+AncR/4++n56tF1D8Y79vbtaJy1Q1sz2w1Az9nMTcT9Lq2G/6QOksQ2yYYs
	1FvLFBgBp3qHNRe3tpuBiyAeEblsZVC6Wfr0UHp+ykk2P9S9NrqwTc2oEViABJRQ5GLGM/Z3P1yKc
	T0fHOdOqZQuMX6UdOWv/0tTsjYUbSGouJublhS9sbEa4c29CQut+BO0dlJAU9fWkgcb5xkFt2zPpI
	la6wxGxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Fv-0000000Fh3z-29Dt;
	Wed, 28 Jan 2026 08:50:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Ft-0000000Fh2C-2TQ9
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 08:50:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D248227A8E; Wed, 28 Jan 2026 09:50:27 +0100 (CET)
Date: Wed, 28 Jan 2026 09:50:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v2] nvme: stop using AWUPF
Message-ID: <20260128085026.GA10028@lst.de>
References: <20260128082623.3945303-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128082623.3945303-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_005029_818818_57CEF26A 
X-CRM114-Status: UNSURE (   8.36  )
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


