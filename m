Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C563FC83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czXyCb8lm5lbx9VO7mRZr+AqWmorIa5UtUmAa7RzC6w=; b=B4Cif1JDad24k+feV41kKqj1e7
	kLfHal4hv+yKmc1MNrAVMeXg3f4GeOOSGCgvyRaPxFBGvyGBzmXta/fMrgYraFc61VurwncKCCRpx
	mslvrJSoo5QEQwEH1WbNyvWFJIWSkxpPG7a8ZMphqbD0e0eMgi74PWNCHmQHeQa+dHjZ0b1d3X3wV
	sF9C+LIUXnRl0IxY+OvDdQzeOruU1fVtdy16r000V7IfiwwLFEB36acVfvIwTi7DLh0rmpyecMCQe
	NES8PY3iZDL5ts0G5By53jUsFc/Rjs35hf7l36/fZwcmCPKWDLhY0bLoWnGJhgpJl3a8QKzxHCcLM
	NVJvw4cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdZ0M-006NAb-14;
	Tue, 05 Sep 2023 16:34:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdZ0J-006N9n-2G
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 16:34:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 8E3E9CE1279;
	Tue,  5 Sep 2023 16:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC1FC433C7;
	Tue,  5 Sep 2023 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693931651;
	bh=X5L10YoHz2zVk5p4qYnAUloFN9ZU4ucYAmPjaaoOySo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiRm+ulKAd/8crD2KbxWsd8Z1u6QSPzvjsg3PZi/Ay9sIVGqFZh1oiDzQ3Iuh1tHJ
	 q2s5rvZgpGwFwt7+D9xghQlwMy5cya4SYELzWd5VinCDXVWABFJ/oyHVo62d5UyzXp
	 8qhJO2iairFbbwQ+eEVxTK9It94jANP8iPShHeR6dRwnPdLUBjctZN2V1srDCPdN5J
	 C0Z8vTh3s//RVWM9P1Wy0qmpqbSWEXj6uBT/yVxsSqgXHdNIC2whzwI5baDILCe21A
	 LPPE9/6G9J0KwHuvHBjd0aoO4zgl+aYA34WVJf7FZQIZcUc2/ekrBPr0sYhkiV1Ady
	 xiG14GAhJs2pg==
Date: Tue, 5 Sep 2023 10:34:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Message-ID: <ZPdYgK0ebgHtDTXd@kbusch-mbp>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
 <ZPc8v9-lHF4jAcxL@kbusch-mbp>
 <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info>
 <ZPdF3uqbJNSZADzv@kbusch-mbp>
 <CA+4wXKCi+idhPQHx3ywdEDHqRmOyBbhz4Gj4gGr_dDvWBWohQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+4wXKCi+idhPQHx3ywdEDHqRmOyBbhz4Gj4gGr_dDvWBWohQQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_093416_105780_2CE20A47 
X-CRM114-Status: GOOD (  26.74  )
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

On Tue, Sep 05, 2023 at 05:50:06PM +0200, Cláudio Sampaio wrote:
> Hi Thorsten and Keith,
> 
> Thanks for the details. I'm still unsure if responding by email is better
> or adding to the ticket, but here it goes: I have tried for days both with
> complete power off of the machine and cycle-booting all kernels in
> succession and without exception, 6.1.x LTS and the patched 6.5.1 kernel
> always recognize and operate the NVME, whilst the other kernels also fail
> with the same error message. As this is my "production" desktop, though,
> during the week it's more difficult to me to perform tests with it, but I
> will try to do it in a more methodic way and also with 6.5.1 vanilla.
> 
> As for the reason the Lexar doesn't catch the quirk default, I can't say I
> catch the complex logic of the driver activation, but I found out how to
> "fix" for my case because there are three other Lexar models in the pci.c
> file: NM610, NM620 and NM760 (this one with an additional quirk marked on
> it on the code, NVME_QUIRK_IGNORE_DEV_SUBNQN) -- so I guess whatever
> justifies the exception for them also justifies for my model, NM790. Might
> even be the case that I would need NVME_QUIRK_IGNORE_DEV_SUBNQN (not sure
> what it does) like in the NM760 case, but it activates correctly without it.

The existing Lexar quirks for the identifier existed before the default
kernel behavior changed with respect to how identifiers are considered.

But the report says the device failed to enumerate with a "device not
ready" error message. That error message happens *before* identifiers
are checked, so the quirk should be a no-op with respect to that error
message. And the driver abandons the device after printing that message,
so no futher action should be taken no matter what quirk you've set.

In order for this quirk to have any effect at all, the error you should
have seen should look like a "duplicate IDs" message.

