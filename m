Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BCC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 13:04:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96AA61261
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 13:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96AA61261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3lOtwzy46rVM0G/tFQoGfQdJxKzNA+sBMgjROFLmNZo=; b=Lkq9ZWHSbw7Jjcon85R/hM92c
	I2IXGqRl80J26sAt2qZ8mRdkWoyTzoX5wRbjRTYealZBSK9llS/sbtubVKr9NUsZaCIyHGCy+KrEc
	M+BEJnyN7My5upBDYTY+BJRpfNQb5sCf0ZUD3vItjO0E1EKMcnZYGWh2kM9Ze06Ku63rYnnotH9CH
	xz/NobI48vdxlSKWbIo3Mh0+s57jfWGuk9IFVN+Yrv9ZJfTBIaHud8+4BifPINAjK31xsDvPtBUl6
	s/5jz0V+zNVN+axzzwE0Ud6z6GjiA7RUh28JUtoDspdZguJTd+44IyNn9lG27QkX9szAcYLX7IuSm
	7QduWN9jw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVwEc-006mWf-LU; Mon, 12 Apr 2021 13:04:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVwEa-006mWO-Lj
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 13:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7U26dWdmUbGOFoEw3WRLyC/HQG/gNKfhazVkTBVrkrg=; b=y5QSW5rOgYvt3JDNOgDVdxfNXd
 nUamBT55REHpY1whibVLtIbeVbm63zg2N4Q7ZBObD9c+5TjsSc2auPdcEOfvHpW8Bn8AOInO+n0zc
 wbk96F8RhSfwXmTtOosl8lsoxpXpxRzCbioB+q0/f2VuAt6B3rKmf4z48wh3y/mRnABVWmH6xiWHn
 oGopCu2+o6SEcdovM/dK1ucnJggPAnWGpoimhjZvBxgZxtn/vs3zAdWPN5F3oG7LpItoYmivJZmjK
 fHu322gMMxONs3lT+EHWzXZ1Akxx53ax2lxZNguja+LPVtW/22DsP0JuvD63mK+5RgATArFU4Fj0V
 7AoNe7xg==;
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVwEX-006FQJ-VT
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 13:04:07 +0000
Received: by mail-qk1-x72e.google.com with SMTP id b139so7770296qkc.10
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7U26dWdmUbGOFoEw3WRLyC/HQG/gNKfhazVkTBVrkrg=;
 b=ck2b8FIh9doK+J+1zK8r2cGgpdvgLvmRcdTIla3+2T2K6FiOyQW8ljFFj5LhjjZgAb
 qW1Xot4IgLY08JHjSgcGoEgk2q5z0SVjK5DUoixhjW9WeLkuGgKNd5BUL46cUapCcgh1
 zlVnEBwuHOoaxppNcZgKw2FvjYUFFgMiKQ7/XkgNBusP+uMB0wIJ03OO4m/C0KCex2zE
 EwHDRjW3fhJ1vA9WbgBsIfUVQpqwqlriJEvA1Y0hU16x+eFMESuQJr6qPRC2q4BNG/jL
 ARclik07dgjcoqTQ+JS2IqjCm923+PofupkNQxC9/DVl6DnTOtkPCUaSPSmv5I47c9Go
 8ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7U26dWdmUbGOFoEw3WRLyC/HQG/gNKfhazVkTBVrkrg=;
 b=fxtweVJtOKr37K9a0SJmETPNAOmQVDIpMeJGDyU4WJAzus9K86IKuugYyJzDBIVamZ
 GR1V/0L+YSWCzltIk1ozlXoke7YSrNty3b100X91GQxkcuKKKS5DTeqlb9joD/D8+mEZ
 pQcuFzPWMUYKxDg2hx0N8is1+84j03nPgQL8NQYOwTFKWn3nLcP0yfGq1RIoWINNGoHA
 9OXK2FaUKoMP7zn1rCcEYZOiBimDevssbSZjn6BDfLdjn0v87rWCTpp2+3Ee+cXkLA+F
 E409FZYjbjN4SJBFkMKxIIc89pev4NLY88vU8q9ruxDryDeRrwgLL49RltXY/kAs4PUn
 q0nQ==
X-Gm-Message-State: AOAM533mzdw4DvQZIIf+Y+r9kAvKOZBQgHooZf6BUX4LgvQh90ZRxHn6
 EZ8Msf3AGR12sskJtwtbyQORNA==
X-Google-Smtp-Source: ABdhPJwnzUXg4Q5gETmh434aD1mgRTIrB1WpbMiSs+2qQLiq+om+Vm8iL6Soaslfx1hPhcLEu9UKwQ==
X-Received: by 2002:a37:a1d3:: with SMTP id k202mr19967256qke.97.1618232644399; 
 Mon, 12 Apr 2021 06:04:04 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id b198sm7828845qkg.10.2021.04.12.06.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 06:04:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lVwEU-004azS-Sp; Mon, 12 Apr 2021 10:04:02 -0300
Date: Mon, 12 Apr 2021 10:04:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Steve Wise <swise@opengridcomputing.com>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210412130402.GF227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412124909.olui5hfhceakt4u4@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_060406_043404_91B5E98C 
X-CRM114-Status: GOOD (  16.14  )
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

On Mon, Apr 12, 2021 at 02:49:09PM +0200, Daniel Wagner wrote:

> I've grepped through the code and didn't find anything which supports
> the guarantee claim. Neither mm nor schedule seems to care about this
> flag nor workqueue.c (except the early init bits). Or I must miss
> something.

It is pretty complicated, but the WQ_MEM_RECLAIM preallocates a thread:

static int init_rescuer(struct workqueue_struct *wq)
{
	if (!(wq->flags & WQ_MEM_RECLAIM))
		return 0;

	rescuer = alloc_worker(NUMA_NO_NODE);

This comment explains it:

 * Workqueue rescuer thread function.  There's one rescuer for each
 * workqueue which has WQ_MEM_RECLAIM set.
 *
 * Regular work processing on a pool may block trying to create a new
 * worker which uses GFP_KERNEL allocation which has slight chance of
 * developing into deadlock if some works currently on the same queue
 * need to be processed to satisfy the GFP_KERNEL allocation.  This is
 * the problem rescuer solves.
 *
 * When such condition is possible, the pool summons rescuers of all
 * workqueues which have works queued on the pool and let them process
 * those works so that forward progress can be guaranteed.
 *
 * This should happen rarely.

Basically the allocation of importance in the workqueue is assigning a
worker, so pre-allocating a worker ensures the work can continue to
progress without becoming dependent on allocations.

This is why work under the WQ_MEM_RECLAIM cannot recurse back into the
allocator as it would get a rescurer thread stuck at a point when all
other threads are already stuck.

To remove WQ_MEM_RECLAIM you have to make assertions about the calling
contexts and blocking contexts of the workqueue, not what the work
itself is doing.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
