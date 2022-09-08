Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD802C38145
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhDELTK+PlKok5TeU4cH846yjxKVK/OMr2532EdjzK4=; b=Fno4KzGtEnuLB+EhUUc2ddLUUb
	MOWtQ1HWwklbVaHULF/4b4EYULwCgzwjds62PQChauiZsSOdkX+ma6Xo+EOEuSYMMkH/ZscXAqu/t
	N64bV0owt8bPmW4/A52AUGZVOxdforLml0X7nZFXk2dBcfP8+pn6RxCJ66l3zDAkMOcH+K4OcMnpi
	/bWTroRSBzvIqCggj6kBj/QWBvjTzzuDfgMWJk4AKiah6gIUD8AEbZ6fIi/ZNMtprIDoWtT2R4zd0
	aR/tj2yjBQ5TuA0tOeLUr5bSlxRcugOLMHCfnrNHKO0mkCiSOzIXNg+mj59etWfcjiMMhPZuDxx0C
	OD9QPSvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWEz3-002NiZ-O0; Thu, 08 Sep 2022 10:42:09 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWEyz-002Nf3-3k
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 10:42:07 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oWEyo-0006R6-O7; Thu, 08 Sep 2022 12:41:54 +0200
Message-ID: <7883f05d-9ed8-2be3-3f9f-4f814aefe55a@leemhuis.info>
Date: Thu, 8 Sep 2022 12:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc. NVMe
 SSD Controller" from 5.19.y (issue bisected) #forregzbot
Content-Language: en-US, de-DE
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: linux-nvme@lists.infradead.org
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662633725;55c5905c;
X-HE-SMSGID: 1oWEyo-0006R6-O7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_034205_334653_7D6EAADA 
X-CRM114-Status: GOOD (  17.38  )
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

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 07.09.22 08:05, Jaroslav Pulchart wrote:
> Hello,
> 
> I would like to report a regression issue in 5.19.y in NVMe driver.
> 
> The issue is reproducible at AWS EC2 instances with local NVMe storage
> like "r5d.*". Kernel report "IO queues not created":
> [    2.936641] nvme nvme0: 2/0/0 default/read/poll queues  <- EBS volume
> [    2.939493] nvme nvme1: 2/0/0 default/read/poll queues  <- EBS volume
> [    2.940797] nvme nvme2: IO queues not created              <- Local volume
> with 5.19.y (kernel 5.19) and the nvme storage cannot be used.
> 
> I bisected the issue to commit
> "aa41d2fe60ee2e4452b0f9ca9f0f6d80a4ff9f9d" (nvme: set controller
> enable bit in a separate write). Reverting it makes the nvme device
> working again:
> [    3.025599] nvme nvme0: 2/0/0 default/read/poll queues
> [    3.032467] nvme nvme2: 8/0/0 default/read/poll queues
> [    3.040040] nvme nvme1: 2/0/0 default/read/poll queues

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced aa41d2fe60ee2e4
#regzbot title block: nvme: AWS EC2 instances with local NVMe storage fail
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

