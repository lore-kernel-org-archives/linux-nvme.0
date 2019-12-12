Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69297C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 08:37:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B36A214AF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 08:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAz37XEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B36A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3e15oC+OnVqne7jflIJgndi90OevnZXZa21kjnOFLfk=; b=UAz37XEcWDjym7
	m9s1C0xnGRurhprigsNXBg6kF7jamlXe7eyRGHwAJFtjclbR/ztKIsEwyyMV4suUG1WCS4aI8CwX0
	3Wom+mL+oMdrGjocwrp7SHD19rKZeB5dLeEHtjEQwffHvT2puAXBrWcB+rcAXzc/fuZA0g0w8TXat
	Cq3HKnJ17BScAV9MWEXUklnivoEV9HZq4SXJZx3Y+SIOQbgVr4UBNSTS2/zuDOcPhovFhPpEi+jrd
	9xaqdzfrzEYHIsEPAwpx71Wx7IkWmrNcooC6OnHRzc3WljoEZJrxMx1sBgBY0rBKQBkP3r/nOBYdD
	gvbmWZzUpT/OFNUdTnpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifJyF-0000hp-Gv; Thu, 12 Dec 2019 08:37:15 +0000
Received: from mo-csw1114.securemx.jp ([210.130.202.156]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifJyC-0000gz-5o
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 08:37:14 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id xBC8aWQ7016858;
 Thu, 12 Dec 2019 17:36:34 +0900
X-Iguazu-Qid: 2wGrboNCkMzgqCTjvd
X-Iguazu-QSIG: v=2; s=0; t=1576139792; q=2wGrboNCkMzgqCTjvd;
 m=3+jrtIiot6RHUUlSUJIM8JcMPuPYfZ1F07Mw0FljjlA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1113) id xBC8aTFd002943;
 Thu, 12 Dec 2019 17:36:30 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id xBC8aTN0026102;
 Thu, 12 Dec 2019 17:36:29 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id xBC8aTAQ021987;
 Thu, 12 Dec 2019 17:36:29 +0900
From: <tsutomu.owa@kioxia.com>
To: <kbusch@kernel.org>
Subject: RE: [RFC PATCH 0/5] to add more nvme reset functions
Thread-Topic: [RFC PATCH 0/5] to add more nvme reset functions
Thread-Index: AdWvyPOIQs9Y1uTsTWmA/qAYXNTemQAKjieAADRFOdA=
Date: Thu, 12 Dec 2019 08:36:27 +0000
X-TSB-HOP: ON
Message-ID: <58ecb196bb1844fda85b3ae4bfc5bfe4@tgxml778.toshiba.local>
References: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
 <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.119.78.25]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_003712_488072_EBB4FC15 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: hch@infradead.org, tsutomu.owa@kioxia.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith-san,

Thank you for your reply.

> From: Keith Busch [mailto:kbusch@kernel.org]
> Sent: Thursday, December 12, 2019 1:18 AM

> You're not providing any justification for why you want these implemented
> in the nvme driver. What issue is this addressing?
  Please give me some time to write it in another email.

> First, if you're going to introduce a Kconfig option, don't split the
> patch that actually uses it. Second, don't introduce new kernel config
> options for such features in the first place.
  Ok, I'll remove these Kconfig option.

> > 	- what is the best way to export nvme_pci_* functions in
> > 	  drivers/nvme/host/pci.c to drivers/nvme/host/core.c.
> 
> Don't export functions that direction. Use ctrl->ops if core needs to
> call a transport specific routine.
  Yes, I'll use ctrl-ops if needed.

> > I'm still wondoring
> > 	- if it's ok to export functions from drivers/pci.
> 
> Probably not. They are private for a reason.

> > Any comments would be highly appreciated.
> 
> The majority of this series is at the pci protocol level, and the pci
> driver already provides the requested capabilities (but with a more
> safe implementation). Let's not reinvent it just because one nvme
> transport happens to use the pci bus.
Thank you for the comment.  I'll look into the pci driver again to look for 
functions avilable.  Would you please point out function names good for
conventional hot reset and/or link down reset which can be called within
the kernel if you know.

thanks for your time.
-- owa


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
