Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5564C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 17:55:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764C723A7D
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 17:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764C723A7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JNa3LvMcl+de2DCvojgxuEtLHqJfE8BZERQq0NSklBU=; b=tARRUpYwbdHZTZR0AAEDg5kyE
	QBKITtASQZtHb8sHPgJqK7wOxI002jmhenEsP8ymfGRRN3ZNf8kpV194rp5njL9q1KKbXn2pNGPIZ
	O2fFjN7GSOReuNdxXMR0zApV0KGKpn2SWLz768GZwRmRriris8hFvM9PnAmWi9Vzf6cyVr3Lky17/
	NTrusC4CrcVNQvX/7nvgmHF4OPeXqY/qO/D5lyC6RNbKqouHAalVOhqXQsXX9apNpmQhkwGkHqTa9
	XJzrkKJxW0HzGGNJdZh3a21ZxP282kI/hjufNvh0rfUxYe/QU03uNbfSCy9Vvqa7WRU6HS/RaiHE6
	TjjLBz6Ag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l30eO-0006wb-Ho; Fri, 22 Jan 2021 17:55:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l30eM-0006w7-4i
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 17:55:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0631FAC6E;
 Fri, 22 Jan 2021 17:55:09 +0000 (UTC)
Date: Fri, 22 Jan 2021 18:55:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: Early exit if no path is available
Message-ID: <20210122175508.eiimz2fbx3csrejk@beryllium.lan>
References: <20210122174125.145734-1-dwagner@suse.de>
 <20210122175029.GA21127@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210122175029.GA21127@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_125510_319669_D9456223 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 22, 2021 at 06:50:29PM +0100, Christoph Hellwig wrote:
> How can that happen once we're in the loop?

As far I can tell, it's the first nvme_next_ns() call which returns the
NULL pointer and this will pass the test 'ns != old'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
