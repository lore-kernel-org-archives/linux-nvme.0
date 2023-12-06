Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F6C10F05
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=42waLhGF/Rvi9pyYlA/XLpc0Qt
	E4UC1CDzBj8A4MGZP5njOJebXYv11pYgZiKR+q/of0gU6l+16jaF1TJXiTYmLQ58D8RHs62QYcfon
	4f5H3hiFvvENtDmVNJubCp73xqBTXzmNmzn2/Xs6bFdWP0AJj316rUll16MX+v+DLPQYoX0joE07P
	OU19l0zznVcHmOB2j6S3GCBCiCIoMI6RWa4hI119bLQuAWWjx+CL/2+xoOgrmGSV7Bx1IbRvgH8j6
	RgpRjIn36pgCdh4ITwgaSnHCtuPg39gcaT8diIt/93PewC5mBFzDCYcYm8NYcts3BFG3tIWuPBOew
	uPca/2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkd2-0097G2-0w;
	Wed, 06 Dec 2023 05:39:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkcz-0097FH-22
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 05:39:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AA9A227A8E; Wed,  6 Dec 2023 06:39:19 +0100 (CET)
Date: Wed, 6 Dec 2023 06:39:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-fabrics: check ioccsz and iorcsz
Message-ID: <20231206053918.GB18935@lst.de>
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com> <1701761860-17623-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701761860-17623-2-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_213921_811493_56FBCAB9 
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

