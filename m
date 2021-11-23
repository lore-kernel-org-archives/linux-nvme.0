Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE18C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjMwCURZYhH7uxbsg2k5Wuq2Rys5JGTRvwbIfrl7OJk=; b=aKiz7oudbp2jmeqaMtEEItMr4J
	efjlKFoBMNh+vqGmjxfGPrjB5psjCc6Pr3IlFfZ3JQ7Q9ryla1XN5/jPFOsG7fNIVHQBJ+vbD02/Q
	iP5gaGh+1d1/AlSjNAwkKeG+AaYMX8xq3VDDQ3N9lqikLF8qi/jhn8PNGDsMl4KfNmgmenZDNvm59
	r1Xt++fGng9kwuuxSqxKUqkMiaUn9gfiDm78IxzSsTscozPmEPfc4U1Q3m9Ll5LTi9NLwQu57Qt0C
	biOlta/8Bj1ydFy/VqK1MuOpJ+N0hlofpCq1BaFT9h9w7bAfqEHcAAlwmiq7/cvLvQkSj64dOurhX
	BHyGPpRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpJVF-000WUI-HO; Tue, 23 Nov 2021 00:17:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpJVD-000WTA-18
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 00:17:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637626658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjMwCURZYhH7uxbsg2k5Wuq2Rys5JGTRvwbIfrl7OJk=;
 b=iiMxC95P4j77EOqyChr0fxCuhaXG3etu124Ir50Kj0Ru84zTxaF+tzfsHFmohQlCUBFtd6
 p9zly/w/keMzukTj+yOTa+xgTCDb0z5CgHbQyCG01BTwji9hYyZNuzXipVhBP/nbxsCbXp
 JZa8xnBGTCpYU7qRBW0LVmNWn2NasHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-6l01jUTYMtefSNGTxcWa8A-1; Mon, 22 Nov 2021 19:17:36 -0500
X-MC-Unique: 6l01jUTYMtefSNGTxcWa8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230E8423BA;
 Tue, 23 Nov 2021 00:17:35 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 565905FC25;
 Tue, 23 Nov 2021 00:17:24 +0000 (UTC)
Date: Tue, 23 Nov 2021 08:17:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
Message-ID: <YZwzEBtFug6JEmMZ@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
 <YZuagPbZJ6CjiUNi@T590>
 <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_161739_193189_C43F9380 
X-CRM114-Status: GOOD (  19.51  )
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

On Mon, Nov 22, 2021 at 03:55:36PM +0200, Sagi Grimberg wrote:
> 
> > > > Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
> > > > queues in parallel, then we can just wait once if global quiesce wait
> > > > is allowed.
> > > 
> > > blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
> > > obviously it has a scope.
> > 
> > How about blk_mq_shared_quiesce_wait()? or any suggestion?
> 
> Shared between what?

All request queues in one host-wide, both scsi and nvme has such
requirement.

> 
> Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
> flag that is cleared in unquiesce? then the callers can just continue
> to iterate but will only wait the rcu grace period once.

Yeah, that is what these patches try to implement.


Thanks
Ming


