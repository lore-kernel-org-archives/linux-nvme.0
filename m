Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB1C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 23:53:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7BB64E41
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 23:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7BB64E41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZATaV9iYi1GXgm8VgIMexzqDIHtRNZag01mSYC3RXw4=; b=kTmZZpF0kgyWQK1j26UWFbW7J
	3qzeKZzOzu0Jw5Sb5fPD5pcjkCuxr4bQQHUZ7i9EW13E4InqZGIED6MkZg/5KNyBlbTanM356RthE
	Z3LrNqMwdIXsaBGyLlqfTJkA7B43FtpiLJy4MtkvGFDKGPltjFaBwdhetHZKvaau0pVTogU9WXRsa
	2yF/2TOJIly7VCe3Z2EEiWun0f5a4bdlj20AQIPnBQNh+LrdOhjPk9+5gTVNtra0wauMYhzfRpDBq
	dwcEhaVPd2TGPfGSiXPVBB2ZqmkMDnJ70duHIzIFsPJqeCYvd/kYKFV2cSZves2QjUIRa8MlkYNT0
	jlR8vJWhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDyX7-0000tc-HF; Sun, 21 Feb 2021 23:53:01 +0000
Received: from mail108.syd.optusnet.com.au ([211.29.132.59])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDyX3-0000t9-Ur
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 23:52:59 +0000
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au
 [49.179.130.210])
 by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 7E7221ADB51;
 Mon, 22 Feb 2021 10:52:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1lDyWu-00Fq01-QV; Mon, 22 Feb 2021 10:52:48 +1100
Date: Mon, 22 Feb 2021 10:52:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210221235248.GZ4626@dread.disaster.area>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
 a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
 a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=pNaSbsGRAAAA:8 a=7-415B0cAAAA:8
 a=bdcsEvdjF_AAMq5uHxAA:9 a=CjuIK1q_8ugA:10 a=k8uaQqolKd8A:10
 a=cz0TccRYsqG1oLvFGeGV:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_185258_243799_B9236074 
X-CRM114-Status: GOOD (  15.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 19, 2021 at 06:15:13PM +0530, SelvaKumar S wrote:
> This patchset tries to add support for TP4065a ("Simple Copy Command"),
> v2020.05.04 ("Ratified")
> 
> The Specification can be found in following link.
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> 
> Simple copy command is a copy offloading operation and is  used to copy
> multiple contiguous ranges (source_ranges) of LBA's to a single destination
> LBA within the device reducing traffic between host and device.
> 
> This implementation doesn't add native copy offload support for stacked
> devices rather copy offload is done through emulation. Possible use
> cases are F2FS gc and BTRFS relocation/balance.

It sounds like you are missing the most obvious use case for this:
hooking up filesystem copy_file_range() implementations to allow
userspace to offload user data copies to hardware....

Another fs level feature that could use this for hardware
acceleration fallocate(FALLOC_FL_UNSHARE).

These are probably going to be far easier to hook up than filesystem
GC algorithms, and there is also solid data integrity and stress
testing checking infrastructure for these operations via fstests.

> As SCSI XCOPY can take two different block devices and no of source range is
> equal to 1, this interface can be extended in future to support SCSI XCOPY.

That greatly complicates the implementation. do we even care at this
point about cross-device XCOPY at this point?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
