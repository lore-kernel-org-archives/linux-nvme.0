Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970BAC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 07:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gW4QUErGvAesybuMXXu5So0XZ/1kEjh78pRTMQqyBus=; b=WvCY6U9NOMPbDikZUXFJSc7aHS
	Kkg9TP40orW0X1YOYratfOyPGUlEEAJam95xKra8/KCZGivxNnnI+MOKagEB3W101DkjeSEVczr28
	4UPTCW96GxiswYvOtGuD5GBG+KFX7YhYiz4fg3OIbs0L9vXYueR2woPxUALBNPJ+XIOehwXwPZiWB
	H3+4aZRy0GzzgnDoe8B9ESEjTRevUsE80caINOw9oT3wFcWV0gPQEwa2hqf6HyGsVU1huA1Uhmp5q
	4SbkbiRtQBzjCVX135WYuy/98gx4yAtU3Ox2XI900fRSCCTod31m8jCmIPaoCsCzRTpLebUiOE4af
	FE2/B/Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prw2i-005fqz-0C;
	Thu, 27 Apr 2023 07:27:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prw2e-005fod-25
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 07:27:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6D9C1FDFA;
	Thu, 27 Apr 2023 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682580465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gW4QUErGvAesybuMXXu5So0XZ/1kEjh78pRTMQqyBus=;
	b=TyBX65E7nepGXfxpezeZyRNtvZBrhS4QNEzwBVcz+gLfCVTyHB6v6MJ0QO20elgrRkdRFv
	NBQE8wjkHjk9zJMk6y6EqQMPtXzcbWR5vxKM/TeXxRatTl/gCWeWaz8qp2gn8hUvGG7IDd
	9eag1LST/TKpPlZyxLGdqqflP+XJs20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682580465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gW4QUErGvAesybuMXXu5So0XZ/1kEjh78pRTMQqyBus=;
	b=5jv60hrPOjKNcztMjbJJmpUKCgEidfdlY2Y1Sy51opTEf9G9umsGR0uDZ/ndMBLawzjbHl
	vd3+gDsXXfvOvXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C88C513910;
	Thu, 27 Apr 2023 07:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 66neMPEjSmTFKAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 27 Apr 2023 07:27:45 +0000
Date: Thu, 27 Apr 2023 09:27:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Message-ID: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_002748_861782_9B78B4AB 
X-CRM114-Status: GOOD (  17.40  )
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

Hi,

I'd like to use the opportunity to align and discuss the nvme state machine
refactoring work in person. I don't think we need a lot of time for this topic,
so if we could just have the topic during a BOF it would be great.

Sagi proposed following high level API:

  ops.setup_transport(ctrl)
  ops.alloc_admin_queue(ctrl)
  ops.start_admin_queue(ctrl)
  ops.stop_admin_queue(ctrl)
  ops.free_admin_queue(ctrl)
  ops.alloc_io_queues(ctrl)
  ops.start_io_queues(ctrl)
  ops.stop_io_queues(ctrl)
  ops.free_io_queues(ctrl)

Getting the queue functions done is fairly straight forward and I didn't run
into any problems in my experiments.

The more tricky part is the slight different behavior how the transports handle
how many queues are allocated for IO and their placement. To keep it exactly as
it is right now, I had to add a couple of additional callbacks aside to
setup_transport():

 - nr_io_queues(): limit the number of queues
 - set_io_queues(): map the queues to cpu

The first one was mainly necessary for rdma but IIRC Keith has done some work
there which could make the callback unnecessary. My question is should we try
to unify this part as well?

Also I haven't really checked what pci does here.

The second callback should probably be replaced with something which is also
executed during runtime, e.g. for CPU hotplug events. I don't think it is
strictly necessary. At least it looks a bit suspicious that we only do the queue
cpu mapping when (re)connecting. But maybe I am just missing something.

There is also the question how to handle the flags set by the core and the one
set the the transports. There are generic ones like NVME_TCP_Q_LIVE. These can
be translated into generic ones, so fairly simple. Though here is one transport
specific one in rdma: NVME_RDMA_Q_TR_READY. What to do here?

In short, I don't think there are real blockers. The main question for me is, do
we want to unify all transport so far that they act exactly the same?

Required Attendees:
  - Chaitanya Kulkarni
  - Christoph Hellwig
  - Hannes Reinecke
  - James Smart
  - Keith Busch
  - Sagi Grimberg

Anyway, I think it is necessary to have tests in blktests up front. Hence my
current effort with enabling fc transport in blktests.

Thanks,
Daniel

https://lore.kernel.org/linux-nvme/20230301082737.10021-1-dwagner@suse.de/
https://lore.kernel.org/linux-nvme/20230306093244.20775-1-dwagner@suse.de/

