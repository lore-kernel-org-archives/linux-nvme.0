Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD8DC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aX5SHZZrlLzIuA6zspzZp9bdt2bB6GCyAFRXm2vXPG4=; b=IeOQHVuqXIbeokq71lB+zZ5gID
	sR2FJDLnKGVQXYtj9TcfQsO0alktkAdjfINLpZzVFtbeGiXqfDt44wFaDPWZ5tv3wlyjHkb/29/bA
	ZALaw6R1XrbXnWPCmhtUVAcwnOrvBiZMqxCnNMDdRinYpf4JrhfCsjyAPPomNK/HJKpTwQFr9MDI0
	ZjsmH/QIENRBySxPyQ9TavDmuBd1ZaZZnDrhscEI1wk6p1dn2zUrL0QQwh+5Iwib7KSuOwtjx6Fox
	+N4DcvORyJyLBd6XrKbNU/N0oydw5O7TTIATTjdrImUmOHUtTdHrLzRgjzNfdrjNWMY1vrP0graqY
	pNhdxGAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGqW-00DvSQ-UX; Thu, 22 Sep 2022 07:42:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGqU-00DvR1-09
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663832523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aX5SHZZrlLzIuA6zspzZp9bdt2bB6GCyAFRXm2vXPG4=;
	b=Y4e3m4olk6qChKrlkAI+6+jn4SsghsrWLmppW1rqUxF434XppjBc5zxcRUMy4+uRQ0aKAf
	4pOazR7AxPi6U9Yaej/LoHZa/x2h2daz7ttu00q/yWPCeiAhs253MUHhj4yzZ3H5yXRAmw
	7ngLpiIQDOTodNMwQanpm0Fe6byavyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-ggugo2h2M-q7MtGVahmSTQ-1; Thu, 22 Sep 2022 03:41:58 -0400
X-MC-Unique: ggugo2h2M-q7MtGVahmSTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6A5800B30;
	Thu, 22 Sep 2022 07:41:57 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 327B8C15BB9;
	Thu, 22 Sep 2022 07:41:52 +0000 (UTC)
Date: Thu, 22 Sep 2022 15:41:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	homas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <YywRu/g7ML0Dq/Gq@T590>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
 <20220922062517.GB27946@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922062517.GB27946@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_004206_150186_33303126 
X-CRM114-Status: GOOD (  23.84  )
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

On Thu, Sep 22, 2022 at 08:25:17AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 20, 2022 at 10:17:24AM +0800, Ming Lei wrote:
> > For avoiding to trigger io timeout when one hctx becomes inactive, we
> > drain IOs when all CPUs of one hctx are offline. However, driver's
> > timeout handler may require cpus_read_lock, such as nvme-pci,
> > pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> > and irq_build_affinity_masks() needs cpus_read_lock().
> > 
> > Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> > is held, so deadlock is caused.
> > 
> > Fixes the issue by breaking the wait loop if enough long time elapses,
> > and these in-flight not drained IO still can be handled by timeout
> > handler.
> 
> I'm not sure that this actually is a good idea on its own, and it kinda
> defeats the cpu hotplug processing.
> 
> So if I understand your log above correctly the problem is that
> we have commands that would time out, and we exacalate to a
> controller reset that is racing with the CPU unplug.

Yes. 

blk_mq_hctx_notify_offline() is waiting for inflight requests, then
cpu_write_lock() is held since it is cpuhp code path.

Meantime nvme reset grabs dev->shutdown_lock, then calls
pci_alloc_irq_vectors_affinity()->irq_build_affinity_masks() which
is waiting for cpu_read_lock().

Meantime nvme_dev_disable() can't move on for handling any io timeout
because dev->shutdown_lock is held by nvme reset. Then in-flight IO
can't be drained by blk_mq_hctx_notify_offline()

One real IO deadlock between cpuhp and nvme_reset.


thanks,
Ming


