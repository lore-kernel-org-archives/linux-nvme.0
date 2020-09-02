Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28140C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 06:07:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9DE20758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rd+iqB6+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTkF1377"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9DE20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CktY46jZkdzUKqc2gEc/qWM4sJnQr6uS31tQjUoT+p8=; b=rd+iqB6+TVW7vW2gdzMfv8xml
	9eUx8P0URofMSeVV9IBHiVe/PsU1Ks+0XU3iLlg6VEaTo2/hFrjCjqWRu2Uz0YZVYQ/9V6fUZl2Kc
	ZhcFfvqufoXbYt9tOTg3msbj1RgyX5hpSlDvYLkgESCAk/8Jrxr2wNvRdBMQKYvDmZFYs0IkAR1MS
	ZEMhxBg8Wb1cpTpCIJypQswhueB5FuzuY5PsujX6W+BrXfAlBNgItfrk9znm3rBcSQA3vcj8HoFoI
	tgAn2cXkWTW3tc6VYqOLW6ok5XM6ZDXECnhEGT776rZRyBeagRuUPFc1pEFpMEhzABF73/eS0aKvC
	wsohQ3IYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDLvK-0007PL-JV; Wed, 02 Sep 2020 06:07:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDLvH-0007Oy-PD
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 06:07:08 +0000
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 79A972087E
 for <linux-nvme@lists.infradead.org>; Wed,  2 Sep 2020 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599026826;
 bh=5+KmkwCh74/cntArpz/UMLM/pddG8ulQKVSpeB3X+RY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cTkF1377EKFMiKH243aPvnk5sDiPB+mAJ8UbjY3H3CxHW3ub6AhJm8zB6sjCeyjos
 0Zb34r3LG95586+asqAax7/k2wV4jNsfLjOB7nVyJnDD7czJn3t7iganE4hOlIZPud
 bwrsx4majAT2w7kFdtUeFxc30f6s6TlOONSSdwLw=
Received: by mail-lj1-f170.google.com with SMTP id r13so4436992ljm.0
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 23:07:06 -0700 (PDT)
X-Gm-Message-State: AOAM530LtjJKtjAj0ELqThOs+FMeBj9Z/qDq3+umP7PldIq6wNWcT6uH
 HxseuG6uKx6KsXeizf+IfeR+5YIaHoxlIwZnk7Y=
X-Google-Smtp-Source: ABdhPJyE5jGOrYyZE6ORaRQIp51/fhLfZD64Ax0jpOVcS4L2G+U2YIU+6jbqUjHlXVyGhP2izG2P3ekqYZd5wXuophY=
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr2472465ljg.10.1599026824658;
 Tue, 01 Sep 2020 23:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-5-hch@lst.de>
In-Reply-To: <20200901155748.2884-5-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 1 Sep 2020 23:06:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-nfKQK_178R-Y+ps6KLNMrwvWe0Rh5=M1-xvcKHYTgg@mail.gmail.com>
Message-ID: <CAPhsuW5-nfKQK_178R-Y+ps6KLNMrwvWe0Rh5=M1-xvcKHYTgg@mail.gmail.com>
Subject: Re: [PATCH 4/9] block: add a new revalidate_disk_size helper
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_020707_914511_FC862C01 
X-CRM114-Status: GOOD (  19.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid <linux-raid@vger.kernel.org>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-nvdimm@lists.01.org, open list <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 1, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
[...]

>  drivers/md/md-cluster.c       |  6 ++---
>  drivers/md/md-linear.c        |  2 +-
>  drivers/md/md.c               | 10 ++++-----

For md bits:
Acked-by: Song Liu <song@kernel.org>

[...]
>
> +/**
> + * revalidate_disk_size - checks for disk size change and adjusts bdev size.
> + * @disk: struct gendisk to check
> + * @verbose: if %true log a message about a size change if there is any
> + *
> + * This routine checks to see if the bdev size does not match the disk size
> + * and adjusts it if it differs. When shrinking the bdev size, its all caches
> + * are freed.
> + */
> +void revalidate_disk_size(struct gendisk *disk, bool verbose)
> +{
> +       struct block_device *bdev;
> +
> +       /*
> +        * Hidden disks don't have associated bdev so there's no point in
> +        * revalidating them.
> +        */
> +       if (disk->flags & GENHD_FL_HIDDEN)
> +               return;
> +
> +       bdev = bdget_disk(disk, 0);
> +       if (bdev) {
> +               check_disk_size_change(disk, bdev, verbose);
> +               bdput(bdev);
> +       }
> +}
> +EXPORT_SYMBOL(revalidate_disk_size);

Shall we use EXPORT_SYMBOL_GPL() here?

[...]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
