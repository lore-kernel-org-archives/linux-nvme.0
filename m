Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F5EC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 01:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WUJvJb+3FVfie2XgWOKgUsJUKjqCaUKC6dD4Q84ceM=; b=gXckKPJQxKHCOoAMeHWpLXr8Y6
	DyurbR/WJOpZVqV0ZmmhlcjAPA2pm57j69ini4NrV98RrCIJha38yu1lrBUKHUT2a8EOOKD/uyD0P
	oY5dcMUxhaQLsUTylF7lET30lj0I+ACbgdspn0XQ/znecrOrRgTdrE/oVQKPsSNwFCH+TgSZ8TrKE
	ese8H92Hk4jsNMKZzNjXXMUDBjvs0bMY6sdqex5oDMSJRj/rs0U7fy/SW5KkuX5QHah9GqQl6OmfP
	2OiT+45NpSZzs9nH7/pSoh2LF2rR807mpUNDe7Sd2ZYhADQV9NsgNN6Peg4PptdaR8AqAK+IvVPxV
	wKA9rK8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWqGd-00CbSH-Cg; Wed, 23 Mar 2022 01:58:31 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWqGb-00CbRc-2q
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 01:58:30 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 m11-20020a17090a7f8b00b001beef6143a8so354595pjl.4
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=9WUJvJb+3FVfie2XgWOKgUsJUKjqCaUKC6dD4Q84ceM=;
 b=lYFWtQ+pAgnGgUlDOeVxj3+Yg0co3zUv0nBKpaLeh9d31qT/w6jqFpYzFuql2DSM0k
 v0/VtVUp+Rc5Y0j6XGKkRiZLe+xTKIeNJQuvIfG7bAAdFoRvaw6ozxrVYAexNXf4dcjp
 at3rOo26TM2vc5gU/pOWabL/BUp+zuRdLFWKy9NAnOyZ14PGWFPw6o/0Qug4CQxdGdSV
 J02tFzuvhB/x8+gOYnYgiRxy0D45Y2dcukrjc6NTJclXr7JmvtqAazbw0+cqmV89VCwt
 rbZYEUC2xdHsl8dcu5NN4ZPW7x77iiJLznGvl+Lyu/lRNm4OTDSs/XPeSLVQk/IBfqEq
 SCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=9WUJvJb+3FVfie2XgWOKgUsJUKjqCaUKC6dD4Q84ceM=;
 b=11qyf/658riNobfSNxd7qzV+mNBPLAbT3QJgABTtWdnzkxLT+COdgeIZmVCN/+tr9w
 fn1vCTI0uEdofOrJm6JGxD60PlWDow0Lo12PwSlCBqHyBnrVsUZBG/PzoxuaEfvLRKBg
 cPHpnJV5jjvCKLlT3i5zYzwnO4Z0yzX57o3BOAvIbdu5/gkX3IkekfyT0ccTVUbDnoWU
 1GxmazlvjDJPklJkcAmBSh1AxHLch8zVQ9JEsj/7VZOc7xWvqJgxf2oMv5AFuJdvttu0
 LgfHDbTenlk0NGIuwKRvpQ+l8KQku/V0lPtPKyV1azfh4aSISVo+LfLI2l+weX1kyhFj
 MWgw==
X-Gm-Message-State: AOAM531DpOW4+MTmwzWVSSrtr+FJcyS7S+HNnFBAhACCUWhOucQYfd2P
 H3ZOBhEGRrswhBv/cr896R9OAQ==
X-Google-Smtp-Source: ABdhPJywrahHnEK8IuzwOkAHcI26Q0uMh9Rkhe0HSiSKYX/CuWQet6iduiZxFq4TfrnKRIlzFCfdWg==
X-Received: by 2002:a17:902:c949:b0:154:5215:1db1 with SMTP id
 i9-20020a170902c94900b0015452151db1mr14117251pla.163.1648000708134; 
 Tue, 22 Mar 2022 18:58:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 a38-20020a056a001d2600b004f70d5e92basm24545979pfx.34.2022.03.22.18.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Mar 2022 18:58:27 -0700 (PDT)
Message-ID: <a1693c16-151e-60f0-ed8d-25e98dce57d4@kernel.dk>
Date: Tue, 22 Mar 2022 19:58:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Kanchan Joshi <joshi.k@samsung.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com>
 <20220310083400.GD26614@lst.de>
 <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
 <Yi9T9UBIz/Qfciok@T590> <20220321070208.GA5107@test-zns>
 <Yjp3dMxs764WEz6N@T590> <c7ce0850-0286-ec6b-2d68-20226e7bae16@kernel.dk>
In-Reply-To: <c7ce0850-0286-ec6b-2d68-20226e7bae16@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_185829_164336_7A84A3A7 
X-CRM114-Status: GOOD (  17.91  )
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

On 3/22/22 7:41 PM, Jens Axboe wrote:
> On 3/22/22 7:27 PM, Ming Lei wrote:
>> On Mon, Mar 21, 2022 at 12:32:08PM +0530, Kanchan Joshi wrote:
>>> On Mon, Mar 14, 2022 at 10:40:53PM +0800, Ming Lei wrote:
>>>> On Thu, Mar 10, 2022 at 06:10:08PM +0530, Kanchan Joshi wrote:
>>>>> On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>>>
>>>>>> On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
>>>>>>> From: Jens Axboe <axboe@kernel.dk>
>>>>>>>
>>>>>>> Add support to use plugging if it is enabled, else use default path.
>>>>>>
>>>>>> The subject and this comment don't really explain what is done, and
>>>>>> also don't mention at all why it is done.
>>>>>
>>>>> Missed out, will fix up. But plugging gave a very good hike to IOPS.
>>>>
>>>> But how does plugging improve IOPS here for passthrough request? Not
>>>> see plug->nr_ios is wired to data.nr_tags in blk_mq_alloc_request(),
>>>> which is called by nvme_submit_user_cmd().
>>>
>>> Yes, one tag at a time for each request, but none of the request gets
>>> dispatched and instead added to the plug. And when io_uring ends the
>>> plug, the whole batch gets dispatched via ->queue_rqs (otherwise it used
>>> to be via ->queue_rq, one request at a time).
>>>
>>> Only .plug impact looks like this on passthru-randread:
>>>
>>> KIOPS(depth_batch)  1_1    8_2    64_16    128_32
>>> Without plug        159    496     784      785
>>> With plug           159    525     991     1044
>>>
>>> Hope it does clarify.
>>
>> OK, thanks for your confirmation, then the improvement should be from
>> batch submission only.
>>
>> If cached request is enabled, I guess the number could be better.
> 
> Yes, my original test patch pre-dates being able to set a submit count,
> it would definitely help improve this case too. The current win is
> indeed just from being able to use ->queue_rqs() rather than single
> submit.

Actually that is already there through io_uring, nothing extra is
needed.

-- 
Jens Axboe


