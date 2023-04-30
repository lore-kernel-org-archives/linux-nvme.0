Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9FCC77B60
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bysX9DvlsnqvSlQ+lvvjW3IO/Dqv4OjYEOFaq+KP4D8=; b=wSAdnCUdMWlig91O+tZiPvYIMF
	OTIGmij2Lth+Nuxwznv54j9ArBBgrhZfHt+F9oiOgscaXNtlJb7zBoB+WTy8L0qZz7jqguCnqw2Ah
	jhGzMwus00vyNnuOMmaq33kKNGKYAh5Q9xJMtKhXXXS1eYq91UpImsYF86KnWEzO5sFIthEJIH76i
	BW6UmBucgpUMAKEmfq2gzrpAOjpFkAbumK0oO2qp5QKzSheX82I+SAfLGhBpHpYwFq/Ntbv/Av3oc
	ha2SQ444JOx/7tIUeXnVu/QtqU184K8jfElmrtxDW/LeoDG3pXY6p0cV8reNFG3b574u34u7pfnrM
	mVbR/KRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt8Ct-00EIbT-3B;
	Sun, 30 Apr 2023 14:39:19 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt8Cr-00EIZ7-0e
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:39:18 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso9219095e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865553; x=1685457553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bysX9DvlsnqvSlQ+lvvjW3IO/Dqv4OjYEOFaq+KP4D8=;
        b=XWpCeJUJ03oo3LIPP/pbu2+YkM7JhgeP0FSzXNMriy9drVQLTrizr5k+ANx6RDAXKH
         BTuSAjmEexOJumUoR1woFIcoWxNug4EgykPkkkU4RyJj3/D7fA6RTnhmJBD4EuX5A9Zq
         vLH0wxSWNcnit9y8b15ySahbXPptH5N/UvUNrDr/buZvzjhV/16480NVj9ZIdepzMT/n
         gB/BLBHnwDuHTOmC2z5ToOG0O6QvMJWpXZ8L4RAspu0C3TXwzmnN7PzgKbjiTdxWN9G9
         AEeXfIM0k75ByepK/xOR54c+nMP+rFxRAIMgszkSD6SpUJ3rTV2ajcwhbpozl6/qSo+F
         ajLQ==
X-Gm-Message-State: AC+VfDx0SbJIbeYARltrzibMII2z/efNbImYKCqSB/iGL63bL+Qsg67X
	QWhG6TRF8MFvDkEQZCCx+dU=
X-Google-Smtp-Source: ACHHUZ5e0OtY5poBCehPnKMc5JRRNVd8ObeMJIGKcedG4iBnL2UBvGjYpiHz/JTGG1hUh7v+tsBQFA==
X-Received: by 2002:adf:ec09:0:b0:2d5:39d:514f with SMTP id x9-20020adfec09000000b002d5039d514fmr8504393wrn.65.1682865553131;
        Sun, 30 Apr 2023 07:39:13 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id d15-20020adfe84f000000b002fb60c7995esm26272127wrn.8.2023.04.30.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:39:12 -0700 (PDT)
Date: Sun, 30 Apr 2023 07:39:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v2 0/3] io_uring: Pass the whole sqe to commands
Message-ID: <ZE59jseq/BwR7Ac5@gmail.com>
References: <20230421114440.3343473-1-leitao@debian.org>
 <678232fa-fd02-37b7-3048-a124c4ffdc71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678232fa-fd02-37b7-3048-a124c4ffdc71@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073917_232803_6EA2CBA8 
X-CRM114-Status: GOOD (  17.50  )
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

Hello Jens,

On Fri, Apr 28, 2023 at 11:28:14AM -0600, Jens Axboe wrote:
> On 4/21/23 5:44?AM, Breno Leitao wrote:
> > These three patches prepare for the sock support in the io_uring cmd, as
> > described in the following RFC:
> > 
> > 	https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/
> > 
> > Since the support linked above depends on other refactors, such as the sock
> > ioctl() sock refactor[1], I would like to start integrating patches that have
> > consensus and can bring value right now.  This will also reduce the patchset
> > size later.
> > 
> > Regarding to these three patches, they are simple changes that turn
> > io_uring cmd subsystem more flexible (by passing the whole SQE to the
> > command), and cleaning up an unnecessary compile check.
> > 
> > These patches were tested by creating a file system and mounting an NVME disk
> > using ubdsrv/ublkb0.
> 
> Looks mostly good to me, do agree with Christoph's comments on the two
> patches. Can you spin a v3? Would be annoying to miss 6.4 with this, as
> other things will be built on top of it.

Sure. I've just sent V3 with all the fixes discussed in this email
thread.

Here is the link: https://lkml.org/lkml/2023/4/30/91

