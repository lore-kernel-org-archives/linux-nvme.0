Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47B6E810D0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgV9cFphHgiIDJim4IaDO1iHdYf8Ue7XrMajSTBLCk4=; b=A3HtTlLAif+v6ZKN/VN7NJdMcn
	tjfvMCnkK4jznfpuF6z25fbO0zWijWZe/Itx2gQRi1WWp/hfBRcEq8rF5L3e4yFjVxWq4FKrTr7YS
	kP22p1blfl6J0qyXy0ObLwU7Z6mj59VsF9690wRrYw7MAwcTBOpRWC0Us9sOWTLnxRN1wQQkKlEsD
	TEG+qyBVf52uvzI+wE70nvYtwOkpo9lJb/QtVikcAI8955qsljxS8RscEYuvQ83spPOcdLTEjzsWv
	R1Zh/d14TShwx0DWfO4c2CpL9vuP5h3sesG/tH2/8rf6kb4sD+e7bq9jEWXZUwMuPHmE/+Hgy5IWB
	bN2Njvnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSrK-000opL-2P;
	Wed, 27 Sep 2023 11:37:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSrH-000oox-1Y
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 11:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695814651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgV9cFphHgiIDJim4IaDO1iHdYf8Ue7XrMajSTBLCk4=;
	b=g/TZVuflKANuPsmPBSyUnQ8/qYjzBTZW5p6/KQlnqR9bB2+5AiTTyMJGAox/CAyLMGqHdX
	LTiTgMHGEIZ/qq6rsrE+OEtIlM9r0kBJRD51xiIEaAHxibjDOpgi8BNzWqwm7YGW0Fon5X
	snhLB09hFiAbJ0VC6fCDrPcdZ0z6NfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-Nxsf-TKKOxqKuJmE4PVQJw-1; Wed, 27 Sep 2023 07:37:28 -0400
X-MC-Unique: Nxsf-TKKOxqKuJmE4PVQJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9203D80D089;
	Wed, 27 Sep 2023 11:37:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C8740C6EA8;
	Wed, 27 Sep 2023 11:37:22 +0000 (UTC)
Date: Wed, 27 Sep 2023 19:37:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org,
	tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Message-ID: <ZRQT7aaSKBRChzSV@fedora>
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
 <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
MIME-Version: 1.0
In-Reply-To: <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_043735_599362_86B79A61 
X-CRM114-Status: GOOD (  25.61  )
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

On Wed, Sep 27, 2023 at 09:36:11AM +0200, Hannes Reinecke wrote:
> On 9/25/23 18:31, Ewan D. Milne wrote:
> > Returns a count of the total number of active requests
> > in a queue.  For non-shared tags (the usual case) this is
> > the sum of nr_active from all of the hctxs.
> > 
> Bit of an exaggeration here.
> Shared tags are in use if the hardware supports only a global tag space
> (ie basically all SCSI and FC HBAs).
> 
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >   block/blk-mq.h         |  5 -----
> >   include/linux/blk-mq.h | 33 ++++++++++++++++++++++++++-------
> >   2 files changed, 26 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 1743857e0b01..fbc65eefa017 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -214,11 +214,6 @@ static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
> >   	return tag < tags->nr_reserved_tags;
> >   }
> > -static inline bool blk_mq_is_shared_tags(unsigned int flags)
> > -{
> > -	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> > -}
> > -
> >   static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
> >   {
> >   	if (data->rq_flags & RQF_SCHED_TAGS)
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 01e8c31db665..c921ae5236ab 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -716,6 +716,32 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> >   bool blk_mq_queue_inflight(struct request_queue *q);
> > +#define queue_for_each_hw_ctx(q, hctx, i)				\
> > +	xa_for_each(&(q)->hctx_table, (i), (hctx))
> > +
> > +#define hctx_for_each_ctx(hctx, ctx, i)					\
> > +	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> > +	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
> > +
> > +static inline bool blk_mq_is_shared_tags(unsigned int flags)
> > +{
> > +	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> > +}
> > +
> > +static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
> > +{
> > +	unsigned int nr_active = 0;
> > +	struct blk_mq_hw_ctx *hctx;
> > +	unsigned long i;
> > +
> > +	queue_for_each_hw_ctx(q, hctx, i) {
> > +		if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> > +			return atomic_read(&q->nr_active_requests_shared_tags);
> > +		nr_active += atomic_read(&hctx->nr_active);
> > +	}
> > +	return nr_active;
> > +}
> > +
> >   enum {
> >   	/* return when out of requests */
> >   	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
> > @@ -941,13 +967,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
> >   	return rq + 1;
> >   }
> > -#define queue_for_each_hw_ctx(q, hctx, i)				\
> > -	xa_for_each(&(q)->hctx_table, (i), (hctx))
> > -
> > -#define hctx_for_each_ctx(hctx, ctx, i)					\
> > -	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> > -	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
> > -
> >   static inline void blk_mq_cleanup_rq(struct request *rq)
> >   {
> >   	if (rq->q->mq_ops->cleanup_rq)
> 
> Well. As discussed, using xarray on 'small' arrays is horrible for
> performance. We really should revert the patch from Ming to
> turn it back into a simple array; that'll make traversing much faster.

But queue_for_each_hw_ctx() isn't supposed for fast path, and it is always
expensive to run cross-queue things.

It also means any way running cross-queue thing in fast path may not be
one good idea.

Thanks,
Ming


