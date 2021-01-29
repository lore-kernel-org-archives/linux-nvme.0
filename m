Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DFC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF4864E04
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF4864E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0QKSWFTQ66RoiYivbkz/e+nSesCCYmbpDmiEnqwE+94=; b=RUquZVQPiKeJbT3l+PvS3EtJe
	cbXL9/dz2UrrRxNPf92qoLSHR3eUuOqVkVJ9EPFBTwXpiqg1bi7JSs1UB4YKvzUs7XHvR42sH/nc5
	clhg1xfnngqbLsieO/JvtJ6hMDJVLew9K5zXn8PxfXPmhUf8CgB6ahOF1GuLdxM1qUu8Se526kx61
	uuaJKfyTqQ+u7Q3iCIckNfwyPESaHjRhnAy42N+5irkC4G1oR2cdyZqcWr4B2nR57THrOKQJPDzim
	FaWRdeSghPGxE7pL0KRr9b88lT1Ufxsp9dwXWH7MDZkwM4IEQKS3/boIsWOT5xv8IomotZn03YgzS
	9/twU6BAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5a54-0007Gi-Kl; Fri, 29 Jan 2021 20:09:22 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5a52-0007Fg-NJ
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:09:21 +0000
Received: by mail-pl1-f173.google.com with SMTP id b8so5872016plh.12
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 12:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5bJDCSp7K7veuMVDVVdhO7mdyx5Bl4l+8SBRiXwDgAE=;
 b=DoenlxYAw5ypbd03778BGJhxMmcA+kErZdhCJN0O35EEeRB18qhd42SO8xMgHJ+35J
 u17K2XYF2MpyZtLT5JG3y1S4AtqvcaDLrgtv2BKwp04ZSawur+fEPAaWrNarXS5bqhoT
 pP+aj0vU+RMM0AvTYNcpajn5PNcCiDZvvDY2Ph3o2Jablu5eYKRVoJ/wTuVII9FesiJd
 ilQR4M/frJ/KhFmlnPcb7SzHoX7+fdSjsIwLHkJL9rwknYlNgeQvD0fgDxk9fuvIrOsN
 1DBmUEKwIcoa4qMclxJ+jMH169cvgzx3Pz9pN4L63UUVEN/by4zQ8Obl06JTdr/apOR+
 tzWg==
X-Gm-Message-State: AOAM530w8t3a0/BMQdmc3Q+OUSKQ2L1oOn46koTtkgyRWo9wpJzs0RHk
 DGpatqrIFccKAmnWThDH3VA=
X-Google-Smtp-Source: ABdhPJyHeuJOqlGwCjmLf4RwRo/PP9RW79FJEW+vrGR2Te6neyoJNcOFj3FaRHW8ROefMMN0tT+Wzw==
X-Received: by 2002:a17:90a:de81:: with SMTP id
 n1mr684196pjv.215.1611950959493; 
 Fri, 29 Jan 2021 12:09:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id q2sm9520145pfg.190.2021.01.29.12.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 12:09:18 -0800 (PST)
Subject: Re: [PATCH 11/35] monitor: add option -A / --autoconnect
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-12-mwilck@suse.com>
 <d9c74675-a324-b863-1dee-454fc90d5e77@grimberg.me>
 <cbf4808b0becc3978b758d5be5cc3f3c1c6fe86f.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e48f239d-0642-c07a-a442-6922070ab23a@grimberg.me>
Date: Fri, 29 Jan 2021 12:09:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbf4808b0becc3978b758d5be5cc3f3c1c6fe86f.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_150920_793472_D3FDE91C 
X-CRM114-Status: GOOD (  10.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> With this option, the monitor will try to connect to newly
>>> discovered
>>> controllers.
>>
>> Maybe I'm missing something here, but what does it do without
>> autoconnect?
>>
> 
> Basically it just runs "nvme discover". When events come in,
> it runs the discovery and prints the results, like "discover" would.
> 
> We can change that of course.

But its a daemon, seems not very useful, but ok..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
