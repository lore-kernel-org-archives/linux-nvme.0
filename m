Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDFC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04FC64D99
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04FC64D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t3tUwtmQ08nF8AVEl8mavK852gzajp0LIyqiQ95nQD8=; b=QIwGq4eAX1OvvcB5JmQBXbNmt
	Hfoz6d83cIHzm8nCeubaYSapLbOHQArS88lquAUtU/U54zsh5i0mPtbdTdkCV/224TviSQWb4hZ/N
	WN/6mQn0kboXo0FRpR6jfEucmE5sva5lA0nTB+7WFbcXonXUK6v2HMDTQdw5qOq0Oco+RvBLU3Go/
	tCEXMSqX2gtIwLyoE+jog85ZaXCzACqOAr8EbkC/bB32fM27P8oDb3s9QyQKz2Q143pVy4fC5XCoC
	A3SV9JGjmE2VJwGUWVA5fgsCed1maSeYS6a2e5hYZeNp9PBIebEtkL4DSuoO+cdjUtIMQk6LC2hj0
	HBw/haGUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6s8q-0002ND-92; Tue, 02 Feb 2021 09:38:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6s8n-0002MN-TL
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 09:38:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D7D9468C7B; Tue,  2 Feb 2021 10:38:31 +0100 (CET)
Date: Tue, 2 Feb 2021 10:38:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Message-ID: <20210202093831.GG17771@lst.de>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-2-chaitanya.kulkarni@wdc.com>
 <20210201172438.GB12054@lst.de>
 <BYAPR04MB49653AC1A94F78112729EC6686B59@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49653AC1A94F78112729EC6686B59@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_043834_121407_EB8760F6 
X-CRM114-Status: GOOD (  20.16  )
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

On Tue, Feb 02, 2021 at 12:12:33AM +0000, Chaitanya Kulkarni wrote:
> >> +	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
> >> +	if (!req->ns) {
> >> +		status = NVME_SC_INVALID_NS;
> >> +		/*
> >> +		 * According to spec : If the specified namespace is
> >> +		 * an unallocated NSID then the controller returns a zero filled
> >> +		 * data structure. Also don't override the error status as invalid
> >> +		 * namespace takes priority over the failed zeroout buffer case.
> >> +		 */
> >> +		nvmet_zero_sgl(req, 0, sizeof(*id));
> >> +		goto out;
> >> +	}
> >> +
> >>  	id = kzalloc(sizeof(*id), GFP_KERNEL);
> >>  	if (!id) {
> >>  		status = NVME_SC_INTERNAL;
> >>  		goto out;
> >>  	}
> >>  
> >> -	/* return an all zeroed buffer if we can't find an active namespace */
> >> -	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
> >> -	if (!req->ns) {
> >> -		status = NVME_SC_INVALID_NS;
> >> -		goto done;
> > I think all we need to do is to remove the status assignment here.
> > While you're patch avoids the memory allocation for this case, it isn't
> > really the fast path so I'd rather avoid the extra code.
> >
> Sorry, I didn't understand this comment. If we remove the status assignment
> then host will not get the right error. That is the bug we fixed it
> initially
> with bffcd507780e.

Actually, looking at it, bffcd507780e is wrong.  Identify Namespace
to a namespace that is not active should return a status of 0 and
a zeroed structure.

> Regarding fast path, if system is under pressure even single memory
> allocation
> can be costly, especially when host tries to do read id-ns, is there any
> reason why we should not consider this scenario ?

No sensible host gets there.  I'd rather keep the code simple.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
