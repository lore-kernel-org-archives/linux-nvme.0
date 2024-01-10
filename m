Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D37C47073
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jGa7M+RVSIU6eb5GgLKw++O92ls2gRTpR1kY46luj94=; b=eMGRpFQdliN8KU6pLb2RlPKlHw
	HZJL4I/pgIIceeqSDGV+1RQnvfiJCn0hlGHnisatLk/ole67JjIKTV+6JJWKIPQGwt3rn2gYa1Y4d
	RYyvioTrI0ytwAtWvfJajScTjI4VvNK/9gQ3si+1YlqMKyVivb2wRX212Z/BO/hTLrJLl6htnxyVt
	PWdBNwQS0vnbm9NO7EO+j3kufBGP4mZHrimo5Em/KX/DACp/ABhSizxF2e6/IZm63PTQXauR889e3
	2I4N67JpNocHJ9ucvoXQ1GSlj3tDOcs6iNCTk5Q3HWSx/EPcs/oMAG5nP9FUzV+F7GwWfF0m4Hssh
	8rv1IR7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNcBU-00D656-0i;
	Wed, 10 Jan 2024 17:16:08 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNcBR-00D638-1d
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 17:16:06 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso51830339f.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704906962; x=1705511762; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGa7M+RVSIU6eb5GgLKw++O92ls2gRTpR1kY46luj94=;
        b=FwpgIUVOaMzBHnM9eIbWURR4r8l/DXcUHEa2pq9JT4MDOltEL3gAc9lN1LdAJUpSQd
         EVCo3tnvlTotw7vrbKMGTC9jNZx6vLJpcgte/8esDfqIEzpxsXMZhhRAiMTsBKM0X5Yq
         PnjXk+kniRBuvhFuKhIFAlW1gehnDYqfLEUKNkSTQRIdTBhWvs/vlc/d8xxQ9Nc2JdB2
         8hAip13GsLuq2iFCle7hRthJVDOK8DsAd01+I6qWhqqyID8FNbzYdppfEPWESFQJdtkx
         AhFpPhkHV2kKPv21VJU1sjeef8XurDbSj1nB/GNOgFdnCxzrMEttZgcFkv/ZRFsKzUcJ
         XR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704906962; x=1705511762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGa7M+RVSIU6eb5GgLKw++O92ls2gRTpR1kY46luj94=;
        b=kRHuYqDyi7tsV7sQsPBXCNnBI2aKQiRNJE2ev0/BRtGbv6bE+cblAr0IeaQ2BclhVQ
         HegtkNivep0L+0exeP6XKuo5An/g3ealKmWGVBQoHPN/izlmnuGpxvU13WHkeXdiZCRd
         UxhUuGYtnKnPB7/nXLBr88bgRYuLUA4IIMj2euGgqKty/WxAmOw5ILe4c5cIqQZredsE
         jhSrn7CnGdtShY5IGPaWnwFFrpsNnv2m7egeqY0NEKv+r7hGPlDEGMrcHY4tbhb5Y4CJ
         myAi4V3dT+xziQ2aZM77ooPvxyh8AX40nyihSGu2N8oLKm6zpj12k09uGFXPbm8OBLTP
         mK/Q==
X-Gm-Message-State: AOJu0YygCXEXPPOU0N0IdfrOuVdkkMFYSiJTN9X/0BtKyl0MpVRybC5H
	X2rpJJdIvjRqKQa5jT6ATBV3yvNSa3DyiY62wRatNsSYdl6Ybw==
X-Google-Smtp-Source: AGHT+IGiI3yKHRmc6Zyx0CyxcDxiCbs2YyWJPiHS8+YbGIDr9goI7UrxluengVMujJui0EnXTzlOmg==
X-Received: by 2002:a5e:890c:0:b0:7be:e080:6869 with SMTP id k12-20020a5e890c000000b007bee0806869mr2937650ioj.1.1704906962433;
        Wed, 10 Jan 2024 09:16:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w5-20020a029005000000b0046df4450843sm1372806jaf.50.2024.01.10.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:16:01 -0800 (PST)
Message-ID: <28ab4dea-782f-4cd8-adbc-9bcdf6aad2ab@kernel.dk>
Date: Wed, 10 Jan 2024 10:16:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: support reservation feature
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Guixin Liu <kanie@linux.alibaba.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <3a2055ff-6e5c-4afc-a0e1-36255d569e5e@nvidia.com>
 <e6427481-73f3-478b-aadb-e59b096805c8@linux.alibaba.com>
 <0652d478-9b46-400b-85ec-b3a2bb54ff67@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0652d478-9b46-400b-85ec-b3a2bb54ff67@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_091605_539367_7CC17A10 
X-CRM114-Status: GOOD (  15.02  )
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

On 1/10/24 1:31 AM, Chaitanya Kulkarni wrote:
>>>> @@ -904,6 +906,16 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req 
>>>> *req)
>>>>            return ret;
>>>>        }
>>>>    +    ret = nvmet_pr_check_cmd_access(req);
>>>> +    if (unlikely(ret)) {
>>>> +        req->error_loc = offsetof(struct nvme_common_command, opcode);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = nvmet_parse_pr_cmd(req);
>>>> +    if (!ret)
>>>> +        return ret;
>>>> +
>>> Can we make this feature configurable via Kconfig? If someone doesn't
>>> want to
>>> use PR, they will have to bear the cost of these checks in the fast 
>>> path.
>>
>> Yeah, I have added a resv_enable in configfs, the default is false, 
>> one can
>>
>> make reservation enable before enable namespace.
> 
> Why can't we make it KConfig option ? Is there any particular reason
> for not doing that ? That will also allow user to avoid kernel
> compilation of code if they want to turn it off.

Kernel config options generally don't fix anything, as distros enable
everything anyway. It's mostly used as a cop-out if adding something and
people complain that it's slowing things down, and then the answer is
"well you can just not enable it". Not useful when distros blindly
enable everything anyway, it solves absolutely nothing.

Either it's cheap enough that it should just be generally available, or
it should be written in such a way that it is cheap enough.

-- 
Jens Axboe


