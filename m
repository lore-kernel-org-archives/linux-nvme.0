Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32467C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:33:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF83964DE6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83964DE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gRVO6qVCS0C2C3Ne4wJat8yebStRYZ/WshP3We/wQ7A=; b=gGkYagCo/39e9q6wJn/3QTc/4
	JjuHDss6ZpZn19BgFOVD10LJNkMFH8fOVnfaPUPar6Fm3lVU4mI3H4AzuPdoEgYcX2O7aDd8OR5bz
	ZRYYC+hr+xl5xSd2BI5EQn66a3gXcmeBNpgGEhj0FB7zjsvovqnlWjnii9KXRTYGVj9o0nZpYYGPF
	uoTY2CKY5mh8480Kzg1//yt0cWN8YhZP2gW8cQfDZg6VyXlCyx2dCPjXeQlNwXyIzaxLckrX/BVM2
	GORh8WVkFwsgzsAKaO5s07FdW8JcroCme0/OPV8wpViT2b/fhVh43E8Mk9KwN/aByjZl+tamAwXIk
	VZE3gDt3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53fu-0003Pm-TF; Thu, 28 Jan 2021 09:33:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53fs-0003P5-KO
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:33:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E83168B02; Thu, 28 Jan 2021 10:33:11 +0100 (CET)
Date: Thu, 28 Jan 2021 10:33:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v4 7/8] block: introduce blk_queue_clear_zone_settings()
Message-ID: <20210128093310.GB3212@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-8-damien.lemoal@wdc.com>
 <20210128092107.GE1959@lst.de>
 <BL0PR04MB6514021E07E861070BDD852EE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514021E07E861070BDD852EE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_043312_880737_B493D479 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 09:32:22AM +0000, Damien Le Moal wrote:
> On 2021/01/28 18:21, Christoph Hellwig wrote:
> > On Thu, Jan 28, 2021 at 01:47:32PM +0900, Damien Le Moal wrote:
> >> Introduce the internal function blk_queue_clear_zone_settings() to
> >> cleanup all limits and resources related to zoned block devices. This
> >> new function is called from blk_queue_set_zoned() when a disk zoned
> >> model is set to BLK_ZONED_NONE. This particular case can happens when a
> >> partition is created on a host-aware scsi disk.
> > 
> > Shouldn't we just do all this work when blk_queue_set_zoned is called
> > with a BLK_ZONED_NONE argument?  That seems like the more obvious API
> > to me.
> 
> That is what I did. blk_queue_set_zoned() calls blk_queue_clear_zone_settings()
> for BLK_ZONED_NONE case. I simply did not open code the cleanups in that
> functions because it is simpler to stub only blk_queue_clear_zone_settings()
> rather than having conditionals in blk_queue_set_zoned(). That also puts the
> cleanup function together with the code that allocates most resources in
> blk-zoned.c. Easier to not overlook something.

Ok, looks good to me then:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
