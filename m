Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61697C38142
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jan 2023 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GzGw9GxM+HwJxK+ZaOtbOV4S6sorNz657SUIdVfGFrw=; b=iFkZ78PEcvyOJ6
	74SAbh8qADi+j+hjwRhtfqJuhJKJoH7oqVwJJHE65u3KGORNVyALx7y6hRQ0L6aThHikZWYguTCJv
	RXMXIAy1xMA0zrAVjlXURsjEjVm/hf00AEK4McjXK+QkZc3OGOZhm0YPw/32oELopOxohg9rGRp24
	7czHNbCktoLbi8RcgvEzIWT1PiWKkzfG9XxtaqWFNJ9V2iq9UwNkS5KHZkh9lrhm7iPyTUzCAcO4D
	npJ3tawPqT5yqOrHQlGlO0EENK+5XSdCbAJ/NARQVt2oXlB9NLxAsd/a1jATgb7Y0zJrU8yktfu4s
	mNqoob26Gltc8M+GBNjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLMds-00E4qQ-En; Fri, 27 Jan 2023 11:11:36 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLMdm-00E4pD-9y
	for linux-nvme@lists.infradead.org; Fri, 27 Jan 2023 11:11:32 +0000
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pLMdf-0005UE-0Q; Fri, 27 Jan 2023 12:11:23 +0100
Message-ID: <ea5f2437-e7ce-faea-ed8d-30322160c22a@leemhuis.info>
Date: Fri, 27 Jan 2023 12:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: regression on aarch64? panic on boot
Content-Language: en-US, de-DE
From: "Linux kernel regression tracking (#update)" <regressions@leemhuis.info>
To: Klaus Jensen <its@irrelevant.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
In-Reply-To: <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674817890;b31b26e5;
X-HE-SMSGID: 1pLMdf-0005UE-0Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_031130_529231_277CBE97 
X-CRM114-Status: GOOD (  15.92  )
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

[TLDR: there afaics is a fix for the regression discussed in this
thread, but its author did not use a Link: tag to point to the report,
as wanted by Linus and explained in the documentation; this forces me to
write this mail, which sole purpose it to update the state of this
tracked Linux kernel regression.]

On 19.01.23 14:10, Linux kernel regression tracking (#adding) wrote:
> On 16.01.23 22:57, Klaus Jensen wrote:
>>
>> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
>> guest in roughly 20% of boots on v6.2-rc4. Example panic below.
>>
>> I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
>> probe from the rest path").
>>
>> I'm not seeing this on any other emulated platforms that I'm currently
>> testing (x86_64, riscv32/64, mips32/64 and sparc64).
>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced eac3ef262941
> #regzbot title nvme: occasional boot problems due to the newly supported
> async driver probe
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20230124171738.2311160-1-kbusch@meta.com/
#regzbot fix: nvme-pci: flush initial scan_work for async probe
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

