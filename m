Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BEC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0v39/mAWrRUi+2wTwtynXpIdWNGo3L9rkeza3agxKU=; b=wUdWez5vm8jljWFvLny+1dUUuu
	/ZyqiLsO7sHmqe5LWmWTjNBfQDGVWBOV2nJnhEzYFYTFXZ2G8bHrtW//u0GljOf3LWgdfKpugOJJ6
	u8Z5cFFFYLz0OsFDoEQE+iYnjEBqZBKCskcmS+RsT+w1LhPUVbjaPsZuEVTdr0aVgpECTwQVKkxDv
	8B2KqBVVR4jW1YJZRc9K3rHD3XgOk6bhF/DFrWX0G9y3718/r5azqGYwjmTjXJBDMq/Kia8A8KTKB
	qmWJZNHjZGte7ZcoZ4BDpnE513j1mmHZEOYtslNYVKVN7J2TpEhhjGyUavG4TvY5pQXbdG7KGL08t
	ZxZE70Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmayI-00Ft5N-1M; Thu, 05 May 2022 12:52:42 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmay7-00Ft2O-7n
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 12:52:33 +0000
Received: by mail-pj1-x1032.google.com with SMTP id e24so4129508pjt.2
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=P0v39/mAWrRUi+2wTwtynXpIdWNGo3L9rkeza3agxKU=;
 b=ni7cfQokOGOG7Gqv6CAErGvAkN8dReAFXi8deTYfu5ZuHkIHTne+SJ37JeJB6nmoqS
 8DNZdc7JMaUil+CTVIsxPfbIC7DG40Sbu5M+yTGgGYTtZAb6ZrebsdqZXF5+/SeoOmzL
 7tP4whrypFczYx1S1zjmq3o4un7be++X0rIrONEaUbO7l6tme3EnM4O6D4YLvBZDFL2z
 9ddYA6MwP9Q+UNIb1OYVq1v+80HWMJd/J+doRKiW2i0ehMZJN2iyEBZU/kX/Rj0sLMyA
 XTwe09suJhRIc4bqYkDv4PhMcM9lL3vC5HWHr9YiE3Mwdod7pj3+h+Mk3S3zWOH8DhfW
 NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=P0v39/mAWrRUi+2wTwtynXpIdWNGo3L9rkeza3agxKU=;
 b=HMGI+jthy5YcXs890pn6wo+lgVAzlZz+GqQKTbjP8hPtBBfuIgFuw3gvwgME1yznpa
 nvPU0Q4K5X5UK6XCEuwGbGOVbjQqjzkStD1U6XhtSkeyaaynLRH07pci17wHRxa6Ohoz
 8KJNIxYnetcKdkJDCB5T3eNe1MABeTf+AoQfjos5nV2sCEm5cGf4wloFcXBF0ZQpmb87
 f2IiizkS3R7b1OtErAvDTCP46Og4+NiHLueBr/SZGz7g8ZWoX30bODlhQ9OMnDYgD4Od
 JWuHRcJa7+kQOGgKtnxtgf3iLMFMw+JWzchvJgZWbdiuBWCilXll76NbxmCb1336ac0d
 h0kA==
X-Gm-Message-State: AOAM532SCqfWvcOJbOx5jMHSgD1UEQ7lgvcGIow93wHwevEiAv6+lIiG
 IYB5Tdl3bQjZsFn00w0JsiA48mRz6l7Gqw==
X-Google-Smtp-Source: ABdhPJwP8g7QNvIa1qpXfzABwAwh0/VAN3hVjn2WBcMxVuEZsrrgg7DGl6orj8lxASGqvQYWfS1qJw==
X-Received: by 2002:a17:90b:4d8b:b0:1dc:c94f:fc29 with SMTP id
 oj11-20020a17090b4d8b00b001dcc94ffc29mr1115528pjb.186.1651755147706; 
 Thu, 05 May 2022 05:52:27 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 h189-20020a636cc6000000b003c18ab7389asm753772pgc.36.2022.05.05.05.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 05:52:27 -0700 (PDT)
Message-ID: <f9051783-5105-45ba-99b3-bc5d9254656d@kernel.dk>
Date: Thu, 5 May 2022 06:52:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220505060616.803816-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_055231_517559_4861CC8D 
X-CRM114-Status: GOOD (  19.27  )
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

On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> file_operations->uring_cmd is a file private handler.
> This is somewhat similar to ioctl but hopefully a lot more sane and
> useful as it can be used to enable many io_uring capabilities for the
> underlying operation.
> 
> IORING_OP_URING_CMD is a file private kind of request. io_uring doesn't
> know what is in this command type, it's for the provider of ->uring_cmd()
> to deal with. This operation can be issued only on the ring that is
> setup with both IORING_SETUP_SQE128 and IORING_SETUP_CQE32 flags.

One thing that occured to me that I think we need to change is what you
mention above, code here:

> +static int io_uring_cmd_prep(struct io_kiocb *req,
> +			     const struct io_uring_sqe *sqe)
> +{
> +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
> +	struct io_ring_ctx *ctx = req->ctx;
> +
> +	if (ctx->flags & IORING_SETUP_IOPOLL)
> +		return -EOPNOTSUPP;
> +	/* do not support uring-cmd without big SQE/CQE */
> +	if (!(ctx->flags & IORING_SETUP_SQE128))
> +		return -EOPNOTSUPP;
> +	if (!(ctx->flags & IORING_SETUP_CQE32))
> +		return -EOPNOTSUPP;
> +	if (sqe->ioprio || sqe->rw_flags)
> +		return -EINVAL;
> +	ioucmd->cmd = sqe->cmd;
> +	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
> +	return 0;
> +}

I've been thinking of this mostly in the context of passthrough for
nvme, but it originally started as a generic feature to be able to wire
up anything for these types of commands. The SQE128/CQE32 requirement is
really an nvme passthrough restriction, we don't necessarily need this
for any kind of URING_CMD. Ditto IOPOLL as well. These are all things
that should be validated further down, but there's no way to do that
currently.

Let's not have that hold up merging this, but we do need it fixed up for
5.19-final so we don't have this restriction. Suggestions welcome...

-- 
Jens Axboe


