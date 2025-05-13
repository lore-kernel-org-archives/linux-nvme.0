Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C95C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPJ9yo6vD98eOQ2t14u//THUmpv1Ynw+w07XT+8PYQY=; b=ZnJKWmKZlA2zE/IZ3ShOfv1k08
	bWwUNezv353sMCf0AmPz6t5BQUvMXlXNHipkLBndi4CGYm562hDXgdDIdveyCF9eGyWmCPwOsKm7z
	hKbZcGPBe2kxz9u0Rip/IoUwZgTdUsqg2XbN8yBHoDLHQBqgRWsfuixBHRvQKNNX2sp9b6qsUMNrW
	7vVyQk4IaNF/fOq2KAAhlDF0Qc/NhQGkZpIOscu+S2zlH/7OCDeRaeY4wqBQs9ZcYDQj1in+JT/bg
	+voECB/eAMLjFge92k6ZQBQpXad0WEoBIDWbEh9AAOiwBu/RhNY+Kg89hLDLnZr0NlIJ1G4m5gDnN
	Dhdm5aUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEixI-0000000BUB5-1Fqm;
	Tue, 13 May 2025 06:17:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEixB-0000000BUAU-269g
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 06:17:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C730368BEB; Tue, 13 May 2025 08:17:15 +0200 (CEST)
Date: Tue, 13 May 2025 08:17:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v3 0/2] NVMe Atomic Write fixes
Message-ID: <20250513061715.GA974@lst.de>
References: <20250508223802.277311-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508223802.277311-1-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_231725_677365_0E150922 
X-CRM114-Status: UNSURE (   8.45  )
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

Thanks!

While I'd like to have more review I've added this to nvme-6.15
for now to get some buildbot exposure.  More reviews would still be
very welcome.


