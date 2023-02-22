Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C74C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96YfCTjo0uIR0/5W7Y7bHAyKtiTHkOP0iPz7Swp5xkY=; b=KU0Z9z+L5OBtx6ZfOMxm2QbNmO
	L28duXpQ9KrCSraG38W4R4Plkyh9OlMhgUgKaOZVCF8nqvB9gONeAM7mEluQNVktUpCxyYUAZlb2E
	flfuEgZspLPpVlGYjy9hIml10e/wZ6n/3M26J4A/jm8lTWE1tWasqF13/mtjD2xbC+B4ZPkJHtHmD
	91shHHgYZMXSz411UPUPdB9QmwL6Wximt4t97jL3QWWzwMyYqb6hv+t2PwK9QN+FPzN8RmIElGtSX
	V0G9QpBdTaxOmk+zBPmmJ2xA8L1uQAV/5v8fBLf4yxumvDbpLvp+okXezF56J7EAFFio5YvonEDql
	nLEhoiFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUrB1-00CtQ2-Qp; Wed, 22 Feb 2023 15:37:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUrAy-00CtPW-QG
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 15:37:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0069C6141C;
	Wed, 22 Feb 2023 15:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408CC433EF;
	Wed, 22 Feb 2023 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677080219;
	bh=FbGIiq9m4fsIkQ+G9Zan/ZZaJI2SN3Ob8d8KZNzES+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FElNTwnoNw5GI+l3YQNREYrYkxJRkGmA/5AtFI0/jke1/Fcq7ObTygZjHTEygZ+Mz
	 HRAbuUNJ9d61FE+ZbwFlxt3QTXqYi9RZj7GazHjLB7knLslEOMN5DfLuAHOW0VlzX1
	 jyZnEXonL+VmxeRbFeRATbcXg5CPgSz1xOOVfwTMWo6EWFGBjioYExfWbF6H5NYr/x
	 1rtFna9AfRs3CwUa3ldE2FjmzpKK7SLMgkRVqNBWNBqeDIFdb5Aae4AQgrYPaocwHx
	 K3o0736AgiVWuWWUcxcEZIs+FX6SOBOir6BoIyBsDeKBD0RoxGCeb2+x1LT4/1Y56N
	 nl4jsZ7Irtybw==
Date: Wed, 22 Feb 2023 08:36:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux@leemhuis.info,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <Y/Y2mJALiaNxZrX+@kbusch-mbp.dhcp.thefacebook.com>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
 <CABXGCsPStDr8M6v2jCvC2mKOXf6wV1+_tNORPNkTTgToYbWRFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPStDr8M6v2jCvC2mKOXf6wV1+_tNORPNkTTgToYbWRFw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_073700_912108_C8F1A4E0 
X-CRM114-Status: GOOD (  16.61  )
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

On Wed, Feb 22, 2023 at 06:59:59PM +0500, Mikhail Gavrilov wrote:
> On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> 
> > The troubleshooting steps for your observation is to:
> >
> >   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
> >   2. Turn off APSM (pcie_aspm=off)
> >   3. Turn off both
> >
> > Typically one of those resolves the issue.
> 
> What to do if none of these steps helped? I attached log which proves
> that I am using both parameters nvme_core.default_ps_max_latency_us=0
> and pcie_aspm=off .

Those are just the most readily available things we can tune at
this level that has helped on *some* platform/device combinations.
Certainly not going to solve every problem.

You are showing that the driver can't read from the device's memory,
and there's nothing the driver can do about that. This is usually
some platform bios breakage well below the visibility of the nvme
driver.

Perhaps your platform's bridge windows are screwed up. One other
thing you can try is adding param "pci=nocrs" to have the kernel
ignore ACPI when setting these up.

