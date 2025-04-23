Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E14C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=; b=yv7i+hWzF4+mnlaeEB10I6sp+o
	JNjcZC+MHlH2vJ47Dy/4h+rbIPBvorMIkQFuGjRTUMNER0vLDtl8A5or9QCPNKZZ6ehc2cwhJnZap
	LwLaBvtAfXgbCPRtycYJPNeGjUD+yTE8P4lVY6LqKphp97x8vaiYFQ6h0TmCOCs1/m1ixbZDS3E01
	aSn+9yp+1gbsyjbVrwTWFCf0yRN6HzcipZas8NmGAS3av3RpT75IMToC7BR1pjFf7CFq20oCA75oG
	5dunPbJqlDAiYlXtgKg14ioO3FgQ2fDS7vge7VKYklIYg8S8MVvL0CU8ols+kww8faluA86ofyCFY
	xAZFqTIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7jW5-0000000CGSY-2C8k;
	Wed, 23 Apr 2025 23:28:33 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7jW3-0000000CGRw-3KKb
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 23:28:33 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7c54f67db99so179528885a.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745450910; x=1746055710; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=MtJa4NZyr77Yt/ZmGjN7+FmKzo9EpN5AvuatfyLHGhywDO7F6g/Ae4+KS8xuW96GtI
         jhcyx5T//59oYt2MpNyPMbw+0Rq9xwCFKmsMK3bpSeHiuhJZNtWG5PpRn9nBadg+nV3D
         MPxeWZEJiu5awL2TpaKeBbCr68gp6GFDPulig/5UrHGz0cpwTkaILUp8MqKEFlspQCeF
         XnYXXaNFS6sHguCytkNp0GlfOfW68e7Gn+yamkdV/1VSJFpPjmbygyD4AcD3P/T7ghVi
         vkkn+Cz6nBZunAa6uwu/cx4GPY1iiZQbDmniMrRhQefLA6DEJn9o4SpVfaDdP9yaniv8
         77qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450910; x=1746055710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=bADwzyiGFyxGrjoi8Zd1kiJqWT/xg2OJpJd52af2pJMVc66zUGJtUYSHSpqZvZkFxx
         rMsv2E57eLB4d0sesGdcCVPi98qoRxjs3FWU/K1gi/192R9RV6k4Igp6Gq+eFSzia/xe
         TRv7uiLwKyntd2aYnOaiSsivD7qbRlVRACGCk8kQu01f2RjBhrREkKxemrFVnRe9Rrwg
         ktgk5rgrqzlNRYzrJAohP84qbVXFyJCBiscQwtUOtrU0o98qipra9cGG+dzz0VvqdAs+
         0s0S3Ndy3d4NjfORlcPEPrOCTkM2R6NsAXG6SL9nfy6urnmnS9mNGcjRtU+WWOXX+8mD
         VF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhUvfGa0LVyswKutlKNH8c6kz3OD5EdihIquOc5D3k5JDmMHpV9JxF81RVxCV2s7+VjY3syuID6zzK@lists.infradead.org
X-Gm-Message-State: AOJu0YxSs9QNcS5n0gnTLXOwC5tBmZX0Fbh2VQEUFqvYWvTxeQi7Jm7t
	3yyP1i7Fzxq/bCNjMKoIXfm+ww0YwX52mgHOnt2iX3isMibVz0uUQuHpVcwNcAE=
X-Gm-Gg: ASbGncvt4EbDzQ4otdV1GeGT5LycKhZVsh8/b7yZw/0R3Skl1uDMm8T8a4Z7cjKol+L
	UlFTeAh/UShAXwJ1U6XpanHjpIKP0Ub3UE8n9ib/Eg7rTo8elsF0JjjsL/bHjnyuEv4tSWqPCwF
	8/nkbtJVnIkaINOCq01qkT5l0atL7K2cTO5/ZvfrbM150PkKqx8ldcdwuCay/F2tnYT+u2pzae4
	T9ntsPdu7L+8CutO164oBBWW61HeceNhFwsJhxlL3rN5P7QUZrEMw4jSTLqbpofMPHm7IVlUnKf
	qH2/KD6wIO7QJ2OECIkhytmtpKs93hA/4CnAYvyD83nL75OFaOB1Ss5TPOBFGlZOKh6eqNw+WqO
	BhCHhH1QGBoABEGErRkc=
X-Google-Smtp-Source: AGHT+IHQwoUGFyqXOFOgVitrB4+AxVC8d+UTNu2w6OYf0KswkT4EXsvYxHqs0LgYSSaBSDPbedDu/w==
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr36268185a.11.1745450909829;
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e7f154sm2581385a.76.2025.04.23.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7jW0-00000007PIX-0JOv;
	Wed, 23 Apr 2025 20:28:28 -0300
Date: Wed, 23 Apr 2025 20:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250423232828.GV1213339@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_162831_940333_1CA52E08 
X-CRM114-Status: GOOD (  16.66  )
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

On Wed, Apr 23, 2025 at 12:21:15PM -0700, jane.chu@oracle.com wrote:

> So this looks like a case of CPU cache thrashing, but I don't know to fix
> it. Could someone help address the issue?  I'd be happy to help verifying.

I don't know that we can even really fix it if that is the cause.. But
it seems suspect, if you are only doing 2M at a time per CPU core then
that is only 512 struct pages or 32k of data. The GUP process will
have touched all of that if device-dax is not creating folios. So why
did it fall out of the cache?

If it is creating folios then maybe we can improve things by
recovering the folios before adding the pages.

Or is something weird going on like the device-dax is using 1G folios
and all of these pins and checks are sharing and bouncing the same
struct page cache lines?

Can the device-dax implement memfd_pin_folios()?

> The flow of a single test run:
>   1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>   2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
> reserved virtual address space sequentially to form a continual VA
> space

Like is there any chance that each of these 61440 VMA's is a single
2MB folio from device-dax, or could it be?

IIRC device-dax does could not use folios until 6.15 so I'm assuming
it is not folios even if it is a pmd mapping?

Jason

