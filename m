Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B671AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 23:01:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3904664E6F
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 23:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904664E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NH8GmHsuefYGECYQ7rWLIsWMN/v9Skx9SaLiSCNtSz4=; b=EpbPV3n8HOZnxCMtNKMkOUvbv
	JUbRIZddQQrs9XBCZQ2KnWqgUrJ140iIPDZlR/B493ltxhxoL5dAmEZxPE0j9jWkH7xWcgv6FkHYL
	n/TC1sNYhKoLIzJ7wS+aQHfJvv+ALBTYPcz7BuMzqzTmXv4Pta1kKIUil/WviwnIcYlVk8UsL+Ktm
	wfOWkaBZplvwFortxqNCgKr1CXFiYdi0PelghObOsejEXXlGnqs5qiXTirTi3QI1cX8PsScobLWzy
	L9tQywThnM6LcleUmND30Uetp0uH6U1MJtcdbUuOhQrAsimHqeM82QI1ZRSxLYkxcxxa5GAC1cz2U
	4FaJMTFOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9FXG-0000L0-GR; Mon, 08 Feb 2021 23:01:38 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9FXC-0000JO-8w
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 23:01:35 +0000
Received: by mail-wm1-f44.google.com with SMTP id y134so552864wmd.3
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 15:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=33nPILZt3gaNqpfnMm7C6Ldo/5UjX4ng2se5xyuPgQY=;
 b=lig1b1xuZxJ+i8YgaEaUftjhNV/ObmB+c6yjz8aRTr4lyv7Mx3pHCx/ULjRWgrbn0r
 qeat3IksitXOHBUiQGCdKV53SsbiM71ihHpKvoJHuoCfxQN7eliw8efhboeLl6n2jnOh
 5wb+FkZBJpXSilS5WXExzKuaGkSeM/uDaAfagDqbvvshUfADQNsq7PcRLWTB4hgpR8fq
 JQten3TXgh5WknTWxcmQETBhRzy1PkfEYzL+g4gt+Wf3KQLnGHXYLcs9qlPA2gMah6Hr
 gH7xmlgBTU3jAnic32i0Q44on9X8sf+irJvv80ZUfwDvkDggYjIm7uK8hyAFribtZ2kh
 G7aA==
X-Gm-Message-State: AOAM533z8a5Ups1g2occQwViIJ/vP7U143pz9aQ5PH/WPYVR6xRho4rW
 8RKMkQYjjQGd4TsK7r+ZCCRdvsaPoZQ=
X-Google-Smtp-Source: ABdhPJzjgolsWZ+g+cyzeR64PDxSwDUlzSQKeVYhnWkFgKe9Y3zjbx1ZAGCXs2DFCV3+KpMAvK1njA==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr853606wmb.128.1612825292869;
 Mon, 08 Feb 2021 15:01:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id d9sm33496717wrq.74.2021.02.08.15.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 15:01:32 -0800 (PST)
Subject: Re: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
To: Keith Busch <kbusch@kernel.org>
References: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <4608296a-6c45-a252-8b49-88cf25cd7365@grimberg.me>
 <SJ0PR19MB454412891E589E03EF8DB948F28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <c02ae0ac-ce0b-7081-9759-8c3751510ca7@grimberg.me>
 <20210208190458.GB17042@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbf91356-e2b4-692b-38d8-22ec00359b8e@grimberg.me>
Date: Mon, 8 Feb 2021 15:01:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208190458.GB17042@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_180134_361737_140E2DE7 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hi Sagi,
>>>
>>> Yes. The Discovery Controller currently allows it. The problem, however,
>>> is that the DC seems to be expecting these values to be non-zero.
>>>
>>> I tried setting IOCQES=0 and IOSQES=0, which the DC allows (i.e. Prop
>>> Set return status=0). However, when I follow this by a "Property Get -
>>> Controller Status", the Status now shows "Controller Fatal Status (CFS)"
>>> (see Base specs - Figure 79).
>>
>> Yes, the oversight extends to the target that expects it (shared code
>> with I/O controllers).
>>
>> Does this fix your issue?
> 
> Seems like the Identify Controller SQES and CQES fields ought to be
> updated too, but the spec isn't clear on this. Feels like ECN
> material...

Yes, we should start with this patch though right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
