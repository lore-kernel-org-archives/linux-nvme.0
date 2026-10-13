Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C77CCC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1OeWj5fEN8lIAiZwr2V9lr0nz/
	pt/hkqC+nWaGv+VtcPFE2L+Yx3VSB+JjJUNtJlp0cwdBek4m7nhCvLslVNxEkFSnlf49sUes/Ilf9
	aJ4kCHyPKGY+0Qh3C7z9YxieuSNJJQIgKL1u/2aUzthny+B6Q7NZCQeMf8II4GRF5GT8ts/CDroB2
	4ul5EZrRAh2yMV66GC7ekrJFEVdCt1aFsMh2KL+vOKU9g94jTFPwjdHSo13VqX3sD5SyG2UzlMwQR
	PTM5648MjLXYJfoSBbhv0y/5hHkKLcvwBfSqch1YTWRsmhwZWHyNW97yRThSBl2cVuH5hnH8jczMS
	EbbGRI4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdcH-0000000D81W-1Cos;
	Tue, 13 Oct 2026 14:36:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdcD-0000000D80h-3dxX
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:36:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8400F227A88; Tue, 13 Oct 2026 16:36:26 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:36:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH v2 1/2] nvmet: introduce struct nvmet_passthru
Message-ID: <20261013143626.GB15717@lst.de>
References: <20260929112751.2985483-1-nilay@linux.ibm.com> <20260929112751.2985483-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929112751.2985483-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073630_053041_5AD6A3D8 
X-CRM114-Status: UNSURE (   8.32  )
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


