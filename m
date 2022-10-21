Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B05C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQ/d1CufW14ebx5My/UX89mXFLpqaXhjizNzmGRhLpI=; b=IZ6xmgGJFDE1yhCU8gcs+4tKZR
	Jv3jsckW4vFcZgTCuR2dAiX2BVoX0kDnfTeCv8PaP9j2q5nYM2YgIhvw7PiEJEWCWYZtvUmFunNKb
	2Cg7e+dnSvqdQI3g+aCYmSISNnCVq7rjQdLFs94phF3RURbVsu6sI7WU9LAw+uXT4F2nO6dtyd3YR
	djOXnWeJEgwnbtT3chOEL3mjHpNuVaQx/rvcv2rlxiH7nwrZ770XUuWyC7YjnEvOFv+9eDXMgzzb7
	bm3Ibt9k82s1KJhCl7c1R6xtvfhCtj9h3UzLvjQaUmG7dWT3HnPFj7kpuxs6OCHNkga7fa1laC5MA
	8j4YXdVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhEJ-004ICs-OZ; Fri, 21 Oct 2022 01:53:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhEH-004IBk-K2
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666317224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ/d1CufW14ebx5My/UX89mXFLpqaXhjizNzmGRhLpI=;
	b=Im42CpiHPjdxykJEVAK/73qjPZ8irPgXMRKUrMI6w1AzYXjS/YHM8H2Gax6yIoycaVMlGQ
	kCYN8gb73r9NofI2yM1dwA8+tK7YFZ+fpFOr7BvccmJ+24xUkAEwGE0IVXjB21hHIp8zji
	Awjs4iiDt+3OARhkfOre/E7cNaip3TQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-rbO4VJSZOBi7qpmhH2midA-1; Thu, 20 Oct 2022 21:53:41 -0400
X-MC-Unique: rbO4VJSZOBi7qpmhH2midA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E1643C01C0C;
	Fri, 21 Oct 2022 01:53:39 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC4DA1415113;
	Fri, 21 Oct 2022 01:53:28 +0000 (UTC)
Date: Fri, 21 Oct 2022 09:53:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Message-ID: <Y1H7kVgzvnJ9tFqb@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_185345_748134_825FA4A8 
X-CRM114-Status: GOOD (  17.02  )
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

On Thu, Oct 20, 2022 at 12:56:05PM +0200, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> tagset quiesce interface to skip the queue.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: simplify for the per-tag_set srcu_struct]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


