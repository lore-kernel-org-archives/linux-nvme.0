Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0U5+IilDXsW3BQxwBvuwuzwwHS2jIXKuQyNc4QZoJgE=; b=1DkxYLGDpvkn8w9w4vAeVItp9J
	tfRnsvWnp5a88dVghhgRL5epC597GqL0HkzdYGCxc4D/f4jXI3WgvaYXFrYKNr4TOXfoJiedlpnSc
	QhAhkQWNP2Fnc8Se02MHt6EJ60aFnEQh27hIDXW5kaQ8PWVILyPYcEqODrW3h3H3xkckqZvnpfZlA
	I7Jw/hlXDdWLK7X5+INVI4PvJTRwe6Twxlrj8JG94ae0n0V/YBnYWVnFP7bnnNmoQB4L+0pN9CFi7
	LtfT6EHBqGocDH9GWBVvZzyV16unGD4cHNLg4kNjienx46oMTjgiN7tDgMQJAybVA1wetzTpNo4Kj
	SqlfZc5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAwje-003Mio-QA; Mon, 11 Jul 2022 16:58:14 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAwjc-003MgZ-Jh
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 16:58:14 +0000
Received: by mail-wm1-f54.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3818459wma.2
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 09:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0U5+IilDXsW3BQxwBvuwuzwwHS2jIXKuQyNc4QZoJgE=;
        b=CLXlMllH/c6KW4Y3EOoANDSEyA88xkq9+xvtr1dwMKQ/aQWgFYyL9kcBUaLZMpTeJF
         AGdjgqOaErWpEXKquTI42nIxixPqMMNggNzBj/ezkHOF4AjRdHZt7qTp4N0Egiy3g6hL
         a5Nxc56Vy4irsDo8vWUTGOP1E8+Z+eye9ODAkXkQ//dS6styTnqIt1jfedw+eWsCWdP9
         oIvqL/OEV2pihU4WGP9yepjprxaV3ZfNV0TGMNki2qNsVjfZOSptMAZOXYmzICSwufJb
         Rs2y9GLwjcxkw+rvFP0SGmTkpigSMNbLVPC0AnedTKdGldj3t3z7KZ0ow7zRnZlNuaEi
         cZZA==
X-Gm-Message-State: AJIora8Lt163YHtJEZmkdFZXZJdl+AwOfllfB/Y6i0TXMGXAuzCrk2+x
	5oKRsI4vnIN6gDX1eebw49k=
X-Google-Smtp-Source: AGRyM1tDTW2pN9aXI0tb3raSr2YbZRwwOSx9Vn1KdSvNg5gxK9sQ5xn3fSv9QJoTVdTn9JzqblCltg==
X-Received: by 2002:a7b:cb07:0:b0:3a2:e524:4117 with SMTP id u7-20020a7bcb07000000b003a2e5244117mr9881392wmj.54.1657558690142;
        Mon, 11 Jul 2022 09:58:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003a2e7c13a3asm3450777wml.42.2022.07.11.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:58:09 -0700 (PDT)
Message-ID: <2dde0a5b-e4ce-dd44-0f4b-661c860dd5bd@grimberg.me>
Date: Mon, 11 Jul 2022 19:58:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Stefan Metzmacher <metze@samba.org>, Kanchan Joshi <joshi.k@samsung.com>,
 hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
 <5c71b8f6-afec-8ef6-0a70-d13e71ded79c@samba.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5c71b8f6-afec-8ef6-0a70-d13e71ded79c@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_095812_659748_5EA95326 
X-CRM114-Status: GOOD (  10.55  )
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


>>> +static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
>>> +        struct io_uring_cmd *ioucmd)
>>> +{
> 
> Shouldn't we have a BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > 
> sizeof(ioucmd->pdu));
> here?

Probably...

>>> +    return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
>>> +}
>>> +
> 
>>> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>>> index d734599cbcd7..57f4dfc83316 100644
>>> --- a/include/linux/io_uring.h
>>> +++ b/include/linux/io_uring.h
>>> @@ -15,6 +15,8 @@ enum io_uring_cmd_flags {
>>>       IO_URING_F_SQE128        = 4,
>>>       IO_URING_F_CQE32        = 8,
>>>       IO_URING_F_IOPOLL        = 16,
>>> +    /* to indicate that it is a MPATH req*/
>>> +    IO_URING_F_MPATH        = 32,
> 
> Isn't that nvme specific? If so I don't think it belongs in io_uring.h 
> at all...

Yes, it doesn't, it should be completely internal to nvme.

