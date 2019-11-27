Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCFC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6787620835
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGy1wIpL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w9lHJila"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6787620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OmDjnBENCrFGkMFyi5pqbo7GAKXvIs/Hvz/pDM27T6A=; b=aGy1wIpLiQ78ss
	rdbm3RQ9ucvEefMSrbYTvhINXlB97XZKjJL6/Jdy34GgRnaHzGTKlEILJQVvu894jmxUQITPyVLXG
	PNvRsN4OEpvrdEaAQaNuIyE/BwNT6JJfr1/9GkzpmdpPwM0bgZeO34WQWlkr8CDK08k+QMyWZio0X
	veXLYFg+hXjxk3i3RgkKQXN6ZljTXvjJzhtBszQg46yr0+AbKnmebCRUbGLXM/HiIHbJH6v18j1MD
	yS/jGlIiuW73ZCmAZVDugndQrEpZTT7RVCXyxvWYZEqcqi2ppAbhUEP0eOd8C4/R9ZW05fSAtbpog
	dL4nonIOfkY7FxqYP+6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia2gZ-0003CB-ID; Wed, 27 Nov 2019 19:09:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia2gV-00037w-SE
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 19:09:09 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89854204FD;
 Wed, 27 Nov 2019 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574881746;
 bh=UqhatcLR9LOxkP1ncrlrHAD7fkzxOKAPqpZZMh3TRYk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=w9lHJilaBv2YyLvgX30eneNq5uGG3Z7cF5NVWt5j//AFTmw3bdCLs+vo49WsHHsic
 WFBoNGez1LazROdQXKVdsiDkmfbOgr4UeVnnyK8DruvwSCLiC5A3YEgRH2SJor6c1n
 C6jybFzunZHpL/6TNi+ACTDOXlMmZ5YZ9oqU4L3c=
Date: Thu, 28 Nov 2019 04:08:59 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
 <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_110907_970476_537FC201 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 27, 2019 at 03:29:58PM +0000, Meneghini, John wrote:
> On 11/26/19, 11:24 AM, "Christoph Hellwig" <hch@lst.de> wrote:
>     > I agree we need to make this status a non-path error, but we at least
>     > need an Ack from Jens or have this patch go through linux-block if we're
>     > changing BLK_STS_RESOURCE to mean a non-path error.
>  
>    >>> most resource errors are per-path, so blindly changing this is wrong.
>     
>   >>> That's why I really just wanted to decode the nvme status codes inside
>   >>>  nvme instead of going through a block layer mapping, as that is just
>   >>> bound to lose some information.
>     
> It wasn't my intention to turn NVME_SC_CMD_INTERRUPTED into non-path related error.
> The goal was to make the command retry after CDR on the same controller.  So why 
> does this patch change the meaning of BLK_STS_RESOURCE?

What I meant by a "non-path error" is that those types of errors for
nvme go through the "normal" requeuing that checks CRD. The failover
requeuing does not check CRD. But thinking again, I don't see why the
failover side can't also be CRD aware.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
