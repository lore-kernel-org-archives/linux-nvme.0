Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77502C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8t/sfmGk3uiVkcIx+kL3mAVKtyr7xmvJMLDAdFCDSn8=; b=V7vMvvHgY+OrYiKPfA+Jkkx0Ck
	FGcfzATzQWuqBIShAaN32y2EXXI0I5SgKfr15II51b77CsWc6xlxp7S+HsQuoF9hWqRNyqVbXgXQ6
	G7YQhJTKssJt2YpUtqI1rYNUvqbg1IIwkOlhehbn44F2wABy7XRQpqAaZJGjkQKLufMDDPXLkBtSy
	tT2GRbiXBmUQJmSLRuXECbKeExYVHVELyGOjvot6YgbIxdq4ZXfWjCSAKWsu8dv2yAvYYMDE/muEU
	l+jmj+EOkxSeUP+EDVO6Dnmy1Ytj2UWZgNJBhW1z2P7usbmU77zPYW4XtMvyvQocu5CYlUA7K89b2
	QswE46kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmn7v-000qkP-2O; Fri, 06 May 2022 01:51:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmn7r-000qjt-Tv
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 01:51:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6F16EB83236;
 Fri,  6 May 2022 01:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B82C385A4;
 Fri,  6 May 2022 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651801881;
 bh=wgozsDONlpDNBdP9RVy4PIr+sdc8JpyMNa9VEuVsNtU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=scQmvht4GF2Wj8QVzgN1ywXEk6bLMBf078JycOj/eUxtVd1tVp76VgPa23U7N2ExJ
 d8p7fcUqSzPbQowKiH8MBggHslJeKbq94106XM0ZzDtMc8Y8Gy4WP7Eo0bluI4Tizo
 YfNHztMK8CKBBe/8sQc0KHnBGCpd7TlIfjkkhiY69RQP6Plrr3CE0ETcSZn12/6QOj
 Olo3e6+E3Azx3Q6+FYAZSkb0MioT8Fl6/uEU5gwtbJGMTrVZ7n5HyrHb4eLrj2ix9f
 j58Bne1zLx3GBxFkcltBmUV3OmvRVwyY6RYEwLsNmGv/xAPbqy2C3k4yFd6NmvHPig
 K1GBRtfsAdCQg==
Date: Thu, 5 May 2022 19:51:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux@leemhuis.info,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <YnR/FiWbErNGXIx+@kbusch-mbp>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
 <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_185124_147285_2AB3B26D 
X-CRM114-Status: GOOD (  20.50  )
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

On Thu, May 05, 2022 at 01:02:12PM +0500, Mikhail Gavrilov wrote:
> On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> > I think you did misinterpret the results. The max latency just says which power
> > state is the deepest it will request APST, and your controller's reported
> > values will allow the deepest low power state your controller supports, which
> > is known to cause problems with some platform/controller combinations.
> >
> > The troubleshooting steps for your observation is to:
> >
> >   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
> >   2. Turn off APSM (pcie_aspm=off)
> >   3. Turn off both
> >
> > Typically one of those resolves the issue.
> 
> Thanks.
> To make it easier for everyone to diagnose such problems, it would be
> great if every switching between power save modes would be written to
> the kernel log (when console_loglevel is KERN_DEBUG)
> If APST is culprit, we would have seen the change in the power state
> in the kernel logs before the message "nvme nvme0: controller is
> down;".

The "A" in "APST" stands for "Autonomous", as in the kernel doesn't participate
in the power state transitions, so we don't have an opportunity to log such
things. We could perhaps add a kernel message like the classic "Dazed and
confused" power mode strangeness since this spec compliant feature problem
seems to be bizarrely common.

