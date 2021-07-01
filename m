Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6EC11F69
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 09:14:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14DE613BE
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14DE613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=58tjbmvV0BD9NddBTdVuB2JSdnitysF7gn4H+1cjLVo=; b=rKSIhUZlHpvms0
	O08nzgDJgkA2yJv1DB6yZpcR9YNWXY6edV3tFdDRP6i2ZJJb4SfjH+QBtc35pFJEdRr/FOfLxZ6LO
	QUGD4jnh2VKMwOnXS7nf24+zzjqFcSGXf8G9DPTKqGl17eppagDBZGq0a/gchdBsP2fGUztEl7lJI
	rAEWhVEn7+qIjdqOHM0yJ9Ieq/9qRnR65NSn8uoS/gXXsGhRLbUBCLcXDvzXUhmBvYAyTQ4aqesWZ
	FHAYjAflbcQvvGJfmsPGTQgDlGQJDWStUEwfIlFJB/YgAifvhdyd07RTZaB05l+kbLDVWQdPoned1
	0eULDMuafbVZp3KdkpiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lysmD-00GgTG-UF; Thu, 01 Jul 2021 09:14:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lysly-00GgRp-Ia
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 09:14:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625130851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWsQfkJsHozHt689Ycc7QAhEWD6ZJjZVr7BQ4llvQfI=;
 b=LTQdWrTfCWzVY1vta/S3+L+BXXoaOb40HawuDLW95LveExfjkdLopf+MVd91toRw9Y+RtB
 E6lmHrZd/5119dOQocuC05iXOs3jxxka7JrEV4qwb7DhCxh5gEz9L3EjIIvuzqaInWN9kZ
 04F8X5Ge59H6XuYittmKa0ae1PMX3rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-vol2z-XON_SF3zKUgPjlww-1; Thu, 01 Jul 2021 05:14:08 -0400
X-MC-Unique: vol2z-XON_SF3zKUgPjlww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3255100C66B;
 Thu,  1 Jul 2021 09:14:05 +0000 (UTC)
Received: from T590 (ovpn-13-92.pek2.redhat.com [10.72.13.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9661160C17;
 Thu,  1 Jul 2021 09:13:53 +0000 (UTC)
Date: Thu, 1 Jul 2021 17:13:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YN2HTZaygkVemw4y@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
 <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
 <YN0FXrcwXfAwGU6w@T590>
 <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_021414_958681_100D8CA9 
X-CRM114-Status: GOOD (  38.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 01, 2021 at 10:00:27AM +0200, Hannes Reinecke wrote:
> On 7/1/21 1:59 AM, Ming Lei wrote:
> > On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
> > > On 6/30/21 8:59 PM, Sagi Grimberg wrote:
> > > > 
> > > > > > > > Shouldn't we rather modify the tagset to only refer to
> > > > > > > > the current online
> > > > > > > > CPUs _only_, thereby never submit a connect request for hctx with only
> > > > > > > > offline CPUs?
> > > > > > > 
> > > > > > > Then you may setup very less io queues, and performance may suffer even
> > > > > > > though lots of CPUs become online later.
> > > > > > > ;
> > > > > > Only if we stay with the reduced number of I/O queues. Which is
> > > > > > not what I'm
> > > > > > proposing; I'd rather prefer to connect and disconnect queues
> > > > > > from the cpu
> > > > > > hotplug handler. For starters we could even trigger a reset once
> > > > > > the first
> > > > > > cpu within a hctx is onlined.
> > > > > 
> > > > > Yeah, that need one big/complicated patchset, but not see any advantages
> > > > > over this simple approach.
> > > > 
> > > > I tend to agree with Ming here.
> > > 
> > > Actually, Daniel and me came to a slightly different idea: use cpu hotplug
> > > notifier.
> > > Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
> > > no I/O is pending during cpu hotplug.
> > 
> > Why should we ensure that for non-managed irq?
> > 
> 
> While not strictly necessary, it does align the hctx layout with the current
> CPU topology.
> As such we won't have any 'stale' CPUs or queues in the hctx layout, and
> with that avoid any issues we'll be having due to inactive CPUs in the
> cpumask.

We know the exact theory for non-managed interrupt, can you share us
any issue you want to avoid?

> 
> > > If we now add a nvme cpu hotplug notifier which essentially kicks off a
> > > reset once all cpu in a hctx are offline the reset logic will rearrange the
> > > queues to match the current cpu layout.
> > > And when the cpus are getting onlined we'll do another reset.
> > > 
> > > Daniel is currently preparing a patch; let's see how it goes.
> > 
> > What is the advantage of that big change over this simple way?
> > 
> 
> With the simple way we might (and, as the results show, do) run the
> nvme_ctrl_reset() in parallel to CPU hotplug.
> This leads to quite some complexity, and as we've seen is triggering quite
> some race conditions.

CPU hotplug isn't related with nvme reset at all, which is just for
recovering nvme controller to make it working again. How can cpu offline
affect nvme controller?

For NVMe PCI, blk-mq have drained any inflight requests before the hctx
is becoming inactive.

For other NVMe controller which doesn't use managed irq, the inflight
requests can still be completed via the original interrupt, or polling
task, both can been migrated to new online cpu.

I don't know what exact race conditions you are talking about. Please
explain it in details, otherwise it just wastes our time.

> 
> Hence I do think we need to synchronize nvme_ctrl_reset() with CPU hotplug,
> to ensure that the reset handler is completed before the cpu is completely
> torn down.

No, you didn't provide any proof about the necessity of adding the sync. 



Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
