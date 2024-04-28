Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C294C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A51YtIzmxIJ/1M7PSHIJF2EUtzQtza6QH2kzU4XcYpc=; b=SJf8JW1INM0xSbZ5KDOv/n7Q1S
	m2txWgdtonVTju11t1j+TZaqjPmb3Hroa/sZzn6Pdo/yF4h5CT3d9/GcSJkJ3tgby1ATQ3IXFq7eA
	KRqVxvSXprY1aCyqJ8QrFJKIAcZkzMZTjNj7UM6S131IBnBdKUntnmtx5sVUvx2YutGC4JFWVcQB3
	ou/EEyKaIoDBz6oLBh8KmHYyN77y//iMDGu0/goDmKm+KDj8uZxcEXiim/9y4a/Mzutn9zhfDu6MP
	FBWw8Y2H0vsBcatK/fgxjJBM1dyBEuU5F/KMpDFrYKM2sPl3axtzG3QNIwIUhelq6qZTXGYouWTdW
	DH1DZi/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s14Kv-0000000Hb7K-13tr;
	Sun, 28 Apr 2024 13:12:57 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s14Kr-0000000Hb6k-1DAY
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 13:12:54 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346407b8c9aso959197f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 06:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309971; x=1714914771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A51YtIzmxIJ/1M7PSHIJF2EUtzQtza6QH2kzU4XcYpc=;
        b=EFKsrrTeOyevxJ76cWb2rJbtPm+yoP3lqJcaxirI2YuKOy7QlRU1H2wOLzSVmFKI19
         eXFzHxwxJKw3u+YhZB3x3RpjUQuUhwtG6WRNOX5YN00xGaxFomyKcToSm73mpGLBRD5v
         36fx7Sh4K1uiaYdS0VeyejVrcJbawVe5GchLBLS1BOfiLzQBcuU05d0YCMDU9vaz8+Gn
         3L9ukIYTEBN2UuTvQwGSqYJMSRNveQO5ncRWcoTVS9mV3fjedwZEvBpTsna4T7Ka5Rc2
         yFI2wouXh06i0D60xAkI0nyklELKIhKhP7sZQillWfWPxprdpcsrQhYNszfqh0AZpD7n
         7VCA==
X-Forwarded-Encrypted: i=1; AJvYcCX2heVr7LPpVceKtgBAG0ppUcmMY7Py3vx/xsV9jBPDKnhkAg+rrr/IxchsuAIT3dsIox4S2M383EVKyFkHsX29vGnvUTBgXF7T0zNaLDE=
X-Gm-Message-State: AOJu0YwY/XXpsMOaDI/7K2xKJlvoEXjFxIJmMXvEzeTs4uOAfPmPngz9
	Vuqx3+ffBbZFm+iXAMhJSXW7VEv7m51VdFd0zxVPiXPxU0Ah6Kc0
X-Google-Smtp-Source: AGHT+IG28shCoUSbiQL2zGzCWftX7TwpyTs0fmz6s7amnWJ8lD/U5GtkUTE5IxlhNdTTVEuCLgGJvA==
X-Received: by 2002:adf:e247:0:b0:346:e3cf:1394 with SMTP id bl7-20020adfe247000000b00346e3cf1394mr4418317wrb.7.1714309970897;
        Sun, 28 Apr 2024 06:12:50 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0034c5b28c264sm6156930wrt.16.2024.04.28.06.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 06:12:50 -0700 (PDT)
Message-ID: <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
Date: Sun, 28 Apr 2024 16:12:49 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_061253_553165_81733756 
X-CRM114-Status: GOOD (  13.21  )
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



On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
> On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
>>
>> On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
>>> Enable repeated test runs for the listed test cases for
>>> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
>>> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
>>> so that the test cases are repeated for listed conditions in
>>> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>>>
>>> The default values of NVMET_BLKDEV_TYPES is (device file). With this
>>> default set up, each of the listed test cases are run twice. The second
>>> runs of the test cases for 'file' blkdev type do exact same test as
>>> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>>>
>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> ---
>>>    tests/nvme/006 | 2 +-
>>>    tests/nvme/008 | 2 +-
>>>    tests/nvme/010 | 2 +-
>>>    tests/nvme/012 | 2 +-
>>>    tests/nvme/014 | 2 +-
>>>    tests/nvme/019 | 2 +-
>>>    tests/nvme/023 | 2 +-
>>>    7 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tests/nvme/006 b/tests/nvme/006
>>> index ff0a9eb..c543b40 100755
>>> --- a/tests/nvme/006
>>> +++ b/tests/nvme/006
>>> @@ -16,7 +16,7 @@ requires() {
>>>    }
>>>    set_conditions() {
>>> -	_set_nvme_trtype "$@"
>>> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
>> Why not calling separate functions? having func do_a_and_b interface is not
>> great.
> In this case, we want to repeat the test cases to cover combination of two
> conditions: M trtypes and N blkdev_types. The test case should be repeated to
> cover all of M x N matrix elements, then the hook set_conditions() should
> iterate the elements. I can not think of the way to handle this iteration with
> separated two functions.

What happens when you add another condition to iterate against, you 
introduce set_a_and_b_and_c interface?

