Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A772E77197
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 01:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OkbB09Avmo9P9VbNv2ofendGXFiO7b9ycK3o8iKvOqM=; b=k6fbxzdPT/D7YAZO1FCj86Keuu
	iCgd3/sKOh6/ynVOeHhSdArxnYJW2j/jre+bFyjGEPSGGON5GNL9+D/tE27AY3iKGu+r8KIoEm3Ie
	q2O8M1/slTCCRIrtTzaguZt95iWFe79x4CIwPBUTbOjnbzWvSatIg8haUZORybm6HIrU5ZckqVCr2
	65cBExSx3oc6Z1D/hnoJOVTPniVcyoHT0TQieglggeB4vypRVl5XKgS9kDz23TEXH5wq4zad0sSJy
	Xc9mOC7UKoDFsTDSdF0s/9uW492dRBfhO49Aca8CXc6FANzf4tIHlCvUyCERtTvS9hEom+CIuhn/2
	yJRKDYAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUcKT-000000000Sp-2vxK;
	Mon, 06 Jan 2025 01:54:53 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUcKL-000000000S1-2nJh
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 01:54:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 25A51A403AF;
	Mon,  6 Jan 2025 01:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA98C4CED0;
	Mon,  6 Jan 2025 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736128483;
	bh=VXHTSlWVeej65C6gWEdXhGhaNxkRXr5jGN61emh9ek8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEtf3Sawb5gYw3jcbVvK/g+/c3EDSX2rcB/mxneDgQOI9p2znVsjTklVuQxF7/DAy
	 yuErRnUtSZXCbqRdy/KAE++Yea+gXBb12mvvaKI28WpVy5rRHvoRlPx6iPPq2hvtch
	 CCtvF8OrHJG0Aa6lvXY7Buaf9eMZLXh7EOzquUmq9adf3LextO2sUsXV0RH2XG7eR2
	 vBsyPAi3k4O7KXKNHQyE7HmQsd7cclN3x5HRZm4uRLrmoPIAMndZaN7R8RGYcB2mXu
	 XGMHIiJThc2+fF0lXn+i0st5Jysv0qnhyJikf84UoqGHA0CfYkBfXqfyUVooFhFchv
	 m0BqcxcVZSV6Q==
Message-ID: <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
Date: Mon, 6 Jan 2025 10:53:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>, Song Liu <song@kernel.org>,
 hch@infradead.org, yanjun.zhu@linux.dev
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_175445_824007_8CFD1535 
X-CRM114-Status: GOOD (  17.54  )
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

On 1/5/25 2:52 AM, Vishnu ks wrote:
> Thank you all for your valuable feedback. I'd like to provide more
> technical context about our implementation and the specific challenges
> we're facing.
> 
> System Architecture:
> We've built a block-level continuous data protection system that:
> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> 2. Captures sector numbers (not data) of changed blocks in real-time
> 3. Periodically syncs the actual data from these sectors based on
> configurable RPO
> 4. Layers these incremental changes on top of base snapshots
> 
> Current Implementation:
> - eBPF program attached to block_rq_complete tracks sector ranges from
> bio requests
> - Changed sector numbers are transmitted to a central dispatcher via websocket
> - Dispatcher initiates periodic data sync (1-2 min intervals)
> requesting data from tracked sectors
> - Base snapshot + incremental changes provide point-in-time recovery capability
> 
> @Christoph: Regarding stability concerns - we're not using tracepoints
> for data integrity, but rather for change detection. The actual data
> synchronization happens through standard block device reads.
> 
> Technical Challenge:
> The core issue we've identified is the gap between write completion
> notification and data availability:
> - block_rq_complete tracepoint triggers before data is actually
> persisted to disk

Then do a flush, or disable the write cache on the device (which can totally
kill write performance depending on the device). Nothing new here. File systems
have journaling for this reason (among others).

> - Reading sectors immediately after block_rq_complete often returns stale data

That is what POSIX mandates and also what most storage protocols specify (SCSI,
ATA, NVMe): reading sectors that were just written give you back what you just
wrote, regardless of the actual location of the data on the device (persisted
to non volatile media or not).

> - Observed delay between completion and actual disk persistence ranges
> from 3-7 minutes

That depends on how often/when/how the drive flushes its write cache, which you
cannot know from the host. If you want to reduce this, explicitly flush the
device write cache more often (execute blkdev_issue_flush() or similar).

> - Data becomes immediately available only after unmount/sync/reboot

??

You can read data that was written even without a sync/flush.

> Proposed Enhancement:
> We're looking for ways to:
> 1. Detect when data is actually flushed to disk

If you have the write cache enabled on the device, there is no device interface
that notifies this. This simply does not exist. If you want to guarantee data
persistence to non-volatile media on the device, issue a synchronize cache
command (which blkdev_issue_flush() does), or sync your file system if you are
using one. Or as mentioned already, disable the device write cache.

> 2. Track the relationship between bio requests and cache flushes

That is up to you to do that. File systems do so for sync()/fsync(). Note that
data persistence guarantees are always for write requests that have already
completed.

> 3. Potentially add tracepoints around such operations

As Christoph said, tracepoints are not a stable ABI. So relying on tracepoints
for tracking data persistence is really not a good idea.


-- 
Damien Le Moal
Western Digital Research

