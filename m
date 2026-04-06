Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B36AEF4EB0
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ISFnMW0Z1bnYi8+wYvYbfJwbjW
	vpXDwRBHJsDFBBZXuIipvecNI+B54VuEOHIY8szWOGPJJmD8hq1/BL3YpXvrVTZSlPCLYJHlgVCtX
	nKEghwtBbbc304wgdSkIFeIamj1xSMalMfaUSZOaS5IepdyfAI3meLziwg3EYffzVK0ZmibZLT6Zl
	7pNCNwqwEqJsFn9NFsOsvu+q2Su0B+SGSC4CbzqnJFDXnlfbIOH/Pe9pn8hd8TmEphLG1osP/40MP
	n1ljoU4ywvfeVf5WmaEw0LAiDnDZT2CBBeDKXEl+mG056EsKfIvChw9HHYnr/68GNIgNSjpDVKzG0
	9kQ2LWKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dZz-00000004r2K-3QAe;
	Mon, 06 Apr 2026 06:36:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dZy-00000004r1z-1ksI;
	Mon, 06 Apr 2026 06:36:58 +0000
Date: Sun, 5 Apr 2026 23:36:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
Message-ID: <adNUih3CWyA4Nj5f@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-6-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403194109.2255933-6-csander@purestorage.com>
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


