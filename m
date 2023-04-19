Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A5C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIgRlyZSNH/SNYRlepaN+njO6QBAl9chuqcWN0oyisY=; b=z6Ns7RPsFLA9nrKwhIyaU60NNw
	/iFhkc7QEQTQrqAHXasnTqxXTicI8TM9fF1g5Il9iyWyo0d4goiQ6S2EmfHuzCVEMo24f4932RJ4y
	qYN32qnBUikjWQgOQHUTg7ScK809X4goASXIK7ti2HHiGljrmgIs0EA4XvvOWSsjgPlLM+aCBM0pc
	WdC9R00l+nnIcJGyay/gpO7zG/lYY+dBELPDnBZa6Zkbkn0WpWwG2LLwffL/8lA51WnnQUZfrpID2
	70C+JYBRh7BzKUw3aXkvXiSXq5VlQ21PAeFjDdkJa67SB3sdaEihW5H2YedDk5E2Afw//eiq8AvZ6
	Z0cmqnFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp7fC-005Usi-3A;
	Wed, 19 Apr 2023 13:15:58 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp7f9-005UrQ-2n
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 13:15:57 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2f4130b898cso594473f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 06:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910149; x=1684502149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIgRlyZSNH/SNYRlepaN+njO6QBAl9chuqcWN0oyisY=;
        b=I1J+3qUMlbs+jNFCz4IHx86MDAfifDqzgL1+BfAc6wioV1cA6+h30FQ3wDYMnJNVle
         UqYlAzHzJ4yCNk42TmNcl/ymitfX67kpkO+Gyzug1/uOW8MzXNg3vN+6L3VMlB/Ef/q1
         MeYVPQKYSr1tfW0D1nu9R2HH49ga8Heg7lmewj5kDZF3+tyIh2ChVVtQK80I2mt1P6KC
         9LA5QYLX2odEKTOEp6ZuI/FeGgQVQfQ9h3Ij06CvFyN7n/hJq0U10jzJcGIf16iI2rUG
         AquclJG5MFbEcbDlC/EAoR4FvOqhbmH8DWrZazqU3hIqRZm1os0ZYw4+Hs/eLZmDJIwB
         nJIg==
X-Gm-Message-State: AAQBX9egvz+tkMeUxemkrMGSrrg8Ehc2ik9gge4BqX0nZ4GuXjxrMFOh
	pY50Ppr9Kmle11c8+Q2aess=
X-Google-Smtp-Source: AKy350aM3txglqO3IBUp/d4qIVyIrEs8rob4csV9yafFShyvmuXFrJJ0427NCQSlvWFhFQKDFVdKKg==
X-Received: by 2002:a5d:548e:0:b0:2c7:1c72:699f with SMTP id h14-20020a5d548e000000b002c71c72699fmr11405069wrv.4.1681910149047;
        Wed, 19 Apr 2023 06:15:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b002fda1b12a0bsm4211767wrr.2.2023.04.19.06.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:15:48 -0700 (PDT)
Message-ID: <6a5feb66-632f-b843-c04d-e0aaa2d51415@grimberg.me>
Date: Wed, 19 Apr 2023 16:15:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_061555_904502_70116471 
X-CRM114-Status: GOOD (  17.69  )
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


>>>> While testing the fc transport I got a bit tired of wait for the I/O jobs to
>>>> finish. Thus here some runtime optimization.
>>>>
>>>> With a small/slow VM I got following values:
>>>>
>>>> with 'optimizations'
>>>>      loop:
>>>>        real    4m43.981s
>>>>        user    0m17.754s
>>>>        sys     2m6.249s
>>
>> How come loop is doubling the time with this patch?
>> ratio is not the same before and after.
> 
> first run was with loop, second one with rdma:
> 
> nvme/002 (create many subsystems and test discovery)         [not run]
>      runtime  82.089s  ...
>      nvme_trtype=rdma is not supported in this test
> 
> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
>      runtime  39.948s  ...
>      nvme_trtype=rdma is not supported in this test
> nvme/017 (create/delete many file-ns and test discovery)     [not run]
>      runtime  40.237s  ...
> 
> nvme/047 (test different queue types for fabric transports)  [passed]
>      runtime    ...  13.580s
> nvme/048 (Test queue count changes on reconnect)             [passed]
>      runtime    ...  6.287s
> 
> 82 + 40 + 40 - 14 - 6 = 142. So loop runs additional tests. Hmm, though my
> optimization didn't work there...

How come loop is 4m+ while the others are 2m+ when before all
were the same timeframe more or less?

> 
>>> Those jobs are meant to be run for at least 1G to establish
>>> confidence on the data set and the system under test since SSDs
>>> are in TBs nowadays and we don't even get anywhere close to that,
>>> with your suggestion we are going even lower ...
>>
>> Where does the 1G boundary coming from?
> 
> No idea, it just the existing hard coded values. I guess it might be from
> efa06fcf3c83 ("loop: test partition scanning") which was the first real test
> case (according the logs).

Was asking Chaitanya why is 1G considered sufficient vs. other sizes?
Why not 10G? Why not 100M?

