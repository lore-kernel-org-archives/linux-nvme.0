Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DBC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:12:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7F42065D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHsC0CwU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pcZSwZip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7F42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+mWuyKUHH3S8LUNUZN3SZPoH/BzSKkxk3fw69koGGD8=; b=GHsC0CwUSsMLn0AWYbxzkNIxQ
	jLC9Fmc+/KVd05epLPlUAyxTV/t6IPOGGlzk9wVks9VXOIauY+GjKXT9FPLemJNeXm+SjmS78Ee0H
	LoQXc+z6QFWRLktnybsolCf7IhC1CReaK76+MBZnmykFvIGlLY3opOTzcL3F1E4+hIXPaOZA9IVZ6
	KgeWcPYT1xg6tJp4mqmVaMEqHLfuIOTKe0gh+D5B0vGjzfoBGAPEcKcClH5aoyhKPrgXyApTB5wzS
	mHGbmEEkEJLuwFtrumJQLCDaRWva+O0BK2vcuP4Dp1eyxrbh6o+UMLcNxZUhLFpM3Z9J32ObLWS3D
	lwBa83sjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTXxD-0003rA-KI; Fri, 16 Oct 2020 22:12:03 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTXx9-0003qH-KN
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 22:12:01 +0000
Received: by mail-ej1-x643.google.com with SMTP id p15so5426086ejm.7
 for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2020 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
 b=pcZSwZipujNJCrfM4BfqKwSqTOO1tlVYDfGgPLS5HMjSaaFti2Es6Ws8L0Vp4BR0qh
 V71HRk4m6HBbQwP316nTLWmc9NtPWjJoKiZpDvVhYVTbaYa/iDspy0qQC3pPHUUbAxEP
 zx3rQt9TI6QwN7gwLb0sg0V8vWNYZRCctVPbbEN7+CaURNJuIJN6h3o7SOdhd6XWdAop
 RRqvh6nC7BWdaTGvYZdPr7glVwHYKPJHm19PsrI3BQgLw3/cc2+Y+AP+97Z/dyQ/9T2R
 wAMzEqSRy9Wjy5kcby+9zvQUhPtHVm/pArQ2K+jUYkJk0ofEaV3TM5Zw1LOaKF/TNQie
 BoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
 b=RKDFGrUOHiiYytJeuR056rOsuif5EYqZiVNP9Rc7t0KC7UStOs+0veum4qwJOgljqa
 obAy8IW9yzVDy6dx9vf/72lz8OvtoPC065H0XwTx0+T5WocAyIZtNG9t8txeB3y5ijcQ
 dt4OnrP+TZJSQarZSl9oVcsCqJ4fPjc7z/2wqHXnsy5VT05Md45w71TCtU2YSdxvMpD3
 DE8kLlwPPTN3a4aJVFkEDyJLggrtNOUhywb/1yO40vRDA5kV09rbLimDslPn5I0dla8k
 OO3RqRkPJ3gxYndNSuOKD0ClrYfNXo5z9hmZ2s8tbQfJy4dn8xGE36hI1/1kpZK30uWs
 tq0g==
X-Gm-Message-State: AOAM5304aY02aY2vVnvFgPKwyJhvMc0dCvdtePwPdQWZ4K0K/fTbQjAN
 J1vi6dWJrhKz5aNxLewhilx7snE18cpNoyThsbif+w==
X-Google-Smtp-Source: ABdhPJxsSOm3B4N0u0qHPPJOfUxJ1kby8jXT5wG1X7DBdcrTYVmjnEFqodQltQhk0823yfa2RC70ioRF0pDuj3vqDrA=
X-Received: by 2002:a17:906:b88f:: with SMTP id
 hb15mr5934428ejb.45.1602886318070; 
 Fri, 16 Oct 2020 15:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Oct 2020 15:11:48 -0700
Message-ID: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_181159_814995_297DE26E 
X-CRM114-Status: GOOD (  25.10  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Steve Moyer \(smoyer\)" <smoyer@micron.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "John Groves \(jgroves\)" <jgroves@micron.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Pierre Labat \(plabat\)" <plabat@micron.com>,
 "Greg Becker \(gbecker\)" <gbecker@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > I don't think this belongs into the kernel.  It is a classic case for
> > infrastructure that should be built in userspace.  If anything is
> > missing to implement it in userspace with equivalent performance we
> > need to improve out interfaces, although io_uring should cover pretty
> > much everything you need.
>
> Hi Christoph,
>
> We previously considered moving the mpool object store code to user-space.
> However, by implementing mpool as a device driver, we get several benefits
> in terms of scalability, performance, and functionality. In doing so, we relied
> only on standard interfaces and did not make any changes to the kernel.
>
> (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> a collection of logically related objects with a single system call. The objects in
> such a collection are created at different times, physically disparate, and may
> even reside on different media class volumes.
>
> For our HSE storage engine application, there are commonly 10's to 100's of
> objects in a given mcache map, and 75,000 total objects mapped at a given time.
>
> Compared to memory-mapping objects individually, the mcache map facility
> scales well because it requires only a single system call and single vm_area_struct
> to memory-map a complete collection of objects.

Why can't that be a batch of mmap calls on io_uring?

> (2) The mcache map reaper mechanism proactively evicts object data from the page
> cache based on object-level metrics. This provides significant performance benefit
> for many workloads.
>
> For example, we ran YCSB workloads B (95/5 read/write mix)  and C (100% read)
> against our HSE storage engine using the mpool driver in a 5.9 kernel.
> For each workload, we ran with the reaper turned-on and turned-off.
>
> For workload B, the reaper increased throughput 1.77x, while reducing 99.99% tail
> latency for reads by 39% and updates by 99%. For workload C, the reaper increased
> throughput by 1.84x, while reducing the 99.99% read tail latency by 63%. These
> improvements are even more dramatic with earlier kernels.

What metrics proved useful and can the vanilla page cache / page
reclaim mechanism be augmented with those metrics?

>
> (3) The mcache map facility can memory-map objects on NVMe ZNS drives that were
> created using the Zone Append command. This patch set does not support ZNS, but
> that work is in progress and we will be demonstrating our HSE storage engine
> running on mpool with ZNS drives at FMS 2020.
>
> (4) mpool's immutable object model allows the driver to support concurrent reading
> of object data directly and memory-mapped without a performance penalty to verify
> coherence. This allows background operations, such as LSM-tree compaction, to
> operate efficiently and without polluting the page cache.
>

How is this different than existing background operations / defrag
that filesystems perform today? Where are the opportunities to improve
those operations?

> (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> convenient mechanism for controlling access to and managing the multiple storage
> volumes, and in the future pmem devices, that may comprise an logical mpool.

Christoph and I have talked about replacing the pmem driver's
dependence on device-mapper for pooling. What extensions would be
needed for the existing driver arch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
