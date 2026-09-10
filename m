Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B978C79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZ0h9Lijn7HXAqX9b+lmGKqsZXvcLGZp1gaUS0v8TAw=; b=UGPyywZOgBNmxozXcmlCWsfj/P
	3kYwRFpY2UDlAHvtsB8RcLHxqW8BeFNB00AQv1Ewc2nLneMd2Pl0PGt1fy/l9JIr0d98v5mEtmshk
	os0aIlPGZUhOQ9w1XPrld7siMf6P0GDr6EClIakisnoChfK3ZCG/8F+Q/Gf2qoluc4LwwtPQ9Tdpl
	J/WBgco8MAXmYrbkMd79jlpeHKZZQsGFnjMlChMtBp1zDLhPjSfaXcb6z+zoW0JQnI7zJYqASo1cD
	6RWIyAxWJ863EBK2qWU9yhOarn4gYy55qAv2SoTSltaVpI7xCX494QmopDInQqTIIAQ/aYodMa50l
	yTS8EkKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XdN-0000000DTes-0SZv;
	Thu, 10 Sep 2026 05:47:41 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XdK-0000000DTeT-44Bg
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 05:47:40 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ceab75934dso64643735ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 22:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789019258; x=1789624058; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZ0h9Lijn7HXAqX9b+lmGKqsZXvcLGZp1gaUS0v8TAw=;
        b=j5keDtBOctfPiO5xWJAVCds7fRVaHW+DlXcFQ6fZslHyV2/ItiuQH3V28UOEHRU4E5
         ozUUEWCIxWQrie577PmpF2cwk77H2J0ZiCIVtuphwDHMAvi6dVdiBl2+2JgpuqXlLntS
         h9X+M3ywMVLkU8gEWIccmWhUaDlEeCoO0dOGB4cjIphoXuIeNNhrAnP2yTtsg3Tl5epZ
         DauRuvuoVGnCHn8k8DYbNZ/MV8+BDeHiAUeEhmf0WDCcY2ajHYbhC+RaUJCs5K0aJcRs
         nCqRtJ7/yKe2OceMC4WdI2nlZZolQDEOcUpyAqPirdVcTARicFQmpoHPAjyKNRrTYlT1
         FVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789019258; x=1789624058;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZ0h9Lijn7HXAqX9b+lmGKqsZXvcLGZp1gaUS0v8TAw=;
        b=G/E3DgysBf1LtWKEQWQ2hiAM3zVoW0mo1x19puTxbMOwOSEhTVKDIVr6+ihVgWYh4B
         4L86Qf2vSe09s7j14w9LaXx7KuHFEhmVdAM+bvIF5P382x5AelE5SG68IunZ5v1aj+oO
         6MXqIJtZ5R8aeR0kwvz2tNB7D6t1Pw6z1vsLLPxrN6vmKJ0LN8Kl1bxR2GN4/jCXqwNM
         NohZkqv0zkjclvFK10JJLhJwVitiI+Q7Tbriu4d3yWWAQpmWzmaPSIfhL+gRL6KteZvO
         o5DpEeChYCDHdyOwyv4NnXaD/hAsvMHLhytwr1GnWBF4zVH/qqOOqFh6v0cXOvyJURds
         Y7Xw==
X-Gm-Message-State: AFuF++lCjEOqH62Qq8qLtUt3T63Scxts0MDwe6+BWtB17+sxQEEi0D4e
	BlBtg44Vhpe4yJx7CTLC8T0BVln/yXAnfhN+iCf9kN8ODQHS3UXB+14cLQaGOF/rGYU=
X-Gm-Gg: AYBFou2p2iWP/4/028bLASROYYS66Xo4BJH/ZfGTsM/SzVn1EvcJmEoNhnkriWAYD+R
	Xh4KKziqKq77fKm0f/NboMnnrNUxeqSr2ZGPDnnwcJy28w7CrHmu7TFq+H0JQDRLdivZTzKKu2n
	oMmdRC+dVTv1Q8TPzycSNK1wxCGU9ZmOy+K0RY48UEnZj8rwvQjsupFaYiGXV86MiH+P/pfsBsq
	1foAjGG6iSS/5KMAEA8IRwv/1SEhC0oXw64Xf+ljsZ5/WXxeZCjOEIxbhduDRfltjcUYONg0IEN
	pCzMliQQ76q8J21pu7UjDUSWFQwanZYkPB0gdQXx+sRCACwN1HuCRnDBxS6HCmMgqdwavTceq82
	mj0/piJVsYuzkgPr2xxqyrf/b1tXe8mbqurhzerlfq6gvFwvvYHwDXhw/MQZO2NyYLbmtjLFQbv
	TtZiKZCUB/Z65PmwKshpuaIhCpYZC5r7Lh5vB45tEmmATQNg12rfWKlvBhhUWi0wf2n/kecG8vx
	1y6nO5xDAZbq/zfQjLfOsPFBqWCAZVZv1hQo/TkKms=
X-Received: by 2002:a17:902:d587:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2db1265add0mr601825635ad.7.1789019257016;
        Wed, 09 Sep 2026 22:47:37 -0700 (PDT)
Received: from [100.81.12.150] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149cb603sm82805375ad.68.2026.09.09.22.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 22:47:36 -0700 (PDT)
Message-ID: <0d28ee2b-f1ba-4c36-a738-cab2342e1b68@bytedance.com>
Date: Thu, 10 Sep 2026 13:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: reject enabling a namespace without a device
 path
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kch@nvidia.com,
 ming.l@ssi.samsung.com
References: <20260908033519.2721210-1-sunjunchao@bytedance.com>
 <20260908033519.2721210-2-sunjunchao@bytedance.com>
 <20260910054235.GC27511@lst.de>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260910054235.GC27511@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_224739_020367_80FB8B52 
X-CRM114-Status: GOOD (  11.81  )
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

On 9/10/26 1:42 PM, Christoph Hellwig wrote:
> On Tue, Sep 08, 2026 at 11:35:19AM +0800, Julian Sun wrote:
>> With buffered I/O enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
>> before validating the device path. Enabling a namespace without setting
>> device_path therefore passes NULL to filp_open() and crashes in
>> getname_kernel().
>>
>> Reject enabling a namespace if no device path has been configured.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you add test for this to blktests?

I noticed that this has already been fixed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=09d0c07bd9ce3b2f2d993f672698d32a17543c32

But sure, I'll add a test to blktests.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

