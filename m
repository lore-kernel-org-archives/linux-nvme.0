Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4AAD767D6
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkLkUT2155S8/1ZjBvkJQuF+oTKJuM1LeXuQm4xdwNg=; b=yMy16TdBVjFWVex1RFtea5Dist
	b5Bi+XwEW3tpRbEqKHWeICrVTQSFgqt0Bb/SDJhnd3i8+4qAwW78WIxbLEEyBiACUG4d1ojPV1jtG
	l028vKm4iofX7nZndKZrjaf4ADbGimi2l66rJy29yiadgqHKxEPRqwHysuje98KAJhfUhXeH7R8Ys
	gTQeVMF4k4BSoSo0xS6KIL9oiXLmm8TsBqTTImB+zebeQbB9nOt2kUqgOKAM/9boPIRGVWODWe2kH
	jLPQ8EcsfIzE8tw/BW0BkjtzypROe9AdxZgEsuQ5ghadBtWInVhEIcJUa43/YVMTxa79T7beu6dzs
	MP55AZRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6WS1-00000003rT8-1t7X;
	Thu, 31 Oct 2024 14:47:05 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6WK8-00000003q6H-3F0z
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 14:38:58 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso129614066b.2
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730385534; x=1730990334; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkLkUT2155S8/1ZjBvkJQuF+oTKJuM1LeXuQm4xdwNg=;
        b=YQJw0nL7y0qO6xf4eVddq/qnDIPleazJNadXMbdCXsWUWMdpxeUUmCEWNabX1D0Naf
         kG5eN45vsQcsvhpbQ4bEIqPgpTbD+vA+qdCSoJFw0jQORSi6NYWTGcyz5zyqWSurJkUV
         9RTlQXdsEREAPUoWmnuoUCyNWupWGdC386xu4z7SwF+0KDqG5vMunndmGg0FVGui8yF/
         MeH+LkW0nddYxI2qCFOlUYSjrkQ1tMRHsXtQ46iG/nytZZSKQPxccFDnUUq9XFZEevgS
         vMRyNhPXfAXq4scF8RPBrcQB1bEEkAKvI75PBnqGV3/BzvbT59TMUBinZP/n4YPv9Y1b
         830g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385534; x=1730990334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkLkUT2155S8/1ZjBvkJQuF+oTKJuM1LeXuQm4xdwNg=;
        b=X9CEJ4F4RvgW4KsQoBMZ8WiNdmhNRcCpGV5l992EYU18yMK0EWPMEAWZHOrE6S361L
         +KTieT2+9X17ik+xw0oYmCQz5FmzkhOOB+EZxOHOJEiySeKlIrf9sgE87y9NZCvnc6Yd
         r3dICgwqn/L7zVx1Qdg7WeULIIdm0lrr9jNMnTW1Pug9EQVsRaY6JIIUn+hKkw7krmF3
         LAZSHtjlrOqkmf/DGk9O0ZFqS6uL1MtNacg2XL8RVjAel0qbXiTRwm+8jhCwXfZvarXl
         yd8SP4O22cMNrvFKO+cQJeoJF0Xp5n69s/yP5GyAgbFgJ5vqUHUn8Ug9woHPIV8q2sKH
         R8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXwGoT7Jsq96RPbpLca0B6NCFiP9EXIk2W8AjX/DSziWZP5YA6I9V7t4Q6TS3JOj03cVWUNCIqg0Mlf@lists.infradead.org
X-Gm-Message-State: AOJu0YyrILLnHFxmp2vPeruEsfXU8F4SEKAAXc5870zKS06Yj26ShaNR
	3j61Wv0HbUVhBkxEwnY+FGV/tMAkJEMVNNTk6hDj+daLymm+PcBY
X-Google-Smtp-Source: AGHT+IHgy72+xf0zy2u4ibYnZqijgJyothbCzVyB8LNV+B9H3h6X+CKob8pNbhEshHta/sBwmpYt4Q==
X-Received: by 2002:a17:906:c154:b0:a9a:38e6:2fdf with SMTP id a640c23a62f3a-a9e50ba7dc2mr353194166b.64.1730385533573;
        Thu, 31 Oct 2024 07:38:53 -0700 (PDT)
Received: from [192.168.42.106] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c55f4sm74922966b.78.2024.10.31.07.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:38:53 -0700 (PDT)
Message-ID: <914cd186-8d15-4989-ad4e-f7e268cd3266@gmail.com>
Date: Thu, 31 Oct 2024 14:39:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20241030180112.4635-1-joshi.k@samsung.com>
 <CGME20241030181013epcas5p2762403c83e29c81ec34b2a7755154245@epcas5p2.samsung.com>
 <20241030180112.4635-7-joshi.k@samsung.com>
 <ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_073856_866544_96940253 
X-CRM114-Status: GOOD (  22.48  )
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

On 10/30/24 21:09, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 11:31:08PM +0530, Kanchan Joshi wrote:
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index 024745283783..48dcca125db3 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -105,6 +105,22 @@ struct io_uring_sqe {
>>   		 */
>>   		__u8	cmd[0];
>>   	};
>> +	/*
>> +	 * If the ring is initialized with IORING_SETUP_SQE128, then
>> +	 * this field is starting offset for 64 bytes of data. For meta io
>> +	 * this contains 'struct io_uring_meta_pi'
>> +	 */
>> +	__u8	big_sqe[0];
>> +};

I don't think zero sized arrays are good as a uapi regardless of
cmd[0] above, let's just do

sqe = get_sqe();
big_sqe = (void *)(sqe + 1)

with an appropriate helper.

>> +
>> +/* this is placed in SQE128 */
>> +struct io_uring_meta_pi {
>> +	__u16		pi_flags;
>> +	__u16		app_tag;
>> +	__u32		len;
>> +	__u64		addr;
>> +	__u64		seed;
>> +	__u64		rsvd[2];
>>   };
> 
> On the previous version, I was more questioning if it aligns with what

I missed that discussion, let me know if I need to look it up

> Pavel was trying to do here. I didn't quite get it, so I was more
> confused than saying it should be this way now.

The point is, SQEs don't have nearly enough space to accommodate all
such optional features, especially when it's taking so much space and
not applicable to all reads but rather some specific  use cases and
files. Consider that there might be more similar extensions and we might
even want to use them together.

1. SQE128 makes it big for all requests, intermixing with requests that
don't need additional space wastes space. SQE128 is fine to use but at
the same time we should be mindful about it and try to avoid enabling it
if feasible.

2. This API hard codes io_uring_meta_pi into the extended part of the
SQE. If we want to add another feature it'd need to go after the meta
struct. SQE256? And what if the user doesn't need PI but only the second
feature?

In short, the uAPI need to have a clear vision of how it can be used
with / extended to multiple optional features and not just PI.

One option I mentioned before is passing a user pointer to an array of
structures, each would will have the type specifying what kind of
feature / meta information it is, e.g. META_TYPE_PI. It's not a
complete solution but a base idea to extend upon. I separately
mentioned before, if copy_from_user is expensive we can optimise it
with pre-registering memory. I think Jens even tried something similar
with structures we pass as waiting parameters.

I didn't read through all iterations of the series, so if there is
some other approach described that ticks the boxes and flexible
enough, I'd be absolutely fine with it.


-- 
Pavel Begunkov

