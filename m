Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C304CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/hDU5t/SYe5V0/3VS5pxCEmSkWFDNtQGXEw7qwTLNo=; b=FriU68L5fxd/VkPjFiQmBs41gJ
	mDgvJWoKjdI8PC/fzahLOo9ZxVUQu9Sbc5MiiinDVqbJst++r1N1vMWwtn300RdtVeB0JQlmABZP2
	F7El4bV4p5jO89gAQclPG+S1vt4ApbHAWhmPNeZe9HxVlbMMyFLGQKyT58KF8HqjAEdpVXgysOP1y
	SXX5l3oYyc74zOYOtU3dWu6SbOt8bHTTxUKA0qBKHEdrP4v7ELYr2oB98QWgAGXR45WUiGnur/L8f
	JjjS1ifgacIvbsy+1cFpveafL4vUGKzrhbSKNGhnsxqkB5uzsi70VZzXXlBfweA9j1jz7A1U+Op2f
	tDt63e8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbJE-003Rdy-Kb; Wed, 13 Jul 2022 12:17:40 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbJB-003RZE-NW
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 12:17:39 +0000
Received: by mail-wr1-f45.google.com with SMTP id r10so9087970wrv.4
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 05:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F/hDU5t/SYe5V0/3VS5pxCEmSkWFDNtQGXEw7qwTLNo=;
        b=5QiQOAbX4FV0qBvBBYPU7WJhjmpbkPtgJXPWEYCAqX1ivEdjlBQhoPfn6jZeHNjN6d
         Mm6A0hZgrgYrzfqCaPLdAjW81Wji6kLbATeHCkDaFqN+0iNhOQFvkZGAq5PO1Pp2/2Y+
         6mjb6eYAIJW8p/I4HXEOBjvHQZ7g1FCOGxBvpjus2dMt5TcYgK2BSViZj13xTkxG9n7z
         Vl1bkl9t5kujh2XlanyLz/DHPuTde49cI8s+8sFGqewkqvMa4QQZZQXmwljtupS3via0
         5dnx6XSC+s2h0U7stYd1eFYvuIMks2JLscH5Y8jK1pTkj94o4kmmMFo0qVXGK10SIESW
         vC5g==
X-Gm-Message-State: AJIora+KGkP36HlMAQZ34qmQ6XanZPpb2LCbXc3To4D0eFoMf56Sylcb
	mPSYkQGQLrfe571SuK4/5Sg=
X-Google-Smtp-Source: AGRyM1tAELyc3EL80IJoRz+3GsaLhUTzyAc4LlhFA9oAzjwelcEYV2FL/crE4onZIaPYOe0ifaiCCQ==
X-Received: by 2002:a5d:5983:0:b0:21d:a811:3b41 with SMTP id n3-20020a5d5983000000b0021da8113b41mr2821809wri.441.1657714653787;
        Wed, 13 Jul 2022 05:17:33 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb4b000000b0021a34023ca3sm10852773wrs.62.2022.07.13.05.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:17:33 -0700 (PDT)
Message-ID: <474e9b28-033d-f951-b79b-45db31c2129b@grimberg.me>
Date: Wed, 13 Jul 2022 15:17:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
 <20220711183746.GA20562@test-zns>
 <5f30c7de-03b1-768a-d44f-594ed2d1dc75@grimberg.me>
 <20220712042332.GA14780@test-zns>
 <3a2b281b-793b-b8ad-6a27-138c89a46fac@grimberg.me>
 <20220713053757.GA15022@test-zns>
 <f15bc945-8192-c10e-70d8-9946ae2969ce@grimberg.me>
 <20220713112850.GD30733@test-zns>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713112850.GD30733@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_051737_794477_85D0092D 
X-CRM114-Status: GOOD (  18.60  )
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


>>>> However io_kiocb is less
>>>> constrained, and could be used as a context to hold such a space.
>>>>
>>>> Even if it is undesired to have io_kiocb be passed to uring_cmd(), it
>>>> can still hold a driver specific space paired with a helper to 
>>>> obtain it
>>>> (i.e. something like io_uring_cmd_to_driver_ctx(ioucmd) ). Then if the
>>>> space is pre-allocated it is only a small memory copy for a stable copy
>>>> that would allow a saner failover design.
>>>
>>> I am thinking along the same lines, but it's not about few bytes of
>>> space rather we need 80 (72 to be precise). Will think more, but
>>> these 72 bytes really stand tall in front of my optimism.
>>
>> You don't have to populate this space on every I/O, you can just
>> populate it when there is no usable path and when you failover a
>> request...
> 
> Getting the space and when/how to populate it - related but diferent
> topics in this context.
> 
> It is about the lifetime of SQE which is valid only for the first
> submission. If we don't make the command stable at that point, we don't
> have another chance. And that is exactly what happens for failover.
> Since we know IO is failed only when it fails, but by that time
> original passthrough-command is gone out of hand. I think if we somehow
> get the space (preallocated), it is ok to copy to command for every IO
> in mpath case.

Yea you're right. you need to populate it as soon as you queue the
uring command.

