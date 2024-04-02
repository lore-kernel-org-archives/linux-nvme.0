Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC62CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sTGOB16JFdhge0OBY6CyBMTXGc
	+eO6odQ7mY/p5xpsrlYZWjy9rqcWjlqFq1EZaRx8MjSnwcRtyIuWWKxfAKuWb+2+lguOBCvzo0tRy
	vfQFsezpeEvRCGeg5puO0pmYH5ANnVN6l8AWakCEvqdqIUZltka4FPq5Ic63lVplEzlKpYbNrpcsw
	yKN5MhmzB2BlIPt++OYx3dBa1z5lw7lZhx9TMPFT4WxsEHb/YZP8mPSiiOzdMHqmQ6krPygM4sIIv
	MQxDC3qAw+q96I3XmGAp8woDkRNWDyFBYY6OCtcnnE1zPz16JG+G2u1yf5zY/uL2ZxNlywHbVwehr
	9frFt37g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgbr-0000000BwuI-3tix;
	Tue, 02 Apr 2024 16:03:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgbo-0000000BwtZ-2Y1h
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 16:03:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1E4268C4E; Tue,  2 Apr 2024 18:03:31 +0200 (CEST)
Date: Tue, 2 Apr 2024 18:03:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 26/28] block: Remove zone write locking
Message-ID: <20240402160331.GA3527@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org> <20240402123907.512027-27-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402123907.512027-27-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_090336_916951_F9140E20 
X-CRM114-Status: GOOD (  10.05  )
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

