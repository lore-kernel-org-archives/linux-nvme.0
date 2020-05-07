Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC9C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 17:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F6920735
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VG8T84TG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1G0Xa2fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F6920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WSyH/+/vP+SPEbaTY6lYrKJN0C7Y7y4noZlmbKg1AsM=; b=VG8T84TGwU0NwA
	fIZnS4D38jFTURPA+GLUkHDw9f99T0tb1L0uAJq1RZnxfwYqi3MVpSALerCv6rX4V698otTigan5w
	bpwg2qXcPRapXdLI7gcx4lEK9qusn3BfDOI3rBkOyk6R73JOTklcXntJP8wBu2J4tC29sEVA9u9Le
	3eOJ6z9hCu/B+Iu6GiClacZjGOo7r8FQk387wYVpgkMSlMCCImKcauIfAHv5MpIrGvxnQq9ywv/ym
	HHAhjS0RI8BiWzNnxVsftl2O+B/orD6BeFbkxxCIXZ6x9RK3/ReKBCoWMK/XA75FsL35a05ISYhOR
	uUEnX/lBOd4eIUubIm5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWkR5-0000NU-2m; Thu, 07 May 2020 17:35:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWkR2-0000K4-Ff
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 17:35:49 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89ABC20735;
 Thu,  7 May 2020 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588872948;
 bh=rA0N4Z9UPwe3wnnMJ9FEvHFUflFumcOxL7XFOLgIG7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1G0Xa2fYMarHIvSiv6NFwA33NBH9MJ9E9arplduTrrd1nhhT4EinCm8u7MOoADnNM
 VdWCle2BhvR/E9haZe/HVnsyxMyGe0m73GDYqJ9N3q3POYdeKof+dhrB7S6WlW6YYa
 M5vIY0CSukdcRMRWVU3P4F4D/JLY33XZ+G1kdJKY=
Date: Thu, 7 May 2020 10:35:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200507173545.GC2621480@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
 <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
 <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
 <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <9e04eebc-a55b-ac7e-3cb3-9c65f084ee6c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e04eebc-a55b-ac7e-3cb3-9c65f084ee6c@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_103548_571900_98FD7917 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: sagi@grimberg.me, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Will Deacon <will@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 07, 2020 at 05:26:58PM +0100, Robin Murphy wrote:
> On 2020-05-07 4:35 pm, Keith Busch wrote:
> > On Thu, May 07, 2020 at 04:11:23PM +0100, John Garry wrote:
> > 
> > > [  885.344575] WARNING: CPU: 41 PID: 4565 at block/blk-mq.c:665  blk_mq_start_request+0xc4/0xcc
> > 
> > This warning appears to support my suspicion: the completion side is
> > observing a new phase with a stale command id, and that command id was
> > reallocated as a new request that we're still constructing at the time
> > the double-completion occured.
> > 
> > Host software is supposed to be guaranteed the entire CQE is written
> > once we see an updated phase, per spec: "If a Completion Queue
> > Entry is constructed via multiple writes, the Phase Tag bit shall be
> > updated in the last write of that Completion Queue Entry."
> 
> Hmm, that makes me wonder if there might be some interaction with the Arm
> memory model here - if there are strict ordering requirements for things in
> memory being observed, could we be missing appropriate barriers between
> reads/writes of the various fields?

Yeah, that might be something to consider. If that's the case, then it
should be reproducible with a different vendor's nvme controller.

If the behavior is unique to this particular nvme model, then it would
sound like the controller is creating a CQE in multiple memory writes
either high-to-low, or with Relaxed Ordering enabled in the TLPs.

But if some other interaction with the arm memory model is suspect, I'm
not sure how to confirm or debug.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
