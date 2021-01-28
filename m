Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D39C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 07:58:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0313064DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 07:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313064DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VpZSufcz1w18pcVW9TMy0945OxYu6KSEVUJ6pWczYvQ=; b=zhbgEn39J7J8skRRcy45L3sZX
	BSn0deJV8d+r7U2pUq1ormU68WKjoma0ykb5Wm6+gc5CGrCc5cEPu/+05PMwxX8xfuZkVFHFMO7kh
	MnhbTV5QWyMT+SmAHrd7tHdgHZvct4p5md0LUhHyyA5ddJASRsIwhZtS9m48Z+W4z3Z/UluQSe6De
	Eyf+8uo+QXBngyKVanls6Eharwi9WGe1GFZNmvDYUTpxhZ6pdHOEsz3+iflN/3+y5m7AMcfkeOWS/
	wIFq2HTv6DDaGLcB1e15n6X/lcZSrDeM+jukExnCQrwUjB97ZJndVHPuXd0Qq5C6+SeLTxHRowafm
	DHMmJXeVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l52CR-0005Wl-0i; Thu, 28 Jan 2021 07:58:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l52CM-0005VK-W4
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 07:58:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ED9D5AC45;
 Thu, 28 Jan 2021 07:58:37 +0000 (UTC)
Date: Thu, 28 Jan 2021 08:58:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
Message-ID: <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_025839_178850_11DE494C 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 09:31:30AM +0800, Chao Leng wrote:
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> >   	}
> >   	for (ns = nvme_next_ns(head, old);
> > -	     ns != old;
> > +	     ns && ns != old;
> nvme_round_robin_path just be called when !"old".
> nvme_next_ns should not return NULL when !"old".
> It seems unnecessary to add checking "ns".

The problem is when we enter nvme_round_robin_path() and there is no
path available. In this case the initialization ns = nvme_next_ns(head,
old) could return a NULL pointer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
