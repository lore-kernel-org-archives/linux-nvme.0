Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE40C4741F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:14:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E462071A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ptMP13pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E462071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qysHPrEVjKLTnf7RCod/gX6O725BzF1Th4UFAU4QL9M=; b=ptMP13ptJLK4JvOpfwD7xoOM3
	zCAp+1DBaCMy2W/qXFWdvErRtGhSPC9JK5DUw4vHE4Ar7cIbOEXbrGj3orsLPXDaOp9hSpnPT9X07
	7IPB6WJ0zMS/7r2bCQQ7XowIIupeRIqs8O4unPJzrqXLsa8X7b7NVAyZivMwdowXG1eNesCxBZCpI
	wj2Un5ZTOHqsq9xCDDHKHag5Qwdg42jCqc1FuEcypBQjnERorXSYxtsDnjg6NnJN7RWWdIrSUxjfe
	pKB+8m51T6Gm/tqX1+eB3MIv2v1k/Fav19Lcza1xzy3hiTF/Gris0VWaNloBnwhdtr1YKwz454Dh+
	3ADsq6xkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb2Vf-0003FY-2a; Fri, 06 Nov 2020 14:14:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb2Vc-0003F5-OE
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 14:14:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 71E9868B02; Fri,  6 Nov 2020 15:14:29 +0100 (CET)
Date: Fri, 6 Nov 2020 15:14:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH] nvme: enable ro namespace for ZNS without append
Message-ID: <20201106141428.GA23884@lst.de>
References: <20201106122637.14490-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106122637.14490-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_091433_129377_544CC818 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (blk_queue_is_zoned(disk->queue) && !ns->zoned_ns_supp)
> +		set_disk_ro(disk, true);
> +#endif

I think we can simplify this at bit.  Add a new NVME_NS_FORCE_RO flag
to ns->flags, set it in nvme_update_zone_info, and just query it here
without any ifdefs.

>  	struct request_queue *q = disk->queue;
>  	struct nvme_command c = { };
>  	struct nvme_id_ns_zns *id;
> +	bool zoned_ns_supp = true;
>  	int status;
>  
>  	/* Driver requires zone append support */
>  	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>  			NVME_CMD_EFFECTS_CSUPP)) {
> +		zoned_ns_supp = false;
>  		dev_warn(ns->ctrl->device,
>  			"append not supported for zoned namespace:%d\n",
>  			ns->head->ns_id);
> +	} else {
> +		/* Lazily query controller append limit for the first
> +		 * zoned namespace
> +		 */
> +		if (!ns->ctrl->max_zone_append) {
> +			status = nvme_set_max_append(ns->ctrl);
> +			if (status)
> +				return status;
> +		}

While you're at it:  my inverse the polarity of the if check as that reads just
a little more natural, and maybe mention in the warning that the namespace is
forced to read-only mode?

Otherwise this looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
