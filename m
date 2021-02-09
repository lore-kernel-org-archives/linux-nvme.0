Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B459C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 07:54:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2307064E37
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 07:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2307064E37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OlfqykzHq5ZkIMuB/LwAicx8ziEQWKsxyWgkfub2EcY=; b=i2pDVJHX+P8Lyw6UPXxOdjl7E
	ifAF5Id5AtbrNDfDRiEXkRenUtYIaYeI6gqzpeS22QynvJPGn3sHXWppb6P0BWtvCIrUH/3lZ4aco
	xnH/Hhnn3ieGrSZEplQ3+VFKfC827pRYCacB4G2o+hXvigpltIfoQ6gWzYhpJXFOEtOS2Q9qxFimR
	W2C0teRZZBZNF/sOpt1w9+lBRYug0ytFfy8cFsOxAx5Bzy3h7uNFa7q84b+gXfqXOiFaFWjo6Z3uM
	k+MSLQ4ETw5rZnUBXvYBjo2x1D1ukx+vWOiTujjoggxVcF6tgb/aGdSzG3b2B7ft+bMzU+5WGuaZt
	T1ZFVJE2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Nr7-0006Lv-8z; Tue, 09 Feb 2021 07:54:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Nr4-0006L5-DC
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 07:54:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 05EFA67373; Tue,  9 Feb 2021 08:54:35 +0100 (CET)
Date: Tue, 9 Feb 2021 08:54:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Subject: Re: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Message-ID: <20210209075434.GA31373@lst.de>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
 <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_025438_590036_8F29C5F8 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 12:53:17AM +0000, Clay Mayers wrote:
> > From: Clay Mayers
> > Sent: Tuesday, January 26, 2021 1:14 PM
> > To: linux-nvme@lists.infradead.org
> > Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> > 'Chaitanya Kulkarni' <Chaitanya.Kulkarni@wdc.com>;
> > Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
> > Subject: RE: [PATCH V2 0/2] nvme: Support for fused
> > NVME_IOCTL_SUBMIT_IO
> >
> Is there any other feedback on V2?

My feedback is that we should not add code to the kernel driver and
our fast path for fused command unless we have a mainstream in-kernel
users, that is not at all for the foreseeable future.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
