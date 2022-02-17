Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E5FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 06:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6263DjMA8Ryzb1aZeAxR7nM1UBs9qXTaV2YXwbnjjA=; b=QyJrA2DekG/+B4qZLHe/iG6HHV
	zfgEuQaGWZD07zU8UMEmFs/hQlKvGHvmow3jKKITLOEt+ekUlBJYJBb3iZsp5PXgcMoDOxql/oZEu
	nP3uAY6aTIZLmHLyJ8coL7+YEAOf3rpJPFNHlXgLNtLdNXgNqk4zmIRg8iSJTs6Eubf7Yo0Yn2KIB
	jOXABfQ2mGmDMmK2hJ4sxVXeJZ4kB0uSPtIzSBUKOGJk1imaz1BSioCmmyDbqUf/Gq97Y0CVpUWfz
	iGnF/9BRcfRvgziQinxkJvApHeekUiHq3dDwUCixOJXFvGNAt/gtHS8ELSApAbkEIIZcWSzB1UYC7
	LR3pZbHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKaXo-009948-74; Thu, 17 Feb 2022 06:45:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKaXl-00993V-DI
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 06:45:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4AFD768B05; Thu, 17 Feb 2022 07:45:25 +0100 (CET)
Date: Thu, 17 Feb 2022 07:45:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 nitirawa@codeaurora.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/pci: Add QUICK_SIMPLE_SUSPEND for Tegra platforms
Message-ID: <20220217064524.GA444@lst.de>
References: <20220217023635.8963-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217023635.8963-1-vidyas@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_224533_639523_CF4E9D22 
X-CRM114-Status: GOOD (  10.28  )
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

On Thu, Feb 17, 2022 at 08:06:35AM +0530, Vidya Sagar wrote:
> All Tegra platforms remove power to the endpoint devices, hence, enable
> the simple suspend path to avoid issues during resume.

As repeated about half a dozen times:  NAK.  We can't quirk every driver
for PCIe slot misbhehavior.  This needs to go into the PCI/PM core.

