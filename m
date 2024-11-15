Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7738D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GX5wJ6oLxec3STDa1FVtfsmqMbzKtWScheytSQkT1U8=; b=rukBo977YBdm6a14JkOhkdH70N
	yexSFU+u842vbNLfIn2L1e5MVb0ZeaFuutDa7r2UKCtGCqhA2X+VAHgMKjUBKWm312hbMUKfLFNFq
	9CxNAMhrMvvGkmnKF/IW6wZDqrkO+2N04Bvdt9p6C5gVi9urbXHInvHPJwYaNy+zlQI1uQKhDGS1Y
	4geAlXqZCBYP8HbwEqN1SNacTZJpQedyliDJG/5Rfal+6ijNyAV5CHZz/Zp/Nmq6lSRcwucBL33z5
	ivbk0qjk7RUPXxZpLIiomjZlMyHULMw2eCM08COgqj6aibAj2SaRm9GCNKfqZ5W5DgzAbi6M2XfJ6
	M7Awp8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0OH-00000003bGe-0jBd;
	Fri, 15 Nov 2024 17:45:53 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0NR-00000003aog-3Xzw
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 17:45:03 +0000
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3e5f835c024so1243687b6e.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 09:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731692700; x=1732297500; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GX5wJ6oLxec3STDa1FVtfsmqMbzKtWScheytSQkT1U8=;
        b=ctjYif484zlgU3ssThEuAS5V+fq2QaOQvWyr8jtaaWmCCLds/x4c1wMR6V+BqT9qxo
         4lxiFEGJEPwkDN+y2HOREdd1XDFJKacUrGGIz13cyhBPOU/jHy11rOBG0FTclZCdDiJS
         MoN1DeCcaGA8huXi0a/j+lwLmrPAIUnkibn6VGD8HzOxtAh/8jzTj4rAPyHAfawybAvs
         jF+rj6ENP9/aZeoVSZgh1gPATBJ+HglIvAan8OSdfXq6mfI91f4OHwjfExyYjpjTBeTp
         ef2a/NOjCvjuq4TN08N64XeBW9cCCHhRNka/iQbD+XfIHAxHdoTgRX++bNqHzQfNlyXx
         OkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692700; x=1732297500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GX5wJ6oLxec3STDa1FVtfsmqMbzKtWScheytSQkT1U8=;
        b=RHvUati5ZdxHVa1Vp0RyulSNCJ1552/CvxUJ0KDD68/6oB39FEMYyAH72CDxmPN8H3
         GyMm9/hG1yeeUDh9RHcBupe/Ck0kvZATsWmGWnS/urS7hsIoxH3gmS8vVcdKuA5r04D5
         m21Ddyhh2VnsWFirx4nbCNMwzxgI3B/cbMmM8kAyw97HIRqBJFdq6l6iJWu19szn36g0
         tH96rSQf+EptsiZu7KbbfVj1iSoWqz+ma+KE0OFywWuJGHOgFY+7PfkVqc9lHxNK+oqh
         K7YN7DLdeunTlDU0itNGlIgcqrfehjkSaQAxiqnGSn4yfeVt6pGX9xpxDl3zPURbv3mx
         dC3w==
X-Forwarded-Encrypted: i=1; AJvYcCUnecJBE1+NgpvYKPCOEj9mrI8AvPXvelypQcqoTPBbnSWX1dtUn+NrjWtGgyDfKw84l4mZSqOVaQnm@lists.infradead.org
X-Gm-Message-State: AOJu0Ywt7tbh8j8qrvqSbeKrkZZmPcwyWn8eWuEcFicW4AP353wPSE4r
	h5YAdqdkJZm0afhQUaWqxhRITD+lpn74GiTr7bdvLf7l3GrRKtcaLivVB/NTJqA=
X-Google-Smtp-Source: AGHT+IE7u0RxmsRL3LQWgWu6xddXzAE9XDdBJ1jPG6HxqNvh9lsaMK0XyjGjnH4cynjuaCDt1FSOiA==
X-Received: by 2002:a05:6808:4401:b0:3e7:c366:d17f with SMTP id 5614622812f47-3e7c366d358mr1389370b6e.38.1731692700454;
        Fri, 15 Nov 2024 09:45:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd12fbasm661744b6e.21.2024.11.15.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:44:59 -0800 (PST)
Message-ID: <97b3061c-430d-4fc0-9b62-ab830010568e@kernel.dk>
Date: Fri, 15 Nov 2024 10:44:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, kbusch@kernel.org,
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241115171205.GA23990@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_094501_889693_F4A8DEE4 
X-CRM114-Status: GOOD (  14.48  )
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

On 11/15/24 10:12 AM, Christoph Hellwig wrote:
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
> 
> Maybe we just need make it uring_cmd to get out of these conflicting
> requirements.

Let's please lay off the hyperbole here, uring_cmd would be a terrible
way to do this. We're working through the flags requirements. Obviously
this is now missing 6.13, but there's no reason why it's not on track to
make 6.14 in a saner way.

-- 
Jens Axboe

