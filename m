Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DCFC4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHdTuzF4WpCRrGciBhyi5PVxTiUH0NEDczsrk1P37l8=; b=OOFGOWpOIe5rSgWI1jLyevhOD2
	IMZZhs8/QcpxXD2e9yn7UGx5Va1k3YeJGC3f+tO+eQTiifdo1mKVyg91ZPVuBSfEC+QM+fJjbRSlm
	Cqp8fncnxBvTv9jzfUsMKEeDEEv9/tZ2fGiJYL6TTij44QRgvArxraonRN+JPwxBLxwyxrKQLyG19
	yd1zG3EvaE5Ph5gYY+Xihxw4Qug4uSjz9Tv/WbKLWJpLWkg2lz78v0L1RU/Y/cl57JpPG1UzDcjuK
	C6Q7uaemLdRrfe3o79ZEQSdrd1kKd+6B+qk37NQVaRR39apjE2b0dUErozxImoAZHvx8nzOZVXIGd
	RTXSdktQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nPq-0000000FTw0-3vMp;
	Fri, 03 May 2024 07:33:10 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nPn-0000000FTuk-3jjz
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 07:33:09 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1886030f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 00:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721585; x=1715326385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHdTuzF4WpCRrGciBhyi5PVxTiUH0NEDczsrk1P37l8=;
        b=e8Z3HeP3rPmBnebIFnDBIOasFkrQeSOQET9f8Wggry/mR0Gxs/vIEJ0GF+vIh4VoyA
         aIgPMLRyOC9f9gr/Uf5MWlzjN12Dd1nCQBp8MjT0LsWj3RLThNmyWvlZZ2hO+RNQkPJh
         XqjlF5jEkamhKqBWvFEtMcDGkeb+l3+bXoEUL+PJN0yy2QR42tV/L2RQcSdd2rAopUQs
         NiJOtkt6wmYw03IJG5bNI0wfmRcqv9RZ/xqeNJZT9fwjHjI7cKQBSqPc//g+8BmqBHsR
         DyYkiauRdtdKeayKHztywWOdA33oNZzgi0f48AnTbLN/LLtBveiA7PdixVwzIEv9xtzn
         LkcA==
X-Forwarded-Encrypted: i=1; AJvYcCWLkoc7O+3ivS7uGPH+GCu3Hat8BT4ejOfzwgze+/t5+gUoAcq+SVR8vjavOispoWNIZYIojCKxuqLaFgaDEMBTi+13naYxB3YwJ+XUreE=
X-Gm-Message-State: AOJu0YxeVhOgyUV9G4Zeh+WXzO09C7OmTSi30AbCmOiwei3VOvSCmpnH
	dKEShtWsmHq0DDv3IKSdFbBuWnKNXAfqk4WVGt6C6bNiSdcY6Eub0BXJCQ==
X-Google-Smtp-Source: AGHT+IEYrDbizELqBNPGXfUq4T1W1asKlzoGEoXMAPvPSrWZk7SozGy90kvbazf1CUeajndZ3QJnAg==
X-Received: by 2002:a5d:558a:0:b0:34d:7d77:36fa with SMTP id i10-20020a5d558a000000b0034d7d7736famr1225974wrv.5.1714721584470;
        Fri, 03 May 2024 00:33:04 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0034cfb79220asm3081074wrf.116.2024.05.03.00.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:33:04 -0700 (PDT)
Message-ID: <3e3f0cdd-0eac-4463-a659-0d0ca9430658@grimberg.me>
Date: Fri, 3 May 2024 10:33:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
 <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
 <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
 <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
 <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
 <bxklo2o4onybsamatf2nyhecnkl3wuoz66p7nq2dyndnfc4vxt@hkokvvx4c7jy>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bxklo2o4onybsamatf2nyhecnkl3wuoz66p7nq2dyndnfc4vxt@hkokvvx4c7jy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_003307_966257_3B7ADA19 
X-CRM114-Status: GOOD (  10.66  )
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

>>> Another question is how it is likely to have more conditions to add on.
>> I expect that people will want to add more flavors moving forward. For
>> example
>> ADDRESS_FAMILIES="ipv4 ipv6" RDMA_TRANSPORT="siw rxe" and possibly other
>> features that can grow in the future.
>>
>>
>>>    I guess
>>> such many, multiplied conditions will result in combination explosion and long
>>> test runtime, so I'm not sure how much it will be useful.
>> I think that running multiple flavors of a test suite is a capability that
>> is bound to be
>> reused as more test flavors emerge. But that may be just my opinion.
>>
>>> Do we have potential candidates of the third or fourth conditions?
>> Yes, see above.
> Okay, the candidates look useful in the future. Fortunately, I came up with an
> idea to make up the condition matrix from multiple set_conditions() hooks. Will
> try to implement it and respin the series.

Cool.

