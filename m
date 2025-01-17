Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F9C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=B9jl7JA3Y/nWeiAcivRtVflhgw
	7B+O4DVoDiAZcqlFeTNM+AtgekhJY1sGeM1q9uYob20nK9Md7RdCtocfH4tw+WeekdPSG92VDGwpk
	uITE8gqRzH3VAZ+iCNo5btLOj921VH6SU7b+Az6L71aQeIl+TpmnHlz57AgDLBxvDDNCCRr3l2keq
	NiayYMiogJkKAnlliQBTmjBJKkoSS2iQLL0HIZaj9zmiivTRL3fAmInFfkDtNscYsQjjClTt2BLr7
	Dh92Ru48mXimvWdW54wbqZqT20CVhec/WM+RzuakJ4YlhCOXRmMwH8xk9ZG+3PwEhWkf6Re0H3VzQ
	NRmJMaRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhBN-0000000HG1M-0WkU;
	Fri, 17 Jan 2025 07:54:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhBK-0000000HG12-112J
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 07:54:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 664AF68BFE; Fri, 17 Jan 2025 08:54:12 +0100 (CET)
Date: Fri, 17 Jan 2025 08:54:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: francis.p@samsung.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-pci: remove redundant dma frees in hmb
Message-ID: <20250117075412.GA25831@lst.de>
References: <CGME20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921@epcas5p1.samsung.com> <20250116234209.51347-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116234209.51347-1-francis.p@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_235418_429720_8CF69764 
X-CRM114-Status: UNSURE (   8.90  )
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


