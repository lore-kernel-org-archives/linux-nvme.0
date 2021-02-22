Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 06:53:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3FC64EB4
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 06:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3FC64EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.su
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AXNvGIDOCenU2fFriig2vAcqamosVK+wvdtF60O7b1g=; b=q/yYGtqamRBgEfuTXVfczFMEq
	GOCuN6h/c/CFIm1RzHmF8VMdkLt25ssiQyXKzUFzDoVJBxdImfk4YSHzfoFpYEap7BRpQDmNFBIS6
	Qfqkpy1tJ2KUswHaD8QuhVWJYKnjiUCHwL+Xk6oD8OyBvK8tEkxBeF6SQZgiVSckR2Ojz/LjzPkYT
	Wf3G0qqPtnDQIQW7LMVusHKqAeb5ItUyrBX2CoAz21+KH9Ke7PyybktvjyfUgWMkHy9tthmAbETRA
	KHr69DaEaxo0zHjC4S/WmwJSvgrShmDF1JIt/p0A+Hr8UETaogfyF6fYAUM8DbD3k9mWSmZqqcxYd
	L96yB3juQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lE55h-0004aL-G5; Mon, 22 Feb 2021 06:53:09 +0000
Received: from eu-shark1.inbox.eu ([195.216.236.81])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lE55e-0004Zu-3J
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 06:53:07 +0000
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
 by eu-shark1-out.inbox.eu (Postfix) with ESMTP id B93736C00691;
 Mon, 22 Feb 2021 08:52:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
 t=1613976779; bh=Rc9nYZ5mpSg611xOOngasQtO3TAbJ1PYJd/SrA47K7c=;
 h=References:From:To:Cc:Subject:In-reply-to:Date;
 b=i5M3jqnPmcSIWAmIKHZrm+IRPYokLmtwnUWbQMb2Hvwoq3WHvWqgX9/nW/ZA29ffh
 AgwlWGjfW41gnoaxl+V4N8HCuCrwrAN8kzWksQpNO60xivwg6YLl8XxMFOj7gv4LAp
 ItNgVhEuU6ir+cdRo0xaQPds1G1otfas0YWKfNuc=
Received: from localhost (localhost [127.0.0.1])
 by eu-shark1-in.inbox.eu (Postfix) with ESMTP id A5BED6C00661;
 Mon, 22 Feb 2021 08:52:59 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
 by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
 with ESMTP id bUrlneumwWrc; Mon, 22 Feb 2021 08:52:59 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
 by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 01BEE6C00606;
 Mon, 22 Feb 2021 08:52:59 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
 (Authenticated sender: l@damenly.su)
 by mail.inbox.eu (Postfix) with ESMTPA id 8C41F1BE00B1;
 Mon, 22 Feb 2021 08:52:50 +0200 (EET)
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
User-agent: mu4e 1.4.13; emacs 27.1
From: Su Yue <l@damenly.su>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
In-reply-to: <20210219124517.79359-1-selvakuma.s1@samsung.com>
Message-ID: <lfbgr3ur.fsf@damenly.su>
Date: Mon, 22 Feb 2021 14:52:44 +0800
MIME-Version: 1.0
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgs2pzY6IuClpKemo25U5hvmSE6Jek0TWBeplGloT3+5og==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_015306_388644_5AB37F27 
X-CRM114-Status: GOOD (  30.78  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, kch@kernel.org, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, joshi.k@samsung.com, javier.gonz@samsung.com,
 kbusch@kernel.org, joshiiitr@gmail.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Fri 19 Feb 2021 at 20:45, SelvaKumar S 
<selvakuma.s1@samsung.com> wrote:

> This patchset tries to add support for TP4065a ("Simple Copy 
> Command"),
> v2020.05.04 ("Ratified")
>
> The Specification can be found in following link.
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>

404 not found.
Should it be
https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip
?

> Simple copy command is a copy offloading operation and is  used 
> to copy
> multiple contiguous ranges (source_ranges) of LBA's to a single 
> destination
> LBA within the device reducing traffic between host and device.
>
> This implementation doesn't add native copy offload support for 
> stacked
> devices rather copy offload is done through emulation. Possible 
> use
> cases are F2FS gc and BTRFS relocation/balance.
>
> *blkdev_issue_copy* takes source bdev, no of sources, array of 
> source
> ranges (in sectors), destination bdev and destination offset(in 
> sectors).
> If both source and destination block devices are same and 
> copy_offload = 1,
> then copy is done through native copy offloading. Copy emulation 
> is used
> in other cases.
>
> As SCSI XCOPY can take two different block devices and no of 
> source range is
> equal to 1, this interface can be extended in future to support 
> SCSI XCOPY.
>
> For devices supporting native simple copy, attach the control 
> information
> as payload to the bio and submit to the device. For devices 
> without native
> copy support, copy emulation is done by reading each source 
> range into memory
> and writing it to the destination. Caller can choose not to try
> emulation if copy offload is not supported by setting
> BLKDEV_COPY_NOEMULATION flag.
>
> Following limits are added to queue limits and are exposed in 
> sysfs
> to userspace
> 	- *copy_offload* controls copy_offload. set 0 to disable copy
> 		offload, 1 to enable native copy offloading support.
> 	- *max_copy_sectors* limits the sum of all source_range length
> 	- *max_copy_nr_ranges* limits the number of source ranges
> 	- *max_copy_range_sectors* limit the maximum number of sectors
> 		that can constitute a single source range.
>
> 	max_copy_sectors = 0 indicates the device doesn't support copy
> offloading.
>
> 	*copy offload* sysfs entry is configurable and can be used 
> toggle
> between emulation and native support depending upon the usecase.
>
> Changes from v4
>
> 1. Extend dm-kcopyd to leverage copy-offload, while copying 
> within the
> same device. The other approach was to have copy-emulation by 
> moving
> dm-kcopyd to block layer. But it also required moving core dm-io 
> infra,
> causing a massive churn across multiple dm-targets.
>
> 2. Remove export in bio_map_kern()
> 3. Change copy_offload sysfs to accept 0 or else
> 4. Rename copy support flag to QUEUE_FLAG_SIMPLE_COPY
> 5. Rename payload entries, add source bdev field to be used 
> while
> partition remapping, remove copy_size
> 6. Change the blkdev_issue_copy() interface to accept 
> destination and
> source values in sector rather in bytes
> 7. Add payload to bio using bio_map_kern() for copy_offload case
> 8. Add check to return error if one of the source range length 
> is 0
> 9. Add BLKDEV_COPY_NOEMULATION flag to allow user to not try 
> copy
> emulation incase of copy offload is not supported. Caller can 
> his use
> his existing copying logic to complete the io.
> 10. Bug fix copy checks and reduce size of rcu_lock()
>
> Planned for next:
> - adding blktests
> - handling larger (than device limits) copy
> - decide on ioctl interface (man-page etc.)
>
> Changes from v3
>
> 1. gfp_flag fixes.
> 2. Export bio_map_kern() and use it to allocate and add pages to 
> bio.
> 3. Move copy offload, reading to buf, writing from buf to 
> separate functions.
> 4. Send read bio of copy offload by chaining them and submit 
> asynchronously.
> 5. Add gendisk->part0 and part->bd_start_sect changes to 
> blk_check_copy().
> 6. Move single source range limit check to blk_check_copy()
> 7. Rename __blkdev_issue_copy() to blkdev_issue_copy and remove 
> old helper.
> 8. Change blkdev_issue_copy() interface generic to accepts 
> destination bdev
> 	to support XCOPY as well.
> 9. Add invalidate_kernel_vmap_range() after reading data for 
> vmalloc'ed memory.
> 10. Fix buf allocoation logic to allocate buffer for the total 
> size of copy.
> 11. Reword patch commit description.
>
> Changes from v2
>
> 1. Add emulation support for devices not supporting copy.
> 2. Add *copy_offload* sysfs entry to enable and disable 
> copy_offload
> 	in devices supporting simple copy.
> 3. Remove simple copy support for stacked devices.
>
> Changes from v1:
>
> 1. Fix memory leak in __blkdev_issue_copy
> 2. Unmark blk_check_copy inline
> 3. Fix line break in blk_check_copy_eod
> 4. Remove p checks and made code more readable
> 5. Don't use bio_set_op_attrs and remove op and set
>    bi_opf directly
> 6. Use struct_size to calculate total_size
> 7. Fix partition remap of copy destination
> 8. Remove mcl,mssrl,msrc from nvme_ns
> 9. Initialize copy queue limits to 0 in nvme_config_copy
> 10. Remove return in QUEUE_FLAG_COPY check
> 11. Remove unused OCFS
>
> SelvaKumar S (4):
>   block: make bio_map_kern() non static
>   block: add simple copy support
>   nvme: add simple copy support
>   dm kcopyd: add simple copy offload support
>
>  block/blk-core.c          | 102 +++++++++++++++--
>  block/blk-lib.c           | 223 
>  ++++++++++++++++++++++++++++++++++++++
>  block/blk-map.c           |   2 +-
>  block/blk-merge.c         |   2 +
>  block/blk-settings.c      |  10 ++
>  block/blk-sysfs.c         |  47 ++++++++
>  block/blk-zoned.c         |   1 +
>  block/bounce.c            |   1 +
>  block/ioctl.c             |  33 ++++++
>  drivers/md/dm-kcopyd.c    |  49 ++++++++-
>  drivers/nvme/host/core.c  |  87 +++++++++++++++
>  include/linux/bio.h       |   1 +
>  include/linux/blk_types.h |  14 +++
>  include/linux/blkdev.h    |  17 +++
>  include/linux/nvme.h      |  43 +++++++-
>  include/uapi/linux/fs.h   |  13 +++
>  16 files changed, 627 insertions(+), 18 deletions(-)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
