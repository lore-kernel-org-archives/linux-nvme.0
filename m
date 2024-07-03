Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A5FC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCbQ3e/fctAMsFyFSsmL2a2i8WF2NmpOHJaDLgzQpK0=; b=juGFgeRO3OOMGZwKAtGA0Q7cHc
	jeXHc0PEivOhPWaBo1EtAH8PFdBn2KHBmQqCZD+sfKIwkRrtihX/7MPteoKkMbi/opliAutr3seN3
	M+8VeuTlykmtCCFwYYIXGxlO1PR9Kg1FdkzO4S5mcV90IDPfVkkqeGsFY+pElPo/RJdu3HfeZr5RJ
	36skaJ6op2MO+A6c6J7DuPDd/lPlk4h+orcam9MgEhy6JixOp5KfgcjEIixIC/lmEvaZZW13uc/eo
	gJn6by0HTaYewgVfCn+AZLuVd1ClzgTgSLrlxmI2bYUBzeU//IJoQRZXhjH04Uw2i3q9g0JQR6nHI
	HD6ELXNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP3Rq-0000000Ax0j-0maw;
	Wed, 03 Jul 2024 17:07:14 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP3Rm-0000000AwzR-3xQb
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 17:07:12 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso3518678a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026429; x=1720631229; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCbQ3e/fctAMsFyFSsmL2a2i8WF2NmpOHJaDLgzQpK0=;
        b=kyn3Dxo7Ao3sEt74ljtB01xSOIqfrceJYcsk6yz6i+ddqszyMAapkI8n2hXNg29Q5f
         KPjDvPfylSsannfHroibkF0CvNKmgJ+XryOw1h9cZnV5Q2OLPVi9Gt15P8UTlReVwTtR
         dTqvm1MNVDq9QROKPsSi1kfpuckOOMPQ0EJ6OGxIO2SkssSlqfesA+YWhk0xo6B0XnNe
         XDCjH95/6UbGRg+gC8nBp4wG6MOPfXMYyB85MI26pvJKz+LRuwFxHrwspQCsMm+Enxop
         AB16u9Y4nNCReocv45Hq9kjikO+KHciVONcCL1MIjuMt/xKnDx5dwSIll3XqDlk0gfbv
         M7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026429; x=1720631229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCbQ3e/fctAMsFyFSsmL2a2i8WF2NmpOHJaDLgzQpK0=;
        b=IZfrADDkfWGw8Rc5/f4b6aIgGeWH27uI0pvrJ2MIy5CRXWaUbsp47gRX1ZRrX9yRdq
         pApNrURg3C5M6Ga76I0g7WBx6Q+an3XYSMepCA1Vr1WKmx+gz/BtPnG+QtgZXpIe0KJ8
         IKfZk8JfW07Xaueebluyf6EYkBOeGKB0vu810XwkSBUetGs/Ci+UHF+UlARWxHW8B6jC
         7OxmhGmw4cl9MTzJxPC3ki4WW+6bQs6mgVBllvvChoe8vI4CUPMrXjZPt9W+CodhsIOb
         BX0hvu64LfnQWbsDstvyMSaHHk57yA1OZmljK67psnrkW1l1Ym42rXpMhFg0yFaXJ3MC
         hLZA==
X-Forwarded-Encrypted: i=1; AJvYcCWPeHJXj56q/6Ns7FKoe6WKz1RqC5YRzxF6l39obpqEunVuKoUp5Et9ng69y3kkyFGgFpaBeFoyCR6tRT4tPTEdLEpnDWEZnElfABkqsKw=
X-Gm-Message-State: AOJu0YzeW9yk1DEhlRmc8RstFeKbYh9iILkvtr9R9NLFnI0WxICHtX06
	Keyr1bmCigCTOzw/inaq3GYMFx6t99LiTy7ze6ugxy/DnvqAiYKE
X-Google-Smtp-Source: AGHT+IHD/uCEq3nsAsg7M9ZkpbNNafKX++rH2FgH/jfaEFVxkzDQx9UkuAWZfst9fHUQXzcKHWCk5Q==
X-Received: by 2002:a17:90a:784a:b0:2c7:c306:8a69 with SMTP id 98e67ed59e1d1-2c93d6c68cfmr8345947a91.9.1720026428764;
        Wed, 03 Jul 2024 10:07:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c98adcfa1esm536158a91.23.2024.07.03.10.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:07:08 -0700 (PDT)
Date: Wed, 3 Jul 2024 07:07:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Message-ID: <ZoWFOnvgWEiKipW6@slm.duckdns.org>
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_100711_006592_AA1C8BFA 
X-CRM114-Status: GOOD (  26.63  )
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

Hello,

On Wed, Jul 03, 2024 at 06:16:32PM +0300, Sagi Grimberg wrote:
...
> > > OK, wonder what is the cost here. Is it in ALL conditions better
> > > than a single workqueue?
> > 
> > Well, clearly not on memory-limited systems; a workqueue per controller
> > takes up more memory that a single one. And it's questionable whether
> > such a system isn't underprovisioned for nvme anyway.

Each workqueue does take up some memory but it's not enormous (I think it's
512 + 512 * nr_cpus + some extra + rescuer if MEM_RECLAIM). Each workqueue
is just a frontend to shared backend worker pools, so splitting a workqueue
into multiple that do about the same work usually won't create more workers.

> > We will see a higher scheduler interaction as the scheduler needs to
> > switch between workqueues, but that was kinda the idea. And I doubt one

This isn't necessarily true. The backend worker pools don't care whether you
have one or multiple workqueues. For per-cpu workqueues, the concurrency
management applies across different workqueues. For unbound workqueues,
because concurrency limit is per workqueue, if there are enough concurrent
work items being queued, the concurrent number of running kworkers may go up
but that's just because the total concurrency went up. Whether you have one
or many workqueues, as long as workqueues share the properties, they map to
the same backend worker pools and execute exactly the same way.

> > can measure it; the overhead between switching workqueues should be
> > pretty much identical to the overhead switching between workqueue items.

They are identical.

> > I could do some measurements, but really I don't think it'll yield any
> > surprising results.
> 
> I'm just not used to seeing drivers create non-global workqueues. I've seen
> some filesystems have workqueues per-super, but
> it's not a common pattern around the kernel.
> 
> Tejun,
> Is this a pattern that we should pursue? Do multiple symmetric workqueues
> really work better (faster, with less overhead) than
> a single global workqueues?

Yeah, there's nothing wrong with creating multiple if for the right reasons.
Here are some reasons I can think of:

- Not wanting to share concurrency limit so that one one device can't
  interfere with another. Not sharing rescuer may also have *some* benefits
  although I doubt it'd be all that noticeable.

- To get separate flush domains. e.g. If you want to be able to do
  flush_workqueue() on the work items that service one device without
  getting affected by work items from other devices.

- To get different per-device workqueue attribtes - e.g. maybe you wanna
  confine workers serving a specific device to a subset of CPUs or give them
  higher priority.

Note that separating workqueues does not necessarily change how things are
executed. e.g. You don't get your own kworkers.

Thanks.

-- 
tejun

