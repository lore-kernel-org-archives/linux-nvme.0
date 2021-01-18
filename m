Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66076C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:27:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E4E22D03
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E4E22D03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3USvdR2XoxByPHezwVSOG2RaaUfiu2TLvvK59JnxkIM=; b=BzBed+6uIVH04j8zmId8O9LBa
	XzhJfCb7EmLN061yTYH4aeuQWow618XgH8Gat+A5eJrzDYk6YXzqomW77i9/CLbmFHbvwD0vJuCXy
	+zP/g+x3Oen9g65zKLkotVa5B7L1lrt8gBd4PIWRclgr4QP/OvlgbfG40HNJrmQNKAUt9kE6DYZpx
	J9uFSaNCWBu9a4HD/7dN9hLAGxulkSfJK8qPS9WUpO/6QbWvrVYB0Oak5T5GCXCmf9jJ0P+u2IqmN
	iadf6E00U1gpCyv59qQjj6GkDXUI30Ha3+F7mCZgijLxg+FMBN8AsXtBVmShvO769PW2DpHa4abwq
	phXmcCqvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZFP-0000Fe-Bp; Mon, 18 Jan 2021 18:27:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZFN-0000Ey-C8
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:27:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C7B506736F; Mon, 18 Jan 2021 19:27:23 +0100 (CET)
Date: Mon, 18 Jan 2021 19:27:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210118182723.GD11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
 <BYAPR04MB4965CE08B1DE8BC36585991686A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965CE08B1DE8BC36585991686A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_132725_586143_D5D1ECFD 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 04:57:15AM +0000, Chaitanya Kulkarni wrote:
> >>  	/* command sets supported: NVMe command set: */
> >>  	ctrl->cap = (1ULL << 37);
> >> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> >> +		ctrl->cap |= (1ULL << 43);
> >>  	/* CC.EN timeout in 500msec units: */
> >>  	ctrl->cap |= (15ULL << 24);
> >>  	/* maximum queue entries supported: */
> > This needs to go into a separate patch for multiple command set support.
> > We can probably merge the CAP and CC bits with the CSI support, though.
> Do you mean previous patch ?

Yes.

> but we don't add handlers non-default I/O
> command set until this patch..

No, bit 43 just means the TP to support multiple comman sets is supported.
That infrastructure can be used even by controllers only supporting the
NVM command set.

> > bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED
> > these days.
> Are you saying something like following in the prep patch ?or should
> just remove
> theIS_ENABLED(CONFIG_BLK_DEV_ZONED)part in above if?
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 028ccc9bdf8d..124086c1a0ba 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1570,6 +1570,9 @@ static inline bool bdev_is_zoned(struct
> block_device *bdev)
>  {
>         struct request_queue *q = bdev_get_queue(bdev);
>  
> +       if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +               return false;
> +
>         if (q)
>                 return blk_queue_is_zoned(q);

blk_queue_is_zoned calls blk_queue_zoned_model, which is stubbed out
already.  So no extra work should be required.

> 	/*
> 	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> 	 * to the device physical block size. So use this value as the *physical*
> 	 * block size to avoid errors.
> 	 */

See my reply to Damien.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
