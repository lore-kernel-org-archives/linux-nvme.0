Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E1C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yxk3OoqOIYK6tbonnABg1r4S+gFYgUI69hhcj/FUe8E=; b=1cw8/zJ4I/RtKkNuetJlR4D3l0
	vHc/nYeoHmQpI5linbzb6wDyrNn/R9SfQ8ulZO/VOMrythlT+YXoAToinpQAj0arQaKM535LIlijQ
	zml6zj00FFoPBjAMnT8dDpi8a0KKRSnHuu1p98qtitK9T5KYOtah/YJbVJ19VfGsGyJZ5xODNas92
	q1zxXf0E7iAqy724g7GGgLq8K8n9LyoPtEmYEpFseYNFXlPwrLu3z9BScwQjnzkNiQNhoVe+OZnbt
	4DN2dPRIfvnDsV8Jbii7p89z0pY2qJRZYB5ek7/Nauuo6/GykJlbrHKVzxZoY5mbyyEZwseTQziIq
	F9TjBAKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP2gG-00000007bsS-3oBU;
	Tue, 10 Jun 2025 17:22:36 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOzyp-0000000788Q-0PV1
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 14:29:36 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2910602f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 07:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749565773; x=1750170573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxk3OoqOIYK6tbonnABg1r4S+gFYgUI69hhcj/FUe8E=;
        b=OP1tvlqTGPLLvo1p7evHiIgA7OCsCaiDGRg4zPVPnBImzv8xEEvTNYTTbqlZArJFP0
         CvkpaksPZZQKsDPGBQOu1kckBjd4FxSKXg6ahVcWfz8i8m/rZfZuhnThXUVtsSi/mJjd
         phDh6PnpKTTCSTkyNofGmDNwgSouvSke+4R09EJZjhZg4BZvWImUYg0Mk5tXs4iFpdGN
         xfpqA8iLLQlrf06VsoryBs3dslEAjmazqyxUHMdAas+6Ulm7R9G9a5eHAd9F9Kv8O/6X
         7v6GfkHGqr6Ln1CzsO9F6dorvgDAGzors8mgrsGL+lRy8DKfdBw2B5XHM/nrsuZTdY3l
         i8kA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Csm9iJ8AhHyKqf+AqWvVK5c4JsxzdecCsWmLnINb3tU+PtGRmB8YogA9tK8ZxhkIp36Of6mrMyis@lists.infradead.org
X-Gm-Message-State: AOJu0YxoS+FHiN6HrmZa/cP+dx7+ogCJwxU239H3eNBr+9XZ0YYLgoHN
	ceZJBy5ZRvhXX0e57ZRl1QFnTmvURaHa1bQh7v+ehQsmBjU5vniNaAMnSsxv6g==
X-Gm-Gg: ASbGncteCYM/gBNxXITjCWvPO0aS5iOToZZPpuvepKNEnFMUqIWkwHVdlotOVQ4Qgxw
	d/3GanbSUyHrg3xekaaU5lgKSoVgYOl+n5L+Ao0xTR9WbeelSy8z2NR5kQkIe/9YR4j7iLIv/PZ
	6IKCGFBP0H77SRCt2Z6kjI5by+aXoq0PO3BBWnGs+1C9ilZhnSjMaRsvHIBQ/JIav81mpH9ITEF
	E2q/YhZZGX3kl6mQljyMZaaexdPlCjmo6xEPVdqKU1EGDcjR0XRL4tGsibT/TtI+nNhIDyFan3F
	cOOruWjmJNWKDtyjt6E8IEaO96M9sK8h0+2EEJqQArohYD3yO8nsiOxp6PNem+Fbgy1UE8RZtwf
	g7NTVkGpnFGqTPSoqL1fa5PmF5bnq
X-Google-Smtp-Source: AGHT+IEpKB9vaN2fJmNQTRiYjABSeQOdtNguzkqTLzY2m8/8lsGlbBkvtEN0zyv61y+32plFxr3+Wg==
X-Received: by 2002:a05:6000:2c11:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3a531ca6a4emr14593398f8f.56.1749565772827;
        Tue, 10 Jun 2025 07:29:32 -0700 (PDT)
Received: from [10.50.4.239] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b59d0sm12581611f8f.38.2025.06.10.07.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 07:29:32 -0700 (PDT)
Message-ID: <d2ca6b0e-6a76-455d-be90-9e7527e33062@grimberg.me>
Date: Tue, 10 Jun 2025 17:29:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, linux-nvme@lists.infradead.org, zhang.guanghui@cestc.cn,
 loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
 <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
 <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
 <DAIV77646KWY.3QL4ZL1IH2630@bsdbackstore.eu>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DAIV77646KWY.3QL4ZL1IH2630@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_072935_144972_730325C4 
X-CRM114-Status: GOOD (  12.21  )
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



On 10/06/2025 15:50, Maurizio Lombardi wrote:
> On Fri Apr 18, 2025 at 1:14 PM CEST, Sagi Grimberg wrote:
>>
>> On 4/17/25 16:04, Maurizio Lombardi wrote:
>>> On Mon Apr 14, 2025 at 11:35 PM CEST, Sagi Grimberg wrote:
>>>> I see the issue, but we need to make sure that if the connection closes
>>>> before
>>>> the controller finished establishing, then it cleans up correctly.
>>>> Because at some
>>>> point in the past - it wasn't the case. Things have changed in that path
>>>> so it might
>>>> be ok now... Just need to check. I'd trigger the race while the admin
>>>> queue is establishing, as well
>>>> as in the middle of the sequence of IO queues are establishing.
>>> I believe my earlier testing for this patch already covered this scenario,
>>> but I can rerun the tests to confirm and report back.
>> So you indeed made sure that the failure starts sporadically in the
>> controller establishment sequence
>> and there is no use-after-free issue?
> Sorry for the long wait; I am now back at it.
> I repeated the tests using a debug kernel, and nothing has been detected.

OK, then lets get it merged.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

