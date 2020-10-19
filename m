Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B6C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 00:52:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DE522272
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 00:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHlmFUpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0BfZwLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DE522272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=agJFwO/nIy2UbpvPNdQYzvROr3UvY5m6eWdyqs34zEo=; b=rHlmFUpb1SLbr5CQ9j5/nQl2a
	tv0nanY2dvkWWVX1Nacg+WPQRWU8FIE+HtMg5mPJGh5VYTQhGX5E6sD00J+vKqVOjHaVDqXFhCntN
	QqM2yvFuSTaJgWCPCxNHV5A2LOYtoWjvbsxsJma5IGflafkwvic/5RPZCycpwNIpw8SNZuR2Pq5uE
	MZD33OXrERpGZBi5+VulKeKwoUCA89XGI3hH0aZOWGkxYio8RdKqDUR74jUZSslnPnP2M/lgrW600
	/wOCXZ/tIKbFL77w5XSI319TXsuQkodeZ1K7SGUQzdcmchoQxr2gLaJbitc8sAzrZ001tfz9XKO9w
	mb5QaA4xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUJPL-0004jI-CB; Mon, 19 Oct 2020 00:52:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUJPG-0004iL-3s
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 00:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603068727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE/Y48CjGF5exAFdQXpq91w93L8qvd2SuneNHFuHjak=;
 b=K0BfZwLc/GpCZ0vbBQK0/6af2h9WVKMcsq4RsopBASqxSkSiU/oQ5hwIqmoHM8bZLeVUtK
 S/a1uQ3kphsiI2x0tOqeMVdc7ExuOM7C4Kx/o6HAJej2pu4hfR9o1Xko6doEj0iRpTVZBR
 Pnsaiy9OJwG9pgxQW4MCeu79EksFb1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-euvLwKOSMQCm2r3_YSjqSA-1; Sun, 18 Oct 2020 20:50:46 -0400
X-MC-Unique: euvLwKOSMQCm2r3_YSjqSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B877C1868403;
 Mon, 19 Oct 2020 00:50:43 +0000 (UTC)
Received: from T590 (ovpn-12-185.pek2.redhat.com [10.72.12.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F8D5D9F3;
 Mon, 19 Oct 2020 00:50:33 +0000 (UTC)
Date: Mon, 19 Oct 2020 08:50:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] blk-mq: check rq->state explicitly in
 blk_mq_tagset_count_completed_rqs
Message-ID: <20201019005029.GB1301072@T590>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016142811.1262214-2-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201018_205210_339690_998BD27A 
X-CRM114-Status: GOOD (  20.72  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 16, 2020 at 10:28:08PM +0800, Ming Lei wrote:
> blk_mq_tagset_count_completed_rqs() is called from
> blk_mq_tagset_wait_completed_request() for draining requests to be
> completed remotely. What we need to do is to see request->state to
> switch to non-MQ_RQ_COMPLETE.
> 
> So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().
> 
> Meantime mark flush request as IDLE in its .end_io() for aligning to
> end normal request because flush request may stay in inflight tags in case
> of !elevator, so we need to change its state into IDLE.
> 
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-flush.c  | 2 ++
>  block/blk-mq-tag.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 53abb5c73d99..31a2ae04d3f0 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  		return;
>  	}
>  
> +	WRITE_ONCE(rq->state, MQ_RQ_IDLE);

oops, the above line should have been:

	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
