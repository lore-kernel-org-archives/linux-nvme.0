Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620EDC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39GeJ9k26lBm8DIHTydyPakBzI35r02RPQhfQ0zdNso=; b=ZgTOnIkV3bv4RvvGTsRuaZ8azf
	D26Vap2nXgEhI7Nb4JVam6KKMFZJyEpfa8/oXX57+VRhZcRqSZjxQZpiKab3J7bZyS7ZX6pmOlVsg
	l948fRrYZ8sI8cBhUhsXHJaLa0EH5+dpmjYqKiDXb5fDjL5BJONzFMm6LZ5yeBtUOcjuy04GdMX9A
	tz275ij5uXPJ2AtlGpVzTBQ+cK2A+rVCxf70AkQoCshiw8BIi4b7j4aJ2WbkM16dASb97hISj5zKS
	Z8Fm5QkhAE6RE7u8mvxIfYRHq9jY5eBurbH1zVmlxUBkg7IbMWjkytL4R4k1R9CkajAZYYSw0f8Sg
	tI306NjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns1a9-00CHUf-43; Fri, 20 May 2022 12:18:13 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns1a2-00CHTV-Ri
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 12:18:11 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 l20-20020a17090a409400b001dd2a9d555bso7796708pjg.0
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=39GeJ9k26lBm8DIHTydyPakBzI35r02RPQhfQ0zdNso=;
 b=D2sz4VuHz54Z8K4o3FDmSCUHjSmQxhb1IWeJwrbNlmTbDKCExQKm5WGEa647cm4DWH
 FhvB1bUlJVMnFoCipvHNSv/PuenivADYZt15LFYVC3x4Rl5hRSO27HFMuPftDDqAoAK7
 IuXG/rXeigq+MavAzGWvio3Rd8k45cU/mDam3rg7vhv5k4r3btzlVS162I4qyC1coJY0
 wMb+ZqnxvpB0+gBWHxAqREm8DXbjxQX6RQEuwS+LC9GMvpD8WA8JLV9kV4P+mLVW2B8F
 jXlOR06j/mRRAqTTFCCueiw7SCCmnAwU/tOFIBeJ2Cc0G7h8pxVsf1sk0tb8gNH3zCDm
 2uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=39GeJ9k26lBm8DIHTydyPakBzI35r02RPQhfQ0zdNso=;
 b=hkM+EQD0rXPG9xCWbVWFznaxoihlTeqMedmQHK8bZ6zVlNwtPG4o8w0MWgrd6y/PSZ
 /3fCoO6FGko1siQlfh5Pp7Uk/CklU7vB5du/qxEek0fYtXY297LaIEiRdGKreK1FXr+W
 clyOmY+/4GIFYa6U5VOBh7ZgX4sZdwFpdUJWu8HpUQn2k6g26c3/M7a0gzs44wl822oc
 OhkXyL22ZtGU+Q12s899XSKykVmdST6z6HbWIeyxQ/IEdPSRcKo1d7SyENvHEITFg9F9
 e5UXACFcOSQHZx2ALIVmwcLOVqJ1FhUuHkrmn18EJikznqVRu8xbXIiv5IvbDN+YRMrc
 5vdg==
X-Gm-Message-State: AOAM533HMPsMdyvvCieTOe0QGPYpz9S+THsFRg08Cd+M94q1u2yX2nyS
 8qFsFOFyGqh3i8o+rbVHLC9Mpg==
X-Google-Smtp-Source: ABdhPJx5I/7VURrCFU9ckLWRRNL52GVAglAMP086lWlVoEpYUvDlq+8QEPHuoaaxtVKpx55BvAxGCQ==
X-Received: by 2002:a17:90a:a58d:b0:1db:ed34:e46d with SMTP id
 b13-20020a17090aa58d00b001dbed34e46dmr11201889pjq.124.1653049084988; 
 Fri, 20 May 2022 05:18:04 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 jg11-20020a17090326cb00b0015e8d4eb2b8sm5510581plb.258.2022.05.20.05.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 05:18:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: joshi.k@samsung.com, kbusch@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: joshiiitr@gmail.com, linux-nvme@lists.infradead.org, gost.dev@samsung.com
In-Reply-To: <20220520090630.70394-1-joshi.k@samsung.com>
References: <CGME20220520091211epcas5p3bf0725dce4d84f1fdde8cc4a4050ca37@epcas5p3.samsung.com>
 <20220520090630.70394-1-joshi.k@samsung.com>
Subject: Re: [PATCH v3 0/2] uring-passthrough for admin commands
Message-Id: <165304908405.9769.13992346224250890985.b4-ty@kernel.dk>
Date: Fri, 20 May 2022 06:18:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_051806_933636_AFF11494 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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

On Fri, 20 May 2022 14:36:28 +0530, Kanchan Joshi wrote:
> The series enables uring-passthrough for admin-commands.
> Please see if this can go in.
> 
> Patch 1 is prep.
> Patch 2 adds new opcodes for admin uring-passthrough, and enables it on
> nvme controller dev(/dev/nvmeX).It reuses the code of io-command
> passthrough, with the only difference that commands are issued on admin
> queue.
> 
> [...]

Applied, thanks!

[1/2] nvme: helper for uring-passthrough checks
      commit: 00fc2eeb15acc7f7e8713edc6d4d9855936226cb
[2/2] nvme: enable uring-passthrough for admin commands
      commit: 58e5bdeb9c2b06895e723c0b1e670f54510ff782

Best regards,
-- 
Jens Axboe



