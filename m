Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF281C46467
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUC+d41w3lM8W/7rGbcSXOsRNnEhGghHTtxwFhdSJ+A=; b=zyzteNALM0tPB+Wv9KGBx4k37d
	oSwi6agDBA5xVWo/DOERuKRRRzCZYxT255+FaDIHuvshmdRYKxETNTE0Ltr/Q56UZ+RwmOdei2yVp
	ZO8BuNpK1CtT91zY2c740TT4asDu2w87n5Zl7Ql0pYef90e4jNA+bb/4hSSFcKm7rEuG5ZgytgBfm
	eGZS7fxe3aNUfJLPNMUAO/GWX6DKyDPb4yFM83o9n55Ks1sl1ZPJiLSii6QJdkGJpMXXhMi9FmXUN
	YlKnsGRcc1iJa84+Uh1kdTWmXgNc1HhLs5KoxxsiD6JvLkknGhJQKn0fFdtfC1kvcrkJHwr8SB1az
	ptIwvPzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD5pn-00AAj9-RI; Wed, 04 Jan 2023 15:37:43 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD4LO-009Xxy-Ch
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 14:02:18 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pD4LI-0002Kl-EC; Wed, 04 Jan 2023 15:02:08 +0100
Message-ID: <818ec46b-d058-d294-8b22-cea427c2911a@leemhuis.info>
Date: Wed, 4 Jan 2023 15:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: 6.2 nvme-pci: something wrong #forregzbot
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
 <dedcb972-e934-53c2-f933-c25afa5c65a4@leemhuis.info>
In-Reply-To: <dedcb972-e934-53c2-f933-c25afa5c65a4@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672840934;ed0c96da;
X-HE-SMSGID: 1pD4LI-0002Kl-EC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_060214_750360_7659CC65 
X-CRM114-Status: GOOD (  13.65  )
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

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 24.12.22 08:52, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 24.12.22 06:24, Hugh Dickins wrote:
>>
>> There's something wrong with the nvme-pci heading for 6.2-rc1:
>> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
>> but under load...> [...]
>> Bisection points to your
>> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
>> And that does revert cleanly, giving a kernel which shows no problem.
>> [...]
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 0da7feaa5913
> #regzbot title nvme-pci: problems under load
> #regzbot ignore-activity

#regzbot fix: 88d356ca41ba1c3effc2d4208dfbd43

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

