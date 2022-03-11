Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C4C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 02:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qM/UV7FHcZxY+IHV+9o1h4m2AAXBVlhwLsCWQjNFw6I=; b=Tx33ujJ7xe/McOAbxRiiGDn5pe
	UIRD8y2o9/WQbHSXnOtk5z7cMdsjQ+1uKcMjpMMcUO1tFtV6VEftstU9iQBLs0J98hCupYQXcnsf5
	3Z8jH+bK5GDkYlHYhL6NWnoEM1gBIpArNkMRHObiNGsG4SBHqW+A0iamynpZUyA8jua+zSzGPTSYb
	muGUQ8cSdDiHK8VTHeEDLFbsqU0GpzkPrVnp4IMDKbTghTzH5tYlssds5sEQS0Gnvux/ex1TmFKWE
	doEQy8AgBgH2ARtT59yazDzPEd1J8XaZke0GDYSOoz+7CoubBi1Q5oaLij/mThb30NUOTsS0A4WQp
	Mmm0821Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSVFL-00EnDc-3D; Fri, 11 Mar 2022 02:43:15 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSVFI-00EnD2-Qq
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 02:43:14 +0000
Received: by mail-pj1-x1034.google.com with SMTP id cx5so6979359pjb.1
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 18:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qM/UV7FHcZxY+IHV+9o1h4m2AAXBVlhwLsCWQjNFw6I=;
 b=ydMQnwYy5mk0UrEDpFa+OzSqWyno7VdmtQZ4bfjscLiVtXeeYVJVHVu+Mb0h4Vw71X
 E68oqQvdJ3eJnjrN7LMFdsbQp+X/kQR+b5pTXoHqtJJ0G3cy9tx5mAW3nACCkJbRvM4v
 EdCOHa+OmJlmb8Pwo1s8JJQOmxxHn7wWh8kDfOtJYSFSqRGDndPW0eep+1xcaLzpklDl
 OWKyTEVLemVTMmWChdzBievwdhqW8ewCBeTaTyeCznVALCNKda8tXPHMFl633q7NQsRH
 jPSdf4WiEE6bUCFmPOXjx6QaQhT9JsVH2qu17vIbBtAFWu8LN8fSWPVolwDwwFOvyurF
 WkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qM/UV7FHcZxY+IHV+9o1h4m2AAXBVlhwLsCWQjNFw6I=;
 b=rKCElhkZvrluO4l1k08MjJSeelP69LkI/IGayEK02BLAQRgHXB2VxRCBu2YgZ7FrqP
 zbKYCjQqiYPHEklNiA+/sGh6uVGvbCfKDY7KpC5qsFwlzX7jk8GrL89Fk86SAXBOAL2X
 xsqGAErmVHHuIVeDrfdwPLqUkmrXeQeWm0opCsA/2rNunea0Z7gq37O/yT8oGhejfYgV
 XevkUwEkeLEuWlKFptUQfVH0gShxnZa/OuK0D4r2+F0htwiX7s2IRTUIb9mR2Iz8NSe5
 nUCLGi5yKQ1R5B3BYYgTTAdwsmPIyNUldgLCwhf+SPy6ox5WO/nsKs6eZcwb2ReCIynx
 Q5qw==
X-Gm-Message-State: AOAM531zEIeKbxans88Kbsrds+TyawacjnXfNXl4YWPxTHsxFEyx+4MW
 f+AlzyfIK5uDKBnhaDD7GB3kcA==
X-Google-Smtp-Source: ABdhPJxncp1/88IEQE5teKvz0gCS+nBv5XeRvmq3TMQgymIIQ+EEz1/9y6h1o6JnJMOSOqyGfVWtBw==
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id
 21-20020a170902c21500b0014ff1c29fe3mr8274323pll.145.1646966590724; 
 Thu, 10 Mar 2022 18:43:10 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a17090ad99000b001bcbc4247a0sm7161458pjv.57.2022.03.10.18.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 18:43:10 -0800 (PST)
Message-ID: <e3bfd028-ece7-d969-f47c-1181b17ac919@kernel.dk>
Date: Thu, 10 Mar 2022 19:43:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 03/17] io_uring: add infra and support for
 IORING_OP_URING_CMD
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Kanchan Joshi
 <joshi.k@samsung.com>, jmorris@namei.org, serge@hallyn.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, linux-security-module@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, a.manzanares@samsung.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152658epcas5p3929bd1fcf75edc505fec71901158d1b5@epcas5p3.samsung.com>
 <20220308152105.309618-4-joshi.k@samsung.com>
 <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_184312_964400_7AFC4D7F 
X-CRM114-Status: GOOD (  15.11  )
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

On 3/10/22 6:51 PM, Luis Chamberlain wrote:
> On Tue, Mar 08, 2022 at 08:50:51PM +0530, Kanchan Joshi wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> This is a file private kind of request. io_uring doesn't know what's
>> in this command type, it's for the file_operations->async_cmd()
>> handler to deal with.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
> 
> <-- snip -->
> 
>> +static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>> +{
>> +	struct file *file = req->file;
>> +	int ret;
>> +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
>> +
>> +	ioucmd->flags |= issue_flags;
>> +	ret = file->f_op->async_cmd(ioucmd);
> 
> I think we're going to have to add a security_file_async_cmd() check
> before this call here. Because otherwise we're enabling to, for
> example, bypass security_file_ioctl() for example using the new
> iouring-cmd interface.
> 
> Or is this already thought out with the existing security_uring_*() stuff?

Unless the request sets .audit_skip, it'll be included already in terms
of logging. But I'd prefer not to lodge this in with ioctls, unless
we're going to be doing actual ioctls.

But definitely something to keep in mind and make sure that we're under
the right umbrella in terms of auditing and security.

-- 
Jens Axboe


