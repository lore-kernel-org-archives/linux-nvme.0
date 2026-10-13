Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48432CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dvGvoF3jF00OPQndsebVTsb5JUa89YbbVTVQ3f9+rSw=; b=F++SZupkrf6lr6r+K/eyrIIpN3
	zFBjbg6jirsYwLmX+ZlG1FPQhQlE6MuH+LpSfOWObu1m/QVTeiymzXlXffm+lXi3g4p0YlEhG5wRW
	Z/ZmwoibDiJ+hjIk7FSjba0WPp2gqLa+ltK4gDdjPUYBdt+WPFNNn9NriRXz68DScA8LhOtgkRBAZ
	ItFVJ/4ASNV28s4klInt8h/nUBuFsLiUX1C+QQHAyv7hsjC+fd0WY1EuBUEm+jlmp02U6N/GbwJ2Z
	7SWOUTZMelZzeCmCkIcAyPzCx5P4mUg0L27BsstCNURlP/cxEHutP4/MFMfq7yY59nyOaD2jYH0Oc
	R3bZwLbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeYb-0000000DMy3-2lcV;
	Tue, 13 Oct 2026 15:36:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeYa-0000000DMxM-26cc
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:36:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2593E435C0;
	Tue, 13 Oct 2026 15:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F01F000FF;
	Tue, 13 Oct 2026 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905808;
	bh=dvGvoF3jF00OPQndsebVTsb5JUa89YbbVTVQ3f9+rSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtXcTl3W31cuzIoBd8khnJwWOcDXy/POHn4FNUW7deRXgOwWdlW3GIV/IUlKz1ZSX
	 uMgdAmCwptp15P+lDev9wGO5VygNEVQNsse7UIFcvlPUi6qbYvLEMikpUpF8sWFqYQ
	 h/KNdRh8M0Q+Z1reY1/Z/jAFsn/PVkqfG6ee/m4TeGwQxkMD4z7LT/SQzGQfBy+/OK
	 ZpaK4FKCzSiJ9AMGUJ5vrrXmHoWIiQ2Jdf/hTdbm2f+7mZb30jkDde5EP7c6osFu+a
	 6jlbJa7fvCY8aVT8q7AUtTUef+TI/u/q3K8Awmh9ItkHrnvhU1sIKSbxNo1a2uFUhj
	 cVx5o2BzTYL3A==
Date: Tue, 13 Oct 2026 09:36:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, hare@suse.de, saravanand@crusoe.ai,
	sjpark@crusoe.ai, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v5 1/2] nvme-multipath: fix path state evaluation for
 failfast and ANA
Message-ID: <as5QDrAp7srZgWwk@kbusch-mbp>
References: <20261008141407.22992-1-kiyer@crusoe.ai>
 <20261008141407.22992-2-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008141407.22992-2-kiyer@crusoe.ai>
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

On Thu, Oct 08, 2026 at 07:14:06AM -0700, Krishna Iyer wrote:
> nvme_available_path() has two problems that keep I/O queued when it
> should be failed:
> 
> 1. When fast_io_fail_tmo expires, NVME_CTRL_FAILFAST_EXPIRED is set and
>    the path is skipped, but the function still falls through to
>    nvme_mpath_queue_if_no_path(). If delayed_removal_secs is configured
>    the I/O is requeued indefinitely, defeating fast_io_fail_tmo. Only
>    fall through to queue_if_no_path when there really are no paths;
>    if a path exists but its failfast timer has expired, fail instead.
> 
> 2. A LIVE controller counts as a usable path regardless of the namespace
>    ANA state. A path whose ANA state is inaccessible or persistent-loss
>    cannot serve I/O, so it should not count as available. ANA change is
>    transient and bounded by ANATT, so keep queueing while it resolves.
> 
> Also kick the requeue work from nvme_update_ns_ana_state() when a path
> does not transition to live, so parked I/O is re-evaluated when an ANA
> transition leaves the namespace inaccessible.
> 
> Move nvme_state_is_live() above nvme_available_path() so it can be used
> there.

Thanks, applied to nvme-7.4.

