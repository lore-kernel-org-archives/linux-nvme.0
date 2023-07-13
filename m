Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407BEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SvWDdjhd0LKTApanOcXTpRAz1dbUh82hZnsbP9dBDUI=; b=yL3qzQW84D6Bm+
	9TobCJsxpML9J+ZQCHWKV0fY7WuzHVCR79gP1Cctdjq1Icj3JB40TvFJ2cFIWAKYdv4yIIFtalGeW
	TRTXMH0iWHF6DMaA0SSfAG+/LtZEU+puVU7MOqZKBUX6hTFbo2IQ1mKvI9Vom1iE1RykvzGrRC3f7
	z1bAPY3jd4iCjqoBXGPPSaUwmQWuRq5m7iZuiCP1KKbxiKXtt0ldUyHnaUiFketRMwIjSd8OKBuRx
	+oSqYUD19w1eIMD3OnPAcOwjhv4J9Rxr9WYbE1G0AGIn1AwYzB6GIEwMn7RGTGLTsqBBTePoxtN5z
	tvg2Y7tU2DQg5Nw5uiGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJvZL-003G8j-07;
	Thu, 13 Jul 2023 12:37:15 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJvZH-003G7v-2z
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 12:37:13 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qJvZ6-0006Dr-U9; Thu, 13 Jul 2023 14:37:00 +0200
Message-ID: <425eba3b-0138-81d1-f615-97fc24b2d51d@leemhuis.info>
Date: Thu, 13 Jul 2023 14:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Performance Regression due to ASPM disable patch
Content-Language: en-US, de-DE
To: Anuj Gupta <anuj20.g@samsung.com>, hkallweit1@gmail.com,
 davem@davemloft.net
Cc: holger@applied-asynchrony.com, kai.heng.feng@canonical.com,
 simon.horman@corigine.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
 <20230712155052.GA946@green245>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230712155052.GA946@green245>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689251831;60fd35d3;
X-HE-SMSGID: 1qJvZ6-0006Dr-U9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_053712_112202_4B05E0BA 
X-CRM114-Status: GOOD (  15.06  )
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

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 12.07.23 17:55, Anuj Gupta wrote:
> 
> I see a performance regression for read/write workloads on our NVMe over
> fabrics using TCP as transport setup.
> IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> 
> I bisected and found that the commit
> e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
> NAPI poll") is the trigger.
> When I revert this commit, the performance drop goes away.
> 
> The target machine uses a realtek ethernet controller
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e1ed3e4d91112027b90c7ee61479141b3f94
#regzbot title net: r8169: performance regression for read/write
workloads on our NVMe over fabrics
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

