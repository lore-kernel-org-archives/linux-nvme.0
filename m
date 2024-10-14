Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12D3CFC500
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DQirzMDm5FY+RYOI43L0Qj0IVWR9qr1UpBdExUmyhk=; b=cAWnkhNPMh78UeEAdwqH47ChFA
	odynhJ2YzZ/TpKBWcsZgl8wwkYly/uCifaaWBFAl7vVxz1ioxZvfLFko+xygK3CfRfQPNJzeGUWKE
	NVmY9lgQvt+w8KfZcg/drA4YPRcxhe9uGPCJ/21qcOL+4J8gKZfVtjsxdTyFxRsgZe3bnNfaDN5dN
	4/E8trum7ZVd0johcAu704rydcSOx0hBXRWN7isKvB6pGAyR/zc4h1IEDv4exHKX9ZOUd0DnPHo7U
	Yku0iPFh/MQHLburt5D5Ir20bb2uDaRlklq8l8a215yivTYwhO/t1xmVZstKJqN4RFj7vR3uHAe0Q
	f46J0mug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gpv-00000004N33-1ran;
	Mon, 14 Oct 2024 08:53:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Geo-00000004K7g-2Ho6
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 08:42:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5B0D227ABA; Mon, 14 Oct 2024 10:42:19 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:42:19 +0200
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
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Message-ID: <20241014084219.GA23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_014226_747672_33CF2A3F 
X-CRM114-Status: GOOD (  10.67  )
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

s/nvmef_create_ctrl/nvmf_create_ctrl/

But evem looking at the code later using it I fail how this could
work.

nvmf_create_ctrl is used to implement writes to the /dev/nvme-fabrics
control device to create a fabrics controller out of thin air. The
biggest part of it is parsing the options provided as a string,
which most importantly includes the actual transport used.

But you really need to force a pcie transport type here, which
as far as I can tell isn't even added anywhere.


