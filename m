Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF5EC47086
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:24:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74245613CD
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74245613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kdSYy1hVhs37Q8fRK+rZN4S6Ku7eF35pEdwBbuQ2C8E=; b=aSF+MvmP0ypCPw
	xWckd9ApKJyZLCBpu2G4EX7hkBJSbhUFqX87nDXXRCiEizxYGmC9w5PvRbbpkid0XBXGrz4JlDS80
	mcT87nERz3ti1FNdoN8svdbtm4D21w69GVuVKHzsaKbThUcwTCvEeazea3zwbHAnPOnSi7G+HscbG
	+TUOS3BevWhDagEEF+wWEjgK0MtHKLWS9q9DMHkzc2Bjqt05odABmehd8xFVKho1V58UZGTpXGGdM
	2C+jCxmIw0OGEWOv+D4ThAukUvxUw2gFtnKZ5QRplZyfvdCMg840+PLVv03Z5po2xccQmS8YJcCuW
	8zcsqTl4OzU6PBq+V35Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldbK-0084Td-G0; Tue, 25 May 2021 20:24:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldbF-0084SG-7D
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 20:24:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B1A613CD;
 Tue, 25 May 2021 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621974264;
 bh=ohjnjvMnJqAtM7DpAKQIHKwahDD4A2Ar7hbEwkM9k1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pUX5OeiJbKZkK+dUTwozm7E9c1Yhfxe+DFa/7MiIzS2Lj2DnHVsDfl/whZuFs5Knl
 Gn4yPl6jPAwzsG2kGMQQMMaP+PQbrr76q57q0wf+Gk4NDr7XD0WdlV44Gm9pmmxxNz
 z7nBuMk1VWfLUAlpyZPiSzgc6MHJ6AHxu1Gd2ziV/2iwsiLyL/TsWLEiyW2WUg8DJU
 dzBJF8O/2DluzKJ1rXp/AllpSZupGjgx4qbYdorUkjClO5ybWmvTN4tnFZeF20HQji
 lgj6o58TcTLZLcFglnFfLEHV68cyZNsYGLKd4GZPzQQmnicNQE3UFRGaDNhudbje13
 Ft5/IWudLU3jw==
Date: Tue, 25 May 2021 13:24:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>,
 "Liang, Prike" <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Message-ID: <20210525202421.GC3704707@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525195913.GB3704707@dhcp-10-100-145-180.wdc.com>
 <BYAPR12MB269360B4259CA2699A031AE5E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB269360B4259CA2699A031AE5E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_132425_359614_F8128CC5 
X-CRM114-Status: GOOD (  19.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 25, 2021 at 08:09:02PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > On Tue, May 25, 2021 at 02:06:09PM +0000, Limonciello, Mario wrote:
> > > "Then the NVMe device will be shutdown by SMU firmware in the s2idle
> > entry
> > > and then will lost the NVMe power context during s2idle resume. Finally,
> > > the NVMe command queue request will be processed abnormally and
> > result
> > > in access timeout"
> > 
> > The nvme driver explicitly checks pm_set_suspend_via_firmware() in order
> > to know if firmware may manipulate our device after completing the idle
> > suspend. That is returning false here, yet firmware will do something
> > anyway.
> 
> pm_set_suspend_via_firmware is not set during s2idle - from drivers/acpi/sleep.c
> it means ACPI S3 or ACPI S4 and thus pm_suspend_via_firmware however would
> not be used.
> 
> Overloading this definition on these AMD platforms to solve this NVME problem 
> would have unintended consequences.  Just glancing through the kernel I notice
> the following drivers make use of that for decisions, which I would suspect to be
> problematic:
> 
> * cros_ec/gsmi (on any AMD chromebook, EC might receive wrong event and logging wrong)
> * tpm
> * i8042
> * amdgpu (would break DPM_FLAG_SMART_SUSPEND)

Would it be less problematic if we check pm_suspend_no_platform()
instead? According to the kernel-doc, that returns 'true' when
firmware will not touch our device's power state, so it should return
'false' in order to be accurate here.

Note, this is always set for PM_SUSPEND_TO_IDLE, so we'd still need a
quirk to override it on this platform, but maybe this check doesn't
have the same clashes for you like pm_suspend_via_firmware?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
