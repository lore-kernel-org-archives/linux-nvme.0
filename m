Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03608CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ae7wFLoOHSnbM/McJge8aIEZ5M6Q6C3H0xORl5Z7iVA=; b=wwFyyEDf/gP2IlwXE156K1vHve
	u2zS7Z5ExB++sVsioCBj7TlEvyan17x566OZaWOo1FNt7I9kWPs3cWSf8asn4uC98w6zqBpyFvavT
	GVTVx8moLWHhB3o0Co6XIHCW+nV1jBy2kqo51UFjvRZxlpt9zg2obTIr/6QN+XtybWa+mL5FX+mkI
	9EaMjL9ToPQOsq1Ei7AU2+j66cTpuFpZ3LVub6GfAEQUxdrNkiM9nZqO48+mPM+M4eWuJrKPwPDb2
	fYFNJLrheoeVMVRPKwiMO6G/2aPtcZJ0w6VUv3bWEM4+5390SpYLuvrLpmbwo+HsuQSbV3DAMgafe
	XC0Atg2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkH0-00000007Jb1-3AFP;
	Fri, 15 May 2026 04:35:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkGx-00000007JZt-2WTX
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:35:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEE9C6732A; Fri, 15 May 2026 06:35:35 +0200 (CEST)
Date: Fri, 15 May 2026 06:35:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, kmodukuri@nvidia.com
Subject: Re: [PATCH V4 0/3] md/nvme: Enable PCI P2PDMA support for RAID0
 and NVMe Multipath
Message-ID: <20260515043535.GB3756@lst.de>
References: <20260513185153.95552-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513185153.95552-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_213539_780320_9D902FDB 
X-CRM114-Status: UNSURE (   7.20  )
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

Still looks good to me as per the reviews.


