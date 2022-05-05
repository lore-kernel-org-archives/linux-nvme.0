Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8EAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XpEfJwZXAttT4SE3ez9GJgKqMQHTmELAKwKHFiFRKJ8=; b=wG43mhPG/frKduIYtDl3kPhAzk
	kPhkZtQRiCFV2qUsz7fyU2KlIhalCK6ePzgM6OzKy8cnJBy3GLwaHdAJQiQ4mM5+R4MPADiHeifir
	sXBgBKVRLYI832unmCSM4wetFW/8ENc1Bzku1w3UvtRIGgADNLaP31mhwhxxrTa61cu4pu7WIG6kk
	1pZZ9cV4lY6erJ+p73/VTtnaIY/GzmjtUML/RSYgYXt3mav54VGdB/fT4U8Z0m/gaWu2X5MO4rfG8
	xxSqBO9TE719nSu/twCP3QzDcfp3uDyMqiFfazDfmpG4/BDem81H/LQjjqiDUqIxDSZS7ScbcFcOE
	n4SP/dQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmeAq-00GpFj-Ra; Thu, 05 May 2022 16:17:52 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmeAj-00GpDP-R8
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 16:17:47 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 gj17-20020a17090b109100b001d8b390f77bso8461004pjb.1
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XpEfJwZXAttT4SE3ez9GJgKqMQHTmELAKwKHFiFRKJ8=;
 b=y5pm16LZdhbwVc02RrBbqrkH7GlcIxhswde72UVKlz12Zf/6rukkdt9DcoCVRFjVcv
 3Z1Huc128c1QS+18rGGTaPg4RPf0ehnXva3NUvszjTTLEREkWRtE/i/jbzTW5lpuP7AK
 0y+v2Y+n1VEn6O95BDk9VTeV7F9TUKbzZIRGsNU8OqJVhv+jaKb2dx2MIUB0Mf1sPWwb
 RGnv8sH44WrftruKVD0TecPnt4B30bATwyqTHTE+G92+K6KUsYNnHkkZuDD+hvYzrOJo
 rUyIKDdfgEth/U6AUTnpCXw4ti+8jRqRjMFMIgX2tBx/CzcWr9bIQU5kkXb7xFxc8hpt
 aqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XpEfJwZXAttT4SE3ez9GJgKqMQHTmELAKwKHFiFRKJ8=;
 b=IdQHGoKJ1TKFIzolD2IqsxW94QFlkoFnZPi4l3EGzKFyLhZutMlMO/PoKv0ERp1jQX
 /dE/QG/Sx4JMjMpbWkn/IOGX+h5q0X0u63ot0da9CmTqV4HKdu0y6/jccU4/L4vEz1qq
 hwK3svgfnPojOuRl/vusgklEhOswjMZol/M9bmqs4udVDFfYy932S5dumqVouonHkSP1
 IDjppIVGCV5ehSh+M9L3Vm94EnrXn0eWM21e8MKHWM3qh1Hkzl9oqq+GWuP3Ndfy1jxB
 5SLqyhh4U+SRAADoi58ELZNld1WaX2XmtUf8aiiVmfhiDdYhyNH/FONAgS0UKJi4X4SQ
 hwXg==
X-Gm-Message-State: AOAM531JEmfzdRXVGCwSUs8mMIjP2CFH7VJjXx2wmLT42qh+2ZINJImp
 vJPnQThOGOTWEkDkI0KcNc+vNA==
X-Google-Smtp-Source: ABdhPJzUJaZxFJ3VIVHned8hOSB58hXS65Ia/i3cW5fG+fWjdM5G/EEO4OJEX88iWIh/FNrMwQhBpw==
X-Received: by 2002:a17:90b:3b8e:b0:1dc:94f2:1bc3 with SMTP id
 pc14-20020a17090b3b8e00b001dc94f21bc3mr7126632pjb.193.1651767462144; 
 Thu, 05 May 2022 09:17:42 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a6558ce000000b003c14af50639sm1519783pgu.81.2022.05.05.09.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 09:17:41 -0700 (PDT)
Message-ID: <1af73495-d4a6-d6fd-0a03-367016385c92@kernel.dk>
Date: Thu, 5 May 2022 10:17:39 -0600
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
X-CRM114-CacheID: sfid-20220505_091746_121705_C9DDEAA2 
X-CRM114-Status: GOOD (  22.42  )
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

While looking at the other suggested changes, I noticed a more
fundamental issue with the passthrough support. For any other command,
SQE contents are stable once prep has been done. The above does do that
for the basic items, but this case is special as the lower level command
itself resides in the SQE.

For cases where the command needs deferral, it's problematic. There are
two main cases where this can happen:

- The issue attempt yields -EAGAIN (we ran out of requests, etc). If you
  look at other commands, if they have data that doesn't fit in the
  io_kiocb itself, then they need to allocate room for that data and have
  it be persistent

- Deferral is specified by the application, using eg IOSQE_IO_LINK or
  IOSQE_ASYNC.

We're totally missing support for both of these cases. Consider the case
where the ring is setup with an SQ size of 1. You prep a passthrough
command (request A) and issue it with io_uring_submit(). Due to one of
the two above mentioned conditions, the internal request is deferred.
Either it was sent to ->uring_cmd() but we got -EAGAIN, or it was
deferred even before that happened. The application doesn't know this
happened, it gets another SQE to submit a new request (request B). Fills
it in, calls io_uring_submit(). Since we only have one SQE available in
that ring, when request A gets re-issued, it's now happily reading SQE
contents from command B. Oops.

This is why prep handlers are the only ones that get an sqe passed to
them. They are supposed to ensure that we no longer read from the SQE
past that. Applications can always rely on that fact that once
io_uring_submit() has been done, which consumes the SQE in the SQ ring,
that no further reads are done from that SQE.

IOW, we need io_req_prep_async() handling for URING_CMD, which needs to
allocate the full 80 bytes and copy them over. Subsequent issue attempts
will then use that memory rather than the SQE parts. Just need to find a
sane way to do that so we don't need to make the usual prep + direct
issue path any slower.

-- 
Jens Axboe


