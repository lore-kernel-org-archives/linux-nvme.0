Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6D0C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uPbeNwFFvVQVTt9kBGbVaBibbnkr7+pEiNl32W3+iws=; b=3P3/V3NayVmcB/dJroImZf5r5h
	wXsoaAWX9yybm5BwZBc1TWlqp7cxmVyaqNNRWma0k2jaG2V2VqvLvdSxXuEkN9NgwoNjeBR0X6XP/
	nIJo7xs/OrMnYTFN7vHSYeY7rhs5cuNdTJsgq6HumvGPNlxCMTP2OYZ24v/xCX9hFt8D2tqVWhBNH
	WWECYBLRfijgCjW1D0p6PgglYW3ph+eJuldwdO3fwJiBJccINMT9iK/1hZcoU7kuq1haqZFeFvlSU
	oYBUfzsVv+GNnhkJwj0UtENWk01e/Impgs7o0b9Iu9qN9zFsk5eHJ7Zd8XvxxgAJVhf/9Uky/HeQZ
	Bn6TcXqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1m9p-00000006G6S-3sjq;
	Tue, 30 Apr 2024 12:00:26 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1m9l-00000006G5O-1gcg
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 12:00:22 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34cba0d9a3eso132040f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Apr 2024 05:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478418; x=1715083218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPbeNwFFvVQVTt9kBGbVaBibbnkr7+pEiNl32W3+iws=;
        b=ba+7QbbexsIKB+8fROQMoN4OGMeoZN7E75eCeKhcTSMMcgY/M8V3pYDK6VNv7Am1Rp
         Ot/G26gYr1JBRoA9S2JIut0wE7gbrd8UxlIP7FpFOrgW+dvQcIg0QeGA4r4Wjhu2NPVR
         oo6IvG/cD1N5L6cGcohOCsrFYUWT8sG9n7cM3O8JN/Upqhne5Ik42PRz76o1GH/g/+R9
         d1r97DRf7beVfmECX01EOiMt/puuz3litPYAfeoKGoKxbSK6KjRd7Jh0WDl3ozx0+8Se
         asNYqQp2lB5IuhZf9J3ydgoFjvU4SSa9gpdAPznvTk03aDbLxoTeGW0A/aSR4v+SCQqU
         hvgw==
X-Forwarded-Encrypted: i=1; AJvYcCUHu7bDI5CwE7kDGsSQUAyX9TfQcJZzd0VD43XtnTAjSJzQ46h25qsxKGrs46oZq7kVXJZW3dS+KJdsMTZt40XMvtYIps8EBv5kYMaS6nU=
X-Gm-Message-State: AOJu0YwXeSqaFln4iUFKHRk1NLwHnMdRN0rv/21gQWDBOEQsqDz2wYnz
	w05DVsnz+zDRowEHqe2GWe/AP9VS+snTCgAPVAhBDb8PRZYVrcxjQHyDsw==
X-Google-Smtp-Source: AGHT+IHCvPZ4QhLNmWzO2EUJcP6+Q/VtFAhLnOAnwsswtmMF7vi8CXelylUavq4zKECCmZY0HPqn+A==
X-Received: by 2002:a05:600c:4f05:b0:419:f241:6336 with SMTP id l5-20020a05600c4f0500b00419f2416336mr9436889wmq.1.1714478418528;
        Tue, 30 Apr 2024 05:00:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0041be78ae1f0sm11919724wmq.2.2024.04.30.05.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:00:18 -0700 (PDT)
Message-ID: <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
Date: Tue, 30 Apr 2024 15:00:17 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_050021_536439_73444942 
X-CRM114-Status: GOOD (  18.55  )
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



On 29/04/2024 2:58, Shinichiro Kawasaki wrote:
> On Apr 28, 2024 / 16:12, Sagi Grimberg wrote:
>>
>> On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
>>> On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
>>>> On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
>>>>> Enable repeated test runs for the listed test cases for
>>>>> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
>>>>> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
>>>>> so that the test cases are repeated for listed conditions in
>>>>> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>>>>>
>>>>> The default values of NVMET_BLKDEV_TYPES is (device file). With this
>>>>> default set up, each of the listed test cases are run twice. The second
>>>>> runs of the test cases for 'file' blkdev type do exact same test as
>>>>> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>>>>>
>>>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>> ---
>>>>>     tests/nvme/006 | 2 +-
>>>>>     tests/nvme/008 | 2 +-
>>>>>     tests/nvme/010 | 2 +-
>>>>>     tests/nvme/012 | 2 +-
>>>>>     tests/nvme/014 | 2 +-
>>>>>     tests/nvme/019 | 2 +-
>>>>>     tests/nvme/023 | 2 +-
>>>>>     7 files changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/tests/nvme/006 b/tests/nvme/006
>>>>> index ff0a9eb..c543b40 100755
>>>>> --- a/tests/nvme/006
>>>>> +++ b/tests/nvme/006
>>>>> @@ -16,7 +16,7 @@ requires() {
>>>>>     }
>>>>>     set_conditions() {
>>>>> -	_set_nvme_trtype "$@"
>>>>> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
>>>> Why not calling separate functions? having func do_a_and_b interface is not
>>>> great.
>>> In this case, we want to repeat the test cases to cover combination of two
>>> conditions: M trtypes and N blkdev_types. The test case should be repeated to
>>> cover all of M x N matrix elements, then the hook set_conditions() should
>>> iterate the elements. I can not think of the way to handle this iteration with
>>> separated two functions.
>> What happens when you add another condition to iterate against, you
>> introduce set_a_and_b_and_c interface?
> That is my current intent.

I don't think its very maintainable.

>
> Another question is how it is likely to have more conditions to add on.

I expect that people will want to add more flavors moving forward. For 
example
ADDRESS_FAMILIES="ipv4 ipv6" RDMA_TRANSPORT="siw rxe" and possibly other
features that can grow in the future.


>   I guess
> such many, multiplied conditions will result in combination explosion and long
> test runtime, so I'm not sure how much it will be useful.

I think that running multiple flavors of a test suite is a capability 
that is bound to be
reused as more test flavors emerge. But that may be just my opinion.

>
> Do we have potential candidates of the third or fourth conditions?

Yes, see above.

