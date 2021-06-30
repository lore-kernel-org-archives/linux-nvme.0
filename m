Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C71C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:43:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7D861CFC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7D861CFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hKpqEF+MxDKy2hmcMuF9eCycjPAp7GuOpyz+ObtqUJU=; b=RHIxvkpKU2yEkq
	PU+wW82VYz6mWzczSKgb1Jw/yGIgq6y6bEsh4kwxxWaT2eZmHS/vForvlICqtjHMIo6bD8NWMCemQ
	EQ0cd40tfQjQpAVTBRjibo/SXxjKxDvFJ3zWHvVv6kNjbcVkFJqUiziDcCzW/PprHWqZAwIqdsH6/
	UoEb3RE6xsOcW6b/boNN/gCbN7ELzo0617IV/Tvo1H23NO2hBMhUHa2FiO1lzFlQuOQ5Av02SCl7m
	NLWxQopSRcRpNWMFmC+caXVUS8bpMJ0sjnKEX4jM4A/mW/IJg4zHs3F3vi1+7x7Jv+Pox7vXchOAt
	AbnzN+0pM7CYxz6p4a1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyVoJ-00DJWP-5k; Wed, 30 Jun 2021 08:43:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyVoF-00DJOo-UP
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 08:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625042581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+K2zZjhe3r1i8JK801FyLP5ypzTQN49MZp3LuTInG34=;
 b=HB9lPm0aB/ER99tU+uYeZPatK5KZdGrPcDX+k9sm+gQEWoVBjZqZOUZzujCZqISx7qilgg
 O4b8eovZdf13gurFNkyQbAe40Q15RDtcVProg1ZqA8kYlFevBhLtBdx0aiInIJaboOlq9Y
 HJrpI5X7CwNui0F9Tkh7/Yg06sdD/Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-RjPb-VVCNJ-VPL9wbvj3xg-1; Wed, 30 Jun 2021 04:42:58 -0400
X-MC-Unique: RjPb-VVCNJ-VPL9wbvj3xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6866800C60;
 Wed, 30 Jun 2021 08:42:56 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6661E60843;
 Wed, 30 Jun 2021 08:42:47 +0000 (UTC)
Date: Wed, 30 Jun 2021 16:42:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YNwug8n7qGL5uXfo@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_014304_221080_C612E0EF 
X-CRM114-Status: GOOD (  29.64  )
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

On Wed, Jun 30, 2021 at 10:18:37AM +0200, Hannes Reinecke wrote:
> On 6/29/21 9:49 AM, Ming Lei wrote:
> > Hi,
> > 
> > blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
> > io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
> > However, all cpus in hctx->cpumask may be offline.
> > 
> > This usage model isn't well supported by blk-mq which supposes allocator is
> > always done on one online CPU in hctx->cpumask. This assumption is
> > related with managed irq, which also requires blk-mq to drain inflight
> > request in this hctx when the last cpu in hctx->cpumask is going to
> > offline.
> > 
> > However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
> > them to ask for request allocation when the specified hctx is inactive
> > (all cpus in hctx->cpumask are offline).
> > 
> > Fix blk_mq_alloc_request_hctx() by adding/passing flag of
> > BLK_MQ_F_NOT_USE_MANAGED_IRQ.
> > 
> > 
> > Ming Lei (2):
> >    blk-mq: not deactivate hctx if the device doesn't use managed irq
> >    nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop
> > 
> >   block/blk-mq.c             | 6 +++++-
> >   drivers/nvme/host/fc.c     | 3 ++-
> >   drivers/nvme/host/rdma.c   | 3 ++-
> >   drivers/nvme/host/tcp.c    | 3 ++-
> >   drivers/nvme/target/loop.c | 3 ++-
> >   include/linux/blk-mq.h     | 1 +
> >   6 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Daniel Wagner <dwagner@suse. thede>
> > Cc: Wen Xiong <wenxiong@us.ibm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > 
> > 
> I have my misgivings about this patchset.
> To my understanding, only CPUs present in the hctx cpumask are eligible to
> submit I/O to that hctx.

It is just true for managed irq, and should be CPUs online.

However, no such constraint for non managed irq, since irq may migrate to
other online CPUs if all CPUs in irq's current affinity become offline.

> Consequently if all cpus in that mask are offline, where is the point of
> even transmitting a 'connect' request?

nvmef requires to submit the connect request via one specified hctx
which index has to be same with the io queue's index.

Almost all nvmef drivers fail to setup controller in case of
connect io queue error.

Also CPU can become offline & online, especially it is done in
lots of sanity test.

So we should allow to allocate the connect request successful, and
submit it to drivers given it is allowed in this way for non-managed
irq.

> Shouldn't we rather modify the tagset to only refer to the current online
> CPUs _only_, thereby never submit a connect request for hctx with only
> offline CPUs?

Then you may setup very less io queues, and performance may suffer even
though lots of CPUs become online later.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
