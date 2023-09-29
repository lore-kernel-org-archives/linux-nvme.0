Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587AE80ABE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cLt2kr0AqIeZjybsIBp0cVqY2jCdcqbQoh7el6T0NwA=; b=dqLLJuoOeK9IkB
	3KXyS/dRwdjpOQ0rlbjq0QHI56XhuPoOPrVytaY+wKIrHfGc0Qd1qr5kwhiq8guNLojd2be2sU1ss
	+XPpWD+z6GXGPtFahYAq7KQwpnSrNuJT/UStbQ+hyUbTeO7aCVazMiLBeISd9vnlBRiCRkPGlUUH/
	fdE44G00XrCw97Ve0zJoW02qdcfvwrFywjPUd/cfeHQhGIQaG8+WW9lju+O4493jRih8NP05b1f7q
	mkbWsZ6um2t/nhwQP0Z6ois6P4JgY4a8Rd5EcWmwqdaLc8qSde1Dt6x01fpFHrZ3SeCixilJtEqhf
	DIKkiSIk130IHrED6YqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmC01-007qId-33;
	Fri, 29 Sep 2023 11:49:37 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmBzv-007qHY-1q
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 11:49:36 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qmBzq-0005kV-8i; Fri, 29 Sep 2023 13:49:26 +0200
Message-ID: <9d6bb342-0a09-4ec5-99d7-81e095ff5cee@leemhuis.info>
Date: Fri, 29 Sep 2023 13:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US, de-DE
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 Linux Regressions <regressions@lists.linux.dev>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN2NUIg3k5VgMg63@debian.me>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZN2NUIg3k5VgMg63@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695988171;932a8bb3;
X-HE-SMSGID: 1qmBzq-0005kV-8i
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_044931_771278_B1C4B4D4 
X-CRM114-Status: UNSURE (   7.19  )
X-CRM114-Notice: Please train this message.
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

On 17.08.23 05:00, Bagas Sanjaya wrote:
> On Wed, Aug 16, 2023 at 04:39:34PM -0400, Genes Lists wrote:

> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: 101bd907b4244a
> #regzbot title: can't change Samsung SSD power state due to ASPM mode checking
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=217802

Fix is in Gregs tree and hopefully soon in mainline:

#regzbot fix: 0e4cac557531a4
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.




