Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F6C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZjMxrhZX3PqZC48WDq0iIbfVoV5QzA01VRsQ1C30T8=; b=j6WBI5e8sHuYeviBdiOSe5fq6u
	RN/+i293Ij/gZ1pWKiRGYAFR2Fr3tep6Nux9LBIc4HQf8Xzlm7JItskrcMCh7D+FV8HOMKMt4//ge
	xkAX7qKACRdy6yoiG7mOc+6b00h2JV/giIQdB8hZCNv7UV7nJKctcIZams4RXeTiNEoTRzMkkIoSI
	d7idZ3Wt825JxCpF7Po0RWGUFTuvNVBrtGhIYIjFiM1eIRfBLbHK+i/PsuWB2hSC7MXBPk/Knrkj2
	JUl+kS1MTUbn8sB3HecMS2Co/zgGjL23QuGi0IPHhYjGpXlOx1yF3yMn+viQAGUqLEmllFxkwBksf
	+GdEYP5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mh2-0000000A4xl-3Nvh;
	Tue, 29 Apr 2025 15:16:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kjN-00000009k3Q-2HXO
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 13:10:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CC1968AA6; Tue, 29 Apr 2025 15:10:34 +0200 (CEST)
Date: Tue, 29 Apr 2025 15:10:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>,
	Dhankaran Singh Ajravat <dhankaran@meta.com>
Subject: Re: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Message-ID: <20250429131033.GD13970@lst.de>
References: <20250424171801.2300390-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424171801.2300390-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_061037_718511_08BAA668 
X-CRM114-Status: UNSURE (   7.66  )
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

added to nvme-6.15.


