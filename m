Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7AEC6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2N2hb9fQX6BxeQJJ0ZtV3DN7BTyeH4WlP1z3pQfLoc=; b=sMolabnyd8mbjeWE42ZyvUdTo6
	6vGGEm2FYCIeVCZzXoBopfcqSJUjKm8eIp9mgJl6YQrccv2kirG++ixy3bflS3RFfiEG44spOCTI0
	x6GvbO0/uJv5KvzikP4RHnC2cpSeHRhDtFuIY/9okWWibEwOMl8KfQsB3O6SujZSKb4AXEg+rCXvC
	KJLburjICwXs5ZkRfeYihn8Eb0TuEDa98HcsAi8mWzsTO99LhJzW1wwN57vgYpdnj3kKBl906DEl6
	cy4WAWEcAWq6G2/e/+OayxStWszm6uwMSNSYAeE2Xikm4ajTHawBQbeGd/OdjhsMajCCZ0EdFYslc
	BeL0a/dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4S9-004nqt-1D;
	Wed, 19 Apr 2023 09:50:17 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4S6-004npk-1R
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:50:15 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f174c4b404so5001715e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897812; x=1684489812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2N2hb9fQX6BxeQJJ0ZtV3DN7BTyeH4WlP1z3pQfLoc=;
        b=YVi1nHsOgXxVomxcRcKB2XBazKz9KQhmJT6sBSMiwMp3sdX9QUM75X+DPGQkAnX5Gc
         qaMeq4SPfcqqku8EaCMgWM+kJHi5SoA2i0xu//tgGGcJpobt1RGpHqQgKwdxB8EWFYjY
         vLG81xGg8JzU9kVIiLLz9altWKpheyapYFzE6ohwiMF4pbCjIL6vreOn0i6JhrmdBpd7
         ++1h8Bb1a9x2wvllfzSd+xgl0ExEcekTnRHRaIKcQ9ul6JBT8YXitSgoJFAa9f2ykBpT
         rBQFXj/n3LE0TkrYB1ATye+JIs3PVg8glzHLe1Sy9PFEDFMy2UbnZnRh7hnsOhM7tpfI
         5r6g==
X-Gm-Message-State: AAQBX9f9KeBS8HoMHcLKySwFqo74XW99FH0dlnsfsYS3A0fTLGWiPNSR
	FX/xBP0hjrsq+M1geBw/oqI=
X-Google-Smtp-Source: AKy350YUwQJmtEoIRyfXQD/byB/r6Y3aSQT4xySXr4lC8OwtZSeUBvaym/FcGBjHfDQ3253Byj30JA==
X-Received: by 2002:a05:600c:4709:b0:3f1:8278:8d81 with SMTP id v9-20020a05600c470900b003f182788d81mr439223wmo.4.1681897811766;
        Wed, 19 Apr 2023 02:50:11 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c21d100b003edef091b17sm1640098wmj.37.2023.04.19.02.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:50:11 -0700 (PDT)
Message-ID: <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
Date: Wed, 19 Apr 2023 12:50:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_025014_490653_07835572 
X-CRM114-Status: GOOD (  16.35  )
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


>> While testing the fc transport I got a bit tired of wait for the I/O jobs to
>> finish. Thus here some runtime optimization.
>>
>> With a small/slow VM I got following values:
>>
>> with 'optimizations'
>>     loop:
>>       real    4m43.981s
>>       user    0m17.754s
>>       sys     2m6.249s

How come loop is doubling the time with this patch?
ratio is not the same before and after.

>>
>>     rdma:
>>       real    2m35.160s
>>       user    0m6.264s
>>       sys     0m56.230s
>>
>>     tcp:
>>       real    2m30.391s
>>       user    0m5.770s
>>       sys     0m46.007s
>>
>>     fc:
>>       real    2m19.738s
>>       user    0m6.012s
>>       sys     0m42.201s
>>
>> base:
>>     loop:
>>       real    7m35.061s
>>       user    0m23.493s
>>       sys     2m54.866s
>>
>>     rdma:
>>       real    8m29.347s
>>       user    0m13.078s
>>       sys     1m53.158s
>>
>>     tcp:
>>       real    8m11.357s
>>       user    0m13.033s
>>       sys     2m43.156s
>>
>>     fc:
>>       real    5m46.615s
>>       user    0m12.819s
>>       sys     1m46.338s
>>
>>
> 
> Those jobs are meant to be run for at least 1G to establish
> confidence on the data set and the system under test since SSDs
> are in TBs nowadays and we don't even get anywhere close to that,
> with your suggestion we are going even lower ...

Where does the 1G boundary coming from?

> we cannot change the dataset size for slow VMs, instead add
> a command line argument and pass it to tests e.g.
> nvme_verification_size=XXX similar to nvme_trtype but don't change
> the default values which we have been testing for years now
> 
> Testing is supposed to be time consuming especially verification jobs..

I like the idea, but I think it may need to be the other way around.
Have shortest possible runs by default.

