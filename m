Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5FC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=T4hkW6dlv5oAToYulFox/A2wvd
	gMf8cojY/Uk2t7wQv1gZxtPyQaeGKcfRffeB03WtSlRi4XgkPicUmwMTeuCwoZvTgEUl6RQzC+y3C
	GE9Eawt/HbJAcMeG7Ge+EGAlEoXxsCpducmOnBWfCZ3yK7APgZ3csww1FJFLu1dPGIrA5m1E3Lp7D
	HRq4M3OEDjVqxyTOd4IfT9I4FMcLyYfioz1s1fHiGrWNv5ndBSl3DJIN5TEt3JeIM7arWHO83Ne2/
	1aEzX3DwKm1AlixkxzMB4eTmbWIRDhqOKJLhCpo3i0G5Hz2rTjmVHoa3e9pU0q01OctCyZZ12kGS7
	tsf2xzZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxZRG-00Cteg-2i;
	Fri, 12 May 2023 20:32:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxZRE-00CteA-13
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 20:32:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B076268AFE; Fri, 12 May 2023 22:32:25 +0200 (CEST)
Date: Fri, 12 May 2023 22:32:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, israelr@nvidia.com, oren@nvidia.com
Subject: Re: [PATCH 1/1] nvme-rdma: fix typo in comment
Message-ID: <20230512203225.GC21713@lst.de>
References: <20230419231750.25066-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419231750.25066-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_133228_507035_256FC820 
X-CRM114-Status: UNSURE (   8.89  )
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

