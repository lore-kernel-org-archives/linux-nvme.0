Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C109C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:29:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFC2613AB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFC2613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RehrCeeIKQ09BNPqBG3hNxVlGVUgON7REeI9BcALQwc=; b=fRSINmc5RIW6h2
	904CJSPmeS9KpHNNFFeE5yKxOlH3TITTDtFK82P2XllN/Prg4W+bHlOKIGqn3CpeStyDmnPC3mzOm
	pXetzazyPfAa7JYaI8yTSIMXpmnvGTsoSlDBj0itZrhWa/cLUkkfNq8E/NqMB839mv61uP8WqJaq0
	5jNzdkUT3sDQ8GLH7+pEp0CX2vq8sgpvti5HiApz7eIUzv8Yra6HocdsLPlf1UeiMv0KO8AizxPaq
	PSJbnNW3NS7Hs/hdzBJ30IhLTjs9r31C3sHhrFhBUUtCf80+eBiYFxoKsfyK+CVfWPbGV+1nhf8Pg
	hYX5vgAIQdzzfoStEn6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llyHR-00GWqG-77; Wed, 26 May 2021 18:29:21 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llxJs-00G75V-Si
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 17:27:50 +0000
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP
 (IdeaSmtpServer 2.0.5)
 id f5ea3e50c1575b1f; Wed, 26 May 2021 19:27:45 +0200
Received: from kreacher.localnet (89-64-80-240.dynamic.chello.pl
 [89.64.80.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v370.home.net.pl (Postfix) with ESMTPSA id 5DFE4669748;
 Wed, 26 May 2021 19:27:44 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hans de Goede <hdegoede@redhat.com>, Keith Busch <kbusch@kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Date: Wed, 26 May 2021 19:27:43 +0200
Message-ID: <2603488.mvXUDI8C0e@kreacher>
In-Reply-To: <BYAPR12MB2693CC654BD9AC2409AA556AE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <5734923.lOV4Wx5bFT@kreacher>
 <BYAPR12MB2693CC654BD9AC2409AA556AE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
X-CLIENT-IP: 89.64.80.240
X-CLIENT-HOSTNAME: 89-64-80-240.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrvdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvdegtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeforghrihhordfnihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtoheptehlvgigrghnuggvrhdrffgvuhgthhgvrhesrghmugdrtghomhdprhgtphhtthhopefrrhhikhgvrdfnihgr
 nhhgsegrmhgurdgtohhmpdhrtghpthhtoheprgigsghovgesfhgsrdgtohhmpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepufhhhigrmhdqshhunhgurghrrdfuqdhksegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_102749_144734_20FA8DF7 
X-CRM114-Status: GOOD (  28.31  )
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

On Wednesday, May 26, 2021 7:02:08 PM CEST Limonciello, Mario wrote:
> [Public]
> 
> 
> > >
> > > For context, here's the summary from my understanding:
> > >
> > > We (linux-nvme) received a bug report that a platform fails to resume
> > > after idle suspend due to mismatched behavior with the nvme driver.
> > >
> > > When suspending, the nvme driver checks pm_suspend_via_firmware(). If
> > > false, the driver assumes platform firmware will not alter our device's
> > > power state after the kernel completes its suspend process.
> > >
> > > But this platform's SMU firmware will remove power from the device.
> > 
> > How exactly does it do that?
> 
> It's running as a result of a platform driver notifying it to run (amd-pmc).

I guess this happens in one of the amd-pmc driver's system-wide suspend
callbacks.  Which one?

> > 
> > In particular, how does it get a chance to run?
> > 
> > > Since the driver believed that wouldn't happen, the driver did not
> > > prepare the device for this powerloss event.
> > >
> > > It seems that the kernel's assumptions around pm_suspend_via_firmware()
> > > and pm_suspend_no_platform() may not accurately reflect what the
> > > platform's firmware actually does.
> > 
> > Note that this is not about whether or not AML will remove power from devices.
> > 
> > It is about passing control entirely to the platform firmware at the end of the
> > suspend transition.
> > 
> > If instead the kernel executes AML that happens to remove power from some
> > devices, that is a totally different case which should not be confused with
> > the above.
> > 
> > > I do not know of a better way to detect if the platform will remove power,
> > > so I'm looking at quirks to suppress PM_SUSPEND_FLAG_NO_PLATFORM for
> > > this platform. I'm hoping there's a better option, though :)
> > 
> > Honestly, I'm not sure about the clear understanding of what's really going on
> > here.
> > 
> > 
> 
> We'll discuss internally and come back with a different proposal.
> Thanks all for your feedback.
> 

OK




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
