Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F5C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Rk95nbCHvSDXKzKHRytip9QY2TC4q23JnFsZN3gYMM=; b=QMdoownQ78XsQ6Yf1/hF8mbWWP
	Qu2TSbESa8lIHmSeRkia+ObRpoYsXTItil2nzH2tEqlHh4ByRY9BPJA4bDWTS3yRWj6roEDLOoWl6
	NjtQsHeaxJ56M00F8b+Tt8Y14kg83uqD5D9z5vc7HE5MGL+tfuQc08dMkiKWUHHOOv59V8QF2NXt+
	y68cWyLNEsfTTw5VW2tioaGzI0p0TfI15+UJKwDydyISXoUGAM/6waHJdRTBIzaBx5WAe6rgXPL43
	TpnDYX+KS5YvrnUKRALSQKoh6j2imRwJfCnuy2TH9UXjmHm+Af9QPdZibLAfJtqXAeFHtpsdmfYC2
	jiyH34Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hEo-00000002t5E-2C8R;
	Mon, 21 Sep 2026 16:51:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hEm-00000002t4c-2jvh
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 16:51:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 072F041743;
	Mon, 21 Sep 2026 16:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BBF1F000FF;
	Mon, 21 Sep 2026 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009487;
	bh=0Rk95nbCHvSDXKzKHRytip9QY2TC4q23JnFsZN3gYMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W0LEWUPAXKQ99l86x5srS05ioOguB9WT4+1+Fuc7Mx837xB1LILUehGNoa2FnUqtf
	 9b4lnVH/yvjvQXRt6J6fxi4mZtn4KGLZHMGFUYfYG/WIzCzVEtgHuGcOIRMEpbtozj
	 EyzS4WnrUdOIPqJl5fKHBLBgEa55c0b/RcDmmxFkCz7EGl31zZJESinWWym4pm7t8J
	 sWYuaLXA68wN1g93BResBXSlhfFvSBDZmk3hBFcbjes9I5yIvZscIc8wa8Tx43Byur
	 wqwqwb7yBjVLIu0dINTpY91/4khzJwPihi2i4GEDx+z0M5z16TJE+1UleT+kBG2q9D
	 7rVbTJCi7NMjw==
Date: Mon, 21 Sep 2026 06:51:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	yukuai@fygo.io, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [RFC PATCH 1/1] block: charge passthrough requests to the
 submitter's cgroup
Message-ID: <arFgjkKUwYGWbV8H@slm.duckdns.org>
References: <20260921070647.1928289-1-cui.tao@linux.dev>
 <20260921070647.1928289-2-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921070647.1928289-2-cui.tao@linux.dev>
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

On Mon, Sep 21, 2026 at 03:06:47PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Passthrough requests (SG_IO, bsg, nvme passthrough ioctls and uring
> commands) are dispatched via blk_execute_rq{,_nowait}() without ever
> passing through submit_bio(), so the bio mapped by blk_rq_map_user()
> carries no blkcg association: the transferred bytes never show up in
> cgroup io.stat, and every rq_qos policy on the queue (iocost,
> iolatency, wbt) is bypassed, as is blk-throttle, which hooks
> submit_bio_noacct() directly rather than going through rq_qos.
> 
> A quick demonstration on a scsi_debug device with iocost enabled and
> vrate pinned to its 1% floor: a direct fio writer was throttled ~10x
> while the same cgroup issuing sg_dd writes ran at full device speed
> with zero io.stat accounting.
> 
> Associate the mapped bio with the submitter's blkcg at dispatch time
> and run the regular bio accounting (blk_cgroup_bio_start()) and
> rq_qos throttle paths with it.  DRV_IN/DRV_OUT commands are mapped to
> READ/WRITE so io.stat classifies their bytes normally; request
> completion already pairs with the throttle through bio_endio() ->
> rq_qos_done_bio().
> 
> The charge is gated by opcode (READ/WRITE/DRV_IN/DRV_OUT) and to
> queues that already have a gendisk: commands issued during device
> probing (SCSI INQUIRY etc.) have no gendisk yet and stay exempt,
> following the same probe-exemption reasoning as the passthrough
> iostats support.

Do you have an actual use case where this matters?

Thanks.

-- 
tejun

