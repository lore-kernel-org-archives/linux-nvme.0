Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D5C77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E152j3pnk/BrHS8sWJRy0UHCIwLsl7zy8OP47cXnS0Y=; b=f33IQG6dR2zIhLQmS9ls8eT2XE
	z4E0VOb5XOmSgA4jjvXG9xJ6h3ASaC0FQLIoCrWmS8qMinJ0LBjXffGuEa0IL1TdJgCr9hTGrm1yL
	jfDcnA1K86NBe6IySvJ6ZELrZvEnHD43hlKT4oYU1ar+VpCtlB7JY8xn2scAcZOYr0RRRFpbEFgK1
	jUj1ND6ISrajx0m0g6cSnPr/ETFfiPn2qL6inCRdxFm9XpAfT6fOOmDGu145uvrbmS7CZDpCSngVJ
	+ahQOw7FDFkU5LDduOC6iCir3Y9ZVqa9SXlGsYSkbgkDDwnbZE+GfUsDbDtrkY4odAh9VN4P0Mz5J
	/hnNu10w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptUF3-00G7aS-29;
	Mon, 01 May 2023 14:11:01 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptUF0-00G7ZU-31
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 14:11:00 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f16f792384so6746415e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 07:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950253; x=1685542253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E152j3pnk/BrHS8sWJRy0UHCIwLsl7zy8OP47cXnS0Y=;
        b=eclOar2OaeNWPT3UIlVrCTQEdt7TGDmSSQEVebBsLJJMiX8WRsPcBh3tfYjh1JZiWU
         8UmGCYJ/dSQtrOiru22y6XUQYT81796/uXcaoFkuTLUqS3SRdpGT3MLqd7T5ug9b7uZW
         vAQEJXwIMxrVk9FSVvFf5DgoH1i64elMPPdhhPc2xz2rI7kgZrEyRb4/XPMDquA4XSHl
         aexW0f9dVnd/KO2nGQTK7dyjx7Iuc4Zf+mH7yTzNItv/2I9qjVKZQC9uSjXtpzI3VGzB
         yIMe2WHg2A0gVndnyMi4sYMKkC6q3bsCjIWXftHrm9rebMkvSHOJb88/tR+DUUFVPtZg
         yfrQ==
X-Gm-Message-State: AC+VfDwx01Yn5g66SAGHsqPkJGO7X+9CWNvyybppXuJzBlezDAtIXurT
	LMpE/OEzP59S39JReMzRM1Y=
X-Google-Smtp-Source: ACHHUZ6+S4Mp/TYpM1og23avJsV4KoIc7H3R7YzUhy5ilDetCheIf/CqK4ZGbtFdINN5TWWGsJxKDg==
X-Received: by 2002:a05:600c:4f47:b0:3f1:7138:91ee with SMTP id m7-20020a05600c4f4700b003f1713891eemr10855839wmq.2.1682950252653;
        Mon, 01 May 2023 07:10:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003f17e79d74asm33029863wmc.7.2023.05.01.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 07:10:52 -0700 (PDT)
Message-ID: <eb9fec81-0ba6-ce3d-dadd-934250001126@grimberg.me>
Date: Mon, 1 May 2023 17:10:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
 <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
 <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <gqeyqpv2idkkkf7jajdxbgj4fi5tnlbt7tmuudwxq3gul3w56y@ijwb4axr52dl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_071058_975907_D7EDC84D 
X-CRM114-Status: GOOD (  24.69  )
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



On 4/30/23 13:34, Shinichiro Kawasaki wrote:
> On Apr 19, 2023 / 13:45, Sagi Grimberg wrote:
>>
>>>>> Before we unload the module we should cleanup the fc resources first,
>>>>> basically reorder the shutdown sequence to be in reverse order of the
>>>>> setup path.
>>>>
>>>> If this triggers a bug, then I think it is a good idea to have a
>>>> dedicated test that reproduces it if we are changing the default
>>>> behavior.
>>>
>>> Right, though I would like to tackle one problem after the other, first get fc
>>> working with the 'correct' order.
>>>
>>>>> While at it also update the rdma stop_soft_rdma before the module
>>>>> unloading for the same reasoning.
>>>>
>>>> Why? it creates the wrong reverse ordering.
>>>>
>>>> 1. setup soft-rdma
>>>> 2. setup nvme-rdma
>>>>
>>>> 2. teardown nvme-rdma
>>>> 1. teardown soft-rdma
>>>>
>>>> I don't think we need this change. I mean it is a good test
>>>> to have that the rdma device goes away underneath nvme-rdma
>>>> but it is good for a dedicated test.
> 
> I agree that the new test case is good.
> 
>>>
>>> I was woried about this setup sequence here:
>>>
>>> 	modprobe -q nvme-"${nvme_trtype}"
>>> 	if [[ "${nvme_trtype}" == "rdma" ]]; then
>>> 		start_soft_rdma
>>>
>>> The module is loaded before start_soft_rdma is started, thus I thought we should
>>> do the reverse, first call stop_soft_rdma and the unload the module.
>>
>> They should be unrelated. the safe route is to first remove the uld and
>> then the device.
> 
> Sagi, this comment above was not clear for me. Is Daniel's patch ok for you?
> 
> IMO, it is reasonable to "do clean-up in reverse order as setup" as a general
> guide. It will reduce the chance to see module related failures when the test
> cases do not expect such failures. Instead, we can have dedicated test cases for
> the module load/unload order related failures. start_soft_rdma and
> stop_soft_rdma do module load and unload. So I think the guide is good for those
> helper functions also.

As I mentioned here, this change exercises a code path in the driver
that is a surprise unplug of the rdma device. It is equivalent to
triggering a surprise removal of the pci device normally during
nvme-pci test teardown. While this is worth testing, I'm not sure we
want the default behavior to do that, but rather add dedicated tests for
it.

Hence, my suggestion was to leave nvme-rdma as is.

