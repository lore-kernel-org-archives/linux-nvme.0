Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76946C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 14:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A17360F38
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 14:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A17360F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPwkEfg6XxaMuv7YhznccLrAIj8qhEBY/Z4QnaUWnLM=; b=SzqGi/uLnOvIcrElyndY1KW6Pc
	le9F81zHfKqjc966wocys+FSNEIGVRJocKt13Gt1+2xQsprgkTgyZ+Uh1newHPDCA+klzR2XVnrNb
	/1dNdGSEUNTNp9uMprlmJkPa5/NbIJxJ/D6LAb+QG3n/JfoWoZJhrVQMCiHcdy2aSJdp7X6MtuvkN
	q9VauCiTocs4EjO+OG2gP2xBqjffxDXhcEpOjsE5/1vVCoSVmEKHJuIXxwgAtl1LSXSWNo+pSPaWY
	9IxWsX1WkE3H4N2+piOMgwGzXB4kXY/1uBZEAqrkfu+zIpeCYIN2VKJWEXrNa1tdvjpE8+nLjLWa2
	FLx2Sgwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmGl0-00DlU3-8Z; Sun, 14 Nov 2021 14:45:22 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmGkw-00DlTg-MN
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 14:45:20 +0000
Received: by mail-wr1-f49.google.com with SMTP id w29so25203170wra.12
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 06:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dPwkEfg6XxaMuv7YhznccLrAIj8qhEBY/Z4QnaUWnLM=;
 b=sAYNlGbT4bZilpHpQnJuNfMtkaQ11m7wlMkofhhLafhs/IgYFlgOe5CkrAMGovyh1f
 s5EFYHYL7DYyeRwQjXfQtaA2NDT19FYElVbs7HrctL9XO3NaJMTFtboFNAXNA4Gjtr9e
 gM8CKjoUvRn8Fw99dkA49cSvmzykj50Od64nL/lZ3TS/XYMis5rCtWA7kVgmxXXmcSZ5
 k72bPFiA84jej0buQgPHybm0xpl2Vmc9l8ZhGg2V8yc6uRraPLylgpnBAcxOOazhL/PH
 Qe6MQd7H2JuT6yhzSKLsnSUdcF7Fc/VA72AHhJBbzOS8zIEbl6D/l+dKCEMcU9C2Py6M
 A/1A==
X-Gm-Message-State: AOAM530TXC2TUvW7+0nyGLk3yIAZWZsiUtSGL4/JTwmuE8iGtFEtgqN2
 TPJPALD8obIPnB9d2Kbu6II6+iY4Kgw=
X-Google-Smtp-Source: ABdhPJxCtmsaFmbhTeP44MMcqVUfZ7ItwroCaxkMHkSYSR+UADfecpJZVSyvX+wYUHYCl8uNkcfN6g==
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr37558111wrh.330.1636901116868; 
 Sun, 14 Nov 2021 06:45:16 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a22sm10713526wme.19.2021.11.14.06.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 06:45:16 -0800 (PST)
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
 <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
Date: Sun, 14 Nov 2021 16:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_064518_760129_A583728A 
X-CRM114-Status: GOOD (  18.60  )
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



On 11/14/21 3:50 PM, Hannes Reinecke wrote:
> On 11/14/21 11:31 AM, Sagi Grimberg wrote:
>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   tests/nvmeof-tcp/001     |  55 +++++++
>>>   tests/nvmeof-tcp/001.out |   6 +
>>>   tests/nvmeof-tcp/rc      | 347 +++++++++++++++++++++++++++++++++++++++
>>
>> Why another directory? why nvmeof-tcp? what prevents inband-auth
>> to be tested with loop/rdma?
>>
> Technically, nothing.
> But as I'll be looking into tcp in-band _encryption_ as the next step I 
> found it logical to have a disinct directory.

It is unclear to me why the separate directory is needed. But at least
call it something else if you must have it.

> Especially as I still fail to see the actual use-case for using in-band 
> authentication _without_ encryption.

Not sure what you mean. For the same use-case that iscsi chap exists
for. The secrets are pre-shared.

Perhaps you can explain? My understanding is that the extension for
nvme-tcp TLS based auth is to avoid maintaining two sets of pre-shared
keys, i.e just maintain the TLS ones and not the dhchap ones. But maybe
I am missing something.

> We could rename it to nvmeof-auth, though.

or just add it as more tests under nvme (or create a subdirectory).

> Especially as there's the nvmeof-mp precedent, which also has a separate 
> directory.

That one is for nvme and dm-multipath, not really a native suite for
nvme.

