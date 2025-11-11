Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310E6CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 03:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cO5w3yJkudGRFXI8OauYWxvQ3+YR+NH5t9Z29OeLOJo=; b=UPfDO/gAMrf1hbGNPjZ1eXsomK
	5VY2kEsW3QWn2CAngMndN+NzWWH/lxzYg23SEaZuuO+wbhiAhrDr2XPSUX7KXDG3nL0BVARLfSrOe
	LwEMUE/Rd6rKhSCD1tRPHrjTm7BKbQhUvqtp88Xfx27Uj9LG2QYbeab0KkfLLqeASJjf+bE0tk4+I
	DeQOnS8gH4jPi4jZAMzRxfwBtRD7UdFYe6to+VlDL3c/7cdM4ra/wqN7M6SQ71p1X+jDfNMwSE9RK
	dINAJiHQnyXMweWNNZVZPXTeMcGY7CztpxdqqBWAhNHYGAR9hwKS0dBDyCN5i3xI2t9wg63uveBcR
	zU9aNKag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIf19-00000006RD3-2XIP;
	Tue, 11 Nov 2025 03:26:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIf15-00000006RCL-2Wsg
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 03:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762831556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO5w3yJkudGRFXI8OauYWxvQ3+YR+NH5t9Z29OeLOJo=;
	b=hXjm9J1e7r0LKiZeNu9XiPh8K+km0IGZVU4AKZe+GZEu/gOVCYkzpl33ZmjGZxTz32oezl
	3bjvx4kICDeQIfgxvO1GkLAevvLqXbNfPPTUeIFOmpbFZy9XxgD9uCVtzxK1YbYFmIGdhZ
	SiuBOuj8yGIvHuTBaXUbUzgpbccK4zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-gGQa16xoORyOd_8dTj8QQg-1; Mon,
 10 Nov 2025 22:25:55 -0500
X-MC-Unique: gGQa16xoORyOd_8dTj8QQg-1
X-Mimecast-MFC-AGG-ID: gGQa16xoORyOd_8dTj8QQg_1762831553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BB1180048E;
	Tue, 11 Nov 2025 03:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 461EC30044E0;
	Tue, 11 Nov 2025 03:25:42 +0000 (UTC)
Date: Tue, 11 Nov 2025 11:25:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Wangyang Guo <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRKssW96lHFrT2ZN@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111020608.1501543-1-wangyang.guo@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_192559_715642_5D37138C 
X-CRM114-Status: GOOD (  13.48  )
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

On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> As CPU core counts increase, the number of NVMe IRQs may be smaller than
> the total number of CPUs. This forces multiple CPUs to share the same
> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> performance penalty can be observed on some platforms.

Can you add details why/how CPU cluster isn't aligned with IRQ
affinity? And how performance penalty is caused?

Is it caused by remote IO completion in blk_mq_complete_need_ipi()?

	/* same CPU or cache domain and capacity?  Complete locally */
	if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
	        return false;

If yes, which case you are addressing to? cache domain or capccity?

AMD's CCX shares L3 cache inside NUMA node, which has similar issue,
I guess this patchset may cover it?

> This patch improves IRQ affinity by grouping CPUs by cluster within each
> NUMA domain, ensuring better locality between CPUs and their assigned
> NVMe IRQs.

Will look into this patch, but I feel one easier way is to build
sub-node(cluster) cpumask array, and just spread over the sub-node(cluster). 


Thanks, 
Ming


