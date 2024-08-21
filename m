Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A6C52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iBo9Q1pXCBb1xcgelFwqMpmXRnGgdmgIQYHmeKmGuQ=; b=kV4kuFxVBiH05zyGNa48hhm2EL
	V2XVSQliHEZm1hqc+BtKSttkNnv/ktRe7wjJcsNZjnyptYEWv8UccWWgtSDvHQg6m4/NMN//819bG
	9iYFLZN5GivOrWu4+wuxo7WocYCoBBPYejDNt1iPgMrWi90k2+mLGznf84y9Nt5WVDa1pKO0VcoWD
	pfl6KYWwFzv+TkMD/vWDp/ndsBvNMkoyJb3I/3/W/eesuJw+6iK8JduWS7VIjXoXcEPurOunp7ZdN
	aCMyaYd5kL0PfADdP3oeoI8l4mdJynuyRUtaKjAkHhOxTwTTHw6TigQ+6R22FPstSqsSn0pbz+x5G
	rTMOlyNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgouq-00000009t4Y-2h0R;
	Wed, 21 Aug 2024 17:14:36 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgoun-00000009t3p-0o5o
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 17:14:34 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a7aa086b077so729458766b.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yawk.at; s=google; t=1724260471; x=1724865271; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iBo9Q1pXCBb1xcgelFwqMpmXRnGgdmgIQYHmeKmGuQ=;
        b=QD9LvYcw/7tLljOllcAwq2IkytUoGzCzio4JXiB1ZFd46DwthicURTobchkR7lI2+d
         vR/YwOYOuIAgjhERBAlAd6ywRrzjYjqQBOIUHRLGdFhkvs7JDNtFNJyY2lp9s++L3exU
         tBuxeEhfeem3MjhIX7EE0oSWEnGTwXVY4ljDmfk7gyJolCYqaiG/+Ifh7kmNsexCSCY1
         iO7KdxOfWwVBI+kASgCl2BAZ0Gj8xmd60NNj7+MTt6A0XI7CbWvmZLHQbZZ2U6nc2Toz
         8+1W0ic5Md3Ik4fi2TWAl1mUlaVlkfdO767FnTMZezf6SFgXclIg0TaqLwi59q/sD/b2
         jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260471; x=1724865271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iBo9Q1pXCBb1xcgelFwqMpmXRnGgdmgIQYHmeKmGuQ=;
        b=I6CvvNRhiiJsdaYCHhBW9acBRIeZNBcZLfTvbd9WKyXH3SrdB44Zs4/x5psKLq8NRX
         Ar/qnhHiVpfCmNKZEOkAHwwvkENansCsuQFo9rZHZPOdhFCk++bEWoFIkrWTnCnX8CS/
         ODpX6zn1a0XYLEYhSXmqUu1MCSAzwPOu3OmpddFEbeVBxE4/VCpctTDI4ZAlL0TSHwto
         IoucOmX+EdO5J66mchep8b+ruRlOb51t1Ov3rK8T1uvENViGAvsh8Yanv5PtvTa/dzsZ
         h/PNFUV1IXB0BerqBxM3AEGFAyknEOeUX/XGIGStImatZge6ze4D+ycfe4fJgy8p5q1N
         xZGQ==
X-Gm-Message-State: AOJu0Yy58fyUFz7dbYrlLL6IP/UvrgNCYOVsbhR4+Lj3xC6MZshcpuOi
	vuvjyffguOlEmYXC//Xnk2sViu5uxzGgVamkbYZkuT8Frt3se68kdDvfvr5Ehw4=
X-Google-Smtp-Source: AGHT+IGOTZynI3BfI4v9jFjuKgf2+N+gePB5ywaCY4ZjwG1zfTvoie6oxaW2cECqstShqDZ8hU92GQ==
X-Received: by 2002:a17:907:7251:b0:a86:83f9:bc1f with SMTP id a640c23a62f3a-a8683f9c0abmr89446766b.61.1724260470401;
        Wed, 21 Aug 2024 10:14:30 -0700 (PDT)
Received: from ?IPV6:2a02:8109:833c:e300:f556:5d1c:aa18:d31a? ([2a02:8109:833c:e300:f556:5d1c:aa18:d31a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c63csm921976166b.193.2024.08.21.10.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:14:30 -0700 (PDT)
Message-ID: <53001ba3-42af-4038-97a3-4e5a88861623@yawk.at>
Date: Wed, 21 Aug 2024 19:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
 <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
 <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
 <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at>
 <CAFL455mk0aD2DNOp5PPDKM=OJEVd-Cxj4gbtpQeUJH9gpnSs3A@mail.gmail.com>
 <CAFL455kXKGwmketGSK_4R_5jM11LzA5JMpBV4sUeDq8L5meuAg@mail.gmail.com>
Content-Language: en-US
From: Jonas Konrad <me@yawk.at>
In-Reply-To: <CAFL455kXKGwmketGSK_4R_5jM11LzA5JMpBV4sUeDq8L5meuAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_101433_261528_0DF349F4 
X-CRM114-Status: UNSURE (   9.84  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It's the default, 20.

The machine has 192G memory, of which only roughly half is 
used/shared/buffers. However a lot of memory is used by ZFS cache, which 
may impact things. Next time this bug happens I'll try to get some form 
of memory dump.

- Jonas

On 8/21/24 6:21 PM, Maurizio Lombardi wrote:
> st 21. 8. 2024 v 15:50 odesílatel Maurizio Lombardi
> <mlombard@redhat.com> napsal:
>>
>> So I suspect your system is suffering from severe memory
>> fragmentation, but I don't know
>> the root cause nor the solution.
>>
> 
> Just curious,
> 
> What's the value of compaction_proactiveness on your system?
> sysctl vm.compaction_proactiveness
> 
> Maurizio
> 

