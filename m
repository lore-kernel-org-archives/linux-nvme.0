Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B58EE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 08:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+0HDCe5H/YJARh+VTUxGyao+9mK93Pe1R9pmd4RP1I=; b=ttmXqijgxwY/V9
	p4rEzkR6wr6Q+mkPPnNYyeyGIWiM9ONaCBMPZF2GDT6amwtG/cFo3u9K5j/JXYa69AR+8Wm8K5Vee
	YDEP0GHkIHM3/6XbnVqggI6pQSLFEREdcZdtRryjwGldr5eGD+XhYCswwsBbALxlEOvCVMAiNLJ4d
	k10dbvrxx6D7xTKLk1zrF1PblktUhv56RBrPlwwtdj1vPDxw50pC6Ccs5nb4MMObGndonJ1qvdwvV
	IEpF384DZAWzT07Wz85cQ2jbuAgsoSXUG+U+id8+oMQIwDemBg7TkCB72S9YmepPeT2EBT6ZUNgIr
	s4g1SQuEdQeacBgMkAmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbsT-00HUj4-0l;
	Mon, 11 Sep 2023 08:02:37 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbsQ-00HUhm-1d
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 08:02:36 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qfbsB-0006KC-TZ; Mon, 11 Sep 2023 10:02:20 +0200
Message-ID: <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
Date: Mon, 11 Sep 2023 10:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US, de-DE
To: Genes Lists <lists@sapience.com>, Ricky WU <ricky_wu@realtek.com>,
 Keith Busch <kbusch@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
 <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
 <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
 <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694419354;701503d7;
X-HE-SMSGID: 1qfbsB-0006KC-TZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_010234_689060_0BBF8A48 
X-CRM114-Status: GOOD (  13.64  )
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

Hi, Thorsten here, the Linux kernel's regression tracker.

On 30.08.23 23:09, Genes Lists wrote:
> ...
>> I think maybe it is a system power saving issue....
>> In the past if the BIOS(config space) not set L1-substate, our driver
>> will keep drive low CLKREQ# when HOST want to enter power saving state
>> that make whole system not enter the power saving state.
>> But this patch we release the CLKREQ# to HOST, make whole system can
>> enter power saving state success when the HOST want to enter the power
>> saving state, but I don't  know why your system can not wake out
>> success from power saving stat on the platform
> 
>    Thanks for continuing to look into this. Can you share your thoughts
> on best way to proceed going forward - do you plan to revert or
> something else?

Hmmm. This looks like it fell through the cracks. Or am I missing something?

Anyway, 6.4.y will likely be EOL in a week or two. Which bears the
question: are 6.5.y and 6.6-rc1 working better for you? From the
bugzilla ticket (https://bugzilla.kernel.org/show_bug.cgi?id=217802) and
comments from others that are affected it sounds like that's not the
case. If that's how it is I guess it overdue that the 101bd907b4244a
("misc: rtsx: judge ASPM Mode to set PETXCFG Reg") is reverted. Or am I
missing something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

