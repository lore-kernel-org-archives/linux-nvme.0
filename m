Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49653CF6D28
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Ffvu2nWYd/TtMPhyD4YwqAbLAjDY47YPXg3w4lrVDA=; b=l9xFfSFfDardVeKFTbOYDb/lEq
	mjG6M8kea6Orrlu8j0MD+BZ6MF0RT87qND1kdyp+j0fUbHySvTTiMzLEDu5ODKUiv5a4dh6O8N+YG
	lYoMpB9sObT7AOXvMV8TZpAydvjZ8ArR+EoSIo+hUvznGafqXJHUIZcUjt1+fM1iw8bjiAKX0dB4T
	nL29FGfqARtI02EdWrn8ZW1HQwkEv/qxIaQsVEf8l++vjjFiCLyooqVN0vEW3BdOD9MG41OBBTBwX
	h3gtYRJUykzWlzdhFb2Oy+7LxYRa7oZ0+mOLrabqGu4WG7pJ8tf6Ow+9nPQkPXq1YL3oeWJNsU/bH
	jt4QmUIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0IQ-00000006NGy-404t;
	Wed, 02 Oct 2024 14:25:42 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0IK-00000006NGR-1KEY
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 14:25:37 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so1146843366b.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Oct 2024 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727879134; x=1728483934; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ffvu2nWYd/TtMPhyD4YwqAbLAjDY47YPXg3w4lrVDA=;
        b=eOpwR6yt8xezl3f0gadhjhLd4IGCyRwCPlFKag03Uwp+gRWuaF+YJ2ydAGvBqseiHy
         fYfoYkZJsycklJPji4/ffvGsRgQBDozkzkjn3APjavCRFNVau3v3x2AJTPeRzS2hrt5u
         s+qhtMnIWu1AKz1xn/yaIBL143pndJNhLpTsQXdC8971lTJ2WxlF/cFc3ZX/XJswUeZn
         2Yiiv/jdrZemzDAL4GGwlRKweguEBTxdgJ6PrIXHZ24Mtp4nieZqjR2GSN6w/l/Lyr3c
         3jG/eo9XBrtgDQ0XWJcTurPqoKiXpW0yK+nPjtM1qu1DWcoVH492YdJoyKvvAp92e2kH
         OX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879134; x=1728483934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ffvu2nWYd/TtMPhyD4YwqAbLAjDY47YPXg3w4lrVDA=;
        b=aeUpLMx0klkSiPLHSz+ffSqTrv64NJErYuzDkEMC+0Gqupn/GXxD5/vvzLo+nv0Fs5
         1Y6I9D9XSy5u5MdtcpeUjfUe98txfSQW2/wFJLZ6jYbZ4gyztG+IGyF9gZKVuyB4iO5X
         Jg0G3PhcjTmCwpU505YMScfhOai8twpCXpbc/aHoHnSXRLQUb3yW3U26nXZBbomHr/ES
         acWLz3D/KH2Xikzho+/a8UXsNPJwKxpdgqnsdN4GWyb38r9I6PTbAejxPW5vMLudpxwr
         JI0NNPDu7AM4SktfI3DLvmOBJES1YTqwf73fQYhPME6jBLN8xyxzeeXtpSYhvGcBc+ZM
         LyQw==
X-Gm-Message-State: AOJu0YyFxdAekqPobnrKYsJvXQ2pNSdUCV1Hr32m4Urt3QThCsGGUOhy
	j5iCri3Ms0vLqq5cB1/s6DMegzU/BPlkpTAlk/U6ckYZ5QtEZVb1
X-Google-Smtp-Source: AGHT+IFvPj+ATYZr1BExZ+QKBSVAPTglcZEJzhHNqX4Kf54MmKEy7qHf5bA10I/1t1JMjnnnPOz7jw==
X-Received: by 2002:a17:907:7ba8:b0:a8a:6c5d:63b2 with SMTP id a640c23a62f3a-a98f8245134mr302970566b.18.1727879133514;
        Wed, 02 Oct 2024 07:25:33 -0700 (PDT)
Received: from [192.168.42.109] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5b15sm870870366b.59.2024.10.02.07.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:25:33 -0700 (PDT)
Message-ID: <48c70b95-f0c9-44bc-8a3b-3010e8d682be@gmail.com>
Date: Wed, 2 Oct 2024 15:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] io_uring: enable per-io hinting capability
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240930181305.17286-1-joshi.k@samsung.com>
 <CGME20240930182103epcas5p4c9e91ca3cdf20e900b1425ae45fef81d@epcas5p4.samsung.com>
 <20240930181305.17286-4-joshi.k@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240930181305.17286-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_072536_393760_47565B4F 
X-CRM114-Status: GOOD (  20.28  )
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

On 9/30/24 19:13, Kanchan Joshi wrote:
> With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
> all the subsequent writes on the file pass that hint value down.
> This can be limiting for large files (and for block device) as all the
> writes can be tagged with only one lifetime hint value.
> Concurrent writes (with different hint values) are hard to manage.
> Per-IO hinting solves that problem.
> 
> Allow userspace to pass additional metadata in the SQE.
> The type of passed metadata is expressed by a new field
> 
> 	__u16 meta_type;

The new layout looks nicer, but let me elaborate on the previous
comment. I don't believe we should be restricting to only one
attribute per IO. What if someone wants to pass a lifetime hint
together with integrity information?

Instead, we might need something more extensible like an ability
to pass a list / array of typed attributes / meta information / hints
etc. An example from networking I gave last time was control messages,
i.e. cmsg. In a basic oversimplified form the API from the user
perspective could look like:

struct meta_attr {
	u16 type;
	u64 data;
};

struct meta_attr attr[] = {{HINT, hint_value}, {INTEGRITY, ptr}};
sqe->meta_attrs = attr;
sqe->meta_nr = 2;

I'm pretty sure there will be a bunch of considerations people
will name the API should account for, like sizing the struct
so it can fit integrity bits or even making it variable sized.


> At this point one type META_TYPE_LIFETIME_HINT is supported.
> With this type, user can pass lifetime hint values in the new field
> 
> 	__u64 lifetime_val;
> 
> This accepts all lifetime hint values that are possible with
> F_SET_RW_HINT fcntl.
> 
> The write handlers (io_prep_rw, io_write) send the hint value to
> lower-layer using kiocb. This is good for upporting direct IO,
> but not when kiocb is not available (e.g., buffered IO).
> 
> When per-io hints are not passed, the per-inode hint values are set in
> the kiocb (as before). Otherwise, these take the precedence on per-inode
> hints.
-- 
Pavel Begunkov

