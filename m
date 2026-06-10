Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A46BCD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vVLeiIT6d1JYNQG4XrLELpG3m6
	bXuW88fsIQV9zDj3HhDBzEHEfemN+l+YKfEFXPZ/NgXlIolmcME+IggbQ67E+xkxL3VUUzgFjzokz
	/ewT5kJbrEp3tNA3iOy5wU1sF/dstmlVjJqI6oFZnTXs6UyrW7RrwSktZ1SjST1vpVMRB8L3Ze/k5
	Q8bGrFKOIeIwtrECGaGsNoMnTJ1QPZeft5MIR1WFARPvbxYpFJbxAKRK24CUGRz2e34733RyWpSsl
	i45HiOUKB0QzOsV7loO4N/DS2cDq1RQRX2hVHLYxqSFhFvnHlArwJaWShDS1MugEOlwGbYd6AwzvP
	fwInwONQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHYu-00000007avW-1Kwe;
	Wed, 10 Jun 2026 11:57:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHYr-00000007arj-1iIW
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:57:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F2A168AFE; Wed, 10 Jun 2026 13:57:27 +0200 (CEST)
Date: Wed, 10 Jun 2026 13:57:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH] nvme: make some sysfs diagnostic structures static
Message-ID: <20260610115726.GA19624@lst.de>
References: <20260610085332.3213760-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610085332.3213760-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_045733_591219_A2607838 
X-CRM114-Status: UNSURE (   8.40  )
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


