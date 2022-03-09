Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4997DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kC1honlpPqbd0U19UJ9XJiEx07PrOqmIT4xgwjmDqYg=; b=Rs/JpwVFMwBhqXyk4KKcDkfdPI
	qsBjFH7qwlrbsroy/L2nR5lQD/0abl0K4dY6tjl4H51PBuufavXdtgE7KAqSPRIS3ZxoF0rMaICWT
	El97aGFXFYy8nAYj8R79ZNQXVccp5+cdRaHoJ5DpM9+kw1xNWFhcjCbw/DSt6eyuvHI5sbId09Dq0
	/FxA2Qw+bLagMojDt6rwjVhLsCkIHTfNsPGIfjBcF/9DEPKy6bOGDRGKZzPzBWZn2hcngt9SsRSmu
	P25hpwpWMa+wL8QubmWX6KsGBol5bXTtcOxjY7Ap9MzAxbYwDbQAQjTtkTq+70/LwXc7i2qnaSfP4
	P70zHeSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRqMf-007Z18-50; Wed, 09 Mar 2022 07:04:05 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRqMc-007Z0E-59
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 07:04:03 +0000
Received: by mail-lf1-x129.google.com with SMTP id g17so2117927lfh.2
 for <linux-nvme@lists.infradead.org>; Tue, 08 Mar 2022 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kC1honlpPqbd0U19UJ9XJiEx07PrOqmIT4xgwjmDqYg=;
 b=Knzq25TFwbkPITtv1ULPzaKty7jBithqFlOsAvow2l/wAuKTTUEE0S3N0j5qpidCIg
 izQAm/jZ1wt2Uxaox/LfySimB9y9lUIvTh2EN519keNpXM9TXfgTUR1yQPr87uFCA9vo
 YWnoTlzOURUvo/HioIA4CXjQLwcpof8QBCiF+TFYkW5Ur0g/gYqxG6cjwVNVa1ltLRlw
 B6YHi2wSB5N3cAKDPJOXvnoECyU17Y6XPa1LhJXmt3f4pDUX/i1s4Nk00KUS0fWzLuz3
 56Ism2Fn5Y5FOHGqDC27gY/T9AiBiSwlK+KvcvKByANLjtV7NaMIMPJdZ5vC+rfv6mQJ
 Fwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kC1honlpPqbd0U19UJ9XJiEx07PrOqmIT4xgwjmDqYg=;
 b=Jf6OuzfRvzZvtbzrb4I/xZ4RKD/T/lMQYaYFw0zJImuGZVCACFlgn9QnEhA7VpI6hG
 G1sAXm6211ktpwF7BGFNW9+T4QVT+vq1NA6p9UsfP5qL9xk9U4sHCRtNxHkJXY2VH9c3
 MnlnurQD4pj7f0PJWfBc1MSkonpk61Ug4pDOnWtCGPQ3M498G8lhvQDzu/mA0Byv97bm
 DF4l9nxaygqLRvdPh+qAVdoruQ0p7g837S+2U8IFGn5x5jVwPNn/eJxtfKJBRp3WoMxL
 rSQb2k70flNwdg1AoL7l8w7Ssj5A3mKNWZ9u6JNKW6lPBSic4GprmkJ5W+2HOM6eXtSH
 trcA==
X-Gm-Message-State: AOAM530/wcmNqVsLGWJaSZH66nKFlVHWd9Q8VgQBP67V2RAQu3jL8CYU
 ALiIhoMNg80Lp8Fjdp3ggXXsYMKL45sb+XogOdY=
X-Google-Smtp-Source: ABdhPJxiZsMxro7KEvH5gOFU6sYzzt0XHyhxDRv99yW+yYyLcHrIK88FJIeNr54w++1JqViFN/NVfgMOg9rH0RyjPZ0=
X-Received: by 2002:a05:6512:1111:b0:439:6328:c168 with SMTP id
 l17-20020a056512111100b004396328c168mr13012310lfg.650.1646809439303; Tue, 08
 Mar 2022 23:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152720epcas5p19653942458e160714444942ddb8b8579@epcas5p1.samsung.com>
 <20220308152105.309618-14-joshi.k@samsung.com>
 <20220308170857.GA3501708@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220308170857.GA3501708@dhcp-10-100-145-180.wdc.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 9 Mar 2022 12:33:33 +0530
Message-ID: <CA+1E3rLEJ49jp678Us1C3ux2iu4KWT9FF+iMjY5_Ug2MAU1q7w@mail.gmail.com>
Subject: Re: [PATCH 13/17] nvme: allow user passthrough commands to poll
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_230402_223418_9DB9A9A2 
X-CRM114-Status: GOOD (  15.36  )
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

On Tue, Mar 8, 2022 at 10:39 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 08:51:01PM +0530, Kanchan Joshi wrote:
> >       if (copy_from_user(&io, uio, sizeof(io)))
> >               return -EFAULT;
> > -     if (io.flags)
> > -             return -EINVAL;
> > +     if (io.flags & NVME_HIPRI)
> > +             rq_flags |= REQ_POLLED;
>
> I'm pretty sure we can repurpose this previously reserved field for this
> kind of special handling without an issue now, but we should continue
> returning EINVAL if any unknown flags are set. I have no idea what, if
> any, new flags may be defined later, so we shouldn't let a future
> application think an older driver honored something we are not handling.

Would it be better if we don't try to pass NVME_HIPRI by any means
(flags or rsvd1/rsvd2), and that means not enabling sync-polling and
killing this patch.
We have another flag "IO_URING_F_UCMD_POLLED" in ioucmd->flags, and we
can use that instead to enable only the async polling. What do you
think?

