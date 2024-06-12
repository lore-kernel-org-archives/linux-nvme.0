Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1DEC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1PGf6HlJc1ANQenmlixWu1Sno9FA8D3ndcnX4NZVy9I=; b=2WtC9VYg0Ia+7tNNAJa3/WWX/s
	KApFMkxsAKS8JCy5G7R4CmkmgiAiajvWDGpKFYp4LiAdh8s0XIvUuMc8Y95NiUn7zsUxluT0MntQI
	pqJHjk4gum08BSW4UzQyrO+xKyo1DdGGxqQmZrCAQBhR9voM4hmuG45MHkae2mNCMbCZdp2nNxg02
	z3zq9GXjmFDr8CU4nsJWusHCXfufv/BAQCt7ar5qOJdoFomhUOWRQVRyXqal/5evlnYcjLQWqFZgg
	G/PJfNmqBXoFxaa+JbUBz7/YRJ9JrZ+AqOlAPCgUuM3xMLGJbaSZt2U/R6QomcbZuzUr7siXipAl4
	AXiQ3AjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPU7-0000000D4GV-2oAU;
	Wed, 12 Jun 2024 15:01:59 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHIvB-0000000BZja-23Bx
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 08:01:32 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-628c1f09f5cso23561567b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718179283; x=1718784083; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PGf6HlJc1ANQenmlixWu1Sno9FA8D3ndcnX4NZVy9I=;
        b=P5TG9aFCeBdgebSp1hkjD/eJq4G0jkRHU2xEY4GnuJJ/BRhpYXVLv4jTBqwr+4SThN
         1nlPE/mriFMNl74zBBbia66Zce22GTWY8xd7VCY7ykyAQi160YmcsFqdTuoQMdDEAxks
         nkO7jl6jrRMwFmqFNYYLdv8tst1uT4wFWk4is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179283; x=1718784083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PGf6HlJc1ANQenmlixWu1Sno9FA8D3ndcnX4NZVy9I=;
        b=wJ5igmreN+EcFRfVZjhly6N4JfVgV/R6shrc1UOivKx5WKeI5sJCyHxskcwRNlMd6u
         tVGCRJVbEUwgPZ96tjvJ96Lz/HUiZoRuiHrzmI0RsRAC2/t2hhlRdP69oGjGz9q+hY9a
         8KArENsG4c3C0uvE7f8bsjAwS0Ma+wi+A9Xl3n33FlHLBKTB3JT4CftBUXxRyuUkJDYQ
         WzLdU6o3IPaLAAlc+zo3mpkEYbZyP8TGStAzx+xa7ypJbINS/rTFWfTLJF7lQ0iUASFM
         ixrte9aOaqZLugWBjampCynzvxkwXAVkOTubaSmO2YxRHRzLBz3/eCYjfFfGhAux9SHG
         WgFg==
X-Forwarded-Encrypted: i=1; AJvYcCXKiw8v8xaBacerpAWe/SRa62rIehgtYRxEfZgArNuXQNQfw9ooVMVe69mUm1UVD0XpPPM3KebNH3hawocpTt4I46a3YX5ztLlJFVQIOjM=
X-Gm-Message-State: AOJu0YyWF2DUwhJNH0BiJnHSvcSSaRabToc3lPDTmfzm8yGZhIQmqczA
	BmoSF9PXBKLmOKzKsBgbfbZn4Mtg/l011a56qiQB4FPGue0WJkqlSaUmCFtyNQg=
X-Google-Smtp-Source: AGHT+IEk5bObzz8qCZsqdRqFNOU7a/dh67daOPgnEKJGJzh0sP06pKqPApTvT03CHGJxr8rf1zPYww==
X-Received: by 2002:a81:b647:0:b0:61b:e62e:73f1 with SMTP id 00721157ae682-62fb8a58273mr12605907b3.3.1718179282688;
        Wed, 12 Jun 2024 01:01:22 -0700 (PDT)
Received: from localhost ([46.222.2.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b093aff889sm6894416d6.101.2024.06.12.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:01:22 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:01:18 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <ZmlVziizbaboaBSn@macbook>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611051929.513387-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_010129_651166_56B775D5 
X-CRM114-Status: GOOD (  14.63  )
X-Mailman-Approved-At: Wed, 12 Jun 2024 08:01:58 -0700
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

On Tue, Jun 11, 2024 at 07:19:10AM +0200, Christoph Hellwig wrote:
> blkfront always had a robust negotiation protocol for detecting a write
> cache.  Stop simply disabling cache flushes when they fail as that is
> a grave error.

It's my understanding the current code attempts to cover up for the
lack of guarantees the feature itself provides:

 * feature-barrier
 *      Values:         0/1 (boolean)
 *      Default Value:  0
 *
 *      A value of "1" indicates that the backend can process requests
 *      containing the BLKIF_OP_WRITE_BARRIER request opcode.  Requests
 *      of this type may still be returned at any time with the
 *      BLKIF_RSP_EOPNOTSUPP result code.
 *
 * feature-flush-cache
 *      Values:         0/1 (boolean)
 *      Default Value:  0
 *
 *      A value of "1" indicates that the backend can process requests
 *      containing the BLKIF_OP_FLUSH_DISKCACHE request opcode.  Requests
 *      of this type may still be returned at any time with the
 *      BLKIF_RSP_EOPNOTSUPP result code.

So even when the feature is exposed, the backend might return
EOPNOTSUPP for the flush/barrier operations.

Such failure is tied on whether the underlying blkback storage
supports REQ_OP_WRITE with REQ_PREFLUSH operation.  blkback will
expose "feature-barrier" and/or "feature-flush-cache" without knowing
whether the underlying backend supports those operations, hence the
weird fallback in blkfront.

I'm unsure whether lack of REQ_PREFLUSH support is not something that
we should worry about, it seems like it was when the code was
introduced, but that's > 10y ago.

Overall blkback should ensure that REQ_PREFLUSH is supported before
exposing "feature-barrier" or "feature-flush-cache", as then the
exposed features would really match what the underlying backend
supports (rather than the commands blkback knows about).

Thanks, Roger.

