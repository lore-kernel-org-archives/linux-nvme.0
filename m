Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E47C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25424613B5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25424613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUMCGu5EGnxwVsd+sc1R/OxBt1jHSsgVHl79sMR3txw=; b=3LKvuT4Akpm99X
	XcvzdJoON95t7AJDeU5LTUz0L9gUfHuRoqxBxGkqPfHJCOlkaKHEQQ/XUgzrResD+FcgIZVeLhAd4
	r+S4wG1Ctozl0HcQW9u89VO0rjVaDKboR8Xwa+tIEVcgTr01JzjSgsN1qqt3A/BBWPtr8KSUyDkLU
	PRogya14oXHtzCbYioVnOCV6y/l0n8A+w7y3AAlbHqXf4wzvg24wEVYfREe7UEzDsHJFs1SSmV5gX
	eJ4s1wnOjKEPIGJkpTNuIEQOg6tWIsJ8Fft6McmFDsM0pb6ED5cfGeBgEYtjcg1auVsNfq/VjvGKR
	ouxwCOYryEAs70yZAdXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llw5V-00FcIN-Ql; Wed, 26 May 2021 16:08:53 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluwE-00F6nl-K4
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:55:16 +0000
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP
 (IdeaSmtpServer 2.0.5)
 id ab1face8871bbc40; Wed, 26 May 2021 16:55:08 +0200
Received: from kreacher.localnet (89-64-80-240.dynamic.chello.pl
 [89.64.80.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v370.home.net.pl (Postfix) with ESMTPSA id CE6D066971B;
 Wed, 26 May 2021 16:55:07 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hans de Goede <hdegoede@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Date: Wed, 26 May 2021 16:55:07 +0200
Message-ID: <5734923.lOV4Wx5bFT@kreacher>
In-Reply-To: <20210526144528.GC3704949@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
 <20210526144528.GC3704949@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
X-CLIENT-IP: 89.64.80.240
X-CLIENT-HOSTNAME: 89-64-80-240.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedtrddvgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvgedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepofgrrhhiohdrnfhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopeetlhgvgigrnhguvghrrdffvghutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheprfhrihhkvgdrnfhirghn
 ghesrghmugdrtghomhdprhgtphhtthhopegrgigsohgvsehfsgdrtghomhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopefuhhihrghmqdhsuhhnuggrrhdrufdqkhesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_075514_862336_F27CDC3C 
X-CRM114-Status: GOOD (  33.54  )
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

On Wednesday, May 26, 2021 4:45:28 PM CEST Keith Busch wrote:
> On Wed, May 26, 2021 at 10:52:35AM +0200, Hans de Goede wrote:
> > On 5/25/21 5:18 PM, Limonciello, Mario wrote:
> > > 
> > > So how about a publishing a notification chain that a platform driver can
> > > optionally pick up and set that flag when the device is probed?  Coming
> > > back to my idea to throw this in amd-pmc, that could also potentially
> > > mean moving out the Lenovo DMI quirk and let something like
> > > thinkpad-acpi behave as a notifier and handle it too.
> > > 
> > > Hans, would appreciate your thoughts here.
> > 
> > I see that the discussion has already continued without my thoughts (good),
> > reading the further discussion I see that pm_suspend_via_firmware() and
> > pm_suspend_no_platform() have already been mentioned. Using these (or
> > introducing something similar for this use-case) was also my first
> > thought on this (after the previous options were shot down).
> > 
> > So I think that looking at those is going in the right direction. I notice
> > that Rafael Wysocki is missing from the Cc (I've added him now) I believe
> > that this is something which is right up his alley and he might have some
> > ideas on this.
> > 
> > Mario, can you provide a summary of the discussion so far for Rafael
> > (I believe you have a better picture of this then I do).
> 
> Rafael,
> 
> For context, here's the summary from my understanding:
> 
> We (linux-nvme) received a bug report that a platform fails to resume
> after idle suspend due to mismatched behavior with the nvme driver.
> 
> When suspending, the nvme driver checks pm_suspend_via_firmware(). If
> false, the driver assumes platform firmware will not alter our device's
> power state after the kernel completes its suspend process.
> 
> But this platform's SMU firmware will remove power from the device.

How exactly does it do that?

In particular, how does it get a chance to run?

> Since the driver believed that wouldn't happen, the driver did not
> prepare the device for this powerloss event.
> 
> It seems that the kernel's assumptions around pm_suspend_via_firmware()
> and pm_suspend_no_platform() may not accurately reflect what the
> platform's firmware actually does.

Note that this is not about whether or not AML will remove power from devices. 

It is about passing control entirely to the platform firmware at the end of the
suspend transition.

If instead the kernel executes AML that happens to remove power from some
devices, that is a totally different case which should not be confused with
the above.

> I do not know of a better way to detect if the platform will remove power,
> so I'm looking at quirks to suppress PM_SUSPEND_FLAG_NO_PLATFORM for
> this platform. I'm hoping there's a better option, though :)

Honestly, I'm not sure about the clear understanding of what's really going on
here.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
