Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C5EC77B72
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTcuP2C+AJHG/nFwJnZGd+3L+CfBLV6Vu/A/V4+9EqA=; b=yD+layMsf68U3Yze1qcsAeNTic
	CxawlkX4ijxQb9tIblfYvoJoOtJC8YeSkAixMobz+pMH9Z0So+7XEXGE+r1S+O9AzwGI7StoPjT4S
	5O76BCdnWOvsZVmOOwtae8n41sf6rpOHPfYunigQy1NRqIaZyIbF9P51lbuPciSUMiUSFjFuGDcZj
	J48HDm9NiGlq8Ckh9ZzU9GstUlFYjsSEccYcCORg4NX7n9irdTceBD3CHNLwBfU2ZwL69qo9v5Cvj
	kwSvPMXYLDPnoKwjnBMSH/sKDjP5S8RPtM2anKcirBGeQ7iqZptMgWTlSiKHB+KwteRjDuuDNha55
	VzaEsdfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTPl-0083eq-2d;
	Thu, 20 Apr 2023 12:29:29 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTPh-0083d1-0u
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 12:29:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so2987326wmr.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Apr 2023 05:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993760; x=1684585760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTcuP2C+AJHG/nFwJnZGd+3L+CfBLV6Vu/A/V4+9EqA=;
        b=On5Ca79ckJBbvLsMteDSbsQGRAexiiNcqus9WZu952BOYqhK3EQh7B3xMt9y1hsmLS
         /uZP4cd4TV4dhO8pUES3JJzBkS3MVs89MGNxGOvCi6XAURVOtEt3EIl6mIJJwQRPl6jQ
         4lroapHzMXGXs6ZHU/I/MHLoEJ/LRu2N0kw61p1iRItnqoUYJRbVVVcQNXgXGREv4W9G
         eIHgIAor6DnQCAg7Go38dppZlmiCjR0KDFclzOyQVOivUslAQpBjqcW8VpLVKhkXrwdp
         5c3uks/OM62E4HQ4O6TlAUwnmCZHulFcXfpY/s6nPJfTgEH/merCzzDY4hVSbOyxmDT+
         PLZw==
X-Gm-Message-State: AAQBX9dutYV+QEkHukioHys653aGvvZmxL62AXzDGZrflkGwwh0zvzVR
	Fkhq5mMwlMLyiNRUYFezBZc=
X-Google-Smtp-Source: AKy350aaCNOtF1Dp5FVmsyixW1o7a582KZIzbTA6bAcNcvBvAfmJ9yC1qp5VWWLw8itQjbmItpc17w==
X-Received: by 2002:a1c:6a02:0:b0:3ee:3e07:5d26 with SMTP id f2-20020a1c6a02000000b003ee3e075d26mr1076568wmc.24.1681993760341;
        Thu, 20 Apr 2023 05:29:20 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm5317875wmq.20.2023.04.20.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:29:19 -0700 (PDT)
Date: Thu, 20 Apr 2023 05:29:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <ZEEwHk32Y8IcT20n@gmail.com>
References: <20230419102930.2979231-1-leitao@debian.org>
 <20230419102930.2979231-2-leitao@debian.org>
 <20230420045712.GA4239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420045712.GA4239@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_052925_320164_BB4E7734 
X-CRM114-Status: GOOD (  17.91  )
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

Hello Christoph,

On Thu, Apr 20, 2023 at 06:57:12AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 19, 2023 at 03:29:29AM -0700, Breno Leitao wrote:
> >  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> > -	const struct nvme_uring_cmd *cmd = ioucmd->cmd;
> > +	const struct nvme_uring_cmd *cmd = (struct nvme_uring_cmd *)ioucmd->sqe->cmd;
> 
> Please don't add the pointless cast.  And in general avoid the overly
> long lines.

Ack!

> 
> I suspect most other users should just also defined their structures
> const instead of adding all theses casts thare are a sign of problems,
> but that's a pre-existing issue.
> >  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> > -	size_t cmd_size;
> > +	size_t size = sizeof(struct io_uring_sqe);
> >  
> >  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
> >  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
> >  
> > -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> > +	if (req->ctx->flags & IORING_SETUP_SQE128)
> > +		size <<= 1;
> 
> 
> Why does this stop using uring_cmd_pdu_size()?

Before, only the cmd payload (sqe->cmd) was being copied to the async
structure. We are copying over the whole sqe now, since we can use SQE
fields inside the ioctl callbacks (instead of only cmd fields). So, the
copy now is 64 bytes for single SQE or 128 for double SQEs.

This has two major advantages:
 * It is not necessary to create a cmd structure for every command
   operations (which will be mapped in sqe->cmd) to pass arguments. The
   arguments could be passed as fields in SQE.

 * sqe->cmd is 16 bytes on single SQEs. Passing the whole SQE to cmd
   will reduce the necessity to use double SQE for operations that
   require large fields, such as {g,s}etsockopt().

There are some discussions about it also at
https://lkml.org/lkml/2023/4/6/786

Thanks for the review!

