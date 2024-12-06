Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C37E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ofi8J7HkOXqzmy0PwYhWkfzpyBnLUyhAbaIeruP1+Ek=; b=tz2njzdL4xGfQpeC1oL4qebL2v
	fXkHF4FlVhY1Treeh5H7zxQhBFLnHw50v6Ax9D4LJ0XoLpqyWVeqbhOMYWPHxQOqwAOplDPWdPpLG
	2cOihteCZ/mWb8dygl83WqfiSvl7CdNzJcQ6f2SFtM9izHYaVkJg32aZrelMtN2UIKgGgp3bzmtrM
	lKJUJaLJaJUC2JZNG/j0fjW+0GfZ8gDJ3470H6okN4hANWLytk4HpAU+FJ8kHt1N1tQYJNmabZDZK
	4tFzlYJ2j800vnBWAX9rdHp4b2R26xwZsA/9G9D3YTFuSgFO3+PZ9v95To8CJag+OH8d1SxEaTpVq
	Usg55UbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJX6q-00000001WQJ-31Kg;
	Fri, 06 Dec 2024 12:07:00 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJX6p-00000001WP3-0m00
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:07:00 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-434a90fed23so13312415e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733486817; x=1734091617; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ofi8J7HkOXqzmy0PwYhWkfzpyBnLUyhAbaIeruP1+Ek=;
        b=LZLLMy1cdjkLdxyslPKrI33ql1kUQe2ncYlb/1Y0oJpetidcynHBwlVVYGy2ceJ9lt
         hJzPAR7YHr4oIm0w7Q4xDz5ramPefcSQbHS7kTTY6nLdmugaJ/AqCzZiULTGGqajqxc7
         hDC0EuNp+3w3yWOLXe9r5Sc7QnRSUpF45zLvsXZ8msNEh/HUJiflI8Q8tNat8c5mWmzP
         71Y6AXRwdsT9nquMmb7yYOO/ZF5FmiH/8UeRdiYVRVxqvNvZJ+KZ2EeYRhmZ2OqsTRi6
         h8qI3k67XMDL/s4Q9NHa2eoleNGLCWMwIRIlLGOCtIieZkZwuIzBhodRZvPe9TOl/xi6
         Y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733486817; x=1734091617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofi8J7HkOXqzmy0PwYhWkfzpyBnLUyhAbaIeruP1+Ek=;
        b=UqzfV22l45Xz9dAzrVyt6T0xsoqx5rTPaKzRjonxN+AIrkCwsRBWREhKI2kDNMfiw1
         yJLPuVGTCwgr0HqP6xAXUymbfGvNg0gP7GP7UfUGk/YLU6Ob4FkGSKlPL9fX4h/8UG8d
         eZtEURxTQlBqfzYC3iEziiPwAIyPsOLwwIIsF4J9VoyEJO31NCPkmm4MFJgf1ROjPyDr
         BGWgv4Iy0fmDl5Tw5iBdSk7sIrfJg4ndSXqBjr1dxX8sV0+TBTlhfLkUCRmHXOey4cdg
         dCaUbkK4Zu5J+KxbKfEDikqcmCeiY/bcFy/PBFbOC276/pF6ZFsF+GsBN9hJRWmyGjVf
         suZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX77SRp9kVM0LdoktAbeoWGHnoLrCupEPgldCRXj76oRKDFJ6KsRIBr6C74E9TftVNGuha+2mPxSyKJ@lists.infradead.org
X-Gm-Message-State: AOJu0YwZGwXu0LyOo0R+EoDYPftYfqSXKSOa/yqKN09QMcNiEJ/t5Juq
	8bg92j8EEYG5L49yypzN7HfFw1pil35ogzg+uGmgX1im6OD1isw6
X-Gm-Gg: ASbGncv9aWqWDptBHK+KcRhKUINa65M7Qx38QSXUJOIvwo0SAd4PykcsCAAAy/D/Ddo
	GiWVxMH/yb7klylIB+lybVZmxAznL18K7MNohW3+QsIA1h2LxcVEGdo3OWm8RHV8/a5hB1Ix4ph
	S1cl0veHmEChLALNB/qU90dZP4iUJ7Ege7aowBjAVtpB0PKsew/KADCqYyK9mTpoRjHgssw+5Z4
	gLL0n9xVGheMjdnCk4uBOWShqbmVxzNj7NmRyEnOVkPKwFSrHS7vf26BA==
X-Google-Smtp-Source: AGHT+IFukNP/9d0bzhZHBl9HWucpX6QKCTEFooLAnEDxeoA5TREQULmq2p5TXYB5euFXhrTUS8HHng==
X-Received: by 2002:a5d:5887:0:b0:385:eb17:cd3d with SMTP id ffacd0b85a97d-3862b33bb70mr1874874f8f.8.1733486816789;
        Fri, 06 Dec 2024 04:06:56 -0800 (PST)
Received: from [192.168.42.94] ([85.255.232.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc51451sm4480100f8f.47.2024.12.06.04.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:06:56 -0800 (PST)
Message-ID: <80aa4160-94fa-4ec1-91b8-2d125ab41120@gmail.com>
Date: Fri, 6 Dec 2024 12:07:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Keith Busch <kbusch@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241128112240.8867-1-anuj20.g@samsung.com>
 <CGME20241128113109epcas5p46022c85174da65853c85a8848b32f164@epcas5p4.samsung.com>
 <20241128112240.8867-7-anuj20.g@samsung.com>
 <Z1HrQ8lz7vYlRUtX@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Z1HrQ8lz7vYlRUtX@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_040659_226838_DC1EEA07 
X-CRM114-Status: GOOD (  15.46  )
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

On 12/5/24 18:04, Keith Busch wrote:
...
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index aac9a4f8fa9a..38f0d6b10eaf 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -98,6 +98,10 @@ struct io_uring_sqe {
>>   			__u64	addr3;
>>   			__u64	__pad2[1];
>>   		};
>> +		struct {
>> +			__u64	attr_ptr; /* pointer to attribute information */
>> +			__u64	attr_type_mask; /* bit mask of attributes */
>> +		};
> 
> I can't say I'm a fan of how this turned out. I'm merging up the write
> hint stuff, and these new fields occupy where that 16-bit value was
> initially going. Okay, so I guess I need to just add a new attribute
> flag? That might work if I am only appending exactly one extra attribute
> per SQE, but what if I need both PI and Write Hint? Do the attributes
> need to appear in a strict order?

Martin put it well, this version requires attributes to be placed
in their id order, but FWIW without any holes, i.e. the following
is fine:

ATTR_PI = 1
ATTR_WRITE_STREAM = 2

strcut attr_stream attr = { ... };
sqe->attr_mask = ATTR_WRITE_HINT;
sqe->attr_ptr = &attr;

In case of multiple attributes:

struct compound_attr {
	struct attr_pi a;
	struct attr_stream b;
} attr = { ... };

sqe->attr_mask = ATTR_WRITE_HINT | ATTR_PI;
sqe->attr_ptr = &attr;

The other option for the uapi, and Martin mentioned it as well, is
to add a type field to all attributes.

FWIW, I think the space aliased with sqe->splice_fd_in is not
used by read/write, but I haven't looked into streams to get
an opinion on which way is more appropriate.

-- 
Pavel Begunkov


