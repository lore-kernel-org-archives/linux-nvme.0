Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F612C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:17:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794F364DBD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794F364DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g+G7lUFBkZ43J1XXtQfjGl4gzy4cXPEGho1SnCcmXIY=; b=0iNde7i70Grav39Xz2+eadu7t
	otDMYe4s8Nily2w22mKoq/BHEfSE7hk7/M71kUntO1lzaojN4busRjl8qvEzHVKCcHiwfKI+o0mKn
	Q2F2Ec7OtFdrmCQp3UWso0/AoD6bmkUm0YoV1gyOnhjCOgG7ADWa30F0RGyTnM/2B5SRY+WShNpI5
	//cA0S9QBc58zFPjejAUynSeYMfNs1PBIQ8HfnEj/CE36vZW5nRqM5yDLWr2YhL3hy29ltE+RNh8P
	2cWmNr27g7pJgLOr5YY8VmccILKy5W3idLvWjGsb4xWYXUh2FUv4B7O29dZV8ma0/4SIdbCd6XuTB
	5yRLtaYDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53QU-0008SV-Hh; Thu, 28 Jan 2021 09:17:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53QR-0008Rd-Dp
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:17:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 51C6868AFE; Thu, 28 Jan 2021 10:17:10 +0100 (CET)
Date: Thu, 28 Jan 2021 10:17:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v4 2/8] nvme: cleanup zone information initialization
Message-ID: <20210128091710.GA1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_041715_579500_0CC281C0 
X-CRM114-Status: UNSURE (   8.06  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  int nvme_revalidate_zones(struct nvme_ns *ns)
>  {
> -	struct request_queue *q = ns->queue;
> -	int ret;
> -
> -	ret = blk_revalidate_disk_zones(ns->disk, NULL);
> -	if (!ret)
> -		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
> -	return ret;
> +	return blk_revalidate_disk_zones(ns->disk, NULL);

We can just kill off nvme_revalidate_zones now and open code it in
the caller as the stub is no needed now that blk_queue_is_zoned always
return false for the !CONFIG_BLK_DEV_ZONED case.

Otherwise this look great, nice cleanup:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
