Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38827CD37AD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Sep 2023 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/5RFv47x87u0a5VDW5H5f+wItWXg5AXze/9/X3tCWU=; b=s1UxgVXCVhqJYe3fFmOUVD1abG
	0WFI1p2W+q9TBTMkLgyr1Ul2F8wjxfgjowytlRqzSTLkHbqVjxccM5IwvDNJxhBWyEpJiHwtcYqLB
	28T1qKmqKQ9NN2f8eSQPzrSaKyid53pnrrM4OnD4a3Wlm77ICUZWrT84NXs4ihISjJgYcya83H0fA
	A11cArAxRNpkvzfrBtJH+Ca/Bu3Ev4RGO/ryh2pKnCVFEDBzAE8Y3q8mo8EXsJnzp5lZCRIdFZNjG
	1TksX5AZBKJ0uX2bAdtXwcrOq3VCH3MzPsL/IJ7lq4olAjt3a0USquEExdW2bSQs28Prv8pv+n4IM
	s4+YHaQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhGho-00BRnF-0k;
	Fri, 15 Sep 2023 21:50:28 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhGhl-00BRmm-0V
	for linux-nvme@lists.infradead.org;
	Fri, 15 Sep 2023 21:50:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4AA6CB82F32;
	Fri, 15 Sep 2023 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EEAC433C8;
	Fri, 15 Sep 2023 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694814622;
	bh=h4tQScTvZ4DuiW3BfzRqqFRi9CTF7m53FDoxLYk3Q9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKpYa8LV1Tz+qI4FLo2ta+zBWQUPRxdK6q5ZkvcMGm6G+PZpU5cbc0ROqqTFESOeQ
	 GDNWwukzcITWiBjdGFfRuaQIO2/rJncVhK+M0EomAS5k9+Ld3diTKbgHihB3A5+8g7
	 rGmmXYhA/v8Uo9V1Vgkyd2HsKWXkGnl7pekbkjh/uGF25zmCTlL7AYN6pCyNQbpMyr
	 EIPlyVSOwh3BY9+g5T8unwSKzXQ3xLPiv8//idlNQqAWIqp4MXs6qoLnLfFs/TUrna
	 SxRzHXAAaL1smTdPnze9QNQ8PWBA0oOkRHWoeQiZC0qxMcv3RVRnfaY4dr4yjyqsJs
	 W7SWnYwziNE3A==
Date: Fri, 15 Sep 2023 14:50:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	=?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Felix Yan <felixonmars@archlinux.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQTRnJm0z3ZE3x4I@kbusch-mbp>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
 <ZQHf8Yyw+UC9ysDR@x1-carbon>
 <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
 <ZQTNP5lnFFn8ThkZ@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTNP5lnFFn8ThkZ@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_145025_366662_2D60D679 
X-CRM114-Status: GOOD (  21.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 15, 2023 at 09:31:44PM +0000, Niklas Cassel wrote:
> I'm not saying that these controllers shouldn't work with Linux.
> However, these controller used to work with CC.CRIME == 0, so perhaps
> we should continue to use them that way?

Perhaps I missed something, but I didn't get any indication that these
controllers were reporting CRIMS capability. They're just reporting
CRWMS as far as I know, so CRIME doesn't apply. I only included that
case in the patch for completeness.
 
> So having both fields defined to zero, or rather, to have both fields
> defined to a value smaller than CAP.TO, regardless of CC.CRIME value,
> is quite bad.
> 
> So perhaps it is better to keep CC.CRIME == 0 for such controllers.
> 
> 
> > If we have a way to sanity check for spec non-compliance, I would prefer
> > doing that generically rather than quirk specific devices.
> 
> It's not going to be beautiful, but one way could be to:
> -check CAP.CRMS.CRIMS, if it is set to 1:
> -write CC.CRIME == 1,
> -re-read CAP register, since it can change depending on CC.CRIME (urgh)
> -check if CRTO.CRIMT is less than CAP.TO, if so:
> -write CC.CRIME == 0 (disable the feature since it is obviously broken)
> -re-read CAP register, since it can change depending on CC.CRIME (urgh)

There is a corner case that I am somewhat purposefully ignoring: CAP.TO
is worst case for both CC.EN 0->1 and 1->0, whereas both CRTO values are
only for the 0->1 transition. It's entirely possible some implementation
needs a longer 1->0 transition, so CAP.TO *could* validly be greater
than the either CRTO value. I just don't see that happening in practice,
and even if we do encounter such a device, waiting a little longer on
init for a broken controller doesn't make any situation worse.

