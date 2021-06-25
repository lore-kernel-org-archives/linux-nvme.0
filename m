Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE87C2B9F4
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 13:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D1061469
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D1061469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IxCKjva8+ZEm3N9sakEbfhpm6Yjimhp3B5BRWKSAsGI=; b=eQFz/bs6NJFx52
	+d9+8e5/WPN+mvSlXCgBQDgn10Gkul9w+hGiTvI9Nr+0YQ/kJe/XW434vTGzlKAQ4OrTJ7K79Xmi/
	uebY1lW5ZUHUSdUdjN6IKunQblqsLEQJTZt/h4LlzKdj9HYwdvl+U/rwmWcnSHflzuvx1YsTzUWb+
	yKLbg3vOu91are8Nkh2JvMxKy/6mfrKCzTYm28eD8T7xbcB7koUW4YjHrto7JXJzlkQPLjoFW/pRZ
	dDaqj6CtauHXnUktMohX9/lOnAa/RnO7X1l4TaYfQtYdrmeGh2a2MRhFmvcjhsTZUkKuuDyRWUu6+
	AdZxeFs28y2yxqyR6AFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwlRt-001Ztx-Aa; Fri, 25 Jun 2021 13:00:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwlRr-001Zt8-4b
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 13:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624626040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3OQ+6kMWXEqLkzrnVZadaNPJSKIMvnSIu0r7ijAo9w=;
 b=AdaaYg2E8MlOmtNBZjQH3xNxu2GxaacwA6FPN/SaYyLXZqwdXxUEGn+UN7CnmZYQQQmZU0
 JaP7ITnuzuf4SXFrHn5X3gPIPkkCFjmoijJGvYTnY70iJjii6ZkVO3QmTkpg2JFF5Cak8m
 eSOVybXreJGlKdgZB8etzP+5S0LG6dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-17j0dxvzNJCKsipDIIqaXw-1; Fri, 25 Jun 2021 09:00:38 -0400
X-MC-Unique: 17j0dxvzNJCKsipDIIqaXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D44A802C92;
 Fri, 25 Jun 2021 13:00:37 +0000 (UTC)
Received: from T590 (ovpn-12-153.pek2.redhat.com [10.72.12.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D09136F5;
 Fri, 25 Jun 2021 13:00:29 +0000 (UTC)
Date: Fri, 25 Jun 2021 21:00:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
Message-ID: <YNXTaUMAFCA84jfZ@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210625_060043_297418_D6DA359E 
X-CRM114-Status: GOOD (  24.38  )
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

On Fri, Jun 25, 2021 at 02:21:56PM +0200, Daniel Wagner wrote:
> On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> > this is a followup on the crash I reported in
> > 
> >   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> > 
> > By moving the hardware check up the crash was gone. Unfortuntatly, I
> > don't understand why this fixes the crash. The per-cpu access is
> > crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> > fixing this problem.
> > 
> > Even though I can't explain why it fixes it, I think it makes sense to
> > update the hardware queue mapping bevore we recreate the IO
> > queues. Thus I avoided in the commit message to say it fixes
> > something.
> 
> I just discussed this with Hannes and we figured out how the crash is
> fixed by moving the blk_mq_update_nr_hw_queues() before the
> nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().
> 
> First of all, blk_mq_update_nr_hw_queues() operates on the normal
> tag_set and not the admin_tag_set. That means when we move the
> blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
> update the mapping to only CPUs and hwctx which are available. When we
> then do the connect call nvmf_connect_io_queue() we will only allocate
> tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
> we skip the blk_mq_put_tag() call.

Your patch just reduces the race window, what if all cpus in
hctx->cpumask become offline when calling blk_mq_alloc_request_hctx()?


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
