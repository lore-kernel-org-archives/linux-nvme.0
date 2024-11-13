Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B078DD637D2
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 23:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dR6gxZVOVPj2t9+Oku6JJyuYiTaMGP57Slvmc9QYLdI=; b=01ZqkVL+Dk4KRSmES+UinoVZ/w
	8v2KTRO3tjDOTnh2LgGJpLY0GhVt5lnWpzeKNza2qcshWQ5BRYI8fdRtRinOZTrkA0uoDPMPSOXAR
	tbJcFbBh7TgX5F0hQdlSyKXY4r1kDDVmonjHtwGnIPHM5ypjUXRgmEnG2A1bsyGrkX7Pwf1nXAsmC
	yUFI2R9r+mHJmEZ+emD2tfAPrA0PzCxY4LNs1DkHMh3OU5GY0m/FdSeDH4LWdSbUR09/EJlPg6G80
	Px+KPQ1DeTRGK1X0g2ehaOS0vT4b97SYaU5wRZ5KEmMcxcRFG5dea/MdPWgvpE+ybo0qlqn0B5GXQ
	nuhOCTsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBN8o-00000008HgS-2nvg;
	Wed, 13 Nov 2024 23:51:18 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBN8l-00000008Hfh-1dhh
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 23:51:17 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso6770a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731541874; x=1732146674; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dR6gxZVOVPj2t9+Oku6JJyuYiTaMGP57Slvmc9QYLdI=;
        b=YKpAzp80Y3tTht/OAdwy6QQs1X4gPhaFgmBMQYJkWFDV4p7ZzrwEOTxrY0OyYK6Y7T
         yOoFLL7M22rgd3pg21K0t6OV+brSaBGEtAr6UaCmkKkCKhJvCLstb/zvWIYX8FU/L993
         JTnh2gdUpDe2WCQBBl3+cibPcgqdAfpf+JsmkyTvUjr7SFKcNqn245077cLQMVqDK7pS
         1mQUdreOPuxci3bL4re9ZGINdCYuGtolV8fpTQWnvfdRa5zTxycoQ2IY4YKHhHf0kzUa
         SnMLRJtBxEeODwDZL1O/iYmndejXSjyLxq6DkYWjhgBvH698e5/Ezf4v+So6r9Jpxcfk
         SCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541874; x=1732146674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR6gxZVOVPj2t9+Oku6JJyuYiTaMGP57Slvmc9QYLdI=;
        b=bMo8EOJhuNXFe1/ld0vvFdiiFY/kA4LKkUiNa6413eNc+y88RVd/h5tmoZTltFyPzh
         jPJCrvP+9Ikww8miXI2fTbOYtcKfhXfS2pQNtzGjnRJ41ksIxyg3FhIp0Ph4X/78njHg
         iwceg9f9OEp/SSA5UB3NYhzNyGSDVfKmqGghnKo/IxyBReeeQKT6YWS+mRx7xfuZcvA5
         xy05sAa7zrVm0vOLZzoT19ZNQwCHCEajALMaCN3loFYrvbMsY8noj7VVje6yMV6DJmYk
         Cp2nlD378MuwZrS6wGgyB8yXDNdx7mBftuRem5VGptYY8i5zp6WZieRkmsqHOm8ysHLO
         tcRw==
X-Forwarded-Encrypted: i=1; AJvYcCWosmDw33csnXoaSFh1FKmJzGYbtHc1mIMC2v8X825foiamcA4Njn7I1egfbfNfmqro5ODIt02BEDGj@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7ykasq55JsRTMSGQ07iR0xKzywsNXBgRD3cS2GemrdK97lupY
	1j4lBxYHxUPaU0TGx5D+OK5ggelPr4+GvpAuO4J965qfefAN6SOhGLE5hmwd3BY=
X-Google-Smtp-Source: AGHT+IGnJMdOUCMCs6jEMGK8slkeJs2lCzIM0b+P01P83BSSB16iV+QAJQtoT6rroZ1RFQlD0VyEEQ==
X-Received: by 2002:a17:90b:1f89:b0:2e2:ada8:2986 with SMTP id 98e67ed59e1d1-2e9fe6640c3mr1819128a91.16.1731541873837;
        Wed, 13 Nov 2024 15:51:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b8dsm134060a91.9.2024.11.13.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:51:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tBN8f-00EIWG-34;
	Thu, 14 Nov 2024 10:51:09 +1100
Date: Thu, 14 Nov 2024 10:51:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Pierre Labat <plabat@micron.com>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [EXT] Re: [PATCHv11 0/9] write hints with nvme fdp and scsi
 streams
Message-ID: <ZzU7bZokkTN2s8qr@dread.disaster.area>
References: <20241108193629.3817619-1-kbusch@meta.com>
 <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com>
 <20241111102914.GA27870@lst.de>
 <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
 <20241112133439.GA4164@lst.de>
 <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
 <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
 <20241113044736.GA20212@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113044736.GA20212@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_155115_730454_01C735F5 
X-CRM114-Status: GOOD (  28.97  )
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

On Wed, Nov 13, 2024 at 05:47:36AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 06:18:21PM +0000, Pierre Labat wrote:
> > About 2)
> > Provide a simple way to the user to decide which layer generate write hints.
> > As an example, as some of you pointed out, what if the filesystem wants to generate write hints to optimize its [own] data handling by the storage, and at the same time the application using the FS understand the storage and also wants to optimize using write hints.
> > Both use cases are legit, I think.
> > To handle that in a simple way, why not have a filesystem mount parameter enabling/disabling the use of write hints by the FS?
> 
> The file system is, and always has been, the entity in charge of
> resource allocation of the underlying device.  Bypassing it will get
> you in trouble, and a simple mount option isn't really changing that
> (it's also not exactly a scalable interface).
> 
> If an application wants to micro-manage placement decisions it should not
> use a file system, or at least not a normal one with Posix semantics.
> That being said we'd demonstrated that applications using proper grouping
> of data by file and the simple temperature hints can get very good result
> from file systems that can interpret them, without a lot of work in the
> file system.  I suspect for most applications that actually want files
> that is actually going to give better results than trying to do the
> micro-management that tries to bypass the file system.

This.

The most important thing that filesystems do behind the scenes is
manage -data locality-. XFS has thousands of lines of code to manage
and control data locality - the allocation policy API itself has a
*dozens* control parameters. We have 2 separate allocation
architectures (one btree based, one bitmap based) and multiple
locality policy algorithms. These juggled physical alignment, size
granularity, size limits, data type being allocated for, desired
locality targets, different search algorithms (e.g. first fit, best
fit, exact fit by size or location, etc), multiple fallback
strategies when the initial target cannot be met, etc.

Allocation policy management is the core of every block based
filesystem that has ever been written.

Specifically to this "stream hint" discussion: go look at the XFS
filestreams allocator.

SGI wrote an entirely new allocator for XFS whose only purpose in
life is to automatically separate individual streams of user data
into physically separate regions of LBA space.

This was written to optimise realtime ingest and playback of
multiple uncompressed 4k and 8k video data streams from big
isochronous SAN storage arrays back in ~2005.  Each stream could be
up to 1.2GB/s of data. If the data for each IO was not exactly
placed in alignment with the storage array stripe cache granularity
(2MB, IIRC), then a cache miss would occur and the IO latency would
be too high and frames of data would be missed/dropped.

IOWs, we have an allocator in XFS that specifically designed to
separate indepedent streams of data to independent regions of the
filesystem LBA space to effcient support data IO rates in the order
of tens of GB/s.

What are we talking about now? Storage hardware that might be able
to do 10-15GB/s of IO that needs stream separation for efficient
management of the internal storage resources.

The fact we have previously solved this class of stream separation
problem at the filesystem level *without needing a user-controlled
API at all* is probably the most relevant fact missing from this
discussion.

As to the concern about stream/temp/hint translation consistency
across different hardware: the filesystem is the perfect place to
provide this abstraction to users. The block device can expose what
it supports, the user API can be fixed, and the filesystem can
provide the mapping between the two that won't change for the life
of the filesystem...

Long story short: Christoph is right.

The OS hints/streams API needs to be aligned to the capabilities
that filesystems already provide *as a primary design goal*. What
the new hardware might support is a secondary concern. i.e. hardware
driven software design is almost always a mistake: define the user
API and abstractions first, then the OS can reduce it sanely down to
what the specific hardware present is capable of supporting.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

