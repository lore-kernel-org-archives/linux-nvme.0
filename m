Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BB4C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HmbsFo56rXa2P8lGD/9C2xnOfcztDKpAWJI9SsNoF4I=; b=Z3iXH5H3ueN/xa
	hjkSVOJv+tdhQRE5ycVPD2qBAWXRkyPoesW3Y8dQP0EF/0jAyMcSZwvCZXEyNMCPivzCUJxjpjiiA
	6rJlIOAS9R4trVGIaPCBxUiLoC5YfV2i6Sxp6Ziy/XhpxIRkAo361KEcjV7YNM7rxYUWRh9QrITbD
	7g4K52gyAj8XKgjD4RogcURN1S8zML4MUtM90gRcAiOYnTmAB7EBRksKBFF0DqTDLAoHFgk3uT4nx
	LjF+NWEJ3M4CAn1J+Ux9KcpELoi6PKNdshg1/XGNW9Is3kRgH9hAX51PQF6yrj/4g0GX/8MqNmSL7
	YsSg1fYrikazvhZ3QA0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFXRM-00AXxQ-Qr; Wed, 11 Jan 2023 09:30:36 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFXRH-00AXti-Fi
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 09:30:33 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pFXR4-0005EH-HR; Wed, 11 Jan 2023 10:30:18 +0100
Message-ID: <ce66aac0-9e6b-7688-9b82-2566e6d26362@leemhuis.info>
Date: Wed, 11 Jan 2023 10:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in
 apple_nvme_disable
Content-Language: en-US, de-DE
To: Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Sven Peter <sven@svenpeter.dev>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-2-hch@lst.de>
 <c20485ec-28aa-2a45-3eba-8fa384ce0349@marcan.st>
 <20230110174745.GA3576@jannau.net>
From: "Linux kernel regression tracking (#adding)" <regressions@leemhuis.info>
In-Reply-To: <20230110174745.GA3576@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673429431;fe9eff08;
X-HE-SMSGID: 1pFXR4-0005EH-HR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_013031_741568_854CA6FD 
X-CRM114-Status: GOOD (  32.87  )
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

Top-posting one thing, to make this msg easier to consume.

Hector, thx for already working on this. If you respin your patches,
could you please include these tags in your patches:

Reported-by: Janne Grunau <j@jannau.net>
Link: https://lore.kernel.org/all/20230110174745.GA3576@jannau.net/

For details, see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

Or these posts from Linus:

https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/

https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/

https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/


For the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 10.01.23 18:47, Janne Grunau wrote:
> On 2022-11-30 00:41:45 +0900, Hector Martin wrote:
>> On 29/11/2022 22.22, Christoph Hellwig wrote:
>>> nvme_shutdown_ctrl already shuts the controller down, there is no
>>> need to also call nvme_disable_ctrl for the shutdown case.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  drivers/nvme/host/apple.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 94ef797e8b4a5f..56d9e9be945b76 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>>>  
>>>  		if (shutdown)
>>>  			nvme_shutdown_ctrl(&anv->ctrl);
>>> -		nvme_disable_ctrl(&anv->ctrl);
>>> +		else
>>> +			nvme_disable_ctrl(&anv->ctrl);
>>>  	}
>>>  
>>>  	WRITE_ONCE(anv->ioq.enabled, false);
>>
>> Reviewed-by: Hector Martin <marcan@marcan.st>
>>
>> I looked at some of our other implementations and we always seem to do
>> both, but this makes sense. If it breaks something we'll notice and
>> shout loudly when it makes it into an -rc at the latest :)
> 
> This breaks resume for the apple nvme controller.


> The immediate problem 
> is that apple_nvme_reset_work() uses NVME_CC_ENABLE to decide whether to 
> call apple_nvme_disable(). Only nvme_disable_ctrl(ctrl, false) clears 
> NVME_CC_ENABLE.
> 
> Even after extending the check to consider NVME_CC_SHN_NORMAL resume is 
> still broken. The host specific reset to re-enable the controller works 
> but IO is blocked. The controller logs following messages into its 
> syslog:
> 
> | RTKit: syslog message: cmd.c:728: Oldest tag 12 is 19 seconds VERY OLD with cmdQe:2
> | RTKit: syslog message: cmd.c:732: Oldest tag is about to crash!!
> | RTKit: syslog message: cmd.c:720: Oldest high water mark moved up to 21,tag 12, cmdQ CQ_PRI0W
> 
> This looks looks like the controller reset after/during shutdown is required
> on this controller.
> 
> Below patch fixes resume for me. I can send this with comment to
> prevent repeating this regression or if preferred handle this in
> nvme_disable_ctrl() either via a quirk or an additional parameter.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced c76b8308e4c9
#regzbot title nvme: resume broken on apple nvme controller
#regzbot monitor:
https://lore.kernel.org/all/20230111043614.27087-1-marcan@marcan.st/
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

> --- 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index e13a992b6096..82396f9486e1 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -867,7 +867,9 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
> 			apple_nvme_remove_cq(anv);
> 		}
>  
> -               nvme_disable_ctrl(&anv->ctrl, shutdown);
> +               if (shutdown)
> +                       nvme_disable_ctrl(&anv->ctrl, true);
> +               nvme_disable_ctrl(&anv->ctrl, false);
> 	}
>  
> 	WRITE_ONCE(anv->ioq.enabled, false);

