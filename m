Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F18ECAAD4
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8xhCNGQ44HWZ9LqBc8ZA6ehjl8xPkQcSslAEFHJe99U=; b=0MR3wPt2kZjKjLQlEV4QCp7mqn
	fIlMaQ7AjZKSSlXQJUQgboP6/sLIHiXjLa6unWdFZkmN0UoCjXM3ifvGK1otpXA9wcbIJ6hB0ymUg
	sYejopywLHBkKyKQO1hoF5RQqQFd+ZaWNPCW3ZNjMgUrB6fHOWtGMIzQR7wyFCqF4puL8JtlThQSe
	tcW70dU0AB3xEu0Y2/1BVuWaYDyr3xH3NIO7CYiOnrYuXmSuWxPRxSR6zNw86g8sPbJbe3vFDvB7c
	BC3yBb4NeuNqLvl2PYUbfHfYoeO1QX/h4KbNME6rqeT8R3kts54GsLZES3yg9r0m6ruWFZlSW4ABN
	4z66KGwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRYJY-002Y31-Cz; Fri, 26 Aug 2022 12:19:56 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRYJS-002Xyw-G7
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 12:19:52 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oRYJL-00028L-IM; Fri, 26 Aug 2022 14:19:43 +0200
Message-ID: <5e8c01cb-2dc1-e460-6bb2-c9861080154f@leemhuis.info>
Date: Fri, 26 Aug 2022 14:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, lixingyuan@inspur.com,
 linux-nvme@lists.infradead.org
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [Regression] Bug 216400 - Firmware activation starting AEN processing
 prevents further AER commands sent to the NVMe controller.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661516390;2384a687;
X-HE-SMSGID: 1oRYJL-00028L-IM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_051950_725756_8744DC96 
X-CRM114-Status: GOOD (  17.87  )
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

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported. That's why I decided to forward it by
mail to those that afaics should handle this.

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216400 :

>  lixingyuan 2022-08-23 01:14:50 UTC
> 
> This bug is related to these two commits:
> 
> 1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=4c75f877853cfa81b12374a07208e07b077f39b8
> 
> These codes will set the controller state to NVME_CTRL_RESETTING while handling the firmware activation staring AEN
> 
> 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d
> 
> When submitting a new AER command to the controller, this code checks if the controller state is NVME_CTRL_LIVE. This caused the problem. When the firmware activation staring AEN was processed before, the controller state was already set to NVME_CTRL_RESETTING, which resulted in no new AER commands being sent to the controller.

See the ticket for details and further comments.

Please look into the issue if you're among the main recipients of this
mail (and not just CCed). I hope I picked the right people to sent this
to, if not just let everyone know (and apologies for getting it wrong!).

Anyway, to ensure this is not forgotten lets get this tracked by the the
Linux kernel regression tracking bot:

#regzbot introduced: 0fa0f99fc84e
https://bugzilla.kernel.org/show_bug.cgi?id=216400
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report in bugzilla, as the kernel's documentation calls
for; above page explains why this is important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

