Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE82C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 05:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bKGSQpZmzTRIONtndrvapQwqHJ
	xQoSlFuaOqm1wQd0bk477uo1gEu8XzXvz7Dv54poOQy5F12Im2hDCC7nXgwBWD1DoSGTCHTdGdB9T
	IKdNwAZUF/PL0eFtyUxMJ/0WLh7AQMecclcmIr+P+SUE/UBr92z0nlTFr6MDNm+iEH51JnDtZykiu
	fU9ZIaqwjkPGkLmhQ0IoRepBKJ8zu0dXJQ9KiUKMWzQlJSVxtfjTuO+sM5QDTqfxZ1+Paf2jmyrpt
	MJ3Z0Pl4VBj68QPIcxHzIkekgL9FZ1djg1weWudXqmKg9IEwZjZJsG/wI2Hjvf0vadLbyWxoK8oMu
	7eYUutcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuPp7-00000004l2a-3vHT;
	Tue, 18 Mar 2025 05:49:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuPp6-00000004l2G-0Bh4
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 05:49:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8002D68AA6; Tue, 18 Mar 2025 06:49:04 +0100 (CET)
Date: Tue, 18 Mar 2025 06:49:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: pci-epf: Always configure BAR0 as 64-bit
Message-ID: <20250318054904.GB14955@lst.de>
References: <20250317095703.1661633-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317095703.1661633-2-cassel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_224908_220338_D357BE41 
X-CRM114-Status: UNSURE (   9.35  )
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

