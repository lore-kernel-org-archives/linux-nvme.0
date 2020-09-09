Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA05C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:54:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E200821D81
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OCh5IB5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E200821D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gstFAImQ4z0u9SRW9gia+VlkqG6ikkY2y4kfJXM+New=; b=OCh5IB5UVwo1P8RblXd1a0Ckw
	cpY4l2TrIO0u7y8cDSeLChm6Y9WUsX5M7rxkp3WjyuRXs82lQofPiEqVL43nTAGijVQeYAB7B8NUX
	CQD21cjj4KUgirzFQbuUFO8KaehkK4X/K/m/vXOQ5kBs+36fL8ZF/SOLA6ggpBgYwi7gaFvWa74mr
	wIJPCqNhRiwub2LMTo2K1laYjplhsD4eB4q8HuC8wnlxUDYEpTkI36hWDqAsd1IP7vd6evTsYaUEt
	F7XcP9Nrge7A6qFfR6Dpv8l3VWOWEGRTpCPtht6MGJnkWPP8s2T0S/2t01KT1RAWvVTXI9biTunZZ
	C26BFoICQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG82k-0000Ti-QD; Wed, 09 Sep 2020 21:54:18 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG82h-0000Sv-Ew
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 21:54:16 +0000
Received: by mail-pj1-f65.google.com with SMTP id s2so2009324pjr.4
 for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2020 14:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M32v7zd8eDOtfGYHRl7Z2DyMLbWUvK7vpiynbk5ijn8=;
 b=C0HTEhXaO4SJvNPYegtbjK99Ags1RA32JSh9W+CgL28peJQbkUYCTJgXNtWG7uYC47
 U2nct4VjfjZqi7RZYvFlFb178TJ919Mx7g2HNbvonlSlWIF7SMwn0ewqH2+1cP9MK3be
 yXrWAuTT3N3WBcGHDmDhT0ssiNstBlgseVW4X90iv98eDa4K4AxbY1bZzZLIFhlKK/ok
 0lbo+JTNGcDl8Nnv0vvX7G9PKhE2afAD/4DCc57utTT4tIYj0tLEFEn9dgH+soOXHmRk
 k2eXd7zUIqdLMNCKMj1unQKq7b3LZKUr6lhVq+6BSl9iX8PhiRSsdmbb2OxJ+NuYHFRC
 3WiQ==
X-Gm-Message-State: AOAM531ZzuGqL3bDrv7L2r4CKK2G5tE3HMCJkwmIE/KbHGw2o4/h/8A5
 VMeMx5AkhL/Pyq8tW/qV5yedxaduYO8=
X-Google-Smtp-Source: ABdhPJzB7A0c/4ixF9tAvW0RKMo//441YLmJpAUnlWMJQ4OWpmAzCJvLujSslhJxmp9CRHzQlPW3Pw==
X-Received: by 2002:a17:90b:1741:: with SMTP id
 jf1mr2413626pjb.164.1599688453938; 
 Wed, 09 Sep 2020 14:54:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5905:3209:6aa:d817?
 ([2601:647:4802:9070:5905:3209:6aa:d817])
 by smtp.gmail.com with ESMTPSA id 194sm3641548pfy.44.2020.09.09.14.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 14:54:13 -0700 (PDT)
Subject: Re: [PATCH nvme-cli] nvme-status: Don't reduce all negative statuses
 to ECOMM
To: Keith Busch <kbusch@kernel.org>
References: <20200909212129.309888-1-sagi@grimberg.me>
 <20200909212717.GB3384631@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73a82522-7506-8759-dd60-7b36695e60ac@grimberg.me>
Date: Wed, 9 Sep 2020 14:54:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909212717.GB3384631@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_175415_518725_F4801D53 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> There should be no reason why we should reduce all the semantic status
>> codes we are getting from the device/driver to a single meaningless
>> status code.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   nvme-status.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nvme-status.c b/nvme-status.c
>> index a78c1fd02797..29982541466d 100644
>> --- a/nvme-status.c
>> +++ b/nvme-status.c
>> @@ -142,7 +142,7 @@ __u8 nvme_status_to_errno(int status, bool fabrics)
>>   		return 0;
>>   
>>   	if (status < 0)
>> -		return ECOMM;
>> +		return status;
> 
> Shouldn't this be 'return errno' instead?

Probably, yes. Let me do a quick test and verify.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
