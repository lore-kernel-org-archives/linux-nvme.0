Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C03E7C4E6
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UrSFuIFom3a3FCpBLPqbU0TDngZDytGzCb9fcci2Vps=; b=qvijeHz9DW1CjA0tYFBD4uGEMC
	CU3T0cVCkhxhjJf6nkTk4/P4RlQ15VXCwVjYo5Gf4qUIoI1mbkRL7ZXG/Tcv/DtPUR4Qv99NUtXSe
	5pW0WJJiLAu88pGTnoU5BEhqcYrUmsUXv1kInh77b1iygjeOr1XGkrblm1cAZS09Lt+GRPes9Eyh2
	NVs5c3Rq1qEcH8O25VbaoZaimry1QBtz9x0Lj2dFNmHucQ8uPqscooMExdbS/IUw5XooBChVW7u7r
	FwBWEXA4clLPAK6twhm02Uv7105PkrOpglYWfw+FUcPSQ63m5R5AnjK1AiWXbuGSjuY/COem9/TYG
	eFgs9H8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5Zw-000aW4-1H;
	Wed, 04 Oct 2023 17:22:32 +0000
Received: from mail-ot1-f50.google.com ([209.85.210.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5Zt-000aUv-21
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 17:22:30 +0000
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c67060fdfbso31869a34.2
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 10:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440147; x=1697044947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSFuIFom3a3FCpBLPqbU0TDngZDytGzCb9fcci2Vps=;
        b=gSq1E/ArD5w0MSUMuFySiN8DRuBSFgH/SzNP6Ii3hHYBL1pv64ZYDbt/rTnyFpT8j6
         W6gsKIHAIahbmt2aM+ihxgoCWcBuD8lkdjdSw30t2x0uDkT57b+OpIajIqVEw4A03T1o
         q1Ema+bM9WbplzmqrDtLWiuwRieB7ismq6dVlUEE21Z3WvVlqj3u0Sols7SHJkgj38g5
         gJ79wJQJf6idIwYXekoPE2D1wtaH1VFbEBttBhJUmnU5sQfUuyDzUNZFJnQ5zWWANTAd
         qB6QtuYH4BtEKrzJukpy9ehULZiANgpwWvaq1QEbr8xsWTyEBItEzeBQvaNax3E1bkgQ
         irQA==
X-Gm-Message-State: AOJu0YzcHjkeniOrmKGpf/S8axv5TZ+GpfDyMnfOruqUp+vXk/Wd6Oh+
	MfNrnJpZ2i2xxBRUBTXypVc=
X-Google-Smtp-Source: AGHT+IFwPyh3g7K1zFFS2K1tx2oSQ5TBcHsOPmaP77rA8BiXr0rEAmLGpZb5/vvrvCmoSVs2TDMIpQ==
X-Received: by 2002:a05:6358:7f15:b0:143:786b:3de5 with SMTP id p21-20020a0563587f1500b00143786b3de5mr3022855rwn.9.1696440147475;
        Wed, 04 Oct 2023 10:22:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id t19-20020a63dd13000000b0055c178a8df1sm3537955pgg.94.2023.10.04.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:22:26 -0700 (PDT)
Message-ID: <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
Date: Wed, 4 Oct 2023 10:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_102229_666475_4B287782 
X-CRM114-Status: GOOD (  18.07  )
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

On 10/3/23 19:53, Martin K. Petersen wrote:
> 
> Bart,
> 
>> I'm still wondering whether we really should support storage
>> devices that report an ATOMIC TRANSFER LENGTH GRANULARITY that is
>> larger than the logical block size.
> 
> We should. The common case is that the device reports an ATOMIC
> TRANSFER LENGTH GRANULARITY matching the reported physical block
> size. I.e. a logical block size of 512 bytes and a physical block
> size of 4KB. In that scenario a write of a single logical block would
> require read-modify-write of a physical block.

Block devices must serialize read-modify-write operations internally
that happen when there are multiple logical blocks per physical block.
Otherwise it is not guaranteed that a READ command returns the most
recently written data to the same LBA. I think we can ignore concurrent
and overlapping writes in this discussion since these can be considered
as bugs in host software.

In other words, also for the above example it is guaranteed that writes
of a single logical block (512 bytes) are atomic, no matter what value
is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.

>> Is my understanding correct that the NVMe specification makes it 
>> mandatory to support single logical block atomic writes since the 
>> smallest value that can be reported as the AWUN parameter is one 
>> logical block because this parameter is a 0's based value? Is my 
>> understanding correct that SCSI devices that report an ATOMIC
>> TRANSFER LENGTH GRANULARITY that is larger than the logical block
>> size are not able to support the NVMe protocol?
> 
> That's correct. There are obviously things you can express in SCSI
> that you can't in NVMe. And the other way around. Our intent is to
> support both protocols.

How about aligning the features of the two protocols as much as
possible? My understanding is that all long-term T10 contributors are
all in favor of this.

Thanks,

Bart.

