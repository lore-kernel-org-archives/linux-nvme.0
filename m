Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EE0C3271E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FwXWhZ/HUY87jCNx8JyRiNalvUMKNtPfOv18rCGNes8=; b=uWc99IiOSfuwP4J5J2+MFceTM3
	yW4NJHzVCRQ8C42/UM0I73a1Ur7L5WTzGq0zxNtKHj+vSJL9HnJvoQELj2V21kdd3xJ4EaZZvpT+G
	Ia8UPqNUOB0zIRbX44dSOK2PEPmHUzM7Qsq2AXMHGvdzgtRzb1/As0QQw2aQVeNmWjOX7VK1zABCs
	Sp/FLFkVuH583zj0Xr0pVleIqYaJkxHarFO4zxGD65vE7C8D4oL2cW5eMEGkkBwq2WeSc3rk9++60
	otd+/MZ6VOgXKcaUNsyZvLLOyPzYrUXD2nOMqgyhPj0O6re04BcpvP3Cq9kB1or5gI9ZqWuA85V3W
	uxyzYxzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm49-0000000GReq-41Iq;
	Fri, 05 Jul 2024 16:45:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm45-0000000GRcf-3alB
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 16:45:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E99668C4E; Fri,  5 Jul 2024 18:45:33 +0200 (CEST)
Date: Fri, 5 Jul 2024 18:45:32 +0200
From: "hch@lst.de" <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
Message-ID: <20240705164532.GA1642@lst.de>
References: <20240229031241.8692-1-kanie@linux.alibaba.com> <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com> <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me> <43565275-d71b-4c51-9a5c-b528e6387614@nvidia.com> <e9e9a7c1-44af-43b3-b2df-8290849eeb67@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e9a7c1-44af-43b3-b2df-8290849eeb67@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_094542_063995_E37B8E81 
X-CRM114-Status: UNSURE (   7.92  )
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

Hi Liu,

did you manage to get back to this?  I just played around with the
feature to test my RFC 9561 implementatiomn and it would be great to
get it merged.

