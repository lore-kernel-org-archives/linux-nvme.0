Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6DEC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z5h98asAviTsgox7FrNAfOD5W+jbBJwdVEYAEoeHiOU=; b=1l5bdpfEsopASuy2RCSSqyhDmS
	RBratos2b1d9YsvdYQuU78RuMaeId1+zcAbFf0YZAD38f19G5rSBru4sGr2ptx7F8r4qY2Q0oDTvW
	7b14EnECheJ8wwZgVX3djgOgEHAqG44CeY3Ti9pTsj+ihBmjMjGm4taiTWvMaxomHkba0ZLjcBmjx
	suAfFkqx5qOc7Q+JqxTP8z2JX+sCPXRnwpPIfZjmLv32GRSFCYV7BkXALuldiY9C3xV8habrMeImX
	PBrncxWIcJRnaByDAaLMPfrugRWlGGXNl5dpi3EF+d4X9oKLQ+3EupMFYbZDic0YhqooGoeBpKk1q
	SCoYQpAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAy5R-003pzt-UE; Mon, 11 Jul 2022 18:24:49 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAy5P-003px6-4t
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 18:24:48 +0000
Received: by mail-io1-xd2e.google.com with SMTP id h200so5690225iof.9
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z5h98asAviTsgox7FrNAfOD5W+jbBJwdVEYAEoeHiOU=;
        b=uKF7ARNiK2yhXk78RqwF9dIBQUUgi/K++tRmFiHfMCl6ho5oxLfNu/XJSmdsnbs5Uc
         vs4p4uGROfJ83bVKzshZUi275Yht1gTiImT8NVM5cGdr1ZFjjAmC+DV3wJHPvqyfMHt1
         KfX87DGYsQafD3VUik3A1YlHBrFG6sAbnIncfzK4bem/g8nRJgKJtkW69SKmQDV9ah6f
         bqBZ2N5fwGFXLv/ernuxFTqNcCfcX5D7Ea9pkzWQM8T2DLuo/f+iNcsBiUyKrBI0GAqP
         RW9rgPBzCIomVbjvKtfJQgTvKwo9u6XKmVxUIwSAQO2htjtCpAX89YBCHzwA4sxnodnY
         u3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z5h98asAviTsgox7FrNAfOD5W+jbBJwdVEYAEoeHiOU=;
        b=rnIdhsfEgsPoU9T8rJI/dAin8BrjsjnRZJxIO7PntFJ++qC6qRnY/UwCqcT5Wbcjq3
         Xu9dTbn5BVj+YUbVMG6KG1fAjXMbGThG4qJ/6K0PhgNk7FB8vn5o2SvpyvGJA6u+rgBc
         w9POIsx5DA0DUCpXXQSOreAXRrCOF7qC0y6SMrYT7pQUvgLcrVftqgx1KYvsbsYxiEdH
         SwQIuY4wZi5AGsNbVEwUZ18jKZs8eaa2+gfJJBYNCy9+oJjjZ9sA5ccjBgQpL/PzKI/v
         gOHXec6M6JAFx4c3aHa3I01v+Fn0c25Q6b3Kc36dHSYybayBGkjk4tDwUjoUJzT19rKx
         0jKg==
X-Gm-Message-State: AJIora/rA/uTt7IsOw5PrpwTG/95ggOTCVO0dI0yo2LFaJ5LZpjRQY2N
	HPHmSJGod0bVTdd0sHiv9KFz3Q==
X-Google-Smtp-Source: AGRyM1t+fqlUsfNSDzwk3ZkCWeIF6sarX69ZJp7fa7jQjkhx5B7+S4naLX97nZzjMJootHnA/lSzsw==
X-Received: by 2002:a05:6602:29d0:b0:669:1723:c249 with SMTP id z16-20020a05660229d000b006691723c249mr10314526ioq.208.1657563883999;
        Mon, 11 Jul 2022 11:24:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f1-20020a02a101000000b0033f3b201d1dsm3168416jag.21.2022.07.11.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:24:43 -0700 (PDT)
Message-ID: <7fb16d2a-21f4-3380-75f3-c8e8c08fd318@kernel.dk>
Date: Mon, 11 Jul 2022 12:24:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_112447_258467_C44AC9E3 
X-CRM114-Status: GOOD (  18.98  )
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

On 7/11/22 12:22 PM, Sagi Grimberg wrote:
> 
>>>> Use the leftover space to carve 'next' field that enables linking of
>>>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>>>
>>>> This is in preparation to support nvme-mulitpath, allowing multiple
>>>> uring passthrough commands to be queued.
>>>
>>> It's not clear to me why we need linking at that level?
>>
>> I think the attempt is to allow something like blk_steal_bios that
>> nvme leverages for io_uring_cmd(s).
> 
> I'll rephrase because now that I read it, I think my phrasing is
> confusing.
> 
> I think the attempt is to allow something like blk_steal_bios that
> nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
> to be linked in a requeue_list.

I see. I wonder if there's some other way we can accomplish that, so we
don't have to shrink the current space. io_kiocb already support
linking, so seems like that should be workable.

>> nvme failover steals all the bios from requests that fail (and should
>> failover) and puts them on a requeue list, and then schedules
>> a work that takes these bios one-by-one and submits them on a different
>> bottom namespace (see nvme_failover_req/nvme_requeue_work).
> 
> Maybe if io_kiocb could exposed to nvme, and it had some generic space
> that nvme could use, that would work as well...

It will be more exposed in 5.20, but passthrough is already using the
per-op allotted space in the io_kiocb. But as mentioned above, there's
already linking support between io_kiocbs, and that is likely what
should be used here too.

-- 
Jens Axboe


