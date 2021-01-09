Return-Path: <SRS0=oNOl=GM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027AC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 00:12:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F86C239EB
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 00:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F86C239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gVEvlknoLhy686P5PZr188dwyhhKQ4/LqhxT5f8nU3Q=; b=zCWuIRClewO4DO+SVLRnWPpwb
	zjjHimbVp95pMV1QdgtFcVsZN3yJ/n5r7CPmkBpaFdgzqzmiG+2/nFg02AlDKdKYLJybMuagMMuCo
	xiV2Llileaz+OaBohkSemBo5s/xusptXN1b1b+ls+C631hLb4zLOk68U99w9utr4kXmC00JE5qLs/
	+Sd/bjL41zTVxaoFhIdKFIQ+fmythWqQ6JTD+ZcslS7SBKDPB/AwUsKy7vGN7AWKg47wJTKNfYzqx
	3bDHNu4ef8u9cO9S6zbWDu2yE4dDL4rh0G3tzSBupHjRA8epVKIU4lTCr1qiYoWfsLjqCA6vGnOuM
	XhrkRnaEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ky1sB-0003ji-Md; Sat, 09 Jan 2021 00:12:51 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ky1s6-0003hF-BM
 for linux-nvme@lists.infradead.org; Sat, 09 Jan 2021 00:12:48 +0000
Received: by mail-ed1-x52d.google.com with SMTP id g24so12880100edw.9
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 16:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t5tc2KDcASlTQ7zbvnpVqF7ZfWknjyxk+i9ybon8Z3k=;
 b=iB4bSpwxPVQE08kFUYeLfQq3Xc4ZufysbrCKydHHbyYgAF00EoDHOHTCzwwW5Z6o9+
 UU5O2GFNSYFtzG9h7U77VgpWPJQOQ92jf67yC0DGQT1wxJmlqIhseeQ17sDx0mdoprzV
 P5gqrla5IWhTaKzZEM3HWsTQu40d3Vh+VlnE8E/S8t7qpuAWJIL5EcLYhjc/m2dfS5KV
 paVfe3yeLQDMCrN20CniKXlMM6tEcpi7whLLouYcI7Xu4CfEyS80vizZz8l7DbKqBRJs
 Ug240rME9I/pRN60gKLgIUu6H3ryxRkazKjtuBx0Ts0abdnfbThm41pc3DNWVcM15GIl
 H5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t5tc2KDcASlTQ7zbvnpVqF7ZfWknjyxk+i9ybon8Z3k=;
 b=O5ftAqTBDixDbOZh1CfxqIMHbXh+S34As07D5UVdxO4yLfIQWivcdF4RgpqXh1A0M/
 ZmjKOArACkGfK+rSy+msIy2wfd7fAME7dj8Ql5ZfoXwYDiNPkSdv5IEs/6gvmweSvRjj
 JRJak+Qtbdrg/VaDyMWKRWK4QGdyHuA3Zo749bhHfL5Q6HaTp7JFN54Wsm8Wf1iRIRPa
 ZSiYcGtDllZVnLEfE8xYPpexOiEivl4on9udRSD2Z4dFdBNAAgh0XPvJa6eYru2qOrNp
 jearRfg63md4zPZRVtvBv6dPAatk+x9ZhVc7CVQFlaGp6CqDnbrHz/DsBa9gBFTWSEFh
 bWSw==
X-Gm-Message-State: AOAM533Th2eC8X3op1pDUDkKlLRQp0jciUJSCZSOAvtjdTLCwV4jfTY2
 2JkVCxCFflnJDPK1b2btSts4TWgMqy9KPKXoxSCDpO6Xlec=
X-Google-Smtp-Source: ABdhPJxbPB3toIK9CMCO5GFjWfjYHBxQL3sPP/p7ueaUFyldsvkdp52f2onI7JtdaTe4zT52zC+3MoYqA/1ox2sL9pU=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr6927755edp.300.1610151162242; 
 Fri, 08 Jan 2021 16:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 8 Jan 2021 16:12:31 -0800
Message-ID: <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_191246_518118_344F36E9 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 8, 2021 at 2:34 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Jan 06, 2021 at 10:00:53AM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 04, 2021 at 08:02:20AM -0800, Keith Busch wrote:
> > > Perhaps it's too late since we've already gone done this path in the
> > > driver, but IMO, we should have only traced raw dwords without any
> > > additional decoding. This would have allowed consistent output for all
> > > kernel versions and resilient to future spec changes. Then that could
> > > have made possible for a user space utility to do the decoding to a
> > > human friendly format, kind of like what blkparse does for block layer
> > > trace events.
> >
> > the block tracepoints actually contain pretty detailed decoding as well.
>
> Sure, but what I'm trying to say is that the current nvme decoding isn't
> forward compatible with spec changes that tools will be able to use, and
> will not be possible to see currently reserved fields. It will be a
> never ending maintenance burden to chase those changes, and there will
> be no consistency in nvme trace events for different kernel versions.
>
> If it would help at all to move in a more future proof direction, I
> wrote a little script handling all the decoding and posted it here:
>
>   https://github.com/linux-nvme/nvme-trace/blob/main/nvme-trace.pl
>
> If that's okay, we can greatly simplify the nvme tracing so that it
> will always be consistent and able to obtain new command fields as they
> show up.

Is there a more centralized place to land such a helper? trace-cmd,
perf? The nice thing about kernel parsing is I don't need to have a
separate pile of disparate tools across subsystems.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
