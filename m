Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72590C25B77
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2sxhFxAcjORFieRCiStlUWoKoj86pGuXV8AATslbns=; b=yqjDHGGLX5pQT52XF2TpSguod0
	I6pkg6SlpZ/E3h5nZ4iIQ6I3d6HEkbgkcJqmCBGHOohwcJucPa7zabdNwQIYI3XNPEzI6sWX+S+sN
	xALDqWdJ/Uz+oBlTLcrOVt6WbeJK6o9VSeqZKy0uTKPMQOn5YqIa02Y/3TWzvV8VEA+/L+4P1RRkb
	lavN0nr/Dp104PzvP34t4dy/Mdqctqlh33HqawQ6rh43dFkEjV5Csl5q+ZlzSq7hjtFZ6GwqytXPG
	MUTnBisrqeWKFUtL5PqJL3FqTOv05axO6oHJyg3rvRBvMw7L6XSIoyCapgALElcLl1e0Vu+wAfhEd
	SQasHYUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9hoB-00000002RAE-3Uvv;
	Wed, 22 May 2024 08:58:51 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9ho8-00000002R8Q-0LRT
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 08:58:49 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354cc708ac9so151204f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 01:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368326; x=1716973126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2sxhFxAcjORFieRCiStlUWoKoj86pGuXV8AATslbns=;
        b=q9keR3+JsaE3E+wxlHaJBkLXQQZfUR1iHFWyEUHo3KEd39Ipu6a0oTHO9Dy3FfZUQe
         +IeDQH+ecRL+wu1D59DufwK+s/WfRcKgstBFfCAUYuDMiQpCYYB/D+6rNJZ+bYCk9Jt6
         6tRk0HG20E4BVBhIq26SeicnnRUEsTf/FdMZ1rEvpjr3Zu+KCG+bgiCpgFAugIGTpDhy
         vzpnaboIumX9RmgFhpwfIpOgh3pnhzsaQXyBrPVHP30gckTkchHNquM/HuDjCATzPHzt
         JEi0v30gRpeFW7m2v+fPC39JQ2vy3yjN2P0JrQDD2Ki2/K+QnHL1KKin1BKykEnPN7I0
         YarA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ej1q1iDM+ejwHO+NKe8AH5v2KikM3pRrnNEiiXkT5RHucBMqVcEo6HmsZLspr8vLC42gMtdmpWUemdXgBXEKQFuaYXxjGgBsx3F6C1U=
X-Gm-Message-State: AOJu0YzQylg3CWU420EslrEoSeQvh3eH523QppgFu+UdSeMhzwXNjJS2
	oh21lKU/L7RAXne1itdbMAU9DXpWUBiJlDcPbB9+eQNWteAON8IU
X-Google-Smtp-Source: AGHT+IF4pel29G3rkuhRj9R4XNtijbS+o0AOcQSrDNU+Ib3pv1GxisXC4f/ZceNua7/0xBxuJBm/WA==
X-Received: by 2002:a05:600c:1d0a:b0:418:1303:c3d1 with SMTP id 5b1f17b1804b1-420fd387394mr10449435e9.3.1716368325878;
        Wed, 22 May 2024 01:58:45 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013b4e9aesm383798585e9.40.2024.05.22.01.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 01:58:45 -0700 (PDT)
Message-ID: <01c126a8-6cd5-4aa5-be7d-bf48317b9d0c@grimberg.me>
Date: Wed, 22 May 2024 11:58:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme: add regression test for concurrently
 enable/disable nvmet ns
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20240521085623.87681-1-sagi@grimberg.me>
 <010a2f18-1f2e-4f95-b5c3-08ee1a197ba6@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <010a2f18-1f2e-4f95-b5c3-08ee1a197ba6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_015848_140601_54477246 
X-CRM114-Status: GOOD (  18.24  )
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



On 22/05/2024 3:54, Chaitanya Kulkarni wrote:
> On 5/21/24 01:56, Sagi Grimberg wrote:
>> Reproduce a hang in nvmet when concurrently disabling/enabling
>> an nvmet namespace.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> thanks for the test  ...
>
>> ---
>>    tests/nvme/051     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/051.out |  2 ++
>>    2 files changed, 50 insertions(+)
>>    create mode 100755 tests/nvme/051
>>    create mode 100644 tests/nvme/051.out
>>
>> diff --git a/tests/nvme/051 b/tests/nvme/051
>> new file mode 100755
>> index 000000000000..ddc097310dd7
>> --- /dev/null
>> +++ b/tests/nvme/051
>> @@ -0,0 +1,48 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Sagi Grimberg
>> +#
>> +# Regression test for kernel hang when enabling/disabling nvmet
>> +# namespace concurrently
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test nvmet concurrent ns enable/disable"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_require_nvme_trtype_is_fabrics
>> +}
>> +
>> +set_conditions() {
>> +	_set_nvme_trtype "$@"
>> +}
>> +
>> +ns_enable_disable_loop() {
>> +	local ns="$1"
> nit: how about :-
>
> 	local ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
>
> and get rid of the argument at the call site ? unless there is
> a plan to use different namespaces

I think its better that the ns comes as an argument, maybe someone may 
make this
function a generic utility in the future.

>
>
>> +	local iterations=200
> nit: not sure if we need iterations as variable, unless there is
>        a plan to make it configurable in the future maybe we can
>        remove that ?

At first I used NVME_NUM_ITERS, but that made the test too long, I can
make it hard-coded.

