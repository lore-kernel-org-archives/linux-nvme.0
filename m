Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E293C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 15:41:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E3E6101A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 15:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3E3E6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZMFQYn+PDgp9dM3h5kGvYItsergRo9Frc4XodopEHYE=; b=f0y25MKYU8QpSP
	u+mygy3r4UVw3zIkCOajdFZLaEjflY77esN55RcTCziM22vhHPUiR38On0C+Rir7m/ts4uAYbDdD5
	ugd1MYo4MFUndgRLJoQysfxNbrFmsoFWZml3MeaijEPdFBdxqDdrHITNZNZXcYyPiQj+AAVBcMGKd
	oI5Nc5KHgC8aiTaVt+sOO9zRaIvKPRYgtcVaJlHxVobZ7GvvY4fIi4ryQGVqUMgusIAj860F1RdpH
	aBpA3LcVVP5yf2nrn/ROMuXHI2f0bKk8tQgrenWZFgP+5P5HiirAP25IhQvydKdVPIiYPh0CkSrcs
	PBpnJtsfhVYCnt+HcNfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGNgP-0064f3-3M; Wed, 18 Aug 2021 15:40:49 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGNgJ-0064cz-Vp
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 15:40:48 +0000
Received: by mail-lf1-x133.google.com with SMTP id w20so5540820lfu.7
 for <linux-nvme@lists.infradead.org>; Wed, 18 Aug 2021 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AtAhgc/cdtdzOpUDiq7xYnKI2s3eNwZmdV1LdaG9ySo=;
 b=PWcYhEYYtZjTfKDZMdN0WFm25zWU6vUnEefdgNPih6QwJ4e5NnO1itZZ1z1zd+A2RU
 xbkYngFQPwxL14gfyz8aQFErBFx2jLEjNEHFknMIvJJtURxUEdxLi05hwsbYhnjIQqHp
 PmyNYUo+2I4gNGOYXsiBAJM8F68rTG39YBp8Ov2dTh60SnKE84Tc1nNa15KlqgerEbO1
 /OS3iNwnU8HNiXDucG3hVJCSznV2bRCqz0B+A5lAq1+nCz6cd81q7sJ23RqCAYfeizBJ
 pG8Hv45xxi5e8Y6bIdzGC17dmLTPU06HEW1daIvzgluzf5ZvuyIYnpueSArX3cJQHGjU
 kH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AtAhgc/cdtdzOpUDiq7xYnKI2s3eNwZmdV1LdaG9ySo=;
 b=nAWxNFQe6tyHcsJizximyeC5NU7QT2ReLyCiyfdO2U/6N+kp/n5ZsSv3KpyDe2FdVf
 ui3JqFg9d7tfJsGBLfUcqinJe762ZKAHACXkBSFrTIHv/zUYquew3AwNkvzItQTQoVrn
 bN/irp10orn39ZIUw9X4TR16pSWarBm3SWw0H4P7waF1CVg76Vte+UQqiUajnLnf4vVk
 u4JSxWcl1Ldwxmayepsi8BVRohpjaSUbDQNzanxq4eOGDbWaWiw+msrWFAG9CkdiRGbn
 ZwWpVFVUcv5eUtizLWrh0vFuWSwVnqsn0SD4PqB40pLE2HcRiQ92ZKGC/3lHtZQvIuBa
 mBUg==
X-Gm-Message-State: AOAM531oqRsANB4a50KKUJzQeWKBss8or3AZWrC+QEOBey5xUb76ZSKS
 MNd++3w+zuf6XZ1IsI3fHOXERkVFf6dzxnoEGQg=
X-Google-Smtp-Source: ABdhPJxdbKKZ7HzWf73HynFAAtUBdYY23NO4eYcF1dkerR0DWdHpzlIlPrMdLWA5PYdjRCSguNfZNXVeUUh1TMNdro0=
X-Received: by 2002:a05:6512:1283:: with SMTP id
 u3mr7005906lfs.390.1629301242041; 
 Wed, 18 Aug 2021 08:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad@epcas5p1.samsung.com>
 <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <20210817233758.GB12597@magnolia>
In-Reply-To: <20210817233758.GB12597@magnolia>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Wed, 18 Aug 2021 21:10:29 +0530
Message-ID: <CAOSviJ0qbkg9WPtmxuvf6HAgQ9sBYWVRGisGRgwed77uK86byg@mail.gmail.com>
Subject: Re: [PATCH 0/7] add simple copy support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk, 
 damien.lemoal@wdc.com, asml.silence@gmail.com, johannes.thumshirn@wdc.com, 
 hch@lst.de, willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com, 
 mpatocka@redhat.com, bvanassche@acm.org, snitzer@redhat.com, agk@redhat.com, 
 selvajove@gmail.com, joshiiitr@gmail.com, nj.shetty@samsung.com, 
 joshi.k@samsung.com, javier.gonz@samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_084044_075174_16AB2F8E 
X-CRM114-Status: GOOD (  45.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 18, 2021 at 5:07 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Aug 17, 2021 at 03:44:16PM +0530, SelvaKumar S wrote:
> > This started out as an attempt to support NVMe Simple Copy Command (SCC),
> > and evolved during the RFC review process.
> >
> > The patchset, at this point, contains -
> > 1. SCC support in NVMe driver
> > 2. Block-layer infra for copy-offload operation
> > 3. ioctl interface to user-space
> > 4. copy-emulation infra in the block-layer
> > 5. copy-offload plumbing to dm-kcopyd (thus creating couple of in-kernel
> >       users such as dm-clone)
> >
> >
> > The SCC specification, i.e. TP4065a can be found in following link
> >
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip
> >
> > Simple copy is a copy offloading feature and can be used to copy multiple
> > contiguous ranges (source_ranges) of LBA's to a single destination LBA
> > within the device, reducing traffic between host and device.
> >
> > We define a block ioctl for copy and copy payload format similar to
> > discard. For device supporting native simple copy, we attach the control
> > information as payload to the bio and submit to the device. Copy emulation
> > is implemented incase underlaying device does not support copy offload or
> > based on sysfs choice. Copy emulation is done by reading each source range
> > into buffer and writing it to the destination.
>
> Seems useful.  Would you mind adapting the loop driver to call
> copy_file_range (for files) so that anyone interested in making a
> filesystem use this capability (cough) can write fstests?

We are planning to look into copy_file_range plumbing after settling
on the current series,
 which already became heavyweight for the first drop.

Nitesh Shetty
>
> --D
>
> > At present this implementation does not support copy offload for stacked/dm
> > devices, rather copy operation is completed through emulation.
> >
> > One of the in-kernel use case for copy-offload is implemented by this
> > patchset. dm-kcopyd infra has been changed to leverage the copy-offload if
> > it is natively available. Other future use-cases could be F2FS GC, BTRFS
> > relocation/balance and copy_file_range.
> >
> > Following limits are added to queue limits and are exposed via sysfs to
> > userspace, which user can use to form a payload.
> >
> >  - copy_offload:
> >       configurable, can be used set emulation or copy offload
> >               0 to disable copy offload,
> >               1 to enable copy offloading support. Offload can be only
> >                       enabled, if underlaying device supports offload
> >
> >  - max_copy_sectors:
> >       total copy length supported by copy offload feature in device.
> >       0 indicates copy offload is not supported.
> >
> >  - max_copy_nr_ranges:
> >       maximum number of source range entries supported by copy offload
> >                       feature in device
> >
> >  - max_copy_range_sectors:
> >       maximum copy length per source range entry
> >
> > *blkdev_issue_copy* takes source bdev, no of sources, array of source
> > ranges (in sectors), destination bdev and destination offset(in sectors).
> > If both source and destination block devices are same and queue parameter
> > copy_offload is 1, then copy is done through native copy offloading.
> > Copy emulation is used in otherwise.
> >
> > Changes from  RFC v5
> >
> > 1. Handle copy larger than maximum copy limits
> > 2. Create copy context and submit copy offload asynchronously
> > 3. Remove BLKDEV_COPY_NOEMULATION opt-in option of copy offload and
> > check for copy support before submission from dm and other layers
> > 4. Allocate maximum possible allocatable buffer for copy emulation
> > rather failing very large copy offload.
> > 5. Fix copy_offload sysfs to be either have 0 or 1
> >
> > Changes from RFC v4
> >
> > 1. Extend dm-kcopyd to leverage copy-offload, while copying within the
> > same device. The other approach was to have copy-emulation by moving
> > dm-kcopyd to block layer. But it also required moving core dm-io infra,
> > causing a massive churn across multiple dm-targets.
> > 2. Remove export in bio_map_kern()
> > 3. Change copy_offload sysfs to accept 0 or else
> > 4. Rename copy support flag to QUEUE_FLAG_SIMPLE_COPY
> > 5. Rename payload entries, add source bdev field to be used while
> > partition remapping, remove copy_size
> > 6. Change the blkdev_issue_copy() interface to accept destination and
> > source values in sector rather in bytes
> > 7. Add payload to bio using bio_map_kern() for copy_offload case
> > 8. Add check to return error if one of the source range length is 0
> > 9. Add BLKDEV_COPY_NOEMULATION flag to allow user to not try copy
> > emulation incase of copy offload is not supported. Caller can his use
> > his existing copying logic to complete the io.
> > 10. Bug fix copy checks and reduce size of rcu_lock()
> >
> > Changes from RFC v3
> >
> > 1. gfp_flag fixes.
> > 2. Export bio_map_kern() and use it to allocate and add pages to bio.
> > 3. Move copy offload, reading to buf, writing from buf to separate functions
> > 4. Send read bio of copy offload by chaining them and submit asynchronously
> > 5. Add gendisk->part0 and part->bd_start_sect changes to blk_check_copy().
> > 6. Move single source range limit check to blk_check_copy()
> > 7. Rename __blkdev_issue_copy() to blkdev_issue_copy and remove old helper.
> > 8. Change blkdev_issue_copy() interface generic to accepts destination bdev
> >         to support XCOPY as well.
> > 9. Add invalidate_kernel_vmap_range() after reading data for vmalloc'ed memory.
> > 10. Fix buf allocoation logic to allocate buffer for the total size of copy.
> > 11. Reword patch commit description.
> >
> > Changes from RFC v2
> >
> > 1. Add emulation support for devices not supporting copy.
> > 2. Add *copy_offload* sysfs entry to enable and disable copy_offload
> >         in devices supporting simple copy.
> > 3. Remove simple copy support for stacked devices.
> >
> > Changes from RFC v1:
> >
> > 1. Fix memory leak in __blkdev_issue_copy
> > 2. Unmark blk_check_copy inline
> > 3. Fix line break in blk_check_copy_eod
> > 4. Remove p checks and made code more readable
> > 5. Don't use bio_set_op_attrs and remove op and set
> >    bi_opf directly
> > 6. Use struct_size to calculate total_size
> > 7. Fix partition remap of copy destination
> > 8. Remove mcl,mssrl,msrc from nvme_ns
> > 9. Initialize copy queue limits to 0 in nvme_config_copy
> > 10. Remove return in QUEUE_FLAG_COPY check
> > 11. Remove unused OCFS
> >
> >
> > Nitesh Shetty (4):
> >   block: Introduce queue limits for copy-offload support
> >   block: copy offload support infrastructure
> >   block: Introduce a new ioctl for simple copy
> >   block: add emulation for simple copy
> >
> > SelvaKumar S (3):
> >   block: make bio_map_kern() non static
> >   nvme: add simple copy support
> >   dm kcopyd: add simple copy offload support
> >
> >  block/blk-core.c          |  84 ++++++++-
> >  block/blk-lib.c           | 352 ++++++++++++++++++++++++++++++++++++++
> >  block/blk-map.c           |   2 +-
> >  block/blk-settings.c      |   4 +
> >  block/blk-sysfs.c         |  51 ++++++
> >  block/blk-zoned.c         |   1 +
> >  block/bounce.c            |   1 +
> >  block/ioctl.c             |  33 ++++
> >  drivers/md/dm-kcopyd.c    |  56 +++++-
> >  drivers/nvme/host/core.c  |  83 +++++++++
> >  drivers/nvme/host/trace.c |  19 ++
> >  include/linux/bio.h       |   1 +
> >  include/linux/blk_types.h |  20 +++
> >  include/linux/blkdev.h    |  21 +++
> >  include/linux/nvme.h      |  43 ++++-
> >  include/uapi/linux/fs.h   |  20 +++
> >  16 files changed, 775 insertions(+), 16 deletions(-)
> >
> > --
> > 2.25.1
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
