Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A637C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2j3XSLAEiPG8zbDWGsooYqPI2DkCsxM8IRL9IlmyISo=; b=LDSIDQ1BsTPprSGzOMCP/yjKsn
	6raEZu3TZibuHSLbEUM3aNiIpqfz3K+0kNsLUnoVceYHVu8uug2g6ntBG3s99DLlxtTF1Jphhl+Wl
	r+IljR+uVmU42oa6csk4TPBo58sGyKh75I3szr7f6dew7nEtQ/dsyCGsjIK+vXdMqN5c+tvKAN+Db
	ZTghYoB5XzQE+lPFEm/0E/UB4Pk3HVCcQSApo5pqRORpmVR+S2D6qNZwBa65DAU/AOUYshaqkVhWa
	HDSpxm1A/DfwJOhrBTb/l4WXgs3R8MAE3Ho1a+pzE9MQp9tsSWF0rebcGA8lK84pBoieUXxI15UnZ
	Ya0GOJ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAybp-0043ee-TV; Mon, 11 Jul 2022 18:58:17 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAybn-0043az-Mz
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 18:58:17 +0000
Received: by mail-wr1-f45.google.com with SMTP id f2so8200838wrr.6
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 11:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2j3XSLAEiPG8zbDWGsooYqPI2DkCsxM8IRL9IlmyISo=;
        b=BapXocFIohz3i2b2s9IrSe9Q2XJCKBRsilgPQ242y7HDuesWWiLcB+oIdTzllMTx2E
         PhBVY4KUiYFLQtHTELurxG+cCpGrVUGGeYVOjGiAs1f069C4mLscbX/KR1gbZlCC3ZiC
         /hOteKjmTL4aOtzzBWlQNkZ90fSbynAgkSqtKxCs5MT7mdmvHPMXLS9I/uOmUJcW2+BK
         yly7DCULfs0EvNRN5QEDqaVXtzCzYcMzH9ODqPggRecwh5sf+b8NH+lEv2dPrnKkMFhs
         3Uv13Ziohn6b8sMuTi3g9BGB27xEM/KaMoFeg2gbsjMWMW3T1dIDkpqRZPFEu88qRAhF
         8FqQ==
X-Gm-Message-State: AJIora8ZFqsROvsAgNZW8ROgeD9ePwGkP3yrZFVsmjiqqSFmxco6lZQg
	8WKa4l3HYU6UA2u5r3k+dVk=
X-Google-Smtp-Source: AGRyM1uSN6+c9RwIsoZsZxFpEMndlkJzBtm/pGf9nH2yMuHqqVcX8CbL/p+gBklnUxsP/kRuIPQI2Q==
X-Received: by 2002:a5d:67c4:0:b0:21d:6d91:7b1a with SMTP id n4-20020a5d67c4000000b0021d6d917b1amr18384998wrw.313.1657565892805;
        Mon, 11 Jul 2022 11:58:12 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003a17ab4e7c8sm11109872wmp.39.2022.07.11.11.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:58:12 -0700 (PDT)
Message-ID: <28ccfab7-eb0f-c4fc-2bc2-fb1268cc844f@grimberg.me>
Date: Mon, 11 Jul 2022 21:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
 <7fb16d2a-21f4-3380-75f3-c8e8c08fd318@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7fb16d2a-21f4-3380-75f3-c8e8c08fd318@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_115815_779419_D4802745 
X-CRM114-Status: GOOD (  19.17  )
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


>>>>> Use the leftover space to carve 'next' field that enables linking of
>>>>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>>>>
>>>>> This is in preparation to support nvme-mulitpath, allowing multiple
>>>>> uring passthrough commands to be queued.
>>>>
>>>> It's not clear to me why we need linking at that level?
>>>
>>> I think the attempt is to allow something like blk_steal_bios that
>>> nvme leverages for io_uring_cmd(s).
>>
>> I'll rephrase because now that I read it, I think my phrasing is
>> confusing.
>>
>> I think the attempt is to allow something like blk_steal_bios that
>> nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
>> to be linked in a requeue_list.
> 
> I see. I wonder if there's some other way we can accomplish that, so we
> don't have to shrink the current space. io_kiocb already support
> linking, so seems like that should be workable.
> 
>>> nvme failover steals all the bios from requests that fail (and should
>>> failover) and puts them on a requeue list, and then schedules
>>> a work that takes these bios one-by-one and submits them on a different
>>> bottom namespace (see nvme_failover_req/nvme_requeue_work).
>>
>> Maybe if io_kiocb could exposed to nvme, and it had some generic space
>> that nvme could use, that would work as well...
> 
> It will be more exposed in 5.20, but passthrough is already using the
> per-op allotted space in the io_kiocb. But as mentioned above, there's
> already linking support between io_kiocbs, and that is likely what
> should be used here too.

Agree. I don't think there is an issue with passing uring_cmd() an
io_kiocb instead of a io_uring_cmd which is less space strict.

