Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ECFC388F9
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 03:04:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D755206E3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 03:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wej1b+Hh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF5GUzSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D755206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wDq23toeBBbXc+gTPibxdSbR/6jdfY8jUd3kUAKg1mc=; b=wej1b+Hh7uW7px0RvLRZl3xYz
	0VZekNRagXPos62tznRYU1ndVXdsOTef215cdwr90AzJwD+Pde4iAnfigr/33TUCJkZpoQK3k79R4
	euF3gJvSxhO9ovSuxCsQ/RiQeTZuygYvw9Vp+mUZ6EU/KXGQy76FLYrvu+FyN6gPsPwTpRDBPoWG1
	dNlzYozkSeAe/lQp+Gp+UIhzfOtt/NkTis3R0mcg60TKe8+VvJCulKBxtuwAgt14S7O17ogze9iD7
	ZtoRiosQs1F5m2o9i1rYVMQEBk4KY6A1+4z+nPZypKgOdAU2T9SG2X2tUNo8wyOM8R1BI3IsRIbJ8
	zV1xlMsqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbxTr-0007zB-4A; Mon, 09 Nov 2020 03:04:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbxTn-0007yn-Sh
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 03:04:28 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 263A3206E3;
 Mon,  9 Nov 2020 03:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604891066;
 bh=htggS9MFLADgzMkKUlNYGoFQwnZj6qbQer41SATSvz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NF5GUzSoCQH4OLTu0z60aQW2SpKWOMWLHkZHdDENyuFQawuBucxcwXoETcnoLGk76
 xL9M9i/bNdBHXGk8s+SUJyuvfL87n6upnVyDm2NZQVpJYMQRunRrkp+KVZlJnmDgy2
 LVsqAtIYwreN4DfD4PMQbIRo5TrLph8qczxXxR3E=
Date: Sun, 8 Nov 2020 19:04:24 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201109030424.GC2219646@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201108040903.8185-1-bvanassche@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_220428_139373_A1EE6407 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Greg KH <gregkh@linuxfoundation.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> The following two issues have been introduced by commit 1811977568e0
> ("nvme/pci: Use async_schedule for initial reset work"):
> - The boot process waits until all NVMe controllers have been probed
>   instead of only waiting until the boot controller has been probed.
>   This slows down the boot process.

Prior to that commit, the boot process didn't wait for anything at all
and missed the boot controller entirely.

> - Some of the controller probing work happens asynchronously without
>   the device core being aware of this.

Why is that an "issue"?

> Hence this patch that makes all probing work happen from nvme_probe()
> and that tells the device core to probe multiple NVMe controllers
> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.

Afaics, that setting just may let driver core do an async_schedule() for
the asynchronous part, but that's what we're already doing. ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
