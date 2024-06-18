Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3451C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NaDAiRmFCXMwg/Jif66ZjmayEhJaZCZNrfQ3r+T5BQA=; b=uYzxw9O9cjR5J5
	bwAD/80guGVY/Vy/+IGx4JTQAf3b5L7rDU6133G/GNH8m4wTXDrAjDfANjxQMSAjw7g/YSuHJ09bh
	yoCHevla5n0fkT+8spTkrA2zjnr/z++Dtlr5SEFAIXV18NNMhRn6K6I6OBSchthlhYogCNO12pOey
	63R1N8x/plAStTkGni247H8rZ2vs3wCE0tuDVf2+MZNn44uqkRly2GsEFeirt7/2enhalRB4iSl2b
	/R+gKndQpZbWRGSnMQXsZGjeHvqYlL4Yt+GSqbkGRx8RG169k0xruFOugBjIL2OGgPy/hY74WMyR2
	I3W+duyFIw+sZLCktGRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSXn-0000000DqWr-2pI9;
	Tue, 18 Jun 2024 06:42:15 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSXk-0000000DqWM-1cO1
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 06:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=NaDAiRmFCXMwg/Jif66ZjmayEhJaZCZNrfQ3r+T5BQA=;
	t=1718692932; x=1719124932; b=k/tqB/II+8gul+SitE2Luzumd+gDTu+oWqnVNXyocAxaPKA
	s6gyJ6prVC+/yfyryfioed4HPJN0YJ3Mi6+9cpqlxue4HmhaGRP9zVpQWmpdSdDYW4GA328XU2cFE
	fIE/69GTPjyqEkukNq6Qa4DHk1cBgYimrx2+JDpF0SqDi3ibCJ1dM4H3XXj7ArARW1hS5MOI6drUq
	Sc6eUXbowd+0iRki/GXmCvXx8jGL82dTAfkyEusM2UyDEyX1NKIiLg5aIuhpTBBYScqYbqX29jDNQ
	oYF6jXxaSj3bRzcmdNHcrZrPQjnDG9GvOea3hbWOcKmfSurwzh35OiAY7RHqaLfA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJSXg-0004zv-56; Tue, 18 Jun 2024 08:42:08 +0200
Message-ID: <b4d09ffc-a8e4-4e9f-9032-7c8583ca6abd@leemhuis.info>
Date: Tue, 18 Jun 2024 08:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20240508154950.GA1768252@bhelgaas>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240508154950.GA1768252@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718692932;0227141f;
X-HE-SMSGID: 1sJSXg-0004zv-56
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_234212_656595_4B0CB900 
X-CRM114-Status: GOOD (  15.05  )
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

Hi Bjorn!

On 08.05.24 17:49, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>> 
>>> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
>>>
>>> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
>>>
>>> ```
>>> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
>>> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>> Date:   Tue Mar 7 14:32:43 2023 -0600
>>>
>>>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
>>>     
>>>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
>>>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
>>>     native"), the PCI core does this for all devices during enumeration, so the
>>>     driver doesn't need to do it itself.
>>> [...]
>>>
>>> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218090
>>
> I don't think regzbot picked this up [...]

This is still open and it seems nothing happened for a few weeks now
(sorry, should have sent a reminder earlier, but such old regressions
have a lower priority here). Did it fall through the cracks or is this
some good reason why giving up on this one might be the right thing to do?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

