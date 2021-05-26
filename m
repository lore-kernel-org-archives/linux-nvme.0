Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE211C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB9A610C7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB9A610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y1iPWbi+k68fkMmDxxGvOnySHpfeSqArnfADtoWe5VA=; b=iAPECoW8wAukWD
	GsiOTjjYn2hfpnl4ykU86C03VftrKdf2MAwYh9v7GlcL866kpyRig+EvpEr32A66QcHw2rAEkramy
	FkfgUL/m6QXvNd/359MexoTHp/2KYXGzwkwmYn6mvpDyPOB5cPnm9kUZ8L+e96a7J0FJ2PUIV/tB6
	qL/xINVrm1uNI8I4e+D/fSQyZECzqh2YbV2NpZqk3+umu/ogsh9zF4qaHCq1FHfdgNYvrJEoFJTpL
	cQeL4z4XHinZx+Cixn0oQZNYKoHNVqdwoF7FJOpMx+xtXc2zWMOdPavbLKWKnF/m5G26B6LeXGi2u
	J8R1PUuXQ67HORzIr87Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvtV-00FXyi-Sa; Wed, 26 May 2021 15:56:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llump-00F1vA-TI
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:45:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90E8E61360;
 Wed, 26 May 2021 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622040331;
 bh=35XUvIvPH3Qp4Z/eNxDxCX0+pOfkPwIlK757Cu7ioD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O12ylXiSAuKqy9WBGPZqq0+zfnzOt4RCSDQ4fH3uJl7NKW78Px4AXr+N9wxwMG+DU
 TXtiIJ2ORcKpCXsHjI37PryA1+qLaMQWEIMeTlQP5aDP3BJ5jM86hcTqkk2kgaJbCg
 PUISuPtMU4fEXXsSUvE4RQhFxP0CCSqsJkMc1L9F9wQxGc8LxV4UZe7q7nIOtYO81s
 8plPjWNUnNzBYar6UWxh0x+s5QtWtBLuBxHkHCELrmbKmwK+FAt/EXXZHivrX8WEKN
 xegJO1jmkM3LCHRt4HaIwvTvHquXZj73TknrzYVu7u2MGqSBnHCYQBAHP6Mbxb63nZ
 qVldiJvjyHEYg==
Date: Wed, 26 May 2021 07:45:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Message-ID: <20210526144528.GC3704949@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_074532_029613_102943C1 
X-CRM114-Status: GOOD (  22.39  )
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

On Wed, May 26, 2021 at 10:52:35AM +0200, Hans de Goede wrote:
> On 5/25/21 5:18 PM, Limonciello, Mario wrote:
> > 
> > So how about a publishing a notification chain that a platform driver can
> > optionally pick up and set that flag when the device is probed?  Coming
> > back to my idea to throw this in amd-pmc, that could also potentially
> > mean moving out the Lenovo DMI quirk and let something like
> > thinkpad-acpi behave as a notifier and handle it too.
> > 
> > Hans, would appreciate your thoughts here.
> 
> I see that the discussion has already continued without my thoughts (good),
> reading the further discussion I see that pm_suspend_via_firmware() and
> pm_suspend_no_platform() have already been mentioned. Using these (or
> introducing something similar for this use-case) was also my first
> thought on this (after the previous options were shot down).
> 
> So I think that looking at those is going in the right direction. I notice
> that Rafael Wysocki is missing from the Cc (I've added him now) I believe
> that this is something which is right up his alley and he might have some
> ideas on this.
> 
> Mario, can you provide a summary of the discussion so far for Rafael
> (I believe you have a better picture of this then I do).

Rafael,

For context, here's the summary from my understanding:

We (linux-nvme) received a bug report that a platform fails to resume
after idle suspend due to mismatched behavior with the nvme driver.

When suspending, the nvme driver checks pm_suspend_via_firmware(). If
false, the driver assumes platform firmware will not alter our device's
power state after the kernel completes its suspend process.

But this platform's SMU firmware will remove power from the device.
Since the driver believed that wouldn't happen, the driver did not
prepare the device for this powerloss event.

It seems that the kernel's assumptions around pm_suspend_via_firmware()
and pm_suspend_no_platform() may not accurately reflect what the
platform's firmware actually does.

I do not know of a better way to detect if the platform will remove power,
so I'm looking at quirks to suppress PM_SUSPEND_FLAG_NO_PLATFORM for
this platform. I'm hoping there's a better option, though :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
