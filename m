Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA8EB64DB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pIlgS2mcPPDAMm4id28A0AsP9l
	0Z0Ss7dIF1bt6exYnlW5ZV4Gu+w4OHKYSBtYn0xuCeJM3pmONbFYry9bVc0yx+PuOPLVNMNt/5OOZ
	X5dKEvjwciBY3II8J5s+3kGYdPW5chZVZonVu9upteumez1fsVKIQjaYElqD5+wr2Td7rOQJDMfnh
	/zC1P2CKqw3XZojmtt44aMOD37BOue1hBhoMLi4FBLSitqB1CdiZo2cr4JrpAdtaYrWoe3ASbZq28
	EPWUxL24bwwP0JZ4kB5TwyC9Zr9wQTaCuciwskzn1WVPb5+vssvp/1yd9i9DMUdxeJ39nqFkZ44Q8
	8iAVdCKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbIj-00BMzJ-1h;
	Tue, 20 Jun 2023 13:21:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbIh-00BMxI-05
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:21:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE04A6732A; Tue, 20 Jun 2023 15:21:33 +0200 (CEST)
Date: Tue, 20 Jun 2023 15:21:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme-mpath: fix I/O failure with EAGAIN when
 failing over I/O
Message-ID: <20230620132133.GA23879@lst.de>
References: <20230620130736.1090531-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620130736.1090531-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_062139_215203_4FC93B3F 
X-CRM114-Status: GOOD (  10.14  )
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


