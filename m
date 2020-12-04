Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE052C4361A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 09:27:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EFB225AB
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 09:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFB225AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gPMDu5pPNbrXBa2X4QBAizNBwZ1EdqNVWZ64mvQliWE=; b=E2eTWU+Ehd+PY2KiGLNGcY6xG
	KxoN0lg9sqO3P1B9KCvdPc3sxLfMVUQVZRyOXgFeSwdokOf5Qzv9ZMRYa5Ip5YOv+sfH810+5v+Zx
	27SzDb6VFh/uppwxVsft7l/8KaTpMSS/UqOYyFc7xQBKFogYDtH60OfMOjr+ZX3uXx3pXd57Qq/jU
	0Y5SQNMA1cx+2OHy3awOwm3jejYOPqdvZb4uGZwob4iHh/YXVIuH0jqjS6IYWwT1e7QtnknDgeOUw
	mkvlRDILv+RAGVkAc2YSodTBwO+W4UCpg5qigazvVU9GaWZiJfp7g8vu8wxKdc86IK5vJI5Ip2vkq
	jpXSuns6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl7NV-000621-VO; Fri, 04 Dec 2020 09:27:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl7NT-00060J-Ej
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 09:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C436E6736F; Fri,  4 Dec 2020 10:27:42 +0100 (CET)
Date: Fri, 4 Dec 2020 10:27:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V4 2/9] nvmet: add ZNS support for bdev-ns
Message-ID: <20201204092742.GA8955@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-3-chaitanya.kulkarni@wdc.com>
 <20201202090715.GA2952@lst.de>
 <BYAPR04MB4965E50D3DCEFE4A0970631286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965E50D3DCEFE4A0970631286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_042747_684645_4A5BD8A2 
X-CRM114-Status: GOOD (  19.94  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 04, 2020 at 03:13:40AM +0000, Chaitanya Kulkarni wrote:
> >> +	if (!bdev_is_zoned(nvmet_bdev(req)))
> >> +		return NVME_SC_SUCCESS;
> >> +
> >> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
> >> +					&nvme_cis_zns, off);
> >> +}
> > This looks weird.  We can want to support the command set identifier in
> > general, so this should go into common code, and just look up the command
> > set identifier in the nvmet_ns structure.
> 
> ZNS is the only user for this, so I've added to the zns code. I'll move to
> 
> admin-cmd.

CSI is a generic feature, ZNS is just the first thing that requires it.

> > This will change the limit when a new namespaces is added.  I think we need
> > to just pick the value of the first namespaces and refuse adding a new
> > one if the limit is lower to not completely break hosts.
> 
> But that will force users to add ns with highest zasl first no matter what.
> 
> Isn't there should be a way to update the host with async event
> 
> so that host can refresh the ctrl->zasl when ns addition async notification
> 
> is generated ?

I'd rather not go too dynamic and change capabilities down dynamically.
I think that will cause all kinds of fun problems with I/Os already
queue up in the block layer while the limit changes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
