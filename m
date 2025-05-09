Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92205C3ABC3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 05:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aiSSfTARXLXB+2b6Ug2v7LTxgYSipXgqDvEptgUSWk=; b=JnEHVnnaqdjwL+MrKD0837mP0p
	CJ3F6cwGclPeZEMHfoiKC1swbPBh1rjBh1R5Kgi4rQPYZBuEg8mY289BgKWobon13ihUWoJ0DMOL2
	rFT7nvIa8SQA1TMn+ZHGNBIomcTCST6+imr0q1ZTlhGhC640ZEd813SwflyFJw4zlZC4SeUKYvhRF
	a75kuDZFabr9/JTvz/Wcal6dS0rZ4oBYwHSGnPDzCaP6xHhIP9/5bFnAXU6Vp6fQkUqaVBEs75jWN
	Gt5L1heezw9pjjo/gBvpdfj/ApydEr2taWDTHtVh9aTGh9/Jeoa6aeRpDuwJsOIQSJrq2vtCSc9iI
	8nsMzxUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFxd-00000002UBx-0kbu;
	Fri, 09 May 2025 05:07:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFov-00000002Tdz-2MKq
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 04:58:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3B9867373; Fri,  9 May 2025 06:58:44 +0200 (CEST)
Date: Fri, 9 May 2025 06:58:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 0/5] nvmet pci-epf fixes
Message-ID: <20250509045844.GB29348@lst.de>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_215849_737998_45645EEF 
X-CRM114-Status: UNSURE (   8.21  )
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

applied to nvme-6.15.


