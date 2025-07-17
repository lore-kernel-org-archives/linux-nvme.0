Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9B3C83F1B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyDGedYrP4k8Aszf5hpD4KCimePEOpFHiQOOiG+glm4=; b=hNOOy+JiZUABiOxBJ/wHRGwuU5
	fItXdXOkC6BscOCn7EseKow51cDMnCL0WBWaT2rUxu/sVf7z/YncZ24HOHXLGflMdlnY1c05VmSlW
	EmkuvC7+ozUfKKSrZpD2xXU0xYif+jvzMw0VSm4mB2MeW4oiOfjwfBVohp+HDrruRN+DxQu6V8DVp
	Ik+dRb1dcumN2JcNnXXVjDLGDQBx7CAP1kzS73J+72Ne/H80tT4zdQ+LS2Lh6gpIk13ojGibedtRD
	JWsoyCd2913R888NIJIiW6P/GE/N1ecDfho/nwVgK/gu/1r9ioE+OjnxdAvNEb72byPsxVo7w3kX6
	j/95FmOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucOFd-0000000ACDk-39x9;
	Thu, 17 Jul 2025 13:02:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMz1-0000000A00Z-1qLo
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 11:41:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6556227A88; Thu, 17 Jul 2025 13:40:57 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:40:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Message-ID: <20250717114057.GB18331@lst.de>
References: <20250715191627.3690017-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715191627.3690017-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_044103_613095_85D7C18F 
X-CRM114-Status: UNSURE (   6.94  )
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

applied to nvme-6.17.


