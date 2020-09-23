Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCFC2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 18:02:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D37C2075B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 18:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1QKfjO8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D37C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0q+7T+nClZqx74vu90lQcIVAYvoCh22w68vA/VYoznA=; b=1QKfjO8cy7UldNqNtyphm/+vm
	Aw+jVjPgZjOrsmk8/NYcICYsjCjmnZneXI4U4kaydkyIIevB+igxomqJk7P1AyMQVpHpzJId3MWmh
	UpVZBs+KAjAEtMv1xJAFZGzcfUOFn8PSBJcoojDrT74Nb+FfFY+kW5B7qz7Z0A51yaiS2yqCwM1U+
	UxJmKctHa9oY2s4VOExoPaYHi9BNi0Yglvs0YYX4twk93QQkNrqvVCp17yHo/lwJSyItoBufm8j9Q
	tY2gcgbNbUQ/JjIBG+lddAiaogNlGny91AJX2syURxXcc53llR57lsCOaamGksWJiXpykRSPRSytq
	Z3nrwXeiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL96B-0005w1-Sq; Wed, 23 Sep 2020 18:02:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL968-0005uz-NN
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 18:02:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F154C6736F; Wed, 23 Sep 2020 20:02:29 +0200 (CEST)
Date: Wed, 23 Sep 2020 20:02:29 +0200
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-core: don't use NVME_NSID_ALL for cmd-effect
Message-ID: <20200923180229.GA24820@lst.de>
References: <20200922194938.51845-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49653CBA4B13CC2595F9205D863B0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200923173544.GA4036936@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923173544.GA4036936@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_140232_887393_943CFD04 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Huai-Cheng Kuo <hh81478072@gmail.com>, "hch@lst.de" <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 23, 2020 at 10:35:44AM -0700, Keith Busch wrote:
> On Tue, Sep 22, 2020 at 09:04:36PM +0000, Chaitanya Kulkarni wrote:
> > In the function nvme_get_effects_log() it uses NVME_NSID_ALL which has 
> > namespace scope. The command effect log page is controller specific.
> >
> > Replace NVME_NSID_ALL with 0x00 which specifies the controller scope
> > instead of namespace scope.
> >
> > Reported-by: Huai-Cheng Kuo <hh81478072@gmail.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=209287
> > Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
> 
> This is actually the wrong fixes tag. The code was simply carried
> forward from 84fef62d135b6.
> 
> But otherwise, yes, this looks correct.

I've fixed up the fixes tag in the nvme-5.9 branch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
