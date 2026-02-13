Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7302FEF48D1
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AMuGppZMWLY4819CViajMcvExI
	gLNXFAO39lMFK2hpV0aMmBTvpDmQgVzibUEnsdQcSmR8riNOrkssWrF7tR5t9emsFQN8LjH9zy4Lx
	/b8JkL6MrGYsTih2XQ68QwiMnOblrUblBpP+oMWJlap/R+hxtYoxdQ9DuIOFwt+biyDVP6CE6tNYx
	HACyV5zntRc3fA6TXu4JQnuh5kYZNJAnBFUz+hyvtTcDMW+kTSgrdhO8Lfl2owPHFxYRM3BX/MH3o
	wf4tAAhC90tTA9Tz+vbk+Qe/rkxLu4q0MLtLCJbdII7dWbmYxwA3UK2iU1uzKg6g4PtGh1v0b1Eln
	sjfZWWQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmc3-000000033yF-0Yaq;
	Fri, 13 Feb 2026 06:25:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmc0-000000033xw-3DDb
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 06:25:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5C4368B05; Fri, 13 Feb 2026 07:25:00 +0100 (CET)
Date: Fri, 13 Feb 2026 07:25:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] nvme-pci: cap queue creation to used queues
Message-ID: <20260213062500.GB27228@lst.de>
References: <20260212164733.3006071-1-kbusch@meta.com> <20260212164733.3006071-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212164733.3006071-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_222508_962301_4A8547D1 
X-CRM114-Status: UNSURE (   8.74  )
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


