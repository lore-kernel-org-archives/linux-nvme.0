Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166AFC54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:References:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LImgPIASdrSeNOmjJNK1OcP0wsILAbRQCgNFrDjJQx0=; b=wVgXbizda/i8hD
	t0X81TYqEU6/38ZVDRrJBfvNU+moLtB08lQmg9SZskOZOHxeVyB2N6Pu41aa1OXX+VQN+4knN2Pgk
	M3EEfg+xaI14ebPv3ycLdodbjkwPFdV5GR9ANNiMjgQJOFnoQlEocMH8BkDzCCQrb7HDiXxa7yWeb
	5pddet96htB+AHT2hYvC+KYT5hRz7RuhZQgvO1YMIFgyVJK1u3ghU/rrzzcF3z3FuQxjAm4yzDm/W
	+CJZowp3U2KxJO7EPti4QJmlPF1V2sfMgIdWNHquJZ/pFsoq4exAByQ88T04OiwIhdLT5aOR9iKOj
	yRU7DZibb427QmIELXNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyt4-00FSUP-T8; Thu, 12 Jan 2023 14:49:02 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFysw-00FSQF-2B
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 14:48:58 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pFyso-0000Xu-Nn; Thu, 12 Jan 2023 15:48:46 +0100
Message-ID: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
Date: Thu, 12 Jan 2023 15:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
From: "Linux kernel regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: =?UTF-8?Q?Julian_Gro=c3=9f?= <julian.g@posteo.de>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673534934;ad046a82;
X-HE-SMSGID: 1pFyso-0000Xu-Nn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_064854_316244_245B9664 
X-CRM114-Status: GOOD (  24.42  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[adding the nvme maintainers and the regressions mailing list to the
list of recipients]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 11.01.23 23:11, Julian Groß wrote:
> Dear Maintainer,
> 
> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
> system seemingly randomly freezes due to the file system being set to
> read-only due to an issue with my NVMe controller.
> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
> 
> Through network logging I am able to catch the issue:
> ```
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
> controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
> your device have a faulty power saving mode enabled?
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
> enabling device (0000 -> 0002)
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331458] nvme nvme0: Removing
> after probe failure status: -19
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] nvme0n1: detected
> capacity change from 1953525168 to 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371389] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371392] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371394] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371405] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371406] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371411] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371419] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371425] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 10, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  8 14:50:16 x299-desktop kernel: [ 1461.371426] BTRFS error (device
> nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 11, rd 0, flush 0, corrupt 0,
> gen 0
> ```
> 
> I have tried the suggestion in the log without luck.
> 
> Attached is a log that includes two system freezes, as well as a list of
> PCI(e) devices created by Debian reportbug.
> The first freeze happens at "Jan  8 04:26:28" and the second freeze
> happens at "Jan  8 14:50:16".
> 
> Currently, I am using git bisect to narrow down the window of possible
> commits, but since the issue appears seemingly random, it will take many
> months to identify the offending commit this way.
> 
> The original Debian bug report is here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v5.19..v6.0-rc7
#regzbot title nvme: system partially freezes with "nvme controller is down"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

