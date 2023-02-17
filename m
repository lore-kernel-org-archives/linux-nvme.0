Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74A9C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1JctMY7RN3YnWxlGj2n334jc+Fkj1EKw0W21ptclrsQ=; b=ecDQi9BdgVtmF0
	V8scBCh+NT+zb5+WR3Do0bQrAYVrLdQt9Q6pAgEUAzaXvbjRbALKicRO78EmjR0gO1D6eSecSo1SM
	1ELptv/igrWHBu4wR1jX3BOcITFmyulMi9box5Zjo9FuSmlb1Kp37KuQorwXp/JHj8+2mIxiJp8Ip
	szy2WNOnvU6Ew2sw/YCXkjEwpGWxLuIWxsXPtbg/iLKXcs0gscE70v8KzGM4EdQWwbbVYaiawwFk+
	7RAAopVMduyTZxHJRKhrr2dcntgprA969yqNvZ9WEcewSGfqPoqQgcNRLfo4EqheWlhy39cqpJOaC
	yqVYWMzdBobS/i/kof8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT025-00E9E7-81; Fri, 17 Feb 2023 12:40:09 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT01x-00E9Co-1a
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 12:40:02 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pT01p-00064O-Fl; Fri, 17 Feb 2023 13:39:53 +0100
Message-ID: <f30eae62-c827-f743-acbe-867770714522@leemhuis.info>
Date: Fri, 17 Feb 2023 13:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
To: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Julian_Gro=c3=9f?=
 <julian.g@posteo.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230112164204.GA1768006@bhelgaas>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230112164204.GA1768006@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676637601;4da994f5;
X-HE-SMSGID: 1pT01p-00064O-Fl
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_044001_253319_D55136A8 
X-CRM114-Status: GOOD (  24.84  )
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

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

I might be missing something, but it looks like this discussion stalled.
I wonder why.

Julian, did you ever share the data Bjorn asked for? Or tried a a
bisection, as suggested by Keith? Or did you stop caring for some
reason? Does everything maybe work fine these days?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 12.01.23 17:42, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2023 at 03:48:46PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
>> ...
>> On 11.01.23 23:11, Julian Groß wrote:
>>> Dear Maintainer,
>>>
>>> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
>>> system seemingly randomly freezes due to the file system being set to
>>> read-only due to an issue with my NVMe controller.
>>> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
>>>
>>> Through network logging I am able to catch the issue:
>>> ```
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
>>> controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
>>> your device have a faulty power saving mode enabled?
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
>>> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
>>> Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
>>> enabling device (0000 -> 0002)
>>> ...
>>>
>>> I have tried the suggestion in the log without luck.
>>>
>>> Attached is a log that includes two system freezes, as well as a list of
>>> PCI(e) devices created by Debian reportbug.
>>> The first freeze happens at "Jan  8 04:26:28" and the second freeze
>>> happens at "Jan  8 14:50:16".
>>>
>>> Currently, I am using git bisect to narrow down the window of possible
>>> commits, but since the issue appears seemingly random, it will take many
>>> months to identify the offending commit this way.
>>>
>>> The original Debian bug report is here:
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309
> 
> For some reason the log [1] has very little of the kernel dmesg log.
> It does seem like the freeze is partial (I see messages for hundreds
> or thousands of seconds after the nvme reset), but requires a reboot
> to recover.
> 
> The lspci information [2] shows the 00:1b.0 Root Port leading to the
> 01:00.0 NVMe device.
> 
> Is it possible to collect lspci output after the nvme freeze?  If so,
> please save the output of:
> 
>   sudo lspci -vv -s00:1b.0
>   sudo lspci -vv -s01:00.0
> 
> Make sure to run lspci as root so we can see the error logging
> registers for these devices.
> 
> If you can collect more of the dmesg log after the freeze, e.g., via
> the "dmesg" command, that might be helpful, too.
> 
> Bjorn
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1028309;filename=x299-desktop_crash.log.xz;msg=5
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=0;bug=1028309;msg=5
> 
> 

