Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C9C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:14:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00002086A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HFmSEusY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00002086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wcvHoLWClmT70ogGPVF8kTn/pzHntrIXReTzWYvUgD8=; b=HFmSEusYXjeddz82aDEaS5QZG
	brgPvBC3Zr+OEluX0IvaWK52+0GmMKgwMFNhfg/sZEYMFznB6ZC+gD2Ls9l7AoTgjVv6fBk85GKFi
	p4XWX3ilv+9dKKBhG2uSyt32x4vlX/ZrijqOb4jeHIqekigYS52vxWIofB4N0AIu3U+ZRnCUBZ2UG
	FGP7SmaRwXu4QJmwJTYf+1IllfrXMIkq1NAq0xePYd9LmI7ytG+RtcQERx8ZaHd/Trj4JQLfHNy+3
	KjH2e3Cg2ANUECnMy+UJClVyAF65OqOehWtq5q7glrjxLOQ2nf/LwhYPMxhKPoY0dcfxZiAWn8591
	WFalJGpDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45wZ-0000YC-OD; Fri, 07 Aug 2020 17:14:11 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45wW-0000X4-Ts
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:14:10 +0000
Received: by mail-pl1-f196.google.com with SMTP id q17so1341477pls.9
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/WDhvBaZrJnJ4jgZQWWfHB6fNmDXA5JZyzuuiZ8iUSA=;
 b=B64yLmhPRoYdClKNQjdP2vcMeAwHxjYrxYTZ2OF2tYdwCPjf4SHq8NSxfefR9LxJsn
 5h2CrWDkhD0cb1LXu79Oqlzrz44slz0QopZRmi2ac6iraq41kpIluVxPTF+eqC4wvLEC
 ebb9nuCwjrrjxx89lPwSdRg8cmXqtI5F4iB/yYLYRyRQiWBHavmehjS1JYablB9bg8/5
 f4KGYYWE1kKFfhCeyacRPWdMl0H5YqsZfJK5TAxc1xqu9hNVZL0h/wQmAvNUAZyGPhVF
 V9MCYkJ28azDpITs2Qb7x+V7L9emqYtjjNdN23vLbdeMSCtyBTt2t+zlg+Kj7/rEBTwZ
 +lYQ==
X-Gm-Message-State: AOAM532w6NSWWpMAocas4QWdLxyJF/1DY6sflgJ6VpAJ5aPIi82ukJWY
 8fwfVtTu4kGqE1u00YtRFMimBRKoGlQ=
X-Google-Smtp-Source: ABdhPJxYPYSslV5v0zGDZQCpWSXYntqtbLvPD6nyyOEVMwCjiIr2opMeO0cz2oIrCMcQaQk65/7Xog==
X-Received: by 2002:a17:902:a611:: with SMTP id
 u17mr13596173plq.263.1596820445697; 
 Fri, 07 Aug 2020 10:14:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id s1sm5660681pgh.47.2020.08.07.10.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:14:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-2-sagi@grimberg.me>
 <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc11798d-52aa-01b0-8289-f6e76659e564@grimberg.me>
Date: Fri, 7 Aug 2020 10:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_131409_138253_E0C7BEA5 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 6ffa971b4308..320aa4b2b475 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -6,6 +6,25 @@
>>    
>>    . common/rc
>>    
>> +nvme_trtype=${nvme_trtype:-"loop"}
>> +
>> +_nvme_requires() {
>> +	_have_program nvme
>> +	case ${nvme_trtype} in
>> +	loop)
>> +		_have_modules nvmet nvme-core nvme-loop
>> +		_have_configfs
> We should just move nvmet nvme-core configfs _have_nvme_fabrics_common
> which are common for all the transports to avoid the duplication.

That's a minor duplication, not sure it warrants consolidation...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
