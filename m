Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F131DC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:23:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C4764E42
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C4764E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UE+5PNAfIzpOTFQxXDddLECJMtWB/2SGHo+bA7ZjF2Q=; b=x1xaEwKeDTNjLlBYvK6KFEAF/
	UV5VO6w1b19blVVc98TTvMem9I5VKoTv7QhGIs6nKA0+yVg3B+eVM55/atit0JRzxFOYhyGumUHOX
	9NGoyzmsZ47zXcYP/SgV73Idx5kwu2mpbKm0Zz+IM0PIQFvd+jl8OclKb5YjY9QWDtm+nCnLMN7nM
	QtGz88wOzCDqCdigZl1UBS9k8GzoUyME65c6GigPavccvVqgFVCpSSQSafdmFW/datBQA69eqYezH
	2idmmXpl+bV/ZJ+7OAwl8tL8/YYknfLrCpqDRrWWtwYweUtF43HlMQzrkP1Xrxy8i3ARJRmVCvJ9o
	j5289WAhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9kmo-0004hi-2k; Wed, 10 Feb 2021 08:23:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9kml-0004gs-37
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 08:23:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 87E6B6736F; Wed, 10 Feb 2021 09:23:40 +0100 (CET)
Date: Wed, 10 Feb 2021 09:23:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V3 09/11] nvme-loop: rename variable to get rid of the warn
Message-ID: <20210210082339.GA24330@lst.de>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
 <20210210054802.34269-10-chaitanya.kulkarni@wdc.com>
 <20210210081335.GE24040@lst.de>
 <BYAPR04MB496597E9F3AE6D3D82306C0E868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496597E9F3AE6D3D82306C0E868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_032343_257722_D27269C4 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 10, 2021 at 08:18:16AM +0000, Chaitanya Kulkarni wrote:
> On 2/10/21 00:13, Christoph Hellwig wrote:
> > numa_node is a perfectly fine name for a local variable.  Please find
> > the global one and rename it instead.
> >
> I know, the warning is really annoying breaks the automated script for
> clean compilation.

So fix the global variable, which is indeed very badly named for global
variable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
