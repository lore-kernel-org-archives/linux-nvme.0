Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B68AEDE99E
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NA2QQiG8na7p2zyoHrqglnZGulVew8OYf20oAvjPOiI=; b=bxXgv0q094G5CzDJDkS5ZxLRWO
	yIgD1JK9KN5wejzvlPX+ebv6v1v/VnOsEXkghpyvg/Lgd05idHIZM3muGzcYQt/RQePswr6UWJL8r
	U0Qg0JtsBOTUK/PIeNI/fV/uphAGFgo1xmdtcDmbJSN8elI4Ja8odYe1e6ryJ6cbArP6Nd+R5DTzv
	3woEwtPv52qQHbN4avdqPlPIDYjJT3nMys6zlBiYUJS1NpKsENGV1Bvfg3vOb5uBfb7hQ3UJMngMn
	OkYYnGdtZxvbI724eTBtTV8dCxrpZAQzNd8um4G5m+QC4jHvoaerEZAzpnK2RK4R83BxxgyBiOW0p
	I2Lmh03g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so31j-00000006Bj5-3QZR;
	Tue, 10 Sep 2024 15:43:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2qv-0000000682y-0lpF
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:32:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 888AD227AAE; Tue, 10 Sep 2024 17:32:18 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:32:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 03/10] scsi: use request helper to get integrity
 segments
Message-ID: <20240910153217.GC23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_083225_518936_FF56BC60 
X-CRM114-Status: GOOD (  12.24  )
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

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 3958a6d14bf45..dc1a1644cbc0c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1175,8 +1175,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
>  			goto out_free_sgtables;
>  		}
>  
> -		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
> -
> +		ivecs = blk_rq_integrity_segments(rq);

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I'd be tempted to just remove the BUG_ON below (or move
it into blk_rq_map_integrity_sg) and the ivecs variable entirely.


