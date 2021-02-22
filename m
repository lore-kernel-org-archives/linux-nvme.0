Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 01:32:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3B464EF5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 01:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B464EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3/9teBDIp7O0Z1K6yZfw0oN8Iiu3SGhgTfM83zhDvME=; b=bzRctHLhV+bzefgMBtlV99Nb0
	NE8SWwOJkOpD/x7i6TIiORqmGCuk+XetFCPRW/E1+OKWRi+fFwmY9DHe9SuIzmZibHD1f/oFxEJ7C
	m05PKbthY8pc7vrWxQ6ZpcBF/Qyh3vQnGfrfJORQYii2xIapETvSsIsmwp7OsxRNKTzCXGDsiMqVX
	7plY7b/05Dx4ywg42mEGXTfJv7JsZvpBY1Grt0YDeXgKW4L8iAtpdI91+dF6ODNK+ZNLITiEcVeDF
	rx34EEwAzuGb0F3BhMDIiqB+Qmt3s7hY0MdRxeFdgRD5wpwvg3KLGeaFRILTS8v+jndzBu4262BOW
	sPvOc1jHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lE05D-00060o-MA; Mon, 22 Feb 2021 01:32:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lE057-0005zB-Jl
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 01:32:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613957532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N34hBKZHkXIxa+0JV+MfgWWrHN+GVw6/8nre7Mkust8=;
 b=hieEmomI5pyfS7/HG1LRWV4LCmIR2/2l/17lI8X6ihCyJo2EtpgxUqpubB26nd63UaSDZx
 EJnmtscijgGpMbL3DVMoVApcmF5KfmUElKcHhuwsPEJrjdLsOTfDlre2gy7ImJb1KwhzR1
 Atm6gsmvEVatCRrVSpojfAKlwee3YSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-vCCu8_aQNUS3Y2da_gJthQ-1; Sun, 21 Feb 2021 20:32:00 -0500
X-MC-Unique: vCCu8_aQNUS3Y2da_gJthQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA26A79EC0;
 Mon, 22 Feb 2021 01:31:57 +0000 (UTC)
Received: from T590 (ovpn-12-196.pek2.redhat.com [10.72.12.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7972B1A867;
 Mon, 22 Feb 2021 01:31:37 +0000 (UTC)
Date: Mon, 22 Feb 2021 09:31:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <YDMJdekWhy/Y1Y1r@T590>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_203213_704862_18A60FBF 
X-CRM114-Status: GOOD (  17.22  )
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
 dm-devel@redhat.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
 joshi.k@samsung.com, javier.gonz@samsung.com, kbusch@kernel.org,
 joshiiitr@gmail.com, linux-scsi@vger.kernel.org, hch@lst.de
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
> 
> *blkdev_issue_copy* takes source bdev, no of sources, array of source
> ranges (in sectors), destination bdev and destination offset(in sectors).
> If both source and destination block devices are same and copy_offload = 1,
> then copy is done through native copy offloading. Copy emulation is used
> in other cases.
> 
> As SCSI XCOPY can take two different block devices and no of source range is
> equal to 1, this interface can be extended in future to support SCSI XCOPY.

The patchset adds ioctl(BLKCOPY) and two userspace visible data
struture(range_entry, and copy_range), all belong to kabi stuff, and the
interface is generic block layer kabi.

The API has to be allowed to extend for supporting SCSI XCOPY in future or similar
block copy commands without breaking previous application, so please CC linux-scsi
and scsi guys in your next post.


-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
