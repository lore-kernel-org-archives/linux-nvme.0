Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08130D33992
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTU+LxuJwXlNa9YUgQCS8AbBwlbqwdJ/enGGPEzwseM=; b=ar1qejw4dvqMgR9ODdenIhBjWU
	z15e12iuBTZBfBqQzAaQyGzz4XZ/OD/e4FXjVIJXCYMgbXRzXARUl2+q9Jv2vINNIZ7kObibNY/3r
	9K3ecU60iSMeahFbhPdFpRSEcGxPPV6klSneSyosx69J/slkL6bk9Qz2i/PjvqUOPjiPzb1Nde9Su
	TNlbt2l/1stqDgOflChxP6lm3nzrHQKZOl5DBLg+PXwuCN1piQD79zX7TupuMOIFnOyftKSZ/kQ+2
	1CFTdLfi+mTsN9XWXdaJPk1nuiLzaHs8IdWQeJuV7u0ftnmlLeVWX29vdIb8U5S85UmE88fYVxnMj
	UaAMeLqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRYqC-00000009iFo-311v;
	Fri, 05 Dec 2025 16:39:32 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRYq9-00000009iFH-3Cwr
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 16:39:31 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-297d4a56f97so29943395ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 05 Dec 2025 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764952769; x=1765557569; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTU+LxuJwXlNa9YUgQCS8AbBwlbqwdJ/enGGPEzwseM=;
        b=TrgsMHf9sp2zE+I9bl7fZgaIr3bD83OXDuOqS+xS3oJWQrmnQgo2KwNXK2Vaol4dAG
         fIiE7wqzYr9oERL2+Coj1Z0VF3KKAEMr9xRBO03zvthjaWIzeonoRl9bcVWYd9vt0JaK
         D+k2egeingZWXyAfkcnuEkroMJq61TuGvq6JQqnd/i8qfEPjTXMDEeLnjjguUNgZapg7
         u2U9lRi38I/RaHEQi8qUPZSioXOjd73yHN+FCOV2KNoDNWdaGK56dNI+iqpH6b9q49pW
         ZKan+zIbDWP4Id6uV3VUFl4nqBSJAnoxWL+Y06FhBn9nGzDaOorAGHoUroFGp6WjkDKI
         ZuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952769; x=1765557569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTU+LxuJwXlNa9YUgQCS8AbBwlbqwdJ/enGGPEzwseM=;
        b=Y4m2jPTBTXGv10cpEg009lxKYcCCbl3buq8CyK52g5JnoGCjRW5UrdRlt5fQfuKnxw
         GZxJ645dQY0GJ4a5KGVSFeRzEVD+XrsN5qky/PiM1Jv6HJ48f7/mU3gVTzAh4ku2/Npd
         aRIWFwox6rLhFyrQ9NV77/b54eE4JQp8z35JjKc79la3G4yIppNzJPRlwInu8V9eRQYs
         gEmb6etP55dosYyj+0FVZgJdFzL6ReIcOkSk06dBzGxwztqM/bUyPQT38WQW6GBlTEHP
         P/HR6lkhjZcvCS6LGJFttRygwTSKAefVSrzb4/JkHrd43dTvx7H/CltKoguR6DmKgsfJ
         tZRw==
X-Forwarded-Encrypted: i=1; AJvYcCWCCMiyeh2JEJQIChVxD3ftMBApal4Rw/mO4f3pz5ZB6R9BXVXTzkBKGo1AR600E9B4Tiq6f2YeJLtR@lists.infradead.org
X-Gm-Message-State: AOJu0YwL4qBCAHkM6CAcDm6FDmOHJpXqiGpEz1Hxbyb8HaWH3BaFreX2
	ucYRWfWXvLQ9ehV/3o01lKnTplbLN8LYuNckja0M9N4kY4p4jZcfN6bzdbYFRcu0/1c=
X-Gm-Gg: ASbGncshvWP7YYzfsh43bh4LqcQlTAd7PplJ31zcwVhXlgeJqpV5wK9krgHIdP1qXuU
	5SP4B8Lbx3UB7jgBKwVZFpdgwnbyqZzL1Qh8IMOKuQIJ+DXCnzjG4D9aTrkeAmYP5atKpBZD1EY
	UV+spBFGM8vvY6AiPs9JXb1ZMcazQYrfpgw2dIGD4YuEQ4vqODgmYe/ZhhPKL3ZyjrRNtN4oGpX
	Je+1cWZOy5s8RoeQwsDO04Z/atZ/GZwE4dcWqpByYraP/M8n04VxUM44vwep8MpBRHaHoMqSRBz
	AoVjHRLAO8UsR7eKlVbwpDFxYU5pb8HhEIZEP5bsxl8al7cS6GNmfbEiRcZJzk1MKtYL4sTdvH9
	G1N+oiV4ryQCMU4+0Fc5x5xgi17XEaGNEo89TaXbLy2k8ue+PBpJUETeDedaHUbF6bORyZkXJCZ
	Dr9fj7DFxGDLAqH5Wtd+1MaUZXvf0=
X-Google-Smtp-Source: AGHT+IGyqqXd0/T+TfMGuiq+NHZnOPlJ5gPhROJprsj74mw36MvYZMv3SkASuMrsEc7UEyVTpKpkdw==
X-Received: by 2002:a05:7301:da88:b0:2a4:61a1:c0d5 with SMTP id 5a478bee46e88-2ab92ebc2d6mr5258910eec.36.1764952768406;
        Fri, 05 Dec 2025 08:39:28 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2aba87d7b9dsm20321107eec.4.2025.12.05.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:39:27 -0800 (PST)
Date: Fri, 5 Dec 2025 08:39:26 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251205163926.GI2376676-mkhalfella@purestorage.com>
References: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
 <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
 <aTI2L6j50VWjp7aW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTI2L6j50VWjp7aW@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_083929_980896_BF3E4DF0 
X-CRM114-Status: GOOD (  43.23  )
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

On Thu 2025-12-04 18:32:31 -0700, Keith Busch wrote:
> On Thu, Dec 04, 2025 at 01:22:49PM -1000, Bart Van Assche wrote:
> > 
> > On 12/4/25 11:26 AM, Keith Busch wrote:
> > > On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:>> Hence, the deadlock can be
> > > > solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
> > > > and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
> > > > I/O and does not call blk_mq_quiesce_tagset() then the
> > > > blk_mq_freeze_queue_wait() call will finish instead of triggering a
> > > > deadlock. However, I do not know whether this proposal seems acceptable
> > > > to the NVMe maintainers.
> > > 
> > > You periodically make this suggestion, but there's never a reason
> > > offered to introduce yet another work queue for the driver to
> > > synchronize with at various points. The whole point of making blk-mq
> > > timeout handler in a work queue (it used to be a timer) was so that we
> > > could do blocking actions like this.
> > Hi Keith,
> > 
> > The blk_mq_quiesce_tagset() call from the NVMe timeout handler is
> > unfortunate because it triggers a deadlock with
> > blk_mq_update_tag_set_shared().
> 
> So in this scenario, the driver is modifying a tagset list from two
> queues to one, which causes blk-mq to clear the "shared" flags. The
> remaining one just so happens to have hit a timeout at the same time,
> which runs in a context with an elevated "q_usage_counter". The current
> rule, then, is you can not take the tag_list_lock from any context using
> any queue in the tag list.
> 
> > I proposed to modify the NVMe driver because I think that's a better
> > approach than introducing a new synchronize_rcu() call in the block
> > layer core.
> 
> I'm not interested in introducing rcu synchronize here either. I guess I
> would make it so you can quiesce a tagset from a context that entered
> the queue. So quick shot at that here:

Why sychronize_rcu() is intolerable in this blk_mq_del_queue_tag_set()?
This code is not performance sensitive, right?

Looking at the code again, I _think_ synchronize_rcu() along with 
INIT_LIST_HEAD(&q->tag_set_list) can be deleted. I do not see usecase
where "q" is re-added to a tagset after it is deleted from one.
Also, "q" is freed in blk_free_queue() after end of RCU grace period.

Are there any other concerns with this approach other than
synchronize_rcu()? If not, I will delete it and submit v3.

> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e96bb2462475..20450017b9512 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4262,11 +4262,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   * Caller needs to ensure that we're either frozen/quiesced, or that
>   * the queue isn't live yet.
>   */
> -static void queue_set_hctx_shared(struct request_queue *q, bool shared)
> +static void queue_set_hctx_shared_locked(struct request_queue *q)
>  {
> +	struct blk_mq_tag_set *set = q->tag_set;
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
> +	bool shared;
> +
> +	lockdep_assert_held(&set->tag_list_lock);
>  
> +	shared = set->flags & BLK_MQ_F_TAG_QUEUE_SHARED;
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (shared) {
>  			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> @@ -4277,24 +4282,22 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>  	}
>  }
>  
> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
> -					 bool shared)
> +static void queue_set_hctx_shared(struct request_queue *q)
>  {
> -	struct request_queue *q;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  	unsigned int memflags;
>  
> -	lockdep_assert_held(&set->tag_list_lock);
> -
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -		memflags = blk_mq_freeze_queue(q);
> -		queue_set_hctx_shared(q, shared);
> -		blk_mq_unfreeze_queue(q, memflags);
> -	}
> +	memflags = blk_mq_freeze_queue(q);
> +	mutex_lock(&set->tag_list_lock);
> +	queue_set_hctx_shared_locked(q);
> +	mutex_unlock(&set->tag_list_lock);
> +	blk_mq_unfreeze_queue(q, memflags);
>  }
>  
>  static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *shared = NULL;
>  
>  	mutex_lock(&set->tag_list_lock);
>  	list_del(&q->tag_set_list);
> @@ -4302,15 +4305,25 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		/* just transitioned to unshared */
>  		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>  		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, false);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
>  	}
>  	mutex_unlock(&set->tag_list_lock);
>  	INIT_LIST_HEAD(&q->tag_set_list);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> +	struct request_queue *shared = NULL;
> +
>  	mutex_lock(&set->tag_list_lock);
>  
>  	/*
> @@ -4318,15 +4331,24 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  	 */
>  	if (!list_empty(&set->tag_list) &&
>  	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
>  		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, true);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
> +		else
> +			set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
>  	}
>  	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> -		queue_set_hctx_shared(q, true);
> +		queue_set_hctx_shared_locked(q);
>  	list_add_tail(&q->tag_set_list, &set->tag_list);
>  
>  	mutex_unlock(&set->tag_list_lock);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>  }
>  
>  /* All allocations will be freed in release handler of q->mq_kobj */
> --

__blk_mq_update_nr_hw_queues() freezes the queues while holding
set->tag_list_lock. Can this cause the same deadlock?

