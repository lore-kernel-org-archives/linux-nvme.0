Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0255C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 20:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c86qGK32nsVnfDBPzlK095zL52GuJJiCp8X2BQjYCGc=; b=W/aubgHePtTV2cpDOoLNtHl+BM
	YxXivx4qZNqhL+4oRXgae4cFF+i7Y4sQV0rgDimz/e07CraaMjNpFpm2dW5Gb+/lPcQT3d4YoFb92
	0iD9N0313OFequpBdkBDZr5tRsHmES3tSXZMI3JWE1ZL4YSrzW0d7Kl/W3z22U6SDJ7I5Dklj925N
	vlMksalSCUJ5O2ZZOQdd2qAll12THTDQOQDbeEZYSvjpwZyg1KHVkaU9ztmY8x0Xb6G3fo4UZ8nyx
	d+3AHMZxeRZUl1ImcD0IrjlJNB0nadFcySLT1st///jAkZh+zPSXPfLZ/v0PJBHmKz6Csmi4RKJEQ
	/s0zc3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzNZb-00Ay4R-17;
	Wed, 17 May 2023 20:16:35 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzNZZ-00Ay3A-0c
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 20:16:34 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3094871953bso99326f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684354590; x=1686946590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c86qGK32nsVnfDBPzlK095zL52GuJJiCp8X2BQjYCGc=;
        b=oqWa+B8kyAPsW4QlrTWMBcnQ6qkKfyZxb5J3HvGcGebHHd+vNY2EihBHc4ILA6LgDu
         0ArlwQwQLtzk0wpNADCyH+akhsJqxocIQ0Agr6IgmSGMql2O9O6/gbK2eRqs2hIDy+Nr
         NXHS8rM1Z4TUlhIPw4456fbpBwDnjjak0XYrlwioSBnQmL6/i2/ECjf/Imqfa+mbRkDD
         Wa2518d6D5x885Dy3INmBmHpi4pUmwjxIOrU0XAO+alj4JNf/kEUROiFadVsaJQo1Y7a
         NRs5Sf0Zao8aNFwS21uCHcSWYVNVpvhGwuR6zzjzCdDNlUhot9fz+0ij3fxJ4/2ZszJp
         9vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354590; x=1686946590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c86qGK32nsVnfDBPzlK095zL52GuJJiCp8X2BQjYCGc=;
        b=DdnxD3Rx72J1qf1EnEugu33dPS9PBl8SVyJt5GnooLLsxPVk6VZazEbGt7kWCTqp63
         k8HNd63p3Fq8h+yrbWD5kki6E/ePrz1KRe0oh/kL/GdwSCpgWK+ZxNEjEZXyZaSDXNBl
         y1PhjxxkjPR7ecruPjbU+x7gm4T2vCyPXAOmS18QfItlN2lnBuBJkx8OCZtcHqlkHbtW
         wceZUXsvKF6Kgsn2fyIF/n+bBp9X/A1IXh+oVFNaZwF+26WZb0qCKzLMKmE+2h5L/6f7
         Eo6vm9GWB9LFR5I0149eBeuUFQT+ZzLiCrJJd3Qril4WqJ0Qsq2whkaFyfJD+8Gyu1d1
         f9vA==
X-Gm-Message-State: AC+VfDwqZJYFohHzOgduux2rK/cQgPVgSxufudVKBCQpvdp+gdA+HkTZ
	8tM6kO96aNKVdMP0g/7cRn0=
X-Google-Smtp-Source: ACHHUZ4KIAlW/zpvww/YX9ZRyQer1/jw0BjA72Duf6MXqTA5icpc5wNDFZ2Dj7eyKkkedJ9UQ0itRA==
X-Received: by 2002:adf:db4e:0:b0:309:4123:4968 with SMTP id f14-20020adfdb4e000000b0030941234968mr1415027wrj.13.1684354589699;
        Wed, 17 May 2023 13:16:29 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.236.195])
        by smtp.gmail.com with ESMTPSA id h14-20020adffd4e000000b00304aba2cfcbsm3762683wrs.7.2023.05.17.13.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:16:29 -0700 (PDT)
Message-ID: <b28c60cb-a923-967c-887a-71a6590363f1@gmail.com>
Date: Wed, 17 May 2023 21:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org,
 sagi@grimberg.me, joshi.k@samsung.com
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
 <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
 <20230517123921.GA19835@lst.de>
 <61787b53-3c16-8cdb-eaad-6c724315435b@gmail.com>
 <20230517135344.GA26147@lst.de>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230517135344.GA26147@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_131633_251170_5C03DBD2 
X-CRM114-Status: GOOD (  16.08  )
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

On 5/17/23 14:53, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 02:30:47PM +0100, Pavel Begunkov wrote:
>> Aside that you decided to ignore the third point, that's a
>> generic interface, not nvme specific, there are patches for
>> net cmds, someone even tried to use it for drm. How do you
>> think new users are supposed to appear if the only helper
>> doing the job can hang the userspace for their use case?
>> Well, then maybe it'll remain nvme/ublk specific with such
>> an approach.
> 
> New users can add new code when it's actualy needed.  We don't
> bloat the kernel for maybe in the future crap as a policy.

Let me put it for you this way, it's an absolutely horrendous
idea to leave the old innocently looking name, i.e.
io_uring_cmd_complete_in_task(), and add there a bunch of
restrictions no new user would care about, that's called
shooting yourself in the leg.

So, we need to rename the function, which, again, for absolutely
no reason adds dependency on ublk. Why doing that instead of
waiting until ublk is converted? That's a big mystery.

-- 
Pavel Begunkov

