Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85AC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zHwI/TsgQGdKLtdmTFEXrG/XWNl3XnpvJf+wo4hw0DE=; b=w6b8a4MDw2mTBctHasTAKd1obb
	sr1j03jfjvVcXILdw2TOvuy+6vsl3RzmxmTfFlw1zXe/KqL3wLmzwSbmnYrh7tvKayflzaYO4TJdA
	Bk4M7Vc5Sbm98X5xgFIHXgJas/F2RGbiKBmI2CAqsHqu2SY5SbAjBGhpe9cp0Kz/iCy1whENaBZEK
	ctHpBvK56jcnsUxjpOWGnw2+DOfvbIYASLZjOVNjCZPTOoA4NT6l6kT8SUjwbmu0lhixVyxmEVPYM
	0YJn29EpTDz/vjl0Iv/9xjn8ngOJnVz68jhmj6j4F0J3+L5ypok46C3B0HDA5wdHlafNWuqBHohlb
	qmva5Vbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphAO-0000000CMri-0wSG;
	Thu, 28 Mar 2024 04:15:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphAL-0000000CMpK-0W42
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:15:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C984368B05; Thu, 28 Mar 2024 05:14:57 +0100 (CET)
Date: Thu, 28 Mar 2024 05:14:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
Message-ID: <20240328041457.GC13510@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_211501_372788_4DC29E92 
X-CRM114-Status: GOOD (  12.25  )
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

> -		if (req_op(req) == REQ_OP_ZONE_APPEND)
> -			bio->bi_iter.bi_sector = req->__sector;
> -
> -		if (!is_flush)
> +		if (!is_flush) {
> +			blk_zone_update_request_bio(req, bio);
>  			bio_endio(bio);
> +		}

As noted by Bart last time around, the blk_zone_update_request_bio
really should stay out of the !is_flush check, as otherwise we'd
break zone appends going through the flush state machine.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

