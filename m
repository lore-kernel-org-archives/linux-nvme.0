Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95648C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 09:44:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F362D20780
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 09:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="unuQ3fxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F362D20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZQwJOD7UuHYmXH/+VvMkfk9CjJ2TxwAtM1fY56Trjcw=; b=unuQ3fxI5PEP1wvwgqFkpE8WO
	vENbvyZ0xh4a6RsuRLNXGVQSbfPI9qOXtQNWNUW+nc/sPbpbaW7b0kZtQ6gAaHDf5Di+j5i2g0Lsa
	0DAomB8VS8TiGCAXXZ5II55EtNZjeXHbq0fN6FFTw5YMB+AMu4SRlGNyJ8qxdxKCC9iJSSvP7AeNL
	DlMCldRAq9tcMp+2BCwyR0fHC8OZ68uFy8vcLuR9EvN0xycbOt0z6CMVMkXQxKwL4FEWCNTFEeLVa
	LaPjMxvr32cw6JcAzVyT6+maWsAvF6Ofl+1xE4upizlbwxLWFn1t6VvrH5sjgpSr033Fd/82D7xxq
	H/UncY1/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcQC3-0006CD-UR; Tue, 10 Nov 2020 09:44:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcQC1-0006Ax-GZ
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 09:44:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 022DE6736F; Tue, 10 Nov 2020 10:43:55 +0100 (CET)
Date: Tue, 10 Nov 2020 10:43:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH V2] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110094354.GB25672@lst.de>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110093938.25386-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_044401_684989_B480BDA7 
X-CRM114-Status: GOOD (  10.02  )
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

> -	if (id->nsattr & NVME_NS_ATTR_RO)
> +	if (id->nsattr & NVME_NS_ATTR_RO ||
> +			test_bit(NVME_NS_FORCE_RO, &ns->flags))
>  		set_disk_ro(disk, true);
>  	else
>  		set_disk_ro(disk, false);

This has a very minor conflict with the patch from Sagi to remove the
else side of the clause.  I'll merge your patch and will fix unless
someone else objects to the approach.

Note that as discussed we really need a hard read-only settings
instead of set_disk_ro for both NVME_NS_ATTR_RO and the zns with missing
features case, but I'll look into that once I've got a few other things
off my plate.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
