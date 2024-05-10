Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6009C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iklQ4xxHFZV+Qki0dviQ4m5k+nADr2OgsFCMnKwgEcg=; b=08NWfzt9IVa3W6Ei5rh4tmMyTp
	0uKD6mYakVm/fFy8bgrWViTq7XfbioAht/VQhCyHRRE43rvRpyyuUckXwKAqU2IbNg2YLyT9Cn9f4
	4eHr20KH4+xTNxtxcJefEabtzZd8aUY9B/We/AGHziRnzfaCPTqG6RBmRlaNGT3VXJsRbn2NsCPoY
	qTgT9fXXPn69nTtbpXuQc8LPDb+OJgED3+wxbDD9XL8ue3DqcZFFDeukHlPaKH2EosaukrsZY6EZa
	zFcpk5/LcDtvN278Vkk0nDb6hsqsAJYFKMr52iFdcjIq8rPwRFa/m4foMW9jY7L7ucYjCDsmi7s+1
	uzyC0hgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zxl-00000006oxL-2mUW;
	Fri, 10 May 2024 23:47:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zxj-00000006owt-0YFB
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 23:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715384856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iklQ4xxHFZV+Qki0dviQ4m5k+nADr2OgsFCMnKwgEcg=;
	b=CfU/peavGhPJUV34fiv/QgrKEUqzmY6Cw8VIugv0zY+NWc69/B1BMz1aeGYewF7uqIDauG
	voxzB4nz9Uxn/myQyHBa52z5GHYrLoVVg/aGTT5MDFxE3pI6mBbrOD68pw8ZXR8PUfs48C
	CLbXXMqY2txmH+2wpwVQEPbFPhEQKH0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-J1xpJO5-PJqdRrX4Fv4RBQ-1; Fri,
 10 May 2024 19:47:33 -0400
X-MC-Unique: J1xpJO5-PJqdRrX4Fv4RBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E89A138157A6;
	Fri, 10 May 2024 23:47:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B091C043EB;
	Fri, 10 May 2024 23:47:29 +0000 (UTC)
Date: Sat, 11 May 2024 07:47:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6yDtRzl68zspQY@fedora>
References: <20240510174645.3987951-1-kbusch@meta.com>
MIME-Version: 1.0
In-Reply-To: <20240510174645.3987951-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_164739_519361_20EEE888 
X-CRM114-Status: GOOD (  22.31  )
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

On Fri, May 10, 2024 at 10:46:45AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some people _really_ want to control their interrupt affinity,
> preferring to sacrafice storage performance for scheduling
> predicatability on some other subset of CPUs.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Sorry for the rapid fire v2, and I know some are still aginst this; I'm
> just getting v2 out because v1 breaks a different use case.
> 
> And as far as acceptance goes, this doesn't look like it carries any
> longterm maintenance overhead. It's an opt-in feature, and you're own
> your own if you turn it on.
> 
> v1->v2: skip the the AFFINITY vector allocation if the parameter is
> provided instead trying to make the vector code handle all post_vectors.
> 
>  drivers/nvme/host/pci.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685d..def1a295284bb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
>  		"Use SGLs when average request segment size is larger or equal to "
>  		"this size. Use 0 to disable SGLs.");
>  
> +static bool managed_irqs = true;
> +module_param(managed_irqs, bool, 0444);
> +MODULE_PARM_DESC(managed_irqs,
> +		 "set to false for user controlled irq affinity");
> +
>  #define NVME_PCI_MIN_QUEUE_SIZE 2
>  #define NVME_PCI_MAX_QUEUE_SIZE 4095
>  static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
> @@ -456,7 +461,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		 * affinity), so use the regular blk-mq cpu mapping
>  		 */
>  		map->queue_offset = qoff;
> -		if (i != HCTX_TYPE_POLL && offset)
> +		if (managed_irqs && i != HCTX_TYPE_POLL && offset)
>  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>  		else
>  			blk_mq_map_queues(map);

Now the queue mapping is built with nothing from irq affinity which is
setup from userspace, and performance could be pretty bad.

Is there any benefit to use unmanaged irq in this way?


Thanks,
Ming


