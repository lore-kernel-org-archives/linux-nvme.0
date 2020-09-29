Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0800FC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:32:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E599F2074A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a9jHQs99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E599F2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o9wNDp7oynnfpPsSpXmOYabZd2QzAC5ESvm+aM9sr2s=; b=a9jHQs99DwjTzQX26PtRR15qM
	SWF4YsR+IGtUs9F7+IwLn0ifmqqZRu7PMV2Bf/Mzr+LRp+kFYSWuZyY0lQU1vHo0sUArleNz3MWEt
	dYGXBqtQvgCVmobRRVD0348Ujv8KfmkBT+FvMfpSAA8treFNIPVRGHwmiXKa8uWHh594DRZCoH2F1
	BVrQaBNliEa8mLwp36ZxLKpqpa0c88Np3PjZMrP1puQM+HF9FH4Tttj/oAi1+K2UUUQOg9lvHTu95
	/PdfwRX2htolJoua3ryikdP3dYfvpyDTGSU2Tc72fVF8e/eyJytaA+x4u5wlvxm5mEjBVfbREWRkK
	eGi75v6JA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKQG-0004d9-BI; Tue, 29 Sep 2020 18:32:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKQC-0004Yp-Tp
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:32:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 661CB67373; Tue, 29 Sep 2020 20:32:14 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:32:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
Message-ID: <20200929183214.GD12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
 <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143217_095184_75A7A62A 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 01:48:03AM -0700, Sagi Grimberg wrote:
>
>> Ensure that there can't be any I/O in flight went we change the disk
>> geometry in nvme_update_ns_info, most notable the LBA size by lifting
>> the queue free from nvme_update_disk_info into the caller
>
> The queue is frozen on the queue logical block size, why should
> we care about I/O while ns->lba_shift?

Because we use it for all kinds of calculations in the I/O path.  By
moving all assignments into the frozen queue critical sections we
avoid all possibly inconsistencies.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
