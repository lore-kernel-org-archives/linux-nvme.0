Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AD4C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HKzBQ+T/p+5mSPnTVPLhKRtACj
	sdupdC1SX9QnX4++TCacyfbQPv/w/Qfq7R5vdok3A9DSQra+xGmULePpI+0WeaEHQq8109wkvLbIV
	oQDBZXfPeCFLy1bC9eIv59ZI50aNNSA8pXXPXhtDaHCGIGNXvCatjMIwwbpvKuUwh2YDWQgIemG5T
	qKGg+5yGtmjrbsfM14b6clThm88yDtfKCJGAAPYIERy8Xj4hFQPqFWxnH6kTvXyA0PEJpY1XHHV6K
	SGKzuhYc0QsfTRYwHSUS1X6wPLfM3+Y5cqTtR08N6BDLVFOYoApTOE2zCMwneajcVrisx148wPXUv
	hrr/BOrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYpVh-0000000FoN5-1Ilp;
	Tue, 30 Jul 2024 16:15:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoNr-0000000FZjk-3cqI
	for linux-nvme@bombadil.infradead.org;
	Tue, 30 Jul 2024 15:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EPg4xuwGPXbajTNZmKFbgaBz1Q
	R82XBOFKzKyr3E26tt1ZCjEhEMPgM42itlFBzsVnDl4Mdo1lU6mTWAbcFuk43oMYDqGyyXGCBI9Ak
	FC6HhvK6O6VsszNzXWgBH66yiFpet7qT1ptflD/6Sfbmct9FazGUBS/LySi5DVbw7u6XNVbfILC2d
	juA7YjZ6wkwJ9S4PKeNcHI645Ns3yKhP+Wwh8kYYEwwUag/ABuBo30ec9+gfVZftgK+N87N06oGrU
	fAS4YsQaH4C39x8wWBAcebz0uMzF+7PodNMrOObcyr7ZxQjGWSyaka+s4g96JoR3Zmnp1naFgzMlv
	JU6tMfcw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoNo-000000051fa-3d5B
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 15:03:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4334168AA6; Tue, 30 Jul 2024 17:03:21 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:03:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme: change data type of lba_shift
Message-ID: <20240730150320.GB29099@lst.de>
References: <20240730103138.66714-1-joshi.k@samsung.com> <CGME20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7@epcas5p3.samsung.com> <20240730103138.66714-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730103138.66714-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_160325_098889_4D9D3B17 
X-CRM114-Status: UNSURE (   9.20  )
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

