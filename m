Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56682C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jun 2024 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knIuVjnXEJJ+j66MeUZ5fq37co54uOPBN7W+VUSdPRA=; b=QZnxFA7GJ4UYVYyk6ygNP9kRRT
	xlL/5XyCdI8ucyMK2bcmPG3ZRhMYRXV7HVyV78OVZX4ozW7FseS9lA4+wmM5VJpoUvGthpABohjXb
	ejtRMrO4G/LRFHXAeeqHCddqaDwfnTSvtYbmGj0GgxAPB0lQg9c8IWim0cn3ZIQH4Os0S4Zv0l1Nq
	gMK4QKpdVlHGx6DvlDVvR+x32gQMgz5m8hc5u1+xHSJcYNhmn3/x4fm7DGfcZ8oo4ieXSZQObinK7
	6TVAVD+sruQ2K2pSElcPsYA255+F3Caz/oHNiB3wZi3dZ+kJnXLNctNSFqLvEBquo/hsDsyp4Hsrn
	GKGLLyfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIK5-0000000Esth-4BzJ;
	Fri, 28 Jun 2024 20:35:58 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIK2-0000000Essr-3RGY
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jun 2024 20:35:56 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-25cb022c0e6so140126fac.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Jun 2024 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719606953; x=1720211753; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knIuVjnXEJJ+j66MeUZ5fq37co54uOPBN7W+VUSdPRA=;
        b=Ntji5eGhBIEAqSYGySQWs+4zZv9sHH6+ptzcQll2Zap+uQReH/GQOb+ICtHYkcdKCk
         0lbVUWYjLHcJMf7XlSium7EEFr8AdVFEvzMgUuEnR2YQW5+5BV5nl+637TohIIItFf2H
         0epjOJLIMYadTnlxStXaQdgIgafVMyra0U68UB0561tZR+UKBIMsyS5A0jZIcWfG1NQa
         ph6hmA8ZpQ9wzp3VPV3mi3eDV7jMvAK3pXIjDrhYL7IabNmKlIg1QmXjfXxHKomBw1Tr
         889DkYwGhl3woPrzz1TO2vZiNvLAFw4A8C/Zq6mSAhbyatAli64MFGPgsKc9gqIvK+83
         ISLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606953; x=1720211753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knIuVjnXEJJ+j66MeUZ5fq37co54uOPBN7W+VUSdPRA=;
        b=WFRd3cdGpTNp3tXGKT32tO/0Bmq7nhtYJTa7/qvAqju5OY7SOhrczMzn3PTc4G4z9e
         lnE1b2vcsqxTQz9YXS5zA4PcrT24aQmzYgmNUVotMPqGcgCVU0nkAZhL6LHn71hKHgxo
         wHSKTMpFtV2XOv2qZWIvnlqjLSzhM4Nmf314PjvsGPBrg+D82esBmsGwIKO4OG/JKwt9
         Aqz4W7556fBJtmgxShnnujWysIQMjOS5rslTugUVfB/G3Bsu3H0F78d5bvUd+pyn92S+
         RKi/W0YJ7Ir6yVzYe5cn/16+aACXi9jcQSwG5hHLNqJgugujN/XGrrx1Rim9U9hORNVa
         HJIA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5axhtD3AUHIHEOnJVh4Qpvda6YPJE07D5FZdbD9Z3rMELZ1RIWuuved2/AOQo1N2FUw0hRamInX/q5bK1TQfu88YJZZRGMYKpwxzai0=
X-Gm-Message-State: AOJu0YwGl77fhO9o1tfuJnalpymve1GUrf6uEW+Yh1j1Irz7O+oDxP0U
	GQAvq9mNZ4ZanOMEQqicukeOdInMuG2fBrAAqJYYkgctFQClEGdJC/h+g9FbM+0=
X-Google-Smtp-Source: AGHT+IEb27cDCyXqmGni9JEqeFfVr+iPwZqfQQ0Azcu74e0UA/6M2OvYs4xelVHD0QGZqahyFDcDGA==
X-Received: by 2002:a05:6830:3d87:b0:700:ce5f:968c with SMTP id 46e09a7af769-700ce5f9712mr10578115a34.3.1719606953383;
        Fri, 28 Jun 2024 13:35:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7a98f39sm438118a34.3.2024.06.28.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:35:52 -0700 (PDT)
Message-ID: <0d5d9177-8e3c-4ee2-8a77-8bcd59920118@kernel.dk>
Date: Fri, 28 Jun 2024 14:35:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] block: set bip_vcnt correctly
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, asml.silence@gmail.com,
 mpatocka@redhat.com, kbusch@kernel.org, martin.petersen@oracle.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20240626100700.3629-1-anuj20.g@samsung.com>
 <CGME20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94@epcas5p1.samsung.com>
 <20240626100700.3629-3-anuj20.g@samsung.com> <20240628060444.GA26351@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240628060444.GA26351@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_133555_085263_57BDFA95 
X-CRM114-Status: GOOD (  11.33  )
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

On 6/28/24 12:04 AM, Christoph Hellwig wrote:
> Jens, can you pick this one up for 6.11?  We can't really trigger
> it as-is, but it would be good to get it out of the way and avoid
> someone else triggering the issue (e.g. Mikulas with his dm-integrity
> work).

Yeah done - worth noting that patch 1 in this series is already in
my tree as well.

-- 
Jens Axboe



