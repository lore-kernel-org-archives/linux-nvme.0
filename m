Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4963BEE7FF4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CiY8tWKvJZkFT4xfxd/OkwawUND4ef5EQj377XTfFS8=; b=ljBPuSZaQwRsu5
	esymF46Md5iWbqzAeiSr4g1xaILFCMwmRm77ZjNXSg9HJKH8Ku4SNYSkhvDwLxXy/G5TeQn8t38Uz
	q1Dmp15kTsSLkALB/Y0WvKZ22dzoqwUP2K67Ch+iH+RGzUyz3nhr5lDuomipqM5ygV+cz0G6sbvNJ
	K9Ks5UKGw8COvbQBSJHTsFsEIlkNihAScjqkZhZZy+WedAfprMIpXEedBMX3NmOqxtv0Ra5mU/HiX
	cMiR+uCNC4h4BdgmGZRXcrGpO95ZIY8j3w0X3nPCWFX5C5/bCrJAqkPJfIJkduG8LcVrFx1qy3+eY
	JkMKDgTyTcxoK/URcP2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qffFR-000OMh-1D;
	Mon, 11 Sep 2023 11:38:33 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qffFN-000OLM-2C
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 11:38:31 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qffF8-0007PM-HL; Mon, 11 Sep 2023 13:38:14 +0200
Message-ID: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
Date: Mon, 11 Sep 2023 13:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
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
 <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
In-Reply-To: <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694432309;2fbbc713;
X-HE-SMSGID: 1qffF8-0007PM-HL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_043829_884300_EC447C94 
X-CRM114-Status: GOOD (  19.82  )
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

On 11.09.23 10:02, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 30.08.23 23:09, Genes Lists wrote:
>> ...
>>> I think maybe it is a system power saving issue....
>>> In the past if the BIOS(config space) not set L1-substate, our driver
>>> will keep drive low CLKREQ# when HOST want to enter power saving state
>>> that make whole system not enter the power saving state.
>>> But this patch we release the CLKREQ# to HOST, make whole system can
>>> enter power saving state success when the HOST want to enter the power
>>> saving state, but I don't  know why your system can not wake out
>>> success from power saving stat on the platform
>>
>>    Thanks for continuing to look into this. Can you share your thoughts
>> on best way to proceed going forward - do you plan to revert or
>> something else?
> 
> Hmmm. This looks like it fell through the cracks. Or am I missing something?
> 
> Anyway, 6.4.y will likely be EOL in a week or two. Which bears the
> question: are 6.5.y and 6.6-rc1 working better for you? From the
> bugzilla ticket (https://bugzilla.kernel.org/show_bug.cgi?id=217802) and
> comments from others that are affected it sounds like that's not the
> case. If that's how it is I guess it overdue that the 101bd907b4244a
> ("misc: rtsx: judge ASPM Mode to set PETXCFG Reg") is reverted. Or am I
> missing something?

According to feedback in bugzilla.kernel.org 6.5.y is affected as well.
And openSUSE apparently reverted the culprit about a week ago due to the
problems it causes:
https://bugzilla.suse.com/show_bug.cgi?id=1214428

Guess that means we should do the same for mainline with a CC:
stable@... tag.

Ricky WU, or do you have a better idea? Yes, from earlier in the thread
the root of the problem might not be in the patch you contributed, but
it exposes the problem, hence it should be reverted unless a better
solution can be found quickly. And that hasn't happened in the past two
weeks, hence it's afaics time for a revert.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

