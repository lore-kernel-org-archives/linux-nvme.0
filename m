Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A0FC2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=; b=v/AN5r4TC6TpcXfKYRiD8mAKwE
	YyWZNKdka2v2WsfHW5u4Z3J3ViT8nE4hX48sJ483200JTugHa0arpNA/OlqkRb9dDW1l48s/VYPj4
	TaB/wB8awZH5l3Ng9SzJKfNojZwdtsBQ+kKHpg77uuEX4xovfLIewj9AeqFAotSZ5VSLZZsJPMAk4
	3Jb4IU5XpjD2eQlisr0cIMUvBQ04bPV3uuuqkAYHAXKirGT2/L38n2VLBq6eJ4IHjv+mnJut/jbWx
	j3qE2y04fgfJsgIH0ErpYg0GVJAHuABVyvY766fYISODbARydFQFrE+8Fv1/f0hVeHFN2yKdhRaOE
	FBVXgpCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHEyF-0000000AwB4-22ls;
	Wed, 12 Jun 2024 03:48:23 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH4i2-00000009Yw3-0WW1
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 16:51:00 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso6396068276.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124657; x=1718729457; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=nfUswMfi4SUV1LjvJjOXWH2ch5kJBi9zUgkufgiAOl8bKs+UiBaRE0c5edzcYTMOr3
         ZLl5Bi3nSq2ZanGhbzvB3NWhklgkrVS9mUNjyXvgUYlx6s/zmK0Sd6yMmlDqoHxBtKQH
         TfcTxJIs/b2ut+MYXsSPYQHfoGFhfd4SyROBR16JjeJR5OgsQ/rxd/9YGM/mokXSbiMa
         1KUBTDgaNQEmrt7BpNuxbqTI2L3wmU18iqnZBKgWafyPWp3lswviex92t4wedp/z+GcT
         QAy+mhOFs/rTY/VRcnf2EDKX38lFgUp2x299OtR95TS3YRO4jB13Nb+1pQPYHCtl9lMd
         E7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124657; x=1718729457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=pX+oekTpeNpW4csYl7NZSrWacloB5yFyQDiwC8maqDJJ0XOEnicirII6l0Usm+y2Dg
         U3ksng6Iz3L26ie8sRxREmTtR8JfICQ9G+2UQfikkqB0GEiMUGWH4ixQ4MXaO0M2T6/C
         m1J2F3D/mlKMa6jfbs8PGSTqg6OYWeJqtPaMnci7nqT0S3xuNZjpmlUyWdCBv7GwuzbN
         PsmOOue/setbY433l+IcLTzfBWQPWVSm+5fvygwOz1K9uPHaJEwKjpIDW4UKYHPiDm/m
         JHgqs4VTYVodrf8XzvqFHQC/b9XaK1WdqUXfEU4vYBYyFFP4KUXHsVJ8ds90ov88MngU
         GCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSR9XGutDWbGa3cVCBv7TRCsnrhXKDvh4yBi/ciHnE+nUmCX3+1mvHJlfQAw07xaNCahm92xTShovdOkL+JAx42fwVll2w4v4NDIU+f18=
X-Gm-Message-State: AOJu0YxsDaZ2C++J8LCm8bv/G+2FSTpq6hslQXS/QKgWkuhoqyRSsnEZ
	6j8L2kVeMGhNF8FiKXUYDczj4hgxouBkw9widV2SwhYUK/b1LwRQEKUkDxhV6To=
X-Google-Smtp-Source: AGHT+IFLbNcRGoXteJvsvQz9ePKtTqtffGprFSIVvQoC+S7q0aJ0DFFhhqHjAFy+KyUVXYjD8ktBew==
X-Received: by 2002:a0d:d851:0:b0:618:95a3:70b9 with SMTP id 00721157ae682-62cd565129cmr130634777b3.36.1718124656832;
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccaef2825sm20935207b3.139.2024.06.11.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:50:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
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
Subject: Re: [PATCH 09/26] nbd: move setting the cache control flags to
 __nbd_set_size
Message-ID: <20240611165055.GD247672@perftesting>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611051929.513387-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_095058_187252_0668563A 
X-CRM114-Status: GOOD (  11.11  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 20:48:17 -0700
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

On Tue, Jun 11, 2024 at 07:19:09AM +0200, Christoph Hellwig wrote:
> Move setting the cache control flags in nbd in preparation for moving
> these flags into the queue_limits structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

