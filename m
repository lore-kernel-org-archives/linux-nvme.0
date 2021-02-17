Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45774C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 23:27:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BE264E5F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 23:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BE264E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VbIuCaHQSkYBu9sQYCNm8Gma2gWgSdDEulqBGZQrBs0=; b=hunZdmzwJNezm6Ot1t+9RnHz3
	6A0i6cUIPHDivh3HRWiHhDQNufe8lyNJQgFw4QDuKWngoM8DzxLOhiR0ww+TODBSqncXEofE/Ozgv
	dzl6kW0lrvF/MUNncFv8I9hJRK8JgZbnJz2YmBSqeEGuffT70Z94WIkRUPL3yyffTEm/27aTvYLHe
	H40o798N5Sw6pkkrqd63A1q/w6y/E0khbQ8EOItkggxt2EKGrLZ5HM5sdY6IaqG0ekKcewV0CwUTm
	5TG2cc62azy2biMNLhFVZVC5S3ZHSJYd/NVoodQzkbsKyG2L4IW7K5HM8JQAKSE/5SjZ6uObCTdbn
	b2rgIcvhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCWDj-0001iW-I8; Wed, 17 Feb 2021 23:26:59 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCWDh-0001hO-9Z
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 23:26:58 +0000
Received: by mail-oi1-f180.google.com with SMTP id k204so16911680oih.3
 for <linux-nvme@lists.infradead.org>; Wed, 17 Feb 2021 15:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dw31lu0SQefjWaGbNSmWT6m3SSqLWB1AeqUIy5qfD+M=;
 b=S9t9k5TgHa5a5CKaPDP33lTrew2X2kk+c4NPKwAhTn7sNnZBUC+xP+62N2OrnkKqZF
 GoZhHcT5CqAjq9k2BxZ/hjgfR4PChwMxNMLaXVe9UN9D6j6KlomdAUMZUT7IHhV29i5c
 aerU/SjlZ5sWRf4fvQ9Tx1zPlVSRJqigN+Nay2Q30Czkzd9u6ag84kR20s/69x4dpfBN
 KdaTpwnnqrmWNC7AkVd4Mt1ZXYYMT8J8dlmTPocf3HyhTiW9xb6/8z7h1qK9zNsvRPGM
 40qn5THKcy94GoyRfgoBN0FKQY708Sw5nQ6A2vQ43a3mn0RzpKO5GpZDcsTvEOvilNmd
 RoTQ==
X-Gm-Message-State: AOAM5335brAlo8+f6aOtZxWwOHBsV/XgldE6+74X6no82BS+A5ohVA5d
 qQJ8SskV1FQ1hYbbQc31MYdY0PZKfwM=
X-Google-Smtp-Source: ABdhPJzU9GbqKLAUyFBAiXoO6aikKEtJjeswuYHJ0wjVBI/xRshUW0k0WtNxtBbbUJrPL/RYAzegYw==
X-Received: by 2002:aca:a810:: with SMTP id r16mr781552oie.105.1613604414610; 
 Wed, 17 Feb 2021 15:26:54 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:7c9b:a596:e958:8c36?
 ([2600:1700:65a0:78e0:7c9b:a596:e958:8c36])
 by smtp.gmail.com with ESMTPSA id n93sm694083ota.37.2021.02.17.15.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Feb 2021 15:26:53 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
 <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
 <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8937148e-f667-9a05-3828-58114dca6da3@grimberg.me>
 <SJ0PR19MB4544A653D3A84A19A28D3984F28E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <1a430561-498c-70dd-f14b-8fab10673f65@grimberg.me>
 <SJ0PR19MB4544CAB0A539F84E54EC5208F2889@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7f5ff08a-36f0-3b67-9753-20eedd4b6f4d@grimberg.me>
 <8bcaaef7-76b3-0c57-d343-1581807a6d02@grimberg.me>
 <SJ0PR19MB45441A133999DA90186BCC11F2869@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8e482420-f9da-f458-f6d3-93ee1974f0de@grimberg.me>
Date: Wed, 17 Feb 2021 15:26:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45441A133999DA90186BCC11F2869@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_182657_373966_5E1DD6A1 
X-CRM114-Status: GOOD (  13.20  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> =

> Our kernel expert was able to try the patch you provided. This is his =

> comment:
> =

>     /[the patch] fixes the panic, but it=92ll take the controller down so
>     it's unsable.=A0 If we want it to ignore the error, it will need to be
>     a little different./

Thanks for verifying it fixes the crash, not sure we want to ignore this
error, while its not prohibited by the spec to send a 0-length R2T
(although it probably should be), the controller is obviously
buggy and we should probably stop talking to it..

I'll send a formal patch, thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
