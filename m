Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C6BD6ED2A
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UcEid6x7hR6WD3NnjxTjV+SHdDeh2G3crDRCwr0C4Xw=; b=Mxsha3BsiPRxeN6zQZ0BnqGpmD
	zLlHuruVzYdV227+bT8aoJtH2rn4dvedW2Goo8sfVaUSCHmQVH+PK/pNyKkZNudp0NHswUyEhe0Tl
	Nad0bZfGOhlax1oHjpz3VKJMsEpyGUH49g35aRMQvVsnNEF/ffVLaF9SQpMV1cel8PdxYmmvxfN3T
	uFgqXVKyMi9uybowamkUZQlWu4P1Lt/Q/9dYVIIphRzaP1PYjJD4J1yD1xEZ7ulc5Cgy47nRor12s
	y6zF9CFc9axiupRhrGim2oWQixRUGESOPkDzQHY2mWF2e8OuI9xniDZIzYwPvdVZiLWCCm0pOGz58
	PrDXGA/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7EJ-0000000073X-00ZR;
	Thu, 21 Nov 2024 13:28:19 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7EG-00000000739-15Qc
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 13:28:17 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a9ec267b879so157433666b.2
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 05:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732195694; x=1732800494; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcEid6x7hR6WD3NnjxTjV+SHdDeh2G3crDRCwr0C4Xw=;
        b=DwnV3spNhgKwJsW9RUSNYSIq1hkFsHwiaKU5l2aT8jNkXvnQNC0JWEnfSn7QQCSsp7
         lo0EIWNKYIGrYc7e0UOQFsfdenh8oENa7Yu7AT9MaKd2qs1gzzl57u1lp13ohBe4h9ZB
         qqAQ5+irdOWwIbuBhAY972y+2tbj4fjrgJESeTYphKtdWZN7rtK/W9yrYsWSOa/cuY8B
         cZQdym+jssTy4T34+JqfXRyslpHeGEm4TouhwzZnYsR8zzzocJqUdbYCChwfqy9oWB1F
         2FDVo6WU+oAeRyihPdfEPrrkMVJjqco71y/5PNequ6IMu/aWZV6w6s2jSD82ArJ1LmMy
         yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732195694; x=1732800494;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcEid6x7hR6WD3NnjxTjV+SHdDeh2G3crDRCwr0C4Xw=;
        b=V/BJBtz7X79QCAbzB2Pk1Xr8k9IJ6qK9y2iEMu8d7jSjVXsWran8dWG7vOZK25rUAT
         qdSm1gbbM9iOe+gVDXjLYgZJ4Rq3wJf4mG6n0qPcSU6NkjEYcKZQC5HCAdxx5wT0NMe9
         623LadpfUVWaXxWKu2beUkkxXevDXx06aFKYOYe0JJDWTwUTj5Z1HGhX14SsLnyw/jDs
         TgMKUNLjiOpftXxp/FB/nEbMEfIWwgqLimjYTj0iKoyRZ23j9W8O+bMyfwYf8A6hUs7v
         AwryC2C7G7DGcxQW/vMsSmuWSrgo7ym/gwHv5PwjT4kpaCde6LUh72NfLb2NBd5P+8Of
         GJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWfeCV6iR8I1RHu+OYZIxxmtAh2sEKdxmwggke9fUc/PUiAS7L48d/j+49wESmoe8Hc7WYzDHD1edtk@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1/z2vUSPs1IkXkYGlFru35Dq7qrboZx88N7WKiuXkv8Yc8pW+
	p2W582qDDw1tb5ttHIGzKDpGvdXNKLEj3Ub2IGpiWosy0tyaIm8y
X-Google-Smtp-Source: AGHT+IHecWvqkw6Jt2yCsp8YXvCsBLl3jZ1zTbBKU+p/+FeJdjUtQiX377sGWOz0S8T463Hv+SgYcg==
X-Received: by 2002:a17:907:703:b0:a99:f91e:4abb with SMTP id a640c23a62f3a-aa4dd57ba76mr569480466b.27.1732195693926;
        Thu, 21 Nov 2024 05:28:13 -0800 (PST)
Received: from [192.168.42.195] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d328dsm81636666b.109.2024.11.21.05.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 05:28:13 -0800 (PST)
Message-ID: <dfef87ff-175a-4387-9d51-9688e7edbcf6@gmail.com>
Date: Thu, 21 Nov 2024 13:29:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
 <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
 <20241118125029.GB27505@lst.de>
 <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
 <20241118170329.GA14956@lst.de>
 <4f5ef808-aef0-40dd-b3c8-c34977de58d2@gmail.com>
 <20241119124938.GA30988@lst.de>
Content-Language: en-US
In-Reply-To: <20241119124938.GA30988@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_052816_305959_774080EE 
X-CRM114-Status: GOOD (  11.63  )
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

On 11/19/24 12:49, Christoph Hellwig wrote:
> On Mon, Nov 18, 2024 at 05:45:02PM +0000, Pavel Begunkov wrote:
>> Exactly, _fast path_. PI-only handling is very simple, I don't buy
>> that "complicated". If we'd need to add more without an API expecting
>> that, that'll mean a yet another forest of never ending checks in the
>> fast path effecting all users.
> 
> Well, that's a good argument for a separate opcode for PI, or at least

No, it's not. Apart from full duplication I haven't seen any PI
implementation that doesn't add overhead to the io_uring read-write
path, which is ok, but pretending that dropping a new opcode solves
everything is ill advised.

And I hope there is no misunderstanding on the fact that there are
other criteria as well, and what's not explicitly mentioned is usually
common sense. For example, it's supposed to be correct and bug free
as well as maintainable.

> for a 128-byte write, isn't it?  I have real hard time trying to find
> a coherent line in your arguments.

When coming from invalid assumptions everything would seem incoherent.
And please, I'm not here to humour you, you can leave your crude
statements for yourself, it's getting old.

-- 
Pavel Begunkov

