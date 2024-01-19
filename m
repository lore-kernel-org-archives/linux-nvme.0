Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80660C4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8tuBInj9J3wH9KOqK2vAqakrSXV0jA7Hz6gW5gvvw0=; b=XqHAYlbwzx8xWeau2Ae/WyU1b7
	yf+ocxQb0PSZt6J+YK/79l3D0TB9xnXXZfVTBbslfTLm/9KnHMu+5s/1q9oiMmUb+gAA6PF3qdiky
	m/Eyyq7TXcmWurN0QET9eIiCnWIZJTUALVE7DARZKAl5yDzvnpBfH0uHlu41ZtSlIfx5Ah0UNWlQw
	pnimHwB0ytpFAZKFpkwcjY+zgHKSf8CFxjDfkri/I9oYHG9P313XONgOgFv5speRb4IQtgk6PVqWd
	U622z/+D9beFqCPa+KV+Lyl229uZVrU4qACSpsw0yCWdoimx+2sqPa9PnSfKSiGTHud9rNeqmmQLu
	tqo+CK8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQvoA-006azz-08;
	Fri, 19 Jan 2024 20:49:46 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQvo7-006aza-09
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 20:49:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7CAFFB81CDB;
	Fri, 19 Jan 2024 20:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B34C433F1;
	Fri, 19 Jan 2024 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705697380;
	bh=ULOIRBPrMeDfSN1D3IxraZwLRBgSo/f7XWxfB6Eofxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEUmxWi1MMVwOTWVYgyanV5UKKbnmqb37c28J6+QUSNp8xwj6WqpkrhqFFIqoKuA5
	 8hShNIsHBy5UY9KBXm7JGR2R0f9/s/tTj7Xxcy634pVXDb/YVbPeEYFSsowwjh5Fdf
	 QQVJdNyVRMFWSm/hfm81Cctw+tJRE22PrHvJWXPFMAWBg0VCnPdGdhpNHRAiiZTh0s
	 kUmywlWgXOxT5bKFR9EpU0ALlAOzrCyyVJqgJCvo16FN0ZblbLp5IurgVhJpPk3BAr
	 Y5ZIPkcZX2w8rj+Y4hNukwUGkl90mLkvpPOb5z42i6x7H9Y2L7TwDi3/58m/RsKR0m
	 4B79Qe+aBxbcw==
Date: Fri, 19 Jan 2024 13:49:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	lsf-pc@lists.linux-foundation.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <ZargYTc8HE47a0s7@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
 <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
 <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
 <ZahL6RKDt/B8O2Jk@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZahL6RKDt/B8O2Jk@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_124943_372228_E8296116 
X-CRM114-Status: GOOD (  26.72  )
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

On Thu, Jan 18, 2024 at 08:51:37AM +1100, Dave Chinner wrote:
> On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
> > On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
> > > > On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
> > > > > How FDP technology can improve efficiency and reliability of
> > > > > kernel-space file system?
> > > > 
> > > > This is an open problem. Our experience is that making data placement
> > > > decisions on the FS is tricky (beyond the obvious data / medatadata). If
> > > > someone has a good use-case for this, I think it is worth exploring.
> > > > F2FS is a good candidate, but I am not sure FDP is of interest for
> > > > mobile - here ZUFS seems to be the current dominant technology.
> > > > 
> > > 
> > > If I understand the FDP technology correctly, I can see the benefits for
> > > file systems. :)
> > > 
> > > For example, SSDFS is based on segment concept and it has multiple
> > > types of segments (superblock, mapping table, segment bitmap, b-tree
> > > nodes, user data). So, at first, I can use hints to place different segment
> > > types into different reclaim units.
> > 
> > Yes. This is what I meant with data / metadata. We have looked also into
> > using 1 RUH for metadata and rest make available to applications. We
> > decided to go with a simple solution to start with and complete as we
> > see users.
> 
> XFS has an abstract type definition for metadata that is uses to
> prioritise cache reclaim (i.e. classifies what metadata is more
> important/hotter) and that could easily be extended to IO hints
> to indicate placement.
>
> We also have a separate journal IO path, and that is probably the
> hotest LBA region of the filesystem (circular overwrite region)
> which would stand to have it's own classification as well.

Filesystem metadata is pretty small spatially in the LBA range, but
seems to have higher overwrite frequency than other data, so this could
be a great fit for FDP. Some of my _very_ early analysis though
indicates REQ_META is too coarse to really get the benefits, so finer
grain separation through new flag or hints should help.
 
> We've long talked about making use of write IO hints for separating
> these things out, but requiring 10+ IO hint channels just for
> filesystem metadata to be robustly classified has been a show
> stopper. Doing nothing is almost always better than doing placement
> hinting poorly.

Yeah, a totally degenerate application could make things worse than just
not using these write hints. NVMe's FDP has a standard defined feedback
mechanism through log pages to see how well you're doing with respect to
write amplification. If we assume applications using this optimization
are acting in good faith, we should be able to tune the use cases. The
FDP abstractions seem appropriate to provide generic solutions that
don't tailor to just any one vendor.

