Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15609C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:24:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECB264DDC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECB264DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eIPQGzRP11hHkorhBUbw84G2kupADLFzeXj8llyKOys=; b=c9htpTRYd4qiibsYf+sJhBVBr
	mUcYEvZUbBTsMaTSFipai+xrufo5o3jA/srcJ2kE61OAnQlwgdDdESN+CP5qeZLPAmwptBFA84IuV
	J3V9mwlaJeEV+6IJherDNoiYQd61ztECIMTDD+7iDWoyT6Rb+D9DdE/1wa9wb9JyWCPO7IijWRKY8
	01HzJE5RiyfHXChkczAXtis5oPurZcdRumLCpWCrxBgBD5GC6JGIUp+6Bj3OKufQd2dT3ssTY/DKr
	FjlIKbyNl+Bcxhi427D8BeUTGBjjkkzSDytaeNIvuODL4T3Cd5RMmGnOvmIHy1SkZ0bsM/nhd8ISx
	XoHhpXwTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53X8-0001k0-W5; Thu, 28 Jan 2021 09:24:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53X6-0001is-EJ
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:24:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 67D2068AFE; Thu, 28 Jan 2021 10:24:06 +0100 (CET)
Date: Thu, 28 Jan 2021 10:24:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Message-ID: <20210128092406.GA2607@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-9-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_042408_755038_6361EEB6 
X-CRM114-Status: GOOD (  17.31  )
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

On Thu, Jan 28, 2021 at 01:47:33PM +0900, Damien Le Moal wrote:
> For host-aware ZBC disk, setting the device zoned model to BLK_ZONED_HA
> using blk_queue_set_zoned() in sd_read_block_characteristics() may
> result in the block device effective zoned model to be "none"
> (BLK_ZONED_NONE) if partitions are present on the device. In this case,
> sd_zbc_read_zones() should not setup the zone related queue limits for
> the disk so that the device limits and configuration is consistent with
> a regular disk and resources not uselessly allocated (e.g. the zone
> write pointer tracking array for zone append emulation).
> 
> Furthermore, if the disk zoned model changes at run time due to the
> creation of a partition by the user, the zone related resources can be
> released.
> 
> Fix both problems by introducing the function sd_zbc_clear_zone_info()
> to reset the scsi disk zone information and free resources and by
> returning early in sd_zbc_read_zones() for a block device that has a
> zoned model equal to BLK_ZONED_NONE.

So creating the partition doesn't even call into the driver, which
means we'll leak the info for now.  But I guess the next revalidate
will simply clean it up, so it is not a major issue.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
