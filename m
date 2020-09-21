Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77EC43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:22:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B372076E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 02:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WQ/ZHR39";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLJgR84v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B372076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C6fVLbHcwyY2Bo0y2HZTSWHdp3lp8tv2ynviLWhFRyc=; b=WQ/ZHR39QGFScp1YwgJ3UJZJC
	epJ0gJKr9IgWaZV0qyoOfdzEcSFJJFM1CmpaUEpZlIQiUiv4iNJB2+ZLOXsOPDC7BdBuIDsF3zxSa
	evPrHuEGnSeXJ4i4I8OFFzecDz3l+10bHhCIv+Wwpa2gDV4fJLksrp1v0EtS3KdFRqPud7hfvzxVF
	+YMdGaSj39H/nwW5OzZgrUQSSlWPrFw7bcv44Th76kpCSU4hEHmgqT1C9atiZdp6z6+rEBWfjWy6S
	WxKAk6q+he6ne4sSodFJSe6I8itp/vZOD7Rg1cF8lnBSAczD66QocyDtZg9Se1KOWP7EOgdabLjRL
	atAun07nQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKBTd-0008Ke-6T; Mon, 21 Sep 2020 02:22:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKBTb-0008K6-5E
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 02:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600654964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XOfUQSn+cTTKAJrEJ/8pZZKAqjGimUPpNTQvXyXPpLU=;
 b=gLJgR84vWtNQHRRaW9bVD7VtTJ0DZPSMtvUnGcFHEaqoK+rNZ/OC5AWoXzQu4Q/LofmNyK
 KRjQubpBUoRMFQWFkr9+4IuzT1aKU1zSBGoK3Kx81ucCw9ONvrRUN1/FrlSQNVSXlYnDHN
 1TE0K+/RKvR4/oGmVdEpCJbHqOdoH20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-9jKCDnkoOeOt6QteD4uYOg-1; Sun, 20 Sep 2020 22:22:40 -0400
X-MC-Unique: 9jKCDnkoOeOt6QteD4uYOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858C51800D42;
 Mon, 21 Sep 2020 02:22:37 +0000 (UTC)
Received: from T590 (ovpn-13-76.pek2.redhat.com [10.72.13.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA5605D9D5;
 Mon, 21 Sep 2020 02:22:26 +0000 (UTC)
Date: Mon, 21 Sep 2020 10:22:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V6 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200921022222.GA1332419@T590>
References: <20200914020827.337615-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914020827.337615-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200920_222247_242264_7E796F04 
X-CRM114-Status: GOOD (  20.92  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Bart Van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 14, 2020 at 10:08:23AM +0800, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> V6:
> 	- base on for-5.10/block directly, instead of being against on patchset of
> 	'percpu_ref & block: reduce memory footprint of percpu_ref in fast path',
> 	because these patches don't depend on that patchset. 
> 
> V5:
> 	- warn once in case that driver unquiesces its queue being
> 	  quiesce and not done, only patch 2 is modified
> 
> V4:
> 	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
> 	avoiding duplicated quiesce action
> 	- pass blktests(block, nvme)
> 
> V3:
> 	- add tagset quiesce interface
> 	- apply tagset quiesce interface for NVMe
> 	- pass blktests(block, nvme)
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> 
> Ming Lei (3):
>   block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>   blk-mq: add tagset quiesce interface
> 
> Sagi Grimberg (1):
>   nvme: use blk_mq_[un]quiesce_tagset
> 
>  block/blk-core.c         |  13 +++
>  block/blk-mq-sysfs.c     |   2 -
>  block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
>  block/blk-sysfs.c        |   6 +-
>  block/blk.h              |   2 +
>  drivers/nvme/host/core.c |  19 ++--
>  include/linux/blk-mq.h   |  10 +--
>  include/linux/blkdev.h   |   4 +
>  8 files changed, 154 insertions(+), 84 deletions(-)
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> -- 
> 2.25.2
> 

Hello Jens,

Ping...


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
