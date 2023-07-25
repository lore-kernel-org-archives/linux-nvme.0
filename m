Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B724C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGcyFMRbEQ+DkLqOkUunYckn9C40x5rzx1sYQOo13Rc=; b=R5c2hQvFfl+99c
	G37VNqHPFNR0qMGxc8qO1PMFA/S8TA5IalUa99IcF9STGHaHdwTL5LykiDKAr7PTwnawrfpTOCvO9
	icIsv1ryDix4UCDuaGX/8iJf4x0Qcj0fFXcG1bPBWVO83X7FGNwVj5xPL76ov8kxJAeRpuo3+PyLf
	qxw/h/ocP4YvBFk+CnDv6YMCAlePezqLwf5MENnyF3hodG4UcQFfnT4ZJhkQoOLmgburjzP6gQN2G
	rewWTjMp4xd1hyw4u5VSQza9qEUNvpcGm1a8ZtKeW525cmDx7zYWfqF8wNDg1zF33Sv2NI/j9Lbnt
	TCNJUsHTzr4y97nntv5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOIKB-007fZ2-1t;
	Tue, 25 Jul 2023 13:43:39 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOIK8-007fWK-1D
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 13:43:38 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qOIK0-0003xR-4j; Tue, 25 Jul 2023 15:43:28 +0200
Message-ID: <2d2d2225-3a64-2255-92c8-3237402e3f3d@leemhuis.info>
Date: Tue, 25 Jul 2023 15:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Performance Regression due to ASPM disable patch
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
 <20230712155052.GA946@green245>
 <425eba3b-0138-81d1-f615-97fc24b2d51d@leemhuis.info>
In-Reply-To: <425eba3b-0138-81d1-f615-97fc24b2d51d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690292616;33808e48;
X-HE-SMSGID: 1qOIK0-0003xR-4j
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_064336_575562_D8288799 
X-CRM114-Status: UNSURE (   8.36  )
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

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 13.07.23 14:37, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:

> On 12.07.23 17:55, Anuj Gupta wrote:
>>
>> I see a performance regression for read/write workloads on our NVMe over
>> fabrics using TCP as transport setup.
>> IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> 
> #regzbot ^introduced e1ed3e4d91112027b90c7ee61479141b3f94
> #regzbot title net: r8169: performance regression for read/write
> workloads on our NVMe over fabrics
> #regzbot ignore-activity

The fix did not properly link to the report (it only linked to a reply
in the thread), hence regzbot missed it:

#regzbot fix: e31a9fedc7d8d8
#regzbot ignore-activity

/me meanwhile wonders if it'S worth teaching regzbot how to handle these
cases

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

