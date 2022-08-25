Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495D0C3F6B0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZV1yF2Vi8pu+xLMxCiM4X7Erl/WpsmeH2YKxfhNtT8=; b=by26dpznSa0qWgcn8hJu1er2S7
	C5l+i9W8ZIMrjOf1uAOtDHVSnFn0xrSPCtw2jSSLB6N1pje/5LSPvwUHF6B5qPmHzOF1DxoIRpvjV
	kVxYd5tKPBigQAxioBRdzM1tnO1sFjGbzvAJrZatu9IxLO1iDWc/Lsy5DSD89Gj4DmnWAgpEolvHo
	bcum/oUXKyhbCEXI9MA8y79qgT0LLeLW+jB3QNBsE/CEIN0QWTgD20dx2CIcE0rO768NWpbtCzrX7
	iI988cBi1wo8MjAj6Upv42ShxNeZUcZZsFcJA7+xbYJo97js1ZJFwLgEw9odfM5YUq8/kzJ8whD06
	JuvQTIrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRB8K-00ChXp-VZ; Thu, 25 Aug 2022 11:34:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRB8F-00ChEx-UZ
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 11:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661427277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZV1yF2Vi8pu+xLMxCiM4X7Erl/WpsmeH2YKxfhNtT8=;
	b=Pu/ObgODD2HGcvCu7xNYpsYjmlE8+nIGmsDiq/tT0rbQwAEMy6i6YvcTpiavWNHuGGykuq
	VvHTQ2XDY83Gzhhj6AeSQQG1xWGDKGvpVQuGYYbQ6IX1/7WgEI/aenCJ1TTFpWXfJI8pA7
	ds1NkCfpxTc4YFPNECjrzNVoXMm14NE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Gzm7owg0OsOetMJRCllTTw-1; Thu, 25 Aug 2022 07:34:34 -0400
X-MC-Unique: Gzm7owg0OsOetMJRCllTTw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 510C48032FB;
	Thu, 25 Aug 2022 11:34:34 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33F13492C3B;
	Thu, 25 Aug 2022 11:34:29 +0000 (UTC)
Date: Thu, 25 Aug 2022 19:34:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Message-ID: <YwdeRgU4YsZEGz8J@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
 <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com>
MIME-Version: 1.0
In-Reply-To: <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_043444_291850_AEE75E78 
X-CRM114-Status: GOOD (  19.87  )
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

On Thu, Aug 25, 2022 at 06:05:30PM +0800, Chao Leng wrote:
> 
> 
> On 2022/8/21 16:47, Ming Lei wrote:
> > First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
> > If tagset isn't allocated, there can't be any inflight IOs; otherwise
> > blk_mq_update_nr_hw_queues can freeze & wait queues.
> > 
> > Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> > while requests are in progress"), it is fine to unfreeze queue without
> > draining inflight IOs.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/pci.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3a1c37f32f30..91b2903fcc24 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
> >   		nvme_free_tagset(dev);
> >   	} else {
> >   		nvme_start_queues(&dev->ctrl);
> > -		nvme_wait_freeze(&dev->ctrl);
> It is not safe.
> nvme_dev_add may call blk_mq_update_nr_hw_queues, blk_mq_update_nr_hw_queues
> require the state is frozen.

blk_mq_update_nr_hw_queues() calls blk_freeze_queue() for every queue in
this tagset, so it needn't nvme's freeze wait.


Thanks,
Ming


