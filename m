Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C875C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pzoy1lB0v/6rv9DQZd9VxpupwhasQh/2PyI0IHfFrE8=; b=HZ6djkMNv5KFeQsKfKOwj/3kb4
	eR2jzg+li5ToDbi8eMBPXKW+eBrg0+r7+rPwYscly4RsNSD6ILVuI3eDofywjou1yVyGU1abxfy+7
	/Onf19CAICfFIjp/hxtnytGBOJDB2OnnCzOQcDG1CudrK0xhNpGR0k6e11pXxOHjQrFp59vqRWyX3
	LCEtwOzl2BgPMe2ANhWkT061UWBh2E807biOGviuY5yeDiN2xlD3CuvR7W2Mk7K+3QD2t0fgce9sC
	4hyGRymc/ygrtcA7XLVu/P6NaTLXU16MRTEBavYd9m3mEbt9vQEKXhblB/ZCQ+nO7LMDl+r0N7SFc
	+lFYUcGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUqK-00BDku-Nv; Fri, 15 Jul 2022 23:35:32 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUp9-00BD5K-3v
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 23:34:21 +0000
Received: by mail-pj1-x1030.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso7509019pjh.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pzoy1lB0v/6rv9DQZd9VxpupwhasQh/2PyI0IHfFrE8=;
        b=RUs4RJG10t3npoapeFLstot6OT3s2CAwPPMDxx6WbB3XyCwITIKcdE3hATQeTbgqfx
         siSLu2Cow1Al91+Yj8cXP5+AWJYjhrWfOMekD+G6U75zr6J3b+m0Har1b5wy0oea/Fuo
         K6mRsgzH2NiuaPebhGSgxUiRrXnFBypAVT+ZYqxzkksZeIz7aKtkb//RMMl1plawY3ht
         W0ALarB+KnUC9LxxFHiauxK3EFv6BIRLpzhGmpOlmeP0fgWQ39bO+hhJdQ1KBHBMXDOj
         2AOdqFWz4vnpQ3laCcsLaYV5N+tcLXX1MC/zSr07XvHakv3Ez87bNlANsMXCky9ks+M6
         TPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pzoy1lB0v/6rv9DQZd9VxpupwhasQh/2PyI0IHfFrE8=;
        b=gTTu8q8Qj6JLtgBeCXvCIZy6M2+HO/rv582RvvlCiwt2UgwtoIRUyIN5IIYSHhrTPw
         XC5EGLUqa4vBrVt8EDHLKqaRk82zZBkeOkjTR55M1PTULkX7v7zPP0oz5Ped2VocMKi6
         lXGabphIhkXkPes2SSo4SKPrrsWnOB3yIzgTkyZ/OYyyhpP4+m5OhPwsDZFx2V6Sa2nm
         5IxvqtXlXNF+2I2fFtLUbEcnKe6JZCd6JhvEDDZHHh+pQUMTzxN4ZFzkkkIkZ7GtyQ2o
         DG69/S5ubJM+4d6QBuBxShBF5rilARIK97hgqcbqz936hxMlYTusAoL6Lb3azZ/ia3h7
         Rhuw==
X-Gm-Message-State: AJIora+6gGr3+fLDRMCl0AAnZ8L7RPCbeoCC0aNL1d0Jf8FsyHLibqSI
	n7otJ4wRUsBKUAMKRV3r3+EsmQ==
X-Google-Smtp-Source: AGRyM1vuPuU3qfouowNfCFYUqlvzGi9NLhytJ13Q1VlElKwXTIZX+SBEfFQdjaOUe7RlMwvURt059A==
X-Received: by 2002:a17:90a:d714:b0:1ef:b93d:fc4d with SMTP id y20-20020a17090ad71400b001efb93dfc4dmr18709466pju.49.1657928055988;
        Fri, 15 Jul 2022 16:34:15 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016be702a535sm4086321plk.187.2022.07.15.16.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 16:34:15 -0700 (PDT)
Message-ID: <7d928dc4-ed59-3858-803a-41b3947ea12b@kernel.dk>
Date: Fri, 15 Jul 2022 17:34:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore
 <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: joshi.k@samsung.com, linux-security-module@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, a.manzanares@samsung.com, javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <566af35b-cebb-20a4-99b8-93184f185491@schaufler-ca.com>
 <e9cd6c3a-0658-c770-e403-9329b8e9d841@schaufler-ca.com>
 <4588f798-54d6-311a-fcd2-0d0644829fc2@kernel.dk>
 <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
 <27b03030-3ee7-f795-169a-5c49de2f6dd2@kernel.dk>
 <5615235a-ccc4-efc7-c395-f50909860ab0@schaufler-ca.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5615235a-ccc4-efc7-c395-f50909860ab0@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_163419_206474_6C8653D3 
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

On 7/15/22 5:31 PM, Casey Schaufler wrote:
> On 7/15/2022 4:18 PM, Jens Axboe wrote:
>> On 7/15/22 5:14 PM, Casey Schaufler wrote:
>>> On 7/15/2022 4:05 PM, Jens Axboe wrote:
>>>> On 7/15/22 5:03 PM, Casey Schaufler wrote:
>>>>
>>>>> There isn't (as of this writing) a file io_uring/uring_cmd.c in
>>>>> Linus' tree. What tree does this patch apply to?
>>>> It's the for-5.20 tree. See my reply to the v2 of the patch, including
>>>> suggestions on how to stage it.
>>> A URL for the io_uring tree would be REAL helpful.
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.20/io_uring
> 
> I'm sorry, I must be being extremely obtuse. I want to create the Smack
> patch to go along with the patch under discussion. I would like to clone
> the tree (with git clone <URL> ; git checkout <branch>) so I can build
> the tree and then develop the code.  The URL you provided is a web front
> end to the git tree, and does not provide the clone URL (that I can find).

Just go one level back, out of the branch, and it'll tell you:

git://git.kernel.dk/linux-block

or

https://git.kernel.dk/linux-block

and the branch is for-5.20/io_uring as in the link.

-- 
Jens Axboe


