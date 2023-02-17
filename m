Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D9FC6379F
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N3DE8oVS3Pvv8boqSSbVM0odQXdurrOjScGq8hzoKQg=; b=L6zV6I2/JyUzRG
	o7SLTSN37a021xk2/3+1Afq6AjqO6gnrTqGYMoiy47bXhdHaZ74y63z9rfZqKiyTSrdAwo0J+9RC3
	mXsjPH/SYQLYlF0RfJ39QS/m7gymhPJJroQYfREtT5JxWXM5/FWtW/HQZuXIgf2sCJ8K/6K0gzO0Z
	xe+0kIUju7wDUXHOqkRKUuPvtjoBN61CLoznU7e4qpBDnWylWpTx4jZVgn5GMPcjiwXLmwfBOnp6p
	n8jcbv0VxYoHj8UxaUGNvxUTam5CjJ1dvPhUFxgtpMtK6JwCKwhCxvpwJir+Uam7R42YWtsL4C3iX
	on6O3shINmjl+3PmOmiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT2NM-00ElwD-Pl; Fri, 17 Feb 2023 15:10:16 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT2FB-00Ehxz-Pc
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 15:01:54 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pT2F8-0005uQ-Lu; Fri, 17 Feb 2023 16:01:46 +0100
Message-ID: <189043d8-1ea7-4264-7f86-3e28b99cc7da@leemhuis.info>
Date: Fri, 17 Feb 2023 16:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
 <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
In-Reply-To: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676646109;f76b6d22;
X-HE-SMSGID: 1pT2F8-0005uQ-Lu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_070150_030536_C643AC96 
X-CRM114-Status: UNSURE (   9.51  )
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

On 12.01.23 15:48, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> On 11.01.23 23:11, Julian Groß wrote:
>>
>> when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
>> system seemingly randomly freezes due to the file system being set to
>> read-only due to an issue with my NVMe controller.
>> The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
>>
>> Through network logging I am able to catch the issue:
> 
> [...]
> 
> #regzbot ^introduced v5.19..v6.0-rc7
> #regzbot title nvme: system partially freezes with "nvme controller is down"
> #regzbot ignore-activity

Stop tracking this for now:

#regzbot inconclusive: stalled and might be a hw issue
#regzbot ignore-activity

For details see:

https://lore.kernel.org/all/81b5b28e-33fb-48ca-9e84-7574d5596bfb@posteo.de/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



