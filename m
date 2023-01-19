Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44DAC004D4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6lpMxxEae0OrPaXaLQT25GciU6aCNV/uUJdNXx8IAo=; b=XbvecylJ0SjXri
	RATpdLsc8cgbqtuceTZKfWcKkcLKiY/sz2dk8dV0XDdLd3gYC/V6xEgB1cKvgbvGlrw1Cq1R8nNiI
	2ymdq/KDc9uX3HFuCiU385CxKTJXuq7cqio0iIMk2iEf5wI01+PjcY54k0U4Sv9MifOZBjrUVHZyg
	yD64cg54uPgwv2pQ5RXFsiB/0jj84USuexF2vBbaGEvRYIrwDByWjIGab4di25S6fP7Bn9Siqszs9
	nxTjFmFUGN/9YBXzVBw4caMgChk9QCYNIbRJVcdJaT954O9qLKKU8S1an/hzp4cNZRGUCvr8f0+39
	s5oqvkzrBjF6sPcTvvKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIUoc-0053xP-Gp; Thu, 19 Jan 2023 13:18:50 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIUgJ-0050aR-LA
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 13:10:20 +0000
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pIUgA-0005xy-F9; Thu, 19 Jan 2023 14:10:06 +0100
Message-ID: <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
Date: Thu, 19 Jan 2023 14:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: regression on aarch64? panic on boot
Content-Language: en-US, de-DE
To: Klaus Jensen <its@irrelevant.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y8XINx8fpGPKudW6@cormorant.local>
From: "Linux kernel regression tracking (#adding)" <regressions@leemhuis.info>
In-Reply-To: <Y8XINx8fpGPKudW6@cormorant.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674133815;4bf4ddeb;
X-HE-SMSGID: 1pIUgA-0005xy-F9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_051015_928472_88552E93 
X-CRM114-Status: GOOD (  18.67  )
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

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 16.01.23 22:57, Klaus Jensen wrote:
> 
> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
> guest in roughly 20% of boots on v6.2-rc4. Example panic below.
> 
> I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
> probe from the rest path").
> 
> I'm not seeing this on any other emulated platforms that I'm currently
> testing (x86_64, riscv32/64, mips32/64 and sparc64).
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced eac3ef262941
#regzbot title nvme: occasional boot problems due to the newly supported
async driver probe
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


