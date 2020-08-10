Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D356C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 03:16:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494482065D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 03:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SR/Kmsy4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTw+0dRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494482065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FIDffDY/ucGQ+rvfmanBcPtsyiSnKegRvx4l59FLhag=; b=SR/Kmsy4MUhehYLEYbYPGDy2/
	pHx3+xva1bdlGTIkCWC9Rp0hdcq62LnkbnPVArNYVqueJk5wz6afjXEJsrzvXYYfxP8y6lybJeKF9
	XKTef2T139JQhk3XGpZQI6zDJQ15rX4avAhp92XqDFO38z0LLJROhc0PEDWTtk71UTUHUk2yFeS3W
	0VGLH6I2Z+23hjDLartXhW+FXX9uCJU13TqkIIrdmBBYi98+6YcZ0pXtCjbKWbmY4wHh9NLS0AFto
	uLBZm7LErjwOLpK7MvWiYIYiXQNBIbKCCMEqpE2x0I4PnZ2YbluIkxzkYWidshsqvii5glUiRu+AE
	DsmfyMY+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4yIB-0001pU-Vj; Mon, 10 Aug 2020 03:16:08 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4yIA-0001p3-0f
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 03:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597029364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2t4h3xBtgQzBZLBUDif0YVJTDr/h+7SWzN2brxDiDs=;
 b=VTw+0dRg7JHfqHN7q4TLfkRci3O3PJQ4wqEFDni7eig0274n417aiGsmdxztz9iX1RhPX4
 ZE9DeDSCMydDCuZoVWCFj1NwD+Cu0gFlcf50mMppPKvL0r6aheQVxniEatpp13BwfuW0m9
 dLei+FcMxUZHc+1f/yAGQPHdMY3Gft0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-V_6AE8prOUqI8ObSH2fxAg-1; Sun, 09 Aug 2020 23:16:00 -0400
X-MC-Unique: V_6AE8prOUqI8ObSH2fxAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA2380183C;
 Mon, 10 Aug 2020 03:15:59 +0000 (UTC)
Received: from T590 (ovpn-13-99.pek2.redhat.com [10.72.13.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D43048BA11;
 Mon, 10 Aug 2020 03:15:51 +0000 (UTC)
Date: Mon, 10 Aug 2020 11:15:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Message-ID: <20200810031547.GB2202641@T590>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200809_231606_141444_84395CAD 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 10:17:04AM +0800, Chao Leng wrote:
> 
> 
> On 2020/8/7 21:49, Ming Lei wrote:
> > On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
> > > nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
> > > one, if there is lots of name spaces, sync wait long time(more than 10s).
> > > Multipath can not fail over to retry quickly, cause io pause long time.
> > > This is not expected.
> > > To reduce quiesce time, we introduce async mechanism for sync SRCUs
> > > and quiesce queue.
> > > 
> > 
> > Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> > 
> > - percpu_refcount has much less memory footprint than SRCU, so we can simply
> > move percpu_refcount into request_queue, instead of adding more bytes
> > into each hctx by this patch
> > 
> > - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> > 
> > - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()
> IO pause long time if fail over, this is a serios problem. we need fix
> it as soon as possible. SRCU is just used for blocking queue,

The issue has been long time since SRCU is taken, not sure if it is
something urgent.

> non blocking queue need 0 bytes. So more bytes(just 24 bytes) is not
> waste.
> 
> About using per_cpu to replace SRCU, I suggest separate discussion.
> Can you show the patch? This will make it easier to discuss.

https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
