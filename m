Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D60E80A9A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+U5HPD3zGSFPqtXU2SeK2S5ne30ggVI1WMunlo2Ydg=; b=iRkks2s6sKmxlJX2CRwZxxJ2W2
	kGj5eu+7NX1z85ihCGG41wKkIrmzaEZBaKe/+IMBihySJ8S/o2UUsPLDSZsAhGQk/1SkJ9D1n6oSj
	0eRThjzRc1gPBtaK7jqOqXjZrL609tYuDPcnW7FvbNbJrOWZw7Qi9VRF9pVwIJpVSn5j6X8529d8Q
	6EGf3Zf4VMNHrVCoYneGMNXc8Skc+NyyVa3pkGtPjm6Fy3yYQXKr5LRU8BET4XTAVVeTlaHDzih4m
	hUx984oxmpVRl04iZrR/+0+iQmi4WSjX3sQbRh9yqUEpYTj2tUEW7PWslyqt9I2pZBTTsIzCv98hd
	dyVLa2Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlP5q-000CYt-0u;
	Wed, 27 Sep 2023 07:36:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlP5n-000CYO-2V
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 07:36:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F02F31F895;
	Wed, 27 Sep 2023 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695800172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+U5HPD3zGSFPqtXU2SeK2S5ne30ggVI1WMunlo2Ydg=;
	b=t9bpnCbTjPb538M9RZtFmxMnmp6NApY04FQj6PLbKWWa/D6FX1cIESUpzRkRnqkJKGyQfl
	fLSuhTQ2W30DYaA8nYOuXBT3+8IzibxUeAegg04rlWOSdEoPr6vvzNlIo6Xa/zMuBuq+5h
	D49U8W3qoHqVi32dFakl2Wyeu92+2fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695800172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+U5HPD3zGSFPqtXU2SeK2S5ne30ggVI1WMunlo2Ydg=;
	b=QxR5Ywz7kORdPkovo/QG0JNdXA8yeymiLoR3noACM/fQodk4fnQ+pWuBnVsRyhtCBDCDoo
	wBAcg/lyd6ylwkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A7CA1338F;
	Wed, 27 Sep 2023 07:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MD1iHWzbE2UoSwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 27 Sep 2023 07:36:12 +0000
Message-ID: <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
Date: Wed, 27 Sep 2023 09:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230925163123.16042-2-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_003619_965585_FCC4068C 
X-CRM114-Status: GOOD (  19.84  )
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

On 9/25/23 18:31, Ewan D. Milne wrote:
> Returns a count of the total number of active requests
> in a queue.  For non-shared tags (the usual case) this is
> the sum of nr_active from all of the hctxs.
> 
Bit of an exaggeration here.
Shared tags are in use if the hardware supports only a global tag space
(ie basically all SCSI and FC HBAs).

> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>   block/blk-mq.h         |  5 -----
>   include/linux/blk-mq.h | 33 ++++++++++++++++++++++++++-------
>   2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 1743857e0b01..fbc65eefa017 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -214,11 +214,6 @@ static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
>   	return tag < tags->nr_reserved_tags;
>   }
>   
> -static inline bool blk_mq_is_shared_tags(unsigned int flags)
> -{
> -	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> -}
> -
>   static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
>   {
>   	if (data->rq_flags & RQF_SCHED_TAGS)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 01e8c31db665..c921ae5236ab 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -716,6 +716,32 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>   
>   bool blk_mq_queue_inflight(struct request_queue *q);
>   
> +#define queue_for_each_hw_ctx(q, hctx, i)				\
> +	xa_for_each(&(q)->hctx_table, (i), (hctx))
> +
> +#define hctx_for_each_ctx(hctx, ctx, i)					\
> +	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> +	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
> +
> +static inline bool blk_mq_is_shared_tags(unsigned int flags)
> +{
> +	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> +}
> +
> +static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
> +{
> +	unsigned int nr_active = 0;
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> +			return atomic_read(&q->nr_active_requests_shared_tags);
> +		nr_active += atomic_read(&hctx->nr_active);
> +	}
> +	return nr_active;
> +}
> +
>   enum {
>   	/* return when out of requests */
>   	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
> @@ -941,13 +967,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
>   	return rq + 1;
>   }
>   
> -#define queue_for_each_hw_ctx(q, hctx, i)				\
> -	xa_for_each(&(q)->hctx_table, (i), (hctx))
> -
> -#define hctx_for_each_ctx(hctx, ctx, i)					\
> -	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> -	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
> -
>   static inline void blk_mq_cleanup_rq(struct request *rq)
>   {
>   	if (rq->q->mq_ops->cleanup_rq)

Well. As discussed, using xarray on 'small' arrays is horrible for 
performance. We really should revert the patch from Ming to
turn it back into a simple array; that'll make traversing much faster.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


