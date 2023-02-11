Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767BAC636CC
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Feb 2023 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PurHXbJRnHGbSagoMpDJx9A09qf7W54g6forVImCpXk=; b=wJdtFsNRCipGgPOGAycED/XGXT
	GwaEyt8dTBpBYpTHtqyhXhavMV84PFWoZYItLVRsN7V4T/ZNKd45+xR/Key5bmJDVoBwgBTNtzO1+
	hWJdaHlvXiZ3Lay7/ZNnoujP/mTM6fGVqShHlKxcaaKdDT0GwnQrFL1043yuNJyfbvIBRtzWkKiIp
	T3d8+mtrPPMutcZEt3N6bhzQKfaHgvE6w6FObzx2IipUtNbnDG5VGB/93IImja3MwN07Y/t91Nu0A
	J8bmFr54k79numb3z2DyJuDXR/2cTJr+857jC/Y+PioPdVKBnpXWKUwCW4objvEjKmQD63uAV4QXR
	Sr3gN0oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQghL-008a7J-Eo; Sat, 11 Feb 2023 03:37:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQgde-008YFy-3z
	for linux-nvme@lists.infradead.org; Sat, 11 Feb 2023 03:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676086397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PurHXbJRnHGbSagoMpDJx9A09qf7W54g6forVImCpXk=;
	b=af66d5gpQnoAcUnwLoOuBfXyjY88cbsj3R2jDMuMmCq1xbfLG3w7mcF0EjU42dw5+yBrqy
	afNxlkb4B1g45MJB9Vs1eDcGigdzrBywd6DcdPRfnqNRNAiecaTuvi1aCf3m5MGet2326q
	5zQIgW9g1cr6R/mhm52v/YFPkaa4tqY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-aDWqqMpUOYWrKotzjDrxww-1; Fri, 10 Feb 2023 22:33:15 -0500
X-MC-Unique: aDWqqMpUOYWrKotzjDrxww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0509229A9D3B;
	Sat, 11 Feb 2023 03:33:15 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5442026D4B;
	Sat, 11 Feb 2023 03:33:08 +0000 (UTC)
Date: Sat, 11 Feb 2023 11:33:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Message-ID: <Y+cMcE8D9+fDVe+A@T590>
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_193322_289878_02BA0A94 
X-CRM114-Status: GOOD (  24.03  )
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

On Fri, Feb 10, 2023 at 11:30:33PM +0530, Kanchan Joshi wrote:
> is getting more common than it used to be.
> NVMe is no longer tied to block storage. Command sets in NVMe 2.0 spec
> opened an excellent way to present non-block interfaces to the Host. ZNS
> and KV came along with it, and some new command sets are emerging.
> 
> OTOH, Kernel IO advances historically centered around the block IO path.
> Passthrough IO path existed, but it stayed far from all the advances, be
> it new features or performance.
> 
> Current state & discussion points:
> ---------------------------------
> Status-quo changed in the recent past with the new passthrough path (ng
> char interface + io_uring command). Feature parity does not exist, but
> performance parity does.
> Adoption draws asks. I propose a session covering a few voices and
> finding a path-forward for some ideas too.
> 
> 1. Command cancellation: while NVMe mandatorily supports the abort
> command, we do not have a way to trigger that from user-space. There
> are ways to go about it (with or without the uring-cancel interface) but
> not without certain tradeoffs. It will be good to discuss the choices in
> person.
> 
> 2. Cgroups: works for only block dev at the moment. Are there outright
> objections to extending this to char-interface IO?

But recently the blk-cgroup change towards to associate with disk only,
which may become far away from supporting cgroup for pt IO.

Another thing is io scheduler, I guess it isn't important for nvme any
more?

Also IO accounting.

> 
> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
> with block IO path, last year. I imagine plumbing to get a bit simpler
> with passthrough-only support. But what are the other things that must
> be sorted out to have progress on moving DMA cost out of the fast path?
> 
> 4. Direct NVMe queues - will there be interest in having io_uring
> managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
> io_uring SQE to NVMe SQE without having to go through intermediate
> constructs (i.e., bio/request). Hopefully,that can further amp up the
> efficiency of IO.

Interesting!

There hasn't bio for nvme io_uring command pt, but request is still
here. If SQE can provide unique ID, request may reuse it as tag.


Thanks,
Ming


