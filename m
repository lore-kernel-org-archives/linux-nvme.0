Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF0C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 21:36:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5557F22244
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zOcpcRQm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vz2AkNUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5557F22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v4IND1tV6+pZJIMucg2QWAVLVeuKMybnkODLS7DsMSs=; b=zOcpcRQmKeBDF+KcYpM2paRw7
	eMHXPNlh02OpHUJg4HwLLtiayyiYyEXuyffFfj32gtqOtZRzB9x/X7fig8D8fduXIoEw03ndag3Jg
	FgawcNYdco8+jdmEciThXbPkoVD+VZXvFDsmgegBpXrQKRJ7O2Jp0invv/ZCcu0S/drQnRI+Cl6zV
	QVYpkj1suFz0dpy6Bd8gItuHSsxTP+UUxASwxtl+b/c+KNYBF+ARPu74KSzpP2jtFS5FquDpqi6PL
	YfzTNXxWGPnS8rlXLtA7hqAB0nCCYmIJzujqxu5sdxL38EoJEaRsgvACHTOk29B3UnJve+nukySmc
	e05QXVSpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUzIY-0002z7-Us; Tue, 20 Oct 2020 21:36:03 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUzIU-0002xn-NO
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 21:36:00 +0000
Received: by mail-ej1-x641.google.com with SMTP id md26so4925158ejb.10
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
 b=vz2AkNUQj4/8TjPt9jfB06mE5lh3/rlUf+7TZCmQybUg2w9Uy6vQWbxXQCV3LtCDo6
 8NrtKsKDpJKbo08xxZc3HVsXDnUkKREszdVB2trWrs/2AdrZ3mckGXVRO6A2eIKS2906
 Z3RSSNONukymyOXsAGQm4R3ZP6mqVzcK95g/x/1IMvf8wVgCEz66GYAsUm+U916t5qMV
 Ud4Q2SPAHqkVMkhaMoeNEEg/w+QWIpXZYUr+Go78/SEGrUm7J3KqYmBLlQo51CR7KtRg
 TEmUrewGCc0Mw15SfxVDhlxCP3L6jNmETWroPevOTLaxA96Bn4Xgyce/T0RK/mgi2IXd
 /x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
 b=Z7+nV4PbDWfw7vlbejzMyQLHDA+SxWju7/KULOpOgEau4cP7U+yT3oA+OeQdJwmXSt
 UQpbB/CsdUfNgIwwpjU3tw7dxZ68GuuLWouJ2UhZXn2CANkPS7prE4CMoetCRkiXQRnm
 /b6ePyETncygt8x71idjLRtgdFAYmXz/e7RIkB62m+6BjrHb8F8Oxgzqux+GqSPnG0lE
 Z95l1Cb/6Mh50oPfv4Pz9QkCIkMy3FmSpjRPwQG3R7aVZF/p526kK9cIpat+iUQXKfae
 /r5Otghqi5FWrP12vQRYdBrrmYRge672kjUIo03sA5jkDmHbN1YCq++plzgRuvekVMhN
 JdFQ==
X-Gm-Message-State: AOAM533YovTaY+2mEDhRURuNEg7Kfp8MuuS3Ij2RJStZBwGb4M8/sOgN
 wyP2YW3SHrgvGN8mcSA7+R0dBv52SCtBQoZxo9IpLQ==
X-Google-Smtp-Source: ABdhPJxdsFzso6n0bhQlIsaXXdnNPz55lLRK+7wVqKJ60Myp6XphIfmevRWnAF5iTVW1mTgE1+z4eTNT633n3PsqwaQ=
X-Received: by 2002:a17:906:c20f:: with SMTP id
 d15mr155804ejz.341.1603229755722; 
 Tue, 20 Oct 2020 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Oct 2020 14:35:44 -0700
Message-ID: <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_173558_904630_FAE793B4 
X-CRM114-Status: GOOD (  26.56  )
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

On Mon, Oct 19, 2020 at 3:30 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> Hi Dan,
>
> On Friday, October 16, 2020 4:12 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> > >
> > > On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig
> > <hch@infradead.org> wrote:
> > > > I don't think this belongs into the kernel.  It is a classic case for
> > > > infrastructure that should be built in userspace.  If anything is
> > > > missing to implement it in userspace with equivalent performance we
> > > > need to improve out interfaces, although io_uring should cover pretty
> > > > much everything you need.
> > >
> > > Hi Christoph,
> > >
> > > We previously considered moving the mpool object store code to user-space.
> > > However, by implementing mpool as a device driver, we get several benefits
> > > in terms of scalability, performance, and functionality. In doing so, we relied
> > > only on standard interfaces and did not make any changes to the kernel.
> > >
> > > (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> > > a collection of logically related objects with a single system call. The objects in
> > > such a collection are created at different times, physically disparate, and may
> > > even reside on different media class volumes.
> > >
> > > For our HSE storage engine application, there are commonly 10's to 100's of
> > > objects in a given mcache map, and 75,000 total objects mapped at a given
> > time.
> > >
> > > Compared to memory-mapping objects individually, the mcache map facility
> > > scales well because it requires only a single system call and single
> > vm_area_struct
> > > to memory-map a complete collection of objects.
>
> > Why can't that be a batch of mmap calls on io_uring?
>
> Agreed, we could add the capability to invoke mmap via io_uring to help mitigate the
> system call overhead of memory-mapping individual objects, versus our mache map
> mechanism. However, there is still the scalability issue of having a vm_area_struct
> for each object (versus one for each mache map).
>
> We ran YCSB workload C in two different configurations -
> Config 1: memory-mapping each individual object
> Config 2: memory-mapping a collection of related objects using mcache map
>
> - Config 1 incurred ~3.3x additional kernel memory for the vm_area_struct slab -
> 24.8 MB (127188 objects) for config 1, versus 7.3 MB (37482 objects) for config 2.
>
> - Workload C exhibited around 10-25% better tail latencies (4-nines) for config 2,
> not sure if it's due the reduced complexity of searching VMAs during page faults.

So this gets to the meta question that is giving me pause on this
whole proposal:

    What does Linux get from merging mpool?

What you have above is a decent scalability bug report. That type of
pressure to meet new workload needs is how Linux interfaces evolve.
However, rather than evolve those interfaces mpool is a revolutionary
replacement that leaves the bugs intact for everyone that does not
switch over to mpool.

Consider io_uring as an example where the kernel resisted trends
towards userspace I/O engines and instead evolved a solution that
maintained kernel control while also achieving similar performance
levels.

The exercise is useful to identify places where Linux has
deficiencies, but wholesale replacing an entire I/O submission model
is a direction that leaves the old apis to rot.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
