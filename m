Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0266C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 05:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pjIeWzoWDVVfe1VNAHRJypdO0d
	V/GCcheUggeaM22tyJmUzsirswiiT0NRHfFQe397vQ3hHkM9BAD5cgsnGf7ofCBgxxrnLRZBMM47z
	0NuA8Td7TZa23cjp10IIVPIvwR0i3ieE4VsaoFU4A18PrD61ejKS6PU6zN8V2rPMZZi5kpmGemWqK
	m3Gfe+wLBktBE/fmYkX/K/TXm9KNvN95HgeQLYz7HEN2HY1QnAAvSubQtw2NP3fTWF3Ha0iMvoA5q
	UCLfTaxiXXFD8ZkjbBjhqw/FRnAnmtGlRG3s806dvNgm54ungWf5/cHWYSOzv/IAMj/PsF/rmPt59
	FRLIZIBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhkf-000000015x2-1BXm;
	Thu, 09 Jul 2026 05:56:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhka-000000015ut-0zKG
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 05:56:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B476968BFE; Thu,  9 Jul 2026 07:56:38 +0200 (CEST)
Date: Thu, 9 Jul 2026 07:56:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>, Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v4 0/3] nvme: add ABI documentation for sysfs and
 configfs interfaces
Message-ID: <20260709055638.GA16298@lst.de>
References: <20260707121227.2274769-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121227.2274769-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_225644_422769_5C2215DA 
X-CRM114-Status: UNSURE (   9.16  )
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


