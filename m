Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB5DEE6454
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=g1N/e1hM+2a/knJcP7bL+8NKED
	N4uFS+31ALBQgk+wi1B2qDnWnDAn3O9HHYyvMiqur5xR3NRGSf2WbEes5Gr7/Hqwyi6/iIRQO+ToY
	Tfv0Sx6r9CAp1K8YPmysYGT9XqtNm9KA25AGWom710tMFZi/Js2tSlfj8VGZHRz/0oOpTdgmrichv
	C6ZKQ7p24K2WNVCY0fkPDzxQWX2DrrXCGO0s+DbYmYgNF5ytvgOWERPDSgcDkrUvOl6IS+Gr5uLwt
	lgCECDO+9hNvOH4yeuE2hz5jd1kK03NkUFLHbq4rU892Jq0VYle2i8nE+qv88h2jRSzFATRKsu3mW
	HPZC3u8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodr8-0000000C6Jp-3ASm;
	Thu, 12 Sep 2024 07:03:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodr6-0000000C6J9-2Y0D
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:03:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B60868B05; Thu, 12 Sep 2024 09:02:57 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:02:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 01/10] blk-mq: unconditional nr_integrity_segments
Message-ID: <20240912070256.GA7614@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_000304_797993_2F408A3C 
X-CRM114-Status: UNSURE (   8.59  )
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


