Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59340C25B5F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SmsizxDlh8VGIxvKa46Kni5rgHbXmAGCqkr6DBGwWCA=; b=sut9QQwwlaKpk+LhQuBuPhNJMc
	+KjTo5HCBqM1hDnyiFuC+Blt4iL8ZlZDAXcsxwbebx/4iEk9nssvS9GPk/dtM/2QquU9T2N3PxdYC
	zrg1FRpA/FyDeC/Ns345b53papkJ987O7cIghC7v5c1/TiFtM1AEQvEFfxlk9aUbJ9VZLNnEbfH6K
	GSU+u04BrekM86WTQZYv2zzfd7PbWKNk0J80h5kgb3SSe2cnXRb3IituqrUIb4NrRMm3T4ZxoBPf5
	3I6ubc2Ys1RbQC4012ZMFWOygX9WaGdTn7XZGEHIUXY7+oplvIsfnjnN7jT1IZxq29dgbphse25Z+
	X8vpRAGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5QZD-00000005RBZ-0GEr;
	Fri, 10 May 2024 13:45:43 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5QZ8-00000005RAp-0kvO
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 13:45:40 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-36c31c23ab6so557795ab.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715348735; x=1715953535; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmsizxDlh8VGIxvKa46Kni5rgHbXmAGCqkr6DBGwWCA=;
        b=vhe3Q9zi7ikwbMkJwOdtHkEctcAFBluERcc7EctqnvDEp35RrGq3nMIRZsjgjs/Tox
         sj5ziagnEM8MWddZAqg8OcLTNCGPz5YuMwCKIRvFX+kxAXKchai7o4o37G5vGrjPIRFt
         L4V2ViQAUXRjvmplCCs69sNRS0eoc08j/i0ORwdpwGb93TMwNmrKgBiv8PViPusRtOnE
         plcnWURD/p/ui3PQEbolpJjLP5vtU0c+Ca7Y5YxWcY+v+4D0hK1WkJw+am5nApt4p3B8
         hlrz3nGQDJ8JQLW5asyUqY3PQV+QuQb5MPvXroo2KQSotfsf33irhYeJ4YzWIrooWuaP
         4qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348735; x=1715953535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmsizxDlh8VGIxvKa46Kni5rgHbXmAGCqkr6DBGwWCA=;
        b=w1fihQWqDApwC2QAewwgIHUI7BK5WsYpdEXTPNZ1oynqWFBoMpC9pgI9467tPf5AmL
         9EL3ab/7KyeaDBhbOMcl2iLAKlz/DYCvDZdwmu1Mqap+4xPSTCsdx2lHS1W9kOgKuNrJ
         MwY/SPaqwNh/IEEZTFakx8Yilc2wf91wVbzusqrzRPQM9kpCQEYz1NU4y/5PkB7Hftfz
         SIIJNsztgLkZn4DajM65anFXwILh83BjTiMXJt93LRLbBVRUiV34wXYcbdyt8y+gmLch
         R06dvCqAVKX/LgrYgQ1U7Msdrq2l1ysbPPIevsyFFxtnPoZ8lbCNn9cqH7GGlviaQh5N
         tByg==
X-Gm-Message-State: AOJu0YzzCwAh4p+q2IguKEbp5Ot9ypojIDEtdIYyzHofrnHGopnQzbLV
	xx7S+6CSooVBTU0V2uKlIYEkV9dOYsJAyxBK7MhhluINWBYpMmkLiYnS/+7iBV4=
X-Google-Smtp-Source: AGHT+IG3qVDOspiQrCoZTdejYIWXEmeEyT0LSNue3i8UNQAJpOHdd6gPSJvkuIltbiGydLBUGu3InQ==
X-Received: by 2002:a92:ddcd:0:b0:36c:d76:cf5c with SMTP id e9e14a558f8ab-36cc14cf8f7mr27922825ab.3.1715348734919;
        Fri, 10 May 2024 06:45:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e22041sm7913375ab.83.2024.05.10.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:45:34 -0700 (PDT)
Message-ID: <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
Date: Fri, 10 May 2024 07:45:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240510094429.2489-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_064538_257352_6715A33A 
X-CRM114-Status: GOOD (  10.96  )
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

On 5/10/24 3:44 AM, Anuj Gupta wrote:
> +/**
> + * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
> + * @bio:	bio containing bip to be unmapped and freed
> + *
> + * Description: Used to unmap and free the user mapped integrity portion of a
> + * bio. Submitter attaching the user integrity buffer is responsible for
> + * unmapping and freeing it during completion.
> + */
> +void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +	struct bio_set *bs = bio->bi_pool;
> +
> +	WARN_ON(!(bip->bip_flags & BIP_INTEGRITY_USER));
> +	bio_integrity_unmap_user(bip);
> +	__bio_integrity_free(bs, bip);
> +	bio->bi_integrity = NULL;
> +	bio->bi_opf &= ~REQ_INTEGRITY;
> +}
> +EXPORT_SYMBOL(bio_integrity_unmap_free_user);

Should this be a

	if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
		return;

?

-- 
Jens Axboe


