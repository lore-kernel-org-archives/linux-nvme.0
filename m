Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C9BC3DA70
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Qoc6PD1FJrv7fM30EsIQ3lapJ2
	w8PWH14UpxLcaREgipt0qb1oWIbFqmPdrwsyvaP4zxrfuAxU6ntdFjWoyrh5KNUxmgZASTXbXG7JZ
	Xcz0ZWNlIPKbpkfHDP1jzXdto+L7MVwAW5S4IYLSJnESmtHGlot6K97n+S74B+eTYeJSf1TyUW/Kg
	yf/1wH0dvaCRm40G5/1nSv0cgnn/X6HOeesC//0b/JHeDYYJXNo8APRORy9PlyvsQX0P5G+D2ttzK
	VPYVWpmrefBYI6p8MD72NmQkQdxk8owrLqansSPvZ0y9CSlw5gvyEQP1rpTEv2YZsv8Fn99GVP+3c
	kNQOufNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoQM-0000000Fa9g-11cq;
	Tue, 30 Jul 2024 15:06:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoPH-0000000Fa1v-2jo3
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 15:06:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2604227A87; Tue, 30 Jul 2024 17:04:51 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:04:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: reorganize nvme_ns_head fields
Message-ID: <20240730150451.GC29099@lst.de>
References: <20240730103138.66714-1-joshi.k@samsung.com> <CGME20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5@epcas5p3.samsung.com> <20240730103138.66714-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730103138.66714-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_080455_845658_26E16772 
X-CRM114-Status: UNSURE (   9.41  )
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


