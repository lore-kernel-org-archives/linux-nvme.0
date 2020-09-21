Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543DC4346E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB41216C4
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VdJ61Kwc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4PzyqrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB41216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7tP2CAiuVophAcPejl2qUHlc/Z45oL2ferr2tDRuQxk=; b=VdJ61KwcOBeKqkhIWlxhxQ70T
	l7qpzRE4NZbFItRkagc/PrSsOryW7/IFf5qIW5r9uZ5Ng37jJ4r4no4wyE+3s4+EdCMLqqzPA0Xwl
	OEOF8bRIFtpF46VGPnKpz5/5q93GZo6vns1nO7puy36V14o+VXZIEsKso7Q7zLcEUSjH6nAAt0bUa
	OQh8L9RWg7uqgttu2VZqkIo+aavqMbs8oU120PxLRw5baE8Ru8o4pXHZOTYBB7VOoqfEMK3W2VvpZ
	s52qvK1RVVyISiFmgWxxqImFCrO5HYa9XTuTigJPexmHBhw6Lyv6McFhKZ0ObRhHdId6IaVyEyXTv
	QGbH8BegA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKRQB-0000wA-8q; Mon, 21 Sep 2020 19:24:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKRQ8-0000vK-4e
 for Linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 19:24:17 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1993D20757;
 Mon, 21 Sep 2020 19:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600716255;
 bh=6HtsFWmoowQUHmum/hxMzRIMDVMehQO4HAX5xLRZyWs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y4PzyqrAWDJQU1/g5eI2Ay1lDo1S7OrupyNI6A5UtnYsywAjQrGp9EYhm2nfphm3N
 kcUK9GaAbEicef9n48rpRcLrsc+xdu4de3BZ0CMQTi09bpJtMLT062Qx1qF6IsLXc+
 HCyyGJjc3uE91Eh85IyNRRsVyscrk8Ffvb89xUkw=
Date: Mon, 21 Sep 2020 12:24:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kallol Biswas <kallol@nucleodyne.com>
Subject: Re: processor reboots if nvme host controller is surprise removed
Message-ID: <20200921192403.GA4034420@dhcp-10-100-145-180.wdl.wdc.com>
References: <CAH=XD5_UeVPWHskOwwPeHZpv9sKXKvvA8BS-_58KqdXfpY8OWw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH=XD5_UeVPWHskOwwPeHZpv9sKXKvvA8BS-_58KqdXfpY8OWw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_152416_345164_B8B37A98 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 21, 2020 at 11:38:48AM -0700, Kallol Biswas wrote:
> I have an issue with powering down a nvme host controller while fio is active.
> Hoping someone from this list can provide some input so that the
> problem can be resolved or worked around.
> 
> 
> System info:
> 
> description: Motherboard
>        product: X570 Phantom Gaming X
>        vendor: ASRock
> 
> *-cpu
>           description: CPU
>           product: AMD Ryzen 5 3600 6-Core Processor
> 
> Fio with 50-50% rdwr traffic is active and when the power to the
> device is removed by an external means.
>
> 
> A few commands are active in a submission queue.
> 
> I/Os time out.
> 
> The nvme_timeout routine is called. First register access is CSTS.
> Sometimes the read to the register returns 0xffffffff.... sometimes
> causes the processor to restart. When this returns  0xffffffff the
> next processor restarts trying to access the PCIe config register
> PCI_STATUS.
> 
> The root port had big CTO value, I changed to 0, still it did not help.
> 
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> 
> To:
> 
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> 
> This change does not help  processor restart in nvme_timeout()  routine.

It doesn't sound like your platform handles an unexpected link down.
What does your root port's Link Capabilities register show?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
