Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D83C43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3A6215A4
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQQqGWZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3A6215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XemOx85sTeohGxZELSpC4IFaZl2du0d0LWy8M7twxjc=; b=LQQqGWZWF+qzx2LQfentVqwdc
	O2n0T7071OhfKZdVCnpYYfKkLgZU3LYhambXPXn9JTAIc3bDMHJ+b8/LntZGx7S7L6AfaOgeAwDBj
	xLQL4l4HwVi2jW+X9eD7ULzPI/jbM+btmZB+4hqszOn2HwXkt/yTjwWIEfrOWMKUqogeFUffV7aVP
	tbbSip7fdn1LCh8NfU79v8lvjhd5bGrR5piwF3KHBc2J9/eQSte1w7DfvTmGGrZTIdvBz+VLs2mnd
	GICeXCG7oOEgjVK3OGXO/oFXjyROOOEAU9B7PjCkAsiLxSv3ui0yU8peN5bSS6eeL5duMpMvYYm+J
	azFfH6wFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZKH-0001Ja-7M; Tue, 08 Sep 2020 08:50:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZKD-0001Ht-9F
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:50:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 60C2268AFE; Tue,  8 Sep 2020 10:49:58 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:49:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
Message-ID: <20200908084958.GA17413@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
 <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
 <20200905072018.GA13403@lst.de>
 <BYAPR04MB4965438594B46644D7A35AC3862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965438594B46644D7A35AC3862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_045001_452833_E09F5A17 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 05, 2020 at 10:57:42PM +0000, Chaitanya Kulkarni wrote:
> On 9/5/20 00:20, Christoph Hellwig wrote:
> >> I still don't really like this idea. No need to keep a reference to a
> >> whole other file.
> 
> File reference open/close is coupled with ctrl refcnt and module refcnt.
> What is a problem with keeping the file reference open ?
> 
> > We could still lift the filp_open into the caller, but drop the file
> > reference right after we got the controller reference.
> > 
> 
> The file open call gets the ctrl and module reference atomically and on
> close release the module and ctrl reference respectively.
> 
> If dropping the file reference means closing the file then it will lead
> to loosing the module and ctrl reference.

Not if you grab an extra reference before closing it.

> That also means, moving the references get/put out of
> nvme_dev_open()/nvme_dev_release() in host-core, it will fix the problem
> only for the passthru case. Having done it in the core takes care of the
> all the cases if any.

I don't see why that is an either/or instead of doing both.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
