Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihidgXYB4xhjPn48/H5XkAMtFgyfgQGRP//jjSqAZfI=; b=DErRgCW9rGnU2SFGrJvhwunU7h
	a+6ebqpDq906bxR/fF7NH3zA8YqScUTrP39plJQTlA5eUvGbtkJvgvheZjx/gZYv6w+vHSpOf0+kG
	DjW84h+NXc2f1+0bqNdfm/Q38hY5L0/RIVlO2+FRG7lLtNx6cYKL+et2c06tM4YoapjthCY/qZuCs
	7P1mkwY8W0rAPacBpYpJ6fAlc3hTwJvkkERYTuIooa0C/xDkh65aLMkTHi3ZAmeEGGUp826uvLAJ1
	Z86gFACBqPp5zAATXQUsrXTSqZRa259Lo3dGZKSPKGV1zc3sZkuxGHVsr38NvSUnw866/gBFttj0y
	Z5zLU5oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmxmg-003Mfv-ES; Fri, 06 May 2022 13:14:14 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmxmb-003Met-Be
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 13:14:13 +0000
Received: by mail-pf1-x42b.google.com with SMTP id x23so6218002pff.9
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ihidgXYB4xhjPn48/H5XkAMtFgyfgQGRP//jjSqAZfI=;
 b=7mtkz5L+M6CyMpuvSrwmf/po6soshccZkNmunBuH8V68CckpXuXwnPczrcP8Zarrqw
 wlEISzVXGgr3lE/+qnQXce9zh/MWgauJ09HVHypP+wQ+ZKlUWGWQV20qtf3E9eaHM4uO
 itgDW03k+VhpYeAx8L8yDX2zfAPjjRO4XstYqMvOCX1LFKn61uSiYRa55ZgnEh0BYsef
 4F098W0akvQnlNELLFIWuPxCghX8RToOcCzZALCu9LUy4UA5cisgcnmBiKxGtaNUAnFB
 1q0iZr9MOaZoYUOsZh8dqSC28pA2VuCPCQRuPD+SBAzj2LbwDPrrzpLvi6o13jp0gKwq
 TqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ihidgXYB4xhjPn48/H5XkAMtFgyfgQGRP//jjSqAZfI=;
 b=dqhoYRLrZmxJTkSYrmYd5oIlGcrQIwWP5+pxTA4/YKgXCSQERZK3NgOJGLMjVXHupv
 bqyieZp+fU0iYQIpF8lEavJ8TU6qoBJmbzznlln0BKezUqGiIxkoc6L67eIWiOc/Z99L
 kiw13EYL4EyfXP+CWxkvvY+tqMUQp6ca1ZhsbFxjmURlixTGY1bGu9goedGmoQFCPrf7
 9pWi9ckEWmW+c1uQkDB2UZaN626lop3zLvgezaQLAskvlP3nO9TOuqQGQZ78ILvCA/UG
 36HXW2utihBYRnSr+WVBnLWPTywoBayNv0wsxDXpEU852Cfbn2sOAFsCxJuSmPDw8mvy
 52pg==
X-Gm-Message-State: AOAM530DZ/7NBxnQzLq+8waJSnkhT4a2Qa0uGLFE5JTgXMWNiLgn4HI4
 vfyRUqqTcflvrKgdngSxkZrqsw==
X-Google-Smtp-Source: ABdhPJxbgh99Uq2Q8nb4hWzt4D5dqalKDU8yUhhAXreQdsMJpNz9gHsObYxtOvni+z64QBRJbROaeA==
X-Received: by 2002:a05:6a00:1784:b0:50d:d8cb:7a4f with SMTP id
 s4-20020a056a00178400b0050dd8cb7a4fmr3481979pfg.23.1651842844406; 
 Fri, 06 May 2022 06:14:04 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa783c8000000b0050dc762818asm3322528pfn.100.2022.05.06.06.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 06:14:03 -0700 (PDT)
Message-ID: <ac5bc77c-16a3-77b6-df57-823e16c89a70@kernel.dk>
Date: Fri, 6 May 2022 07:14:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
 <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
 <a715cc61-97e7-2292-ec7d-59389b00e779@kernel.dk>
 <20220506064249.GA20217@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220506064249.GA20217@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_061409_673541_2BC966D2 
X-CRM114-Status: GOOD (  24.02  )
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

On 5/6/22 12:42 AM, Kanchan Joshi wrote:
> On Thu, May 05, 2022 at 12:29:27PM -0600, Jens Axboe wrote:
>> On 5/5/22 12:20 PM, Jens Axboe wrote:
>>> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
>>>> This iteration is against io_uring-big-sqe brach (linux-block).
>>>> On top of a739b2354 ("io_uring: enable CQE32").
>>>>
>>>> fio testing branch:
>>>> https://protect2.fireeye.com/v1/url?k=b0d23f72-d1592a52-b0d3b43d-74fe485fb347-02541f801e3b5f5f&q=1&e=ef4bb07a-7707-4854-819c-98abcabb5d2d&u=https%3A%2F%2Fgithub.com%2Fjoshkan%2Ffio%2Ftree%2Fbig-cqe-pt.v4
>>>
>>> I folded in the suggested changes, the branch is here:
>>>
>>> https://protect2.fireeye.com/v1/url?k=40e9c3d0-2162d6f0-40e8489f-74fe485fb347-f8e801be1f796980&q=1&e=ef4bb07a-7707-4854-819c-98abcabb5d2d&u=https%3A%2F%2Fgit.kernel.dk%2Fcgit%2Flinux-block%2Flog%2F%3Fh%3Dfor-5.19%2Fio_uring-passthrough
>>>
>>> I'll try and run the fio test branch, but please take a look and see what
>>> you think.
>>
>> Tested that fio branch and it works for me with what I had pushed out.
>> Also tested explicit deferral of requests.
> 
> Thanks for sorting everything out! I could test this out now only :-(
> Fio scripts ran fine (post refreshing SQE128/CQE32 flag values;repushed fio).
> 
> I think these two changes are needed in your branch:
> 
> 1. since uring-cmd can be without large-cqe, we need to add that
> condition in io_uring_cmd_done(). This change in patch 1 -
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 884f40f51536..c24469564ebc 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -4938,7 +4938,10 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2)
> 
>        if (ret < 0)
>                req_set_fail(req);
> -       __io_req_complete32(req, 0, ret, 0, res2, 0);
> +       if (req->ctx->flags & IORING_SETUP_CQE32)
> +               __io_req_complete32(req, 0, ret, 0, res2, 0);
> +       else
> +               io_req_complete(req, ret);
> }
> EXPORT_SYMBOL_GPL(io_uring_cmd_done);

Ah yes, good catch, I missed that it's cqe32 exclusive right now.

> 2. In the commit-message of patch 1, we should delete last line.
> i.e.
> "This operation can be issued only on the ring that is
> setup with both IORING_SETUP_SQE128 and IORING_SETUP_CQE32 flags."
> 
> And/or we can move this commit-message of patch 4.

I killed the line.

> You can either take these changes in, or I can respin the series. LMK.

I folded it in and will process Christoph's suggestions.

-- 
Jens Axboe


