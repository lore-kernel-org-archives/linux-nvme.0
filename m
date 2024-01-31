Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4747C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Tk8epXhQiQEMaL9sWx/++iPta9
	5YbpQsdRk5SiKyDdVdcCzuEudKYT8Pgb4ofg46KMJd/y8qBXVYc0BwlKSAa48GcHhiBDsrXYB+1mV
	LwIH6qRtK74chJ/WjFCTvy67wHdbF25yDnMYJoJRVZHBPzbSz989MmiLFLmuc86JWQVky5biUliBa
	7STQzAyher+p/7RmEIZqilYw4jelXxADJsumkvbnWXJ6RApovp/Q/cTq+L4W/APA+xE/6QwFe9JtE
	ly0qcKd1SjBA6WJ2DjM5WdX0Uv1wURG/l6ByisDw5PaL+TBLmhhDBokuc4vWpwDB75n1cDn1oChlG
	4aqElApQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVERL-00000004qV2-134d;
	Wed, 31 Jan 2024 17:31:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVERH-00000004qRg-3W2Q
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:31:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC70868AFE; Wed, 31 Jan 2024 18:31:52 +0100 (CET)
Date: Wed, 31 Jan 2024 18:31:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/3] nvme: add tracing of reservation commands
Message-ID: <20240131173152.GB31567@lst.de>
References: <20240131091222.116190-1-kanie@linux.alibaba.com> <20240131091222.116190-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131091222.116190-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_093156_087787_546E91A7 
X-CRM114-Status: UNSURE (   8.98  )
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

