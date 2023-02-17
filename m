Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D5C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yefpipcwcgWHiR2NDw7YTja9p3Xd/QF3FxBb6PaFxEs=; b=W85rfDigle9tIujdiAW/UUcpm0
	c4eFJ43t4rZyu7UGKa9+PMpu481F/DkHokBt0hKnva4KreN2UDMSoww4iby68XXxpWdkEB939Roh2
	CeMgbJr0OYt1rlg69guU99KXJ/QKU0TokAayTy5k/HKxVKYK3dcffCp4vqAH7bea884T9Noy2FT+f
	JF0tAWACp7tV5vo3G4ETlPOG1MqzBqktf1OxPR7ijG6by5lEGesjyMljAmOaWVH8esBCJQv9qTDtG
	BfoFdVqrColg4O57Bc3V1SVCbIO/W71o1hHkjaDadE0bX0vVj3zwMTdjx+QWGoleXFBjKKIiQbgPL
	oCuK057g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSvCx-00D6QM-H0; Fri, 17 Feb 2023 07:31:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSvCt-00D6NY-Sq
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 07:31:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8CE168D08; Fri, 17 Feb 2023 08:30:50 +0100 (CET)
Date: Fri, 17 Feb 2023 08:30:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: refresh visible attrs for cmb attributes
Message-ID: <20230217073050.GA20455@lst.de>
References: <20230216164403.501894-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216164403.501894-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_233100_113708_1BF497AD 
X-CRM114-Status: UNSURE (   7.70  )
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

applied to nvme-6.2

