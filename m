Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3048AD216B7
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bvv1APNe064tYyi6n0dE5n0nQNkAAEm4fvFFi4BNWso=; b=0/y+DAtPGmDOdDPR9VYIaMgAb2
	K1x7AbFRAs4p+Kg2pQB1Bd1DPDsd3DAhmtnD4vPxvumkEo1enLapGew/8QcLV+9w6CqJUngWuHqDd
	+X8qllLZMt67xwijUNsRtL1mVmuPTSk4gVJQIqHu7OHleqnuPb5D6Mgdz/ra78NVjrNk1ri296azG
	f6RLan2UCmEckP38dF0bk3LcgP6dEdMgti7KbOmkGZ9t2ODF2CkGF3Rc5C2yrT8eikLgPoN//xqRB
	iMFXipBf5yJ0GCaqr82s1/zJ6Fwsa/FLN8ZrPCyculRIJCqBURIFeEi2Xb6rkYS9s/mdhWeHg9hk0
	yPeKf5Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0id4-00000008WuZ-24Wt;
	Tue, 15 Oct 2024 14:34:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ibz-00000008Wj3-0rqo
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 14:33:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C0F7B5C5BA1;
	Tue, 15 Oct 2024 14:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3BEC4CEC6;
	Tue, 15 Oct 2024 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002801;
	bh=2DW2EiRLsxDugl1EofZUq16oOJb9O6b+hc80UuokMbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKT5U4uLfZzMMqRzJ/FB7eknScgdIrEmm2W5M44L/16F6v/LDtE9+bbwbB0i793FI
	 4F7SgyMy0/GlIFUS1XN+N20joo4yJ1zYOw3H5eeVclMAOIibtYhDYAYrldh18UUIgX
	 SQUzhkMnhelqaO5T/GC7i0ReVj818gzIpdG9Ai3JowrV2RZ0XJ2hmOWYmTAccHjl5p
	 U5oPXpnrHcfPp7dTp+vG7kaz8EtjtceSXaa9U0OHOP729p0Z31DauOZlB38rZsXXNQ
	 VJFUAxhubcXUIxuK1TLLlcY3bCnEdViJz7iD+X11SGT0pB0HqAOPl7++0B7wNVsxFQ
	 18nvKy3nSaRPg==
Date: Tue, 15 Oct 2024 08:33:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <Zw59LxZ3cngO17_f@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
 <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
 <Zwa-MBS6wn_dGxge@kbusch-mbp>
 <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_073323_309127_F3D6C5A7 
X-CRM114-Status: GOOD (  16.64  )
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

On Thu, Oct 10, 2024 at 10:57:23AM +0200, Hannes Reinecke wrote:
> On 10/9/24 19:32, Keith Busch wrote:
> > @@ -974,14 +991,14 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
> >   		return;
> >   	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> >   		nvme_cdev_del(&head->cdev, &head->cdev_device);
> > +		/*
> > +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> > +		 * to allow multipath to fail all I/O.
> > +		 */
> > +		synchronize_srcu(&head->srcu);
> > +		kblockd_schedule_work(&head->requeue_work);
> >   		del_gendisk(head->disk);
> >   	}
> 
> I guess we need to split 'test_and_clear_bit()' into a 'test_bit()' when
> testing for the condition and a 'clear_bit()' after del_gendisk().
> 
> Otherwise we're having a race condition with nvme_mpath_set_live:
> 
>         if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>                 rc = device_add_disk(&head->subsys->dev, head->disk,
>                                      nvme_ns_attr_groups);
> 
> which could sneak in from another controller just after we cleared the
> NVME_NSHEAD_DISK_LIVE flag, causing device_add_disk() to fail as the
> same name is already registered.
> Or nvme_cdev_del() to display nice kernel warnings as the cdev was
> not registered.

Is that actually happening for you? I don't think it's supposed to
happen because mpath_shutdwon_disk only happens if the head is detached
from the subsystem, so no other thread should be able to possibly
attempt to access that head's disk for a different controller path. That
new controller should have to allocate an entirely new head.

