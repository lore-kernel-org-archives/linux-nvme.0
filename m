Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1446AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Db4OXt2jB/zThVAYY8FmY5qF4NrMlk+GrdMn7ZRrdU4=; b=fr/i2+JuAh+3iQ7+Xk8swmSXRj
	TDKLdjtyI111QdjrTQTCSdziaymWpABqxT73JSNTaoFv7Hv6nh4wJubkC+9lVgUTNn8n/e202SjVB
	YlkysUTy8iwrWkGBhHw3vObwSl4V2SI/MXaZalaZ0CODr//WQSHnf88xHgNRHEZxZovLxeIHAyBje
	2nK0BNTSQbha4zKKZNV16vkFA/OxOCD+1dlpl8GUypCs8iN//6I7b16sftUmOt/3/r3XJWM5l8ftE
	j93Vb1/ow3HOcdjHUc4svTchN2+4nkqiY3EGULwPImoumDN1LF0rPiSlqHZEtN8XOIEAy4apm9fRZ
	/9S5+wWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhUyW-00DBo8-DG; Thu, 21 Apr 2022 11:27:52 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhUyS-00DBn3-5S
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 11:27:50 +0000
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nhUyM-0005mJ-Ie; Thu, 21 Apr 2022 13:27:42 +0200
Message-ID: <8c454aa4-2555-1de5-f947-8509471e56be@leemhuis.info>
Date: Thu, 21 Apr 2022 13:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Bug 215679] New: NVMe/writeback wb_workfn/blocked for more than
 30 seconds
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, bugzilla-daemon@kernel.org,
 Keith Busch <kbusch@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <bug-215679-95461@https.bugzilla.kernel.org/>
 <YlhxNn5JZcsqpOlf@kbusch-mbp.dhcp.thefacebook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YlhxNn5JZcsqpOlf@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1650540468;
 70308447; 
X-HE-SMSGID: 1nhUyM-0005mJ-Ie
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_042748_398806_15FB8903 
X-CRM114-Status: GOOD (  13.02  )
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

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Jens, this regression is now a month old and the culprit was already
identified when the issue was reported, nevertheless it seems no real
progress was made to address this, at least afaics. What's up there?
Should the culprit be reverted?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke

On 14.04.22 21:08, Keith Busch wrote:
> On Sun, Mar 13, 2022 at 08:13:53PM +0000, bugzilla-daemon@kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215679
>>
>>             Bug ID: 215679
>>            Summary: NVMe/writeback wb_workfn/blocked for more than 30
>>                     seconds
>>            Product: IO/Storage
>>            Version: 2.5
>>     Kernel Version: 5.17.0-rc7
>>           Hardware: x86-64
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: high
>>           Priority: P1
>>          Component: NVMe
>>           Assignee: io_nvme@kernel-bugs.kernel.org
>>           Reporter: imre.deak@intel.com
>>         Regression: No
>>
>> Created attachment 300564
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=300564&action=edit
>> dmesg log after suspend resume, io stuck
>>
>> After system suspend/resume filesystem IO will stall, producing a 'kworker
>> blocked for more than x sec" in dmesg, recovering after a long delay. See the
>> attached dmesg-suspend-resume-nvme-stuck.txt. I also noticed the same issue
>> happening right after booting or after runtime suspend transitions.
>>
>> The same issue also happens on multiple SKL systems in the i915 team's CI farm,
>> see:
>>
>> https://gitlab.freedesktop.org/drm/intel/-/issues/4547
>>
>> I bisected the problem to
>> commit 4f5022453acd0f7b28012e20b7d048470f129894
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Mon Oct 18 08:45:39 2021 -0600
>>
>>     nvme: wire up completion batching for the IRQ path
>>
>> By reverting it on top of 5.17.0-rc7, I can't reproduce the problem. Attached  
>> dmesg-suspend-resume-nvme-ok.txt with the revert, captured after a few
>> suspend/resume.
> 
> Forwarding to linux-nvme for higher visibility.
> 


