Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58779EE644A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r++fjGqWkxDZfVCNhZlStzMaDRIbaljNb2IsrD6Hxf8=; b=gTkhi9S/LZqXUUt1akXPOQN8o8
	ivA5UVZjnOEo+dRXGnD7mzp7kCRpxr9PGjNCtivwoxi9/Nu01Gk6ykURG/99yEdkgmO5XbnZ0W/Bx
	GYIT4/jcgElev7GBoezwc4LMTaMhjZH77PvX8XGtu6XOKZR5ulFXZkVdxk158gBLTCQoDG3tSwsQv
	s0Sagi0xbz/zWbP9G6emj778G5dkoqT6IR5haj6GJK1BvXCYFWnfvMGxkKlfw3tk11E2h03wJedU8
	PcpYe0Xir6tQoybSHdms53saosRWWnXZDxY3r0qRoZkf8HCz/nGnm+IJZdYoXYoa/gemXSohStI8O
	HlAzBTmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5yf-00000006R8u-3kV8;
	Wed, 31 Dec 2025 23:51:41 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5yd-00000006R8Z-0x36
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 23:51:40 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-29efd139227so146791285ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767225098; x=1767829898; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r++fjGqWkxDZfVCNhZlStzMaDRIbaljNb2IsrD6Hxf8=;
        b=D6kjwQ6gHJaMw+7I+mJtxWK9IpK+ajZDKt7oqcd4zUpUWLWg11SY+pBOE9YuJjOxIb
         8ki6bDdApE1EQQKhnUrKG5/juGASy/qL2MhBlIwzhPBe3MR1XqiLxlaewFgP0IC/PB0z
         Y/VrVc3wQx0s1I7UsERjxUNXGW7S+JTErmTfuSwrAqgLAc2ao+vjvVkR0kezqlb+UKLL
         QJiqoecDTUBvohdoUGSUb5mnvltveuuy0mKPz45coQPMrUIfIolOMcZ/c4KqpA7O/8NC
         aKOVCGazzX5bmQKWyxJmkotOuBWl4X0L0ZFCIvQf6QV2L/Qzgm6iyrCGkt7jAaLDkzN6
         Jw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767225098; x=1767829898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r++fjGqWkxDZfVCNhZlStzMaDRIbaljNb2IsrD6Hxf8=;
        b=CIohf1NvtDV47ZX8SVUYa8xitVOV+5U4OshB35/hnBMm97Gzgh7XH+eC3IDmV79/af
         wPmay8og0krPeK61WtFHf6yIhEzOrUtCf2N+6ri/6zNW3WiTfTpgfsmBRU/voOG/BeDf
         FAvnWN2R+c0TE23A5QLlAnBZPEEe6+m5onX6LR4UcWV8OU6dQEeKMl3UnG8jnxgRnOSE
         0AZ+uTOTJH74WP/pOt5yIBDxDARUlu7EDmMzcVZFnki+lyC+v75flzgI3W5NhDm+TQLM
         UvOPOk0JQFNoc5dox3gGtml7Elb/4lKblOMfaj8u8ynw4L/INbCUdccMpPtbDwSvFYhh
         R5IA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOkqYRTxBDOz0Xxl3NJFuncccbsxERhCPbDP0tGwO7Fhpq3a90MkW8WpK/6ym6wcFT/Kskh89ytKG@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0/3m0bi6u5F/g1vZQeI6VoYWWs2xy1YMvYK+J/NZ87fUNakMs
	azyle1QuYJK6GkJtm1WipZPja99SwUDB0Q71/GpE80y1ShZlkCbIxioeAYMYKOmJ7cw=
X-Gm-Gg: AY/fxX7pEQPmc2sFzoR5IML0pPQSBV1q6iskO5XovjO0emW1p+dfrFZyUiL/huT2rG1
	tTtjrkt9Ln4Ux0S/0Mf9O1v4gz2cN6xJguXRvofWvjWvUtDXxzzqnD7RV8UxJiMnp7lBWdiE9kI
	FOV55NLu6Ve12G7EVce1o2T7mH4MH6nmillTnvJGCQtdj1X80TbyHeLYTjzMUPO6fLMSm7Sls7W
	yzA9yjgSjo+Gpk431BVFiOcI5Ex6gr2l7JOn5N8LU73wMHejE+vBxzdDKKs+cD4iQhpOQuh+qGU
	WiySx7lzCQUvzGmWMYklGL0hjeX+S3Vh8qTzqnnkxelIDp3MrHZLx8RGki9hKU3eMeLyZuBjHtq
	dZRA7Q0phFpTs9is4pSQYT6h1VqQXzwjUAqUVt9O5kYm0Ueh5lRWmQwdKzDIPGVjQYejp7Le8i/
	N7J1sg04HL8tRugqZSi9EIG5T2iX3VR6Q=
X-Google-Smtp-Source: AGHT+IHOGyDDmKp/WTk96LD/9LH6/uN6yMkmUbuyV8AbfWjQILaAbhHRsxCcaON8ZmhPdTNUck4PKw==
X-Received: by 2002:a05:7023:883:b0:11d:f890:6751 with SMTP id a92af1059eb24-121721acc21mr37058106c88.10.1767225097844;
        Wed, 31 Dec 2025 15:51:37 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217253c058sm143636681c88.11.2025.12.31.15.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 15:51:37 -0800 (PST)
Date: Wed, 31 Dec 2025 15:51:36 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/14] nvme: Implement cross-controller reset
 completion
Message-ID: <20251231235136.GQ3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-10-mkhalfella@purestorage.com>
 <9ac9b7c8-139f-48f9-bfd2-bfd03506abf0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac9b7c8-139f-48f9-bfd2-bfd03506abf0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_155139_274556_CDBC2B9E 
X-CRM114-Status: GOOD (  12.37  )
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

On Sat 2025-12-27 12:24:17 +0200, Sagi Grimberg wrote:
> 
> > +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> > +	if (!log)
> > +		return;
> > +
> > +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> > +			   0x00, log, sizeof(*log), 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> > +		entry = &log->entries[i];
> > +		if (entry->ccrs == 0)	/* skip in progress entries */
> > +			continue;
> 
> What does ccrs stand for?

Cross-Controller Reset Status

0x00 -> In Progress
0x01 -> Success
0x02 -> Failed
0x03 - 0xff -> Reserved

