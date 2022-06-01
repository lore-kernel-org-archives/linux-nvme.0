Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD0EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 05:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GIecLfN+se2O/nYNC4U4N1g5eT
	bgRdzdMeGYC8hdNksbuD8IBkUGbmqg+HvtEUTkwW9R2BHG92p0m6edLfNEzYpG5v5shhfc05OEulV
	53rfvCDqXFyhWypBpAov+PfDqz2s7CM0uGOSAAuapgSIMSlP6Hl53QzJFrlVrmeGCYxGyxYbp/HnN
	CpZkMALJBKOTcSlyJ3ksuXzYfmjPz2jD5IzCZTeJ/QvA3zYLy2m1eN8bH7fNO3AFsXrV2OLH3b7ov
	4hxoZ4oMbzJvPvfrP9XFg79CkBwqTWRLzWCgnUoAUliV3/cCrs3CVvRgw7lkm+0Cran5Pw/Ksqs/D
	zXfx4yjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGvf-00DvZ3-63; Wed, 01 Jun 2022 05:29:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGvc-00DvYO-7o
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 05:29:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE45568AFE; Wed,  1 Jun 2022 07:29:49 +0200 (CEST)
Date: Wed, 1 Jun 2022 07:29:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 05/11] block: add a helper function for dio alignment
Message-ID: <20220601052949.GA21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-6-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-6-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_222956_468125_E8909BB7 
X-CRM114-Status: UNSURE (   9.23  )
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

