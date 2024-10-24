Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB39CE8E90
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QksrU2PIPQJn7aquZcwk7/A073
	YQaZhnaTh5Ha3gvT+1eMX/H81ao+Z5UfTJTVd9LR56bWfMjLdow0m3Nr7wDQ2lm2eG0Ot4RMwF2F3
	Oy1BeXcVXI5EyEm3aggvScQW/scF91rxpRx5AVX7/AeD66E4PQ2oglGY7V2NVZCwJtqk4Iraq0E/Y
	9ymaW33wUAXFz5pPLjC8Hr5MSnFsF5vqCphE49tAB2y66ABWq3XphZxE/6k9bmcg55gENMalHvDQs
	OuWNlBAQM9Hd3IhtFgq67LckDpkdny8ETBkImJ3+f+hA/geGR6jWzbOh4pzNImyOFLXJucHsT49hX
	aCK8DmFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t40IN-000000011Lf-0G4t;
	Thu, 24 Oct 2024 16:02:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t409x-00000000zry-3EYZ
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:54:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7529227A88; Thu, 24 Oct 2024 17:53:56 +0200 (CEST)
Date: Thu, 24 Oct 2024 17:53:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
Message-ID: <20241024155356.GB11382@lst.de>
References: <20241024154923.3156803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024154923.3156803-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_085402_014571_7059CADA 
X-CRM114-Status: UNSURE (   8.05  )
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


