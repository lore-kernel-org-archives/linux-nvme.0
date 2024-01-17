Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C64C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LLeFnk3Q55H1BPBw4YoBu7toGUDI6gBA877Kx/ZWOrU=; b=NyaiYQ+PhRwxZPx+8mcp2GR0PV
	vG/xPKCWAzMx7FDtQ5eshjmAhytBiVShZoz5Nk6ur/2Eh5Qi2ap6O3NrRbbMLqoV50txc0h87UYlI
	x9m0TQY068MzUGptfvXduYm0oYFv5mw725Pu3sjeWhsMIXsMrtNsiSCsOlGD7WZ0ofBIukDckITxM
	1a6NywLq2W7aalHqRQTs/Y7ZQ1ipLyFoGAXxVMl8iIMhbTmbiXYw+7y3DiLqqjl1d1fFLV+y56qrS
	zyZcYHn/C6OiH0U2zdaxXzG+GS928xyHyJfh2xDW1LSolv5SWi75sOf+MYHSGhaZVpGelbhNsuGVN
	n+ZTTQmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDq4-000rRL-1S;
	Wed, 17 Jan 2024 21:52:48 +0000
Received: from mail-oi1-f182.google.com ([209.85.167.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDq1-000rOY-08
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 21:52:46 +0000
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd9a1dd92fso321049b6e.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 13:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705528300; x=1706133100; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLeFnk3Q55H1BPBw4YoBu7toGUDI6gBA877Kx/ZWOrU=;
        b=zmy3XBpH12+XSvZCDtewWu5mGfel3DOKe4+ts5WOdWtN27K6Gho1btb/4fNNr4uR/9
         vgfujabRUoP3IipiRBfVTHyiMV56FRrHonjfJQ7aTkSume38qoEclzOy1eWNPoV3SNhN
         5VdBGmGyWEOY/tXfKjRyrvzQewLnMH5QknzyyhOD81aQWbQeQUj0emPkooAecOgJ1aY9
         ygz6rNh8PpvGSJVyXNoCmelxVXsj3bOgQ0WQzUi9Fw88YSTgMjQOFoLcXMNnLKX5dako
         5n95w7PX7hga2vleKQHLwekkIE+b1EflqQZh9Pmupz56hgjd4YTEYmF0FhGSPTcA9wfp
         srwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528300; x=1706133100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLeFnk3Q55H1BPBw4YoBu7toGUDI6gBA877Kx/ZWOrU=;
        b=qxEjTCVLqhvUgwUNJ+2p3k7qgrJeWb6FzJsNFGf3gesEcAwcoQqVuxr4DT6L/BJXBq
         sl4LNgq5b9uMVGrkHHxahozWiT0LLoT47Fzqkutq4X8UeTu46+O6QsGWGPiPe63JxO94
         HJSjGkCgv0ZFEUA5OT2WMG87vlJn9z+7FwfQ0kirjJCgp5SYpPJo8Nax+K03uZ3mF1EC
         hoaajnvEhu87UAD6Mq1ymQop7oO4lCJRkODkMfhtqg2zI6y11NIR4Dp3YiM6NigRsfkO
         UYg7nxmOximo7Ruz4tBtbOg8r7LRorJFbKLM+wKiXb1NpBCVlra1YGLVi7Z4zurgqxxS
         PPAg==
X-Gm-Message-State: AOJu0Yy7oCL3WfeQ/vgqwk3f7vxpt2odbY+f7gxSP7DkQyWSYztYafOy
	Z/bOZMtz15cdKlOlAZ5EquzR9mjdyMuTLQ==
X-Google-Smtp-Source: AGHT+IGESx3XdAVciQo32JGzL/U/9t/1OLisSeEzkhwKrP6ShbUuF6hJSrsKjUR/tdf3Tqk5GRjSUA==
X-Received: by 2002:a05:6808:f8e:b0:3bd:986e:23 with SMTP id o14-20020a0568080f8e00b003bd986e0023mr1186949oiw.2.1705528300428;
        Wed, 17 Jan 2024 13:51:40 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm2009134pfg.32.2024.01.17.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:51:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rQDov-00BkQF-2K;
	Thu, 18 Jan 2024 08:51:37 +1100
Date: Thu, 18 Jan 2024 08:51:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	lsf-pc@lists.linux-foundation.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <ZahL6RKDt/B8O2Jk@dread.disaster.area>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
 <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
 <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_135245_097243_EFA162E3 
X-CRM114-Status: GOOD (  28.84  )
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

On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
> > > On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
> > > > How FDP technology can improve efficiency and reliability of
> > > > kernel-space file system?
> > > 
> > > This is an open problem. Our experience is that making data placement
> > > decisions on the FS is tricky (beyond the obvious data / medatadata). If
> > > someone has a good use-case for this, I think it is worth exploring.
> > > F2FS is a good candidate, but I am not sure FDP is of interest for
> > > mobile - here ZUFS seems to be the current dominant technology.
> > > 
> > 
> > If I understand the FDP technology correctly, I can see the benefits for
> > file systems. :)
> > 
> > For example, SSDFS is based on segment concept and it has multiple
> > types of segments (superblock, mapping table, segment bitmap, b-tree
> > nodes, user data). So, at first, I can use hints to place different segment
> > types into different reclaim units.
> 
> Yes. This is what I meant with data / metadata. We have looked also into
> using 1 RUH for metadata and rest make available to applications. We
> decided to go with a simple solution to start with and complete as we
> see users.

XFS has an abstract type definition for metadata that is uses to
prioritise cache reclaim (i.e. classifies what metadata is more
important/hotter) and that could easily be extended to IO hints
to indicate placement.

We also have a separate journal IO path, and that is probably the
hotest LBA region of the filesystem (circular overwrite region)
which would stand to have it's own classification as well.

We've long talked about making use of write IO hints for separating
these things out, but requiring 10+ IO hint channels just for
filesystem metadata to be robustly classified has been a show
stopper. Doing nothing is almost always better than doing placement
hinting poorly.

> > Technically speaking, any file system can place different types of metadata in
> > different reclaim units. However, user data is slightly more tricky case. Potentially,
> > file system logic can track “hotness” or frequency of updates of some user data
> > and try to direct the different types of user data in different reclaim units.

*cough*

We already do this in the LBA space via the filesytsem allocators.
It's often configurable and generally called "allocation policies".

> > But, from another point of view, we have folders in file system namespace.
> > If application can place different types of data in different folders, then, technically
> > speaking, file system logic can place the content of different folders into different
> > reclaim units. But application needs to follow some “discipline” to store different
> > types of user data (different “hotness”, for example) in different folders.

Yup, XFS does this "physical locality is determined by parent
directory" separation by default (the inode64 allocation policy).
Every new directory inode is placed in a different allocation group
(LBA space) based on a rotor mechanism. All the files within that
directory are kept local to the directory (i.e. in the same AG/LBA
space) as much as possible.

Most filesystems have LBA locality policies like this because it is
highly efficient on physical seek latency limited storage hardware.
i.e. the storage hardware we've mostly been using since the early
1980s.

We could make allocation groups have different reclaim units,
but then we are talking about needing an arbitrary number of
different IO hints - XFS supports ~2^31 AGs if the filesystem is
large enough, and there's no way we're going to try to support that
many IO hints (software or hardware) in the foreseeable future.

IF devices want to try to classify related data themselves, then
using LBA locality internally to classify relationships below the
level of IO hints, then that would be a much closer match to how
filesystems have traditionally structured the data and metadata on
disk. Related data and metadata tends to get written to the same LBA
regions because that's the fastest way to access related and
metadata on seek-limited hardware.

Yeah, I know that these are SSDs we are talking about and they
aren't seek limited, but when we already have filesystem
implementations that try to clump related things to nearby LBA
spaces, it might be best to try to leverage this behaviour rather
than try to rely on kernel and userspace to correctly provide hints
about their data patterns.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

