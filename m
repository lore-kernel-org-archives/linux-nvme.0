Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A72C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:12:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D25123447
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D25123447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3UbIaT2pphto7T92ymnki1WTSApp2aeRnkrpAfEtgL0=; b=xvU2XQufB3QkhXN9kNgATcWdi
	l5fOWUm0J3K9gz+7nyPP3hh8/tY0+MpEHYU2IZNiClFDFmflisIZWNJQ082v1N48uu3g8xR7boxGs
	UTNK55/xPdHutzU+9afTgXtlM+WujGJ7tJ8KPboMXqwmSmzH+HT72JbnTReY7qunqmcoyNpI9LD06
	vv3zkHZJaIDaTI3dE2Uey6St0h329JWPH6tA6QspM93bW+NRISQs/2gUtjqkG5jmmYN9843GiPQr/
	en+WtnVoFgELu4VHtrRnJuD0J6/SvmLpHm7MyVTHhBGrtuqi4zzwtegFMp8Wdm6kswq0jXfH8mw1L
	r4GH7iRdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmHF8-0003G8-QL; Mon, 07 Dec 2020 14:11:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmHEc-0002yr-I6
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 14:11:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7321567373; Mon,  7 Dec 2020 15:11:23 +0100 (CET)
Date: Mon, 7 Dec 2020 15:11:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207141123.GC31159@lst.de>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204094659.12732-1-selvakuma.s1@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_091126_934981_C81DB584 
X-CRM114-Status: GOOD (  23.24  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Mikulas Patocka <mpatocka@redhat.com>, joshi.k@samsung.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>, kbusch@kernel.org,
 javier.gonz@samsung.com, linux-scsi@vger.kernel.org, hch@lst.de,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

So, I'm really worried about:

 a) a good use case.  GC in f2fs or btrfs seem like good use cases, as
    does accelating dm-kcopyd.  I agree with Damien that lifting dm-kcopyd
    to common code would also be really nice.  I'm not 100% sure it should
    be a requirement, but it sure would be nice to have
    I don't think just adding an ioctl is enough of a use case for complex
    kernel infrastructure.
 b) We had a bunch of different attempts at SCSI XCOPY support form IIRC
    Martin, Bart and Mikulas.  I think we need to pull them into this
    discussion, and make sure whatever we do covers the SCSI needs.

On Fri, Dec 04, 2020 at 03:16:57PM +0530, SelvaKumar S wrote:
> This patchset tries to add support for TP4065a ("Simple Copy Command"),
> v2020.05.04 ("Ratified")
> 
> The Specification can be found in following link.
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> 
> This is an RFC. Looking forward for any feedbacks or other alternate
> designs for plumbing simple copy to IO stack.
> 
> Simple copy command is a copy offloading operation and is  used to copy
> multiple contiguous ranges (source_ranges) of LBA's to a single destination
> LBA within the device reducing traffic between host and device.
> 
> This implementation accepts destination, no of sources and arrays of
> source ranges from application and attach it as payload to the bio and
> submits to the device.
> 
> Following limits are added to queue limits and are exposed in sysfs
> to userspace
> 	- *max_copy_sectors* limits the sum of all source_range length
> 	- *max_copy_nr_ranges* limits the number of source ranges
> 	- *max_copy_range_sectors* limit the maximum number of sectors
> 		that can constitute a single source range.
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
> SelvaKumar S (2):
>   block: add simple copy support
>   nvme: add simple copy support
> 
>  block/blk-core.c          |  94 ++++++++++++++++++++++++++---
>  block/blk-lib.c           | 123 ++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         |   2 +
>  block/blk-settings.c      |  11 ++++
>  block/blk-sysfs.c         |  23 +++++++
>  block/blk-zoned.c         |   1 +
>  block/bounce.c            |   1 +
>  block/ioctl.c             |  43 +++++++++++++
>  drivers/nvme/host/core.c  |  87 +++++++++++++++++++++++++++
>  include/linux/bio.h       |   1 +
>  include/linux/blk_types.h |  15 +++++
>  include/linux/blkdev.h    |  15 +++++
>  include/linux/nvme.h      |  43 ++++++++++++-
>  include/uapi/linux/fs.h   |  13 ++++
>  14 files changed, 461 insertions(+), 11 deletions(-)
> 
> -- 
> 2.25.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
