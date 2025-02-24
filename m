Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED7EC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aqYeDyNQUWZrL7uYCaTmgRoqyd
	4E4/zdUPZmBoIUC/VMpydxno4+F7jrlXfqHCbbvek14CJYhdzxftg8UyCxINW3r0zlKagfyRY3ecz
	CW1NPSph03Lhqw1CWdjODjrQSKRguYKcsH/KUzO2g+41suGcMNYaK1pw+BclwWigoVteuFmGla24q
	Gec2hnznjFkasuSB9uzei6WnVER76BhnGR1Vb5JukeSdemykCsYMJ7/YJyT/Kw4a3q70hL4a5RgxE
	OWgnhG8vQ9vGlz1HdiQ++mavZhyERhTZBi/44byes1B4C1eBGtKhVRYwfTO72gy0D7PKlBPF7PZGA
	hS77/1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh2L-0000000FOLD-0SnU;
	Mon, 24 Feb 2025 22:34:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh2I-0000000FOKY-2s10
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:34:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 903E368C4E; Mon, 24 Feb 2025 23:34:46 +0100 (CET)
Date: Mon, 24 Feb 2025 23:34:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/6] nvme-ioctl: common user timeout setting
Message-ID: <20250224223446.GC15518@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_143450_855340_0C396672 
X-CRM114-Status: UNSURE (   8.66  )
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


