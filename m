Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B1CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HrMPnMPy86c5eNr4b6mgQEhuU1
	y4Xb4mF3dGpWvobsr+PHGOEFXiCx9EiVywV/q10rKmBIx4as/wiBtV9XBi0se/OPqc+OVD7FJdKrB
	tpYt8wkZHaeQJ+CaqIyilApYAgxdN/Wz9xvFd2yAoTBUWXdWlu3hPzaR6jQZbZx1E84NQNJ3aOwBT
	cOwwq/sExCh48cEwKSeCKuBdWY5a2aGOZC9PZUhwJK9QTO+4zkd0GHvqf/43XJjdoONXltSKfBLyX
	RTHO6O40F7Td/PRTOsnPp2wsef1ar1ay9Bqb4pV5jbTkHuj3GEg/6/BKwJxnyN3aquS8yy+WLzRAP
	iqxhGxzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwqo-0000000AHsD-1hTB;
	Mon, 01 Jun 2026 07:14:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwqm-0000000AHrY-0NMo
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:14:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3011468B05; Mon,  1 Jun 2026 09:14:13 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:14:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: pass NS head to
 nvme_mpath_revalidate_paths()
Message-ID: <20260601071413.GA7582@lst.de>
References: <20260529095201.3803100-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529095201.3803100-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001416_266639_E8C0135B 
X-CRM114-Status: UNSURE (   9.29  )
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

