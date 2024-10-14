Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C69CFC503
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EA0l6GGXtijB4gWwEwR0rYAwmuwoJCPCgM2c8/Aon+4=; b=xIGhUQpu622H7c4lxeHjP7WO1a
	jOsM1+XG1qD5iaVk3bZZ0qLBmT7JRHFywph4599DjqxbRXbU52Kj/UvP0hEtszMGfVlhRXszl74RI
	5SXPdRsnnOChNyOzByH+t7kTDfJsoNeSXNHdDxeMGgCMeLSGrJYr3Ab4FELIoaPOljGar8SN668qz
	ApxzbT5Up0NtpYANA9YgF+O92B1LXNx4R9SjQQeO1+GvkSgw6Gq7gPqrI+pFsgSTmFc/WWAwzX8Ov
	FgAYoVC5jEmQv1tCq3v/Obrr5k1SmMzx0wDHo//VnS1eXyP6MHeMgYPq9pA2gl6Wudue50tRc3wKo
	vP2z8QYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gq7-00000004NB0-287K;
	Mon, 14 Oct 2024 08:54:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Ggl-00000004Kkz-1UX1
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 08:44:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9A04227AAC; Mon, 14 Oct 2024 10:44:24 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:44:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20241014084424.GC23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_014427_557642_BF6C6689 
X-CRM114-Status: GOOD (  11.10  )
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

For one please keep nvme target code in drivers/nvme/  PCI endpoint is
just another transport and should not have device class logic.

But I also really fail to understand the architecture of the whole
thing.  It is a target driver and should in no way tie into the NVMe
host code, the host code runs on the other side of the PCIe wire.


