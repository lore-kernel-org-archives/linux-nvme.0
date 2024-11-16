Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7859D68BDA
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 00:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUiuDfFBuPq9wmtwULXkxzA4r3Jz1CPuc0lcmODYolg=; b=yUGKp4hlh2EUTRKNrLczOICHKC
	Qp+7HCRS4gbWwDyt+xJdmsQ5YBpF0XqHYwIYcgIkapRJ8GI4ivhIjDg1uTqu6uWdGD1oG6CU9BUFW
	Gi6tNcfmgr5o6c4tfr8D2RbxgaPRwu7+yP7BbbdokLSVdOyUPOjzlbXM8Bc2kgYcfUlMWDk9iSbvp
	DuH40mHoYYxJJtcA7pV6yXrvrGQvWcfEg64/PmJ2Mu82Qdf/JA4pblc1TSazQzkLIWN+iGUDK6yj0
	R6Z580Iueq9UReXRXvUA7i2KltBVIec+mIqkN5VXIN7RqVOLjH6s6r9A/gQGEiTRMcI8Iwq+x0Ibd
	jz1DbTxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC6j0-00000004eHD-1nNG;
	Sat, 16 Nov 2024 00:31:42 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC6iy-00000004eGk-2eYy
	for linux-nvme@lists.infradead.org;
	Sat, 16 Nov 2024 00:31:41 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso2483265e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731717099; x=1732321899; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wUiuDfFBuPq9wmtwULXkxzA4r3Jz1CPuc0lcmODYolg=;
        b=a3wHNrThwQ7BMqNgBIrVVTwZwPp8SQ311KVc4s1BefzB7vFvjQWsdQz92XYyK5x+iU
         L9FHHYrxLOAG4OXnD7xCeWGpSs+vayBXyYDLdu60JCVuY6TDKA6KbWuPHolbgka2P7pd
         ewVOAfHeQHVVtBNeXvwaW8GFeWukFWOFYxfOQ0j+WRn1yWPcOIa3GGod33P1pOBrrcBx
         PZjH7M4ka51rSJ9/d9K6zvH3EE49y4V4acA3AXy0C5BiFyuzUxaN8anUDUb7gqySBRPO
         L19u4B62PehsLRDbmyVlIh6LoG1UEBHZsx1ptAgOby9cdObdDlEx5ctfhcd+W6IMunps
         syTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731717099; x=1732321899;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUiuDfFBuPq9wmtwULXkxzA4r3Jz1CPuc0lcmODYolg=;
        b=if61dAF0Y3v/ESOGXv1nRf/ej/SsUJy7UA0rNYsR1oPNg24vHNhjUuZtqqr0kMwhgf
         XTALudQsECSQHO7/u14v7SKbE1q6I8848l527el75l5QhlfzVAIFpJj/75Oe48xGS3l/
         HpKMDimhKQxHH+b3Yg/qxcXn6lqmxj71UQY+PS0MlU2yVPXua5SlNvvv/hy4VTH9oxwp
         SoVImbQNdYQDuIG790MrU+IPs30Z9mavGBROHoVTLeWBQNbX0Oxb5PHWoNScuA7aEsr9
         OWqoA2NRJ2NlZQiDL4PZgvdt5O1S1d0szOAt4l0E0Zqf0GZiGnoBejd2Jr5UjmaI664+
         zdWw==
X-Forwarded-Encrypted: i=1; AJvYcCVBtH3HGDq12VDNQLvRkUygdotLjtQ38cGKNMHxH8qoPshhIu24DelMKtGWwpJyO3lG69q6a93RZCyf@lists.infradead.org
X-Gm-Message-State: AOJu0YwM3VRCX9Fxv0IzVQj4UcOSF7Vdc2cUNn0YM4qAd1XTEELLLG8V
	4zyj4gDWEa+fa/Slg83NAjfCXhO5qP/wDX8HTBMOHhZNB4k1wMbs
X-Google-Smtp-Source: AGHT+IHP+NwuGsuzp6CwtW/eEH7kghS9fmgu7RXZGv2sSD+Jk9ssluc8g0aZVNHccATYYsWWJuTJhQ==
X-Received: by 2002:a05:600c:45d1:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-432df74fc6dmr51402325e9.16.1731717098903;
        Fri, 15 Nov 2024 16:31:38 -0800 (PST)
Received: from [192.168.42.251] ([148.252.132.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27f4f8sm72122775e9.18.2024.11.15.16.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:31:38 -0800 (PST)
Message-ID: <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
Date: Sat, 16 Nov 2024 00:32:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
From: Pavel Begunkov <asml.silence@gmail.com>
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
Content-Language: en-US
In-Reply-To: <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_163140_670830_0158DA6A 
X-CRM114-Status: GOOD (  15.53  )
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

On 11/16/24 00:00, Pavel Begunkov wrote:
> On 11/14/24 10:45, Anuj Gupta wrote:
>> Add the ability to pass additional attributes along with read/write.
>> Application can populate an array of 'struct io_uring_attr_vec' and pass
>> its address using the SQE field:
>>     __u64    attr_vec_addr;
>>
>> Along with number of attributes using:
>>     __u8    nr_attr_indirect;
>>
>> Overall 16 attributes are allowed and currently one attribute
>> 'ATTR_TYPE_PI' is supported.
> 
> Why only 16? It's possible that might need more, 256 would
> be a safer choice and fits into u8. I don't think you even
> need to commit to a number, it should be ok to add more as
> long as it fits into the given types (u8 above). It can also
> be u16 as well.
> 
>> With PI attribute, userspace can pass following information:
>> - flags: integrity check flags IO_INTEGRITY_CHK_{GUARD/APPTAG/REFTAG}
>> - len: length of PI/metadata buffer
>> - addr: address of metadata buffer
>> - seed: seed value for reftag remapping
>> - app_tag: application defined 16b value
> 
> In terms of flexibility I like it apart from small nits,
> but the double indirection could be a bit inefficient,
> this thing:
> 
> struct pi_attr pi = {};
> attr_array = { &pi, ... };
> sqe->attr_addr = attr_array;

We can also reuse your idea from your previous iterations and
use the bitmap to list all attributes. Then preamble and
the explicit attr_type field are not needed, type checking
in the loop is removed and packing is better. And just
by looking at the map we can calculate the size of the
array and remove all size checks in the loop.

-- 
Pavel Begunkov

