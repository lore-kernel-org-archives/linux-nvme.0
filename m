Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F28C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 01:23:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2EF2098B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 01:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rz/MVZFF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGlTQQvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2EF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EOpZvL0jCtifg7haRmXMgJf/1NloADUvNCMFVaQxGrQ=; b=rz/MVZFFX8ScagAgGOX85v889
	TTtSk9wwNun/yV5UqQDFLZwUc0S/JzZSYqGPJcT76yZEaDrWMDmKZxn5GyEUsh68Fr0Bm37xp6eJb
	TGDWHuZDghWAue8Gg2Pxg+sGLyI42H+qurJrDKvJZVn/KgHhbk+fXn1N3GmE5GZzL97IJHtdG6ztr
	FMfHl/DF/nz96waGr/R42elL5ttSBRsFFnM4k9VYwomMMNRpgiw+p9aGUF4NHrGGjo11CzOYsmAh2
	Mahhjq+cfzNjmPAZ1hd43J4v+SQhjGmCjZBD85Xxvw0Xqj0nHeDA/gPfz0uj4CDHZufmtXIb9y2Vo
	ikVx0tgNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV2qH-0000BQ-3j; Wed, 21 Oct 2020 01:23:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV2qD-0000Am-1i
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 01:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603243379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/3a5WoNqgZ0iMn8WvLf4Kjb/xKJUJcW3yXxPLXQTp4=;
 b=BGlTQQvxtUSBYjDxSew1DHjSDg9fzgZDyT7+eHzjEtZYMtUVo6UT6BxQNJDdU2GHsEU1Tj
 a1IELOMRgDvwWyYt2wwe8V5rbQp0NxZIyvBEhJ8wfl5Ys2P/SF70Q5JpSK8Ngf8pL/rOOk
 P/CZm5VrQzWfYPDHs8jecnZ5W83Mt+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-uXrBEqrMPVi6CksCj_nIcQ-1; Tue, 20 Oct 2020 21:22:58 -0400
X-MC-Unique: uXrBEqrMPVi6CksCj_nIcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43C0280362F;
 Wed, 21 Oct 2020 01:22:56 +0000 (UTC)
Received: from T590 (ovpn-12-44.pek2.redhat.com [10.72.12.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3704F6EF6D;
 Wed, 21 Oct 2020 01:22:45 +0000 (UTC)
Date: Wed, 21 Oct 2020 09:22:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
Message-ID: <20201021012241.GC1571548@T590>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
 <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_212301_414918_D17BAF00 
X-CRM114-Status: GOOD (  28.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 05:04:29PM +0800, Chao Leng wrote:
> 
> 
> On 2020/10/20 16:53, Ming Lei wrote:
> > During controller's CONNECTING state, admin/fabric/connect requests
> > are submitted for recovery controller, and we allow to abort this request
> > directly in time out handler for not blocking setup procedure.
> > 
> > So timout vs. normal completion race exists on these requests since
> > admin/fabirc/connect queues won't be shutdown before handling timeout
> > during CONNECTING state.
> > 
> > Add atomic completion for requests from connect/fabric/admin queue for
> > avoiding the race.
> > 
> > CC: Chao Leng <lengchao@huawei.com>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 37 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index d6a3e1487354..7e85bd4a8d1b 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -30,6 +30,8 @@ static int so_priority;
> >   module_param(so_priority, int, 0644);
> >   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
> > +#define REQ_STATE_COMPLETE     0
> > +
> >   enum nvme_tcp_send_state {
> >   	NVME_TCP_SEND_CMD_PDU = 0,
> >   	NVME_TCP_SEND_H2C_PDU,
> > @@ -56,6 +58,8 @@ struct nvme_tcp_request {
> >   	size_t			offset;
> >   	size_t			data_sent;
> >   	enum nvme_tcp_send_state state;
> > +
> > +	unsigned long		comp_state;
> I do not think adding state is a good idea.
> It is similar to rq->state.
> In the teardown process, after quiesced queues delete the timer and
> cancel the timeout work maybe a better option.
> I will send the patch later.
> The patch is already tested with roce more than one week.

Actually there isn't race between timeout and teardown, and patch 1 and patch
2 are enough to fix the issue reported by Yi.

It is just that rq->state is updated to IDLE in its. complete(), so
either one of code paths may think that this rq isn't completed, and
patch 2 has addressed this issue.

In short, teardown lock is enough to cover the race.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
