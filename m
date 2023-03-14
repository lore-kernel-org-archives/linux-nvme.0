Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29922C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyepM4Gr0+F/+3GZPpIxz3Rn5sYznnE8KznUYb37UWs=; b=ePfVXBGOO8VJuNrZ/nu26mYxOm
	UXb8Jm5ugeb71lTVwGTI9ZQiEiL0TEXJnhvcW+hUI1fDir61f3etP3UIwhNDqKlM3ZMe03Wt1Tow/
	K7Awt9j0EF4NPQ/ustT3ynvHt9ur2FkY+XWsPVK4jsHt6sH3mKZ37holnIAwZMAVwNZud09FGhAcv
	hPNFoAhjLdMQlnLsJ9dHqoWS8ILqOHQdp4/Sd7nRsiRDXUipT3NYDjrgVhSZjyCXdi/OO2GBGD5WL
	pVMesCr+LgxHSXXIgmldaQcyr01qa3Y/+PcHBsRsfmwUGVqnAJsDQbng8XaoUq6GleUZ1Db7Y+B69
	2Y/4dOYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8BJ-00AxHZ-0q;
	Tue, 14 Mar 2023 17:11:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8BH-00AxGT-08
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:11:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30BD268AA6; Tue, 14 Mar 2023 18:11:20 +0100 (CET)
Date: Tue, 14 Mar 2023 18:11:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH v4 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Message-ID: <20230314171119.GB6780@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_101123_221736_EF62E9BA 
X-CRM114-Status: GOOD (  17.18  )
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

On Fri, Feb 24, 2023 at 11:44:46AM -0600, Mike Christie wrote:
> BLK_STS_NEXUS is used for NVMe/SCSI reservation conflicts or in dasd's
> case something similar. This renames BLK_STS_NEXUS so it better reflects
> this.

I like this rename a lot.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index a9c2a8d76c45..a2899d9690d4 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -2723,7 +2723,7 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
>  	else if (status == 0) {
>  		switch (cqr->intrc) {
>  		case -EPERM:
> -			error = BLK_STS_NEXUS;
> +			error = BLK_STS_RESV_CONFLICT;
>  			break;

But is this really a reservation conflict?  Or should the DASD code
maybe use a different error code here?


