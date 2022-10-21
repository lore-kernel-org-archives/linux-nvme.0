Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FF5C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUvNrwuuXKA8zc+bBog52EGAOJU0uXYgk0rzBuuiK4U=; b=UYr1zKGXNhpdwFRRZGyyCGMxN6
	Sr08KA+GsUppl6aSTxs3R2bgZ55H/kjRf5OZ6hb/CrdJGJJY1SA6g67P5yqd9/+Rm1AJ3vAQqiC5r
	rei9Vqg6c4LdMC77Sv75kV+xHFXmGymxmU+SN6pIWQpIkRsQ38RLRyhgTPjTIeRZ8lQ7VXlwa7PQd
	2uP7c9p5hNbk/XwKjeUjuXf29IeT+9PYji0sJh2bBd8+frRiwaLslIFpdzjfIatG5/9GLLmjdsAZ2
	/fZJzY86ywJKXHjE3ltirGXEPtTHm5cN7CUHBXlRhe9jJt+u26Zab5E/0uw7ZRxUTDLKPxw9xprYe
	E+YMbj6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olh2P-004Fut-Od; Fri, 21 Oct 2022 01:41:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olh2N-004FuE-HQ
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666316485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUvNrwuuXKA8zc+bBog52EGAOJU0uXYgk0rzBuuiK4U=;
	b=dc2Yes54KOD70eQGMHfHe+Z7oF84xKeaIdhgqbgg7HsdjbIP9hKRkHTwIQ8tsy946XJf9q
	8Wa5XdJIRFmBQBTjPeOmgZh7Ave5HMEEXHydVTaZ97J6WySnQ1TBhzE37WSbXPgV/8HZ5U
	7uY5IP2Lt3wBEE6MqxtatZkAi/rgh4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-qj3smm-uNxmM29d6c4utCg-1; Thu, 20 Oct 2022 21:41:22 -0400
X-MC-Unique: qj3smm-uNxmM29d6c4utCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B5EC29AB40C;
	Fri, 21 Oct 2022 01:41:22 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45C674014CF0;
	Fri, 21 Oct 2022 01:41:13 +0000 (UTC)
Date: Fri, 21 Oct 2022 09:41:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <Y1H4soZ///Wi1sov@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_184127_672386_98FD6207 
X-CRM114-Status: GOOD (  15.70  )
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

On Thu, Oct 20, 2022 at 12:56:03PM +0200, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less
> tagsets there is also no need for the variable size allocation trick.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       | 27 +++++----------------------
>  block/blk-mq.c         | 25 +++++++++++++++++--------
>  block/blk-mq.h         | 14 +++++++-------
>  block/blk-sysfs.c      |  9 ++-------
>  block/blk.h            |  9 +--------
>  block/genhd.c          |  2 +-
>  include/linux/blk-mq.h |  4 ++++
>  include/linux/blkdev.h |  9 ---------
>  8 files changed, 37 insertions(+), 62 deletions(-)

q->tag_set is supposed to be live when calling blk_mq_quiesce_queue
and blk_mq_unquiesce_queue, especially del_gendisk() quieses request
queue, so looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


