Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD0BC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 06:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdQ4E3J0Zm3cNHacpvTddt2H+cHR2iZICn9ONJHKSAw=; b=BOk9NtV3lF0yn1pWiNlCCOPvaH
	kRTsAtkpxCU+7Exm43wkVlFuhiK2SSmPABoi498eXQjbwXWIgMJSwMplGCoyN9SbZ33LKXHk1iD8b
	ibblQe1Ze4C2oZibUpg7MEAm0RqpAwNiwOvkdun3AE9ATWMfTAGwc4bgRU3v9ju1RuahaaZ2Kwi4w
	bGAtu3wAQEvrVB4uawICkKAy1mmvIKYXPJsKIgWcuUm7GONNnggd0q02c0KQZOzFwCzfx234cgDUS
	JohpveINLWTJEGAOtc80uRM5f1tmO556FbidjM72/pA/R2xggrMfxeK81mPmKtSnS0jRI734cQe+J
	dvp2XLlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okg6M-003Fss-Ik; Tue, 18 Oct 2022 06:29:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okg6K-003Fr6-Kd
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 06:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666074558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdQ4E3J0Zm3cNHacpvTddt2H+cHR2iZICn9ONJHKSAw=;
	b=WmyZEoCmmcPHVRLNIdA7NV8wbbg8RQrdRnAjxi/u3IU5gCtYn9XK3K8vDC7WrY6b2WA2gk
	YbMXH+2nhwt5EOOMY8vxv2x8QE9xuwNXOfj8h+rsnlwe45JC46TJaOVojLDfVblX4Gt+De
	ZxVobUlRtuhGMyoCZc/Sy6DpXJDs3So=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-XyMAMxqkMx6YQkiLRNNNAg-1; Tue, 18 Oct 2022 02:29:13 -0400
X-MC-Unique: XyMAMxqkMx6YQkiLRNNNAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A25038164C4;
	Tue, 18 Oct 2022 06:29:13 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE701731B;
	Tue, 18 Oct 2022 06:29:08 +0000 (UTC)
Date: Tue, 18 Oct 2022 14:29:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] nvme: don't wait freeze during resetting
Message-ID: <Y05HsJLlx4UNlIKv@T590>
References: <20220926013404.2217794-1-ming.lei@redhat.com>
 <20221010082533.GA24101@lst.de>
MIME-Version: 1.0
In-Reply-To: <20221010082533.GA24101@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_232920_793915_01E7A8DA 
X-CRM114-Status: GOOD (  20.48  )
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

On Mon, Oct 10, 2022 at 10:25:33AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 09:34:04AM +0800, Ming Lei wrote:
> > First it isn't necessary to call nvme_wait_freeze during reset.
> > For nvme-pci, if tagset isn't allocated, there can't be any inflight
> > IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.
> > 
> > Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> > while requests are in progress"), it is fine to unfreeze queue without
> > draining inflight IOs.
> > 
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > Reviewed-by: Chao Leng <lengchao@huawei.com>
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- remove the change in rdma/tcp which may make non-mpath reset
> > 	time much longer, as pointed by Sagi
> 
> So how can this be corret for PCI and apple but not for rdma and TCP?

It doesn't mean it isn't correct for rdma and TCP, just the similar
patch may increase timeout delay a lot for the two, nvme_wait_freeze_timeout(ctrl,
NVME_IO_TIMEOUT) waits 30 secs at default, but nvme_wait_freeze() may wait
much longer if retry is involved.

> 
> Also please don't update two drivers in a single patch.

But the change is same for both two, and we have lots of such example,
same change on lots of subsystem.


thanks,
Ming


