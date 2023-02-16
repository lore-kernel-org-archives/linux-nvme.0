Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB5FC636CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JW8cnJ9DxbqLati7VllUMECsR6VHuLyZ5ou8qfx/8yw=; b=FnK95hBd7VfODm
	l9IKTEWK/sgMm+BB/Lo45hudxx94PfLTvfpyDOipCjS5a1VUOby6Q7WJMKejhZgqYWeFjVEN7RFC4
	gzQE+Z9A9rRDP0r7ApDeDIl43fqbvYlCVqToUd3/zEuZ1f48Y9UPhj2rhau5Muw0rZASf3af9RIqv
	u45+/UPOCOn7RJtGvHLZBhvX7lv6iyvNeiEDlEk8s/ljoUgQuEmln5iW/T2klKdhnsBdgIcu/qBmE
	gLydIE5QC+8C7KEUmXJxwTNIkzrEqtxJjXqtK7Qwlv18UPw6CkEhWFo/uU58Wv2uthRe45roY/kYX
	C9w3aVCE7nYMiCfjMN+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSaZe-009FbN-4D; Thu, 16 Feb 2023 09:29:06 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSaZa-009FZn-OZ
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 09:29:04 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pSaZU-0000eh-1H; Thu, 16 Feb 2023 10:28:56 +0100
Message-ID: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
Date: Thu, 16 Feb 2023 10:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 michallinuxstuff@gmail.com
Subject: [regression] Bug 217037 - cmb attributes missing from the nvme class
 under sysfs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676539742;71e59b1a;
X-HE-SMSGID: 1pSaZU-0000eh-1H
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_012902_977215_D67E0CD0 
X-CRM114-Status: GOOD (  29.50  )
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

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :

>  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> 
> For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> 
> 
> # grep . /sys/class/nvme/nvme0/cmb*
> /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> /sys/class/nvme/nvme0/cmbloc:98
> /sys/class/nvme/nvme0/cmbsz:524829
> #
> 

> The above was taken from fedora37 running under 6.1.8 kernel build.
> In 6.1.{9,10} all these attributes are gone.
> 
> I am running fedora37 under QEMU 7.{0,2}.0, all nvmes are emulated.
> 
> I've tried to understand what change in 6.1.9 might have caused it
> (suspected that maybe fedora's src is applying some weird patches on
> top but that's not it), but I could not pinpoint anything specific.
> 
> The latest commit that indirectly touches these attributes is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86adbf0cdb9ec
> but my C-fu is to weak to understand if this really could somehow
> hide|remove these attrs.
> 
> Also from the look of nvme_pci_attrs_are_visible() nothing has
> recently changed. I use same QEMU params for setting up the nvmes
> across all the VMs - is it possible that the way QEMU exposes CMB is
> not valid anymore?
> 
> If I check proper BARs with setpci + /proc/iomem it seems like CMB is
> there. SPDK also tells me that given nvme comes with CMB.
> 
> Any hints would be appreciated. I have couple of scripts which depend
> on these so I am a bit biased if it comes to prio on this. :)>
> [...]
>
> So I did install the latest available build,
> 6.2.0-0.rc8.20230215gte1c04510.258.vanilla.fc37.x86_64 to be exact,
> but there's no change - /cmb* stuff is still missing (remaining
> parts, lspci output, etc. look exactly the same as in the case of
> previously mentioned versions).

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.1..v6.2-rc8
https://bugzilla.kernel.org/show_bug.cgi?id=217037
#regzbot title: nvme: cmb attributes vanished after v6.1.8
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

