Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F22D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJeoXJwB9bUfd+K442tubIgDjv2gaR4dr6OV0PklIw8=; b=QiAly4S20ezxGaP5mUG5qk/t0O
	kR/WypZrzSFdcEZW8ZMs0Rg7YshdFKuhXyhJZ5Tyc06qKYi1r5srNxIvbPOS7CQy6dgaGngpM88DP
	CATNmrpeU9VKA1Eg+9kBTK0sLNbWb35yJF809FXc7dtcrkLIqOgP+1N+voF9zRbaRZvwmEG98XAvy
	N111op6k1vqlnsGjwji9OvaV96kRUEIlw1GQ2BwpI/NPYrCcnvcN3Cpn93HTmGvEzT/IQ6Rhu3Tbm
	mR18dgy3YWO3H4m2U4OAibxzVcfHkCx5q41hvT/sNJhRUfeY4kygNFdNwElnDm5IBGvz8iW2r8hj/
	7hlyYJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC1af-00000003n43-1zd6;
	Fri, 15 Nov 2024 19:02:45 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC1ad-00000003n3G-2VvF
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 19:02:44 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4314b316495so8525695e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731697361; x=1732302161; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJeoXJwB9bUfd+K442tubIgDjv2gaR4dr6OV0PklIw8=;
        b=fk2e/FU1lH2AmSICm5ganBuqCRgYmgZEPjXCjRORZZO+j4cs4JTggHwYi6wGsf/yNQ
         a/Mde2+spvGA21t/bcemBuhqPlluD5wf9l/6ssd+c1JpIvNUI/HX1HM7VHzPun8V26KK
         jQ44Qj07Z7C9HmYi1wKN/5Hyq3XpX4l1/JHUJF23ourTMF2RLLLcWioHKt8vYr5+0Ah+
         j3BJhQggCyBzGQBgeMk8l6CBq5Tn7XOGiO1oatYYaa+UoaR0Mycn/RbyFQMKKrQKf36w
         NU+y2x37BNst1XsqHHVLYFEKuJIG6qjb7oERxeANqquQFT2d0SyMcwENewNu7QQ2uXgP
         OL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731697361; x=1732302161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJeoXJwB9bUfd+K442tubIgDjv2gaR4dr6OV0PklIw8=;
        b=l1OT3cxgU0bravSa8WsVfmZPqaYXvtl+biWiykAhy/o3AvGqtLNAEjouvDTJUs5UT3
         YYupkxfIC4aFDpJojpHuUI7jGPtX1twdznRQNLSggUlF3m5VFenjTV07Ue1NZnwyTIhR
         QYGseifISKnHH4WT+XIIe/1iw6JqVwjawSCX01MH3zB7OdjCL+BediDRKIIY0A7kbo6s
         6lgExhe+zuwLLYPzo3hbPLsM4fJnsQSMU+WtceIs5sBVQp5+GOL+33/GJheFd/WhYE2P
         8dcEDPnCi6QFMp86u2+dD/eFHvPiYiDqWXLsxzyKEXJ3ow6ggGCEp5XsPRoWkrmDuoHd
         orKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2pPMKAqkG8Sc3vc9oE1TnOAkzxgN8UGECvXNy82XA+HEdaOcHFIOXY2f1aoa+nb6Tb7ffLpt/xbeF@lists.infradead.org
X-Gm-Message-State: AOJu0Yxz4Pc2KzFuVlBqIMudX3swxQiWpmX8KowFjaMoCeMClEvoG3Nb
	VK2v/J5jyR9kNk2SI/1U+Fxfft2uNtY29nlHtNV+t3ruzAyDPFXy
X-Google-Smtp-Source: AGHT+IFoafFKHLVT0DJoHOrqKEmggso2/mCTHNRA/BSnSr63wSqW4R2fLvclLi+NGyR0Zkzfqsw8DA==
X-Received: by 2002:a05:600c:1d9e:b0:431:5ce4:bcf0 with SMTP id 5b1f17b1804b1-432df74d88bmr35454675e9.15.1731697361154;
        Fri, 15 Nov 2024 11:02:41 -0800 (PST)
Received: from [192.168.42.191] ([148.252.132.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae04sm61614265e9.33.2024.11.15.11.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:02:40 -0800 (PST)
Message-ID: <397bc8b7-b569-4726-984a-46054d6b5950@gmail.com>
Date: Fri, 15 Nov 2024 19:03:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
 <20241114151921.GA28206@lst.de>
 <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com>
 <20241115171205.GA23990@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241115171205.GA23990@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_110243_643320_258E73AF 
X-CRM114-Status: GOOD (  22.90  )
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

On 11/15/24 17:12, Christoph Hellwig wrote:
> On Fri, Nov 15, 2024 at 04:40:58PM +0000, Pavel Begunkov wrote:
>>> So?  If we have a strong enough requirement for something else we
>>> can triviall add another opcode.  Maybe we should just add different
>>> opcodes for read/write with metadata so that folks don't freak out
>>> about this?
>>
>> IMHO, PI is not so special to have a special opcode for it unlike
>> some more generic read/write with meta / attributes, but that one
>> would have same questions.
> 
> Well, apparently is one the hand hand not general enough that you
> don't want to give it SQE128 space, but you also don't want to give
> it an opcode.

Not like there are no other options. It can be user pointers,
and now we have infra to optimise it if copy_from_user is
expensive.

One thing that doesn't feel right is double indirection, i.e.
a uptr into an array of pointers, at least if IIUC from a quick
glance. I'll follow up on that.

> Maybe we just need make it uring_cmd to get out of these conflicting
> requirements.
> 
> Just to make it clear: I'm not a huge fan of a separate opcode or
> uring_cmd, but compared to the version in this patch it is much better.
> 
>> PI as a special case. And that's more of a problem of the static
>> placing from previous version, e.g. it wouldn't be a problem if in the
>> long run it becomes sth like:
>>
>> struct attr attr, *p;
>>
>> if (flags & META_IN_USE_SQE128)
>> 	p = sqe + 1;
>> else {
>> 	copy_from_user(&attr);
>> 	p = &attr;
>> }
>>
>> but that shouldn't be PI specific.
> 
> Why would anyone not use the SQE128 version?

!SQE128 with user pointer can easily be faster depending on the
ratio of requests that use SQE128 and don't. E.g. one PI read
following with a 100 of send/recv on average. copy_from_user
is not _that_ expensive and we're talking about zeroing an
extra never used afterwards cache line.

Though the main reason would be when you pass 2+ different
attributes and there is no space to put them in SQEs.

-- 
Pavel Begunkov

