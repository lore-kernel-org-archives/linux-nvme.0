Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A84CC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Is1cfEeUNYF1r1md8mSw/qkiJWZBZJq3TBjLLkTXUKo=; b=0HnwBXhrgu5kbKJ5raNH0HL8ef
	V+5Iw/tFZ8qRVDx5BJQM2Yb6bNkwPMEL/U84raIG+4xTBdIXr1nuFNv6Y71uVQuM1P1PP2+RW8nNN
	wW4FPvu5DREP8S8HQWKH0FY4nnZIJtxew1KxD3/10KGYI1d+ft0+mWP+/jiR3a9MK8VUZikl4Ja2G
	BUWm2ReyN8LqOmoT8JQVI8/79+TW8HV9XZRx5NX6jCZVWp8kFfsuZyGvzNYa11ZDMTMkCSPo9KVOe
	Vp2F1LyY/0Zf+TVytv6+X37gY1YHJZrM2sobgeA1Fyv28BS+D4QvwYCVkrBMyCzWZWAnEILClTpZH
	YKbhojQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwrD-00000009fZf-34iF;
	Wed, 03 Jul 2024 10:04:59 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwr7-00000009fYE-1M8R
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 10:04:55 +0000
X-QQ-mid: bizesmtpsz5t1720001040tepgz58
X-QQ-Originating-IP: JVJParCQJX31txIFihbcR4urx36FbLnqLbvHyv5bb5A=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 18:03:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11011914129124645858
Message-ID: <A929246EF5D140F2+6a40266f-73c2-4ec3-9667-3503ed1ff3a8@uniontech.com>
Date: Wed, 3 Jul 2024 18:03:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
To: Keith Busch <kbusch@kernel.org>
Cc: guanwentao@uniontech.com, huanglin@uniontech.com, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
 <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_030453_873313_B977C011 
X-CRM114-Status: GOOD (  10.83  )
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


On 2024/6/25 05:49, Keith Busch wrote:
> Based on your commit message, it sounds like the platform works the
> majority of the time. Is it possible that NVME_QUIRK_NO_DEEPEST_PS is
> sufficient for this? Or do you really need to disable it entirely? The
> power usage differences can be meaningful.
>
> Also, 30 minutes of idle is an eternity for APST to kick in, so I'm
> curious if there's something else going on here or if the breakage
> occurs earlier than that.
>
When we "quiesce" a machine, some applications may not stop disk I/O 
promptly,
so the 30 minutes include the time to wait for these background 
processes to quiet down.

Thanks for the reminder. I've tested it and 'NVME_QUIRK_NO_DEEPEST_PS' 
is effective and
more appropriate than 'NVME_QUIRK_NO_APST'. I'll send a patch v2 to 
update my code.

-- 
WangYuli <wangyuli@uniontech.com>


