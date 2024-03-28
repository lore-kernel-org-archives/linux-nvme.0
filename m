Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF9C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mZJjJSXqhcrlXaufKZlGJ+0B50
	puSWFNnApyM/Aql/vMUxpqTkl787IyRPLJFxldmEal0ra88r7OoXMlbVDkwJwavQMbYLkOrcwNDoa
	NpcNIOiPef3byQRtFQv+AjeIJ5ruXR3+IgZtZ0w2J4TINv8Bw3Qf6m4/pVeb8LO1CbOvSpTpf1O46
	ki4RoTaX5IbbqTb83ug2E47V+/8D4P2bVDNVUpCCRNkma2SESKy1eG10QNlv/sl3exHewCLqVXwFG
	9bnaLZg3MXu0sSS4PNgCJMECKGsn3d1ngTBUzrzo4R1is1vEtFB/NcjlSa3yHOCfhnbu/4rqOB8yH
	NzHQ2IgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rph6F-0000000CLzp-3piO;
	Thu, 28 Mar 2024 04:10:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rph6C-0000000CLyI-0fKJ
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:10:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25AF368B05; Thu, 28 Mar 2024 05:10:33 +0100 (CET)
Date: Thu, 28 Mar 2024 05:10:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 01/30] block: Do not force full zone append
 completion in req_bio_endio()
Message-ID: <20240328041033.GA13510@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_211044_504508_695FB0B0 
X-CRM114-Status: GOOD (  10.18  )
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

