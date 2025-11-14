Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC77CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 05:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceqWDqvY/FDdzTWcr1CZe6B3SXd28YT0+hfhTO7utYg=; b=kkg4qZDt6kJmAwIUJzAfNDV9Zj
	i79C/0yS2+Aagq6FpRLrIOztmZElPxc3NMYjDdcihlq5M/5D97IRcDQRkPIVg4dLWIZAPlyro5T9D
	jbx8bjbo8dwaAe2qjB6Qc5xjPiY6I5xsbphjH0074ZyaysJbOyffo4KWFsQze4nm7nG/4SeUoXtrY
	TnC/sAlBPoeHGgtnlWE/gEDxEZxHT/eQ+Qn68rBl0o23KhSL6zTjsbSBnDVO5YH4UQmO83O76vx2Y
	Ua3swQokPVCDgiDSB8tdRMjVthRClhBNR5wOVbXPFLIBiUGkylEXtGrq1P4GiNLnHQ7ayBMUOwSpV
	QMqqp9ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmSN-0000000Bb8Y-1WVS;
	Fri, 14 Nov 2025 05:34:47 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmSK-0000000Bb8B-1hrq
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 05:34:45 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso814028a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 21:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763098483; x=1763703283; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ceqWDqvY/FDdzTWcr1CZe6B3SXd28YT0+hfhTO7utYg=;
        b=Y9SlQbnoHQvtxJoumK98jTyLG8c6iY2EXIkYdwGoP+QgjZALKDjsJ0vTphdwXDc7zA
         tcC3KIzudL06XY0E+iQRGjc7RI9ixl21vxYdgfMeTgvsgSnwKkb+LfmXY5cGJTczJWIn
         IiqXdaC0VL+D5OOVHQfCxH3Jw0ROYTnUam6TP0L4Rph03tZ3mL0bxJZG0hf3pU4qhmJu
         pMC2bzYjlnCvhodsZSKqGlLrhaOej1Kn+fSPh7HXMHpAhTogrjHBduMZnQIZkDQS13aE
         RBXFb0R3k0G15flLhqWCLEqnL67sCMB8RK0o3KBin7fsSW3P/loSJqWp5iJks4AsZ18e
         25Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763098483; x=1763703283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceqWDqvY/FDdzTWcr1CZe6B3SXd28YT0+hfhTO7utYg=;
        b=LNF7jOYBEf3Z2yC7ASStGO/bblErb1qRvWkqBQWSAkPNgX9JL68r6DF3SgyOJXtNVq
         1brDQKg9Bkcb7SKQrI09pVdbQmPihY+okSeO8TrrjiwSgPBpDsP2Cqj+CBSFNiEvIpkw
         /0ScGF5048stq09qHKv92LUg2+5HL28UrT5s+AUhp//YIbuaxIRyiil8Nq+mY88SQ8n6
         XptPrdpAUyp2qGZrNZnE/2/a+7ZsStcmtkX5Sl3i1Pc94kUWQC8fmkfV3waeH8KYsSJk
         Isz91U0OFkRh+icqWMhZmM0CCIlkVzR07/VOs5ufnVBuiBeZOn3aIgz1YjSxNntbYrfA
         b4hw==
X-Forwarded-Encrypted: i=1; AJvYcCVOmYHv/FhUux9PH6lYg3LNEUDL281yw18KnTBku2NBTI454EVAf5MNsJIsNdADCcq4FGhjx+oZg6T6@lists.infradead.org
X-Gm-Message-State: AOJu0YziI//7FcJkJGFvpOnLTIhso6hNj1q7gvv1hrLnCifiOw7Gq/9m
	N/eGwI8Zn2iXCts8mNA8L1FTyS6NHc5GIuoma0LhFrT5/L/wtY5jY8v63U0uXDMvJU5Pg6dM46F
	5Rtd1kak=
X-Gm-Gg: ASbGnctRPpvefmV+lq6/t0iUHAYE/v97WR/l9pYYr0B6h76SoMdXrTHJFFk3VXHjZ8H
	mkVBmyw4jOuPGoR+tOJbIa0VQO0+NTu4xdMzw/8B2U+yaIq5xn1GytNtgxdO1K9lfntE94dzjwp
	8jJT1eI4SEjLOEU2bpqKViHof/BcB2nhk5H03nIfDubzLtYU7VQQYsuRlwqv5I/1wXr7a6dJBii
	3W3V2Em5TfOzdozvBTutz8v42TgooB1OpOoE4sjUuW2/VgBzF43hZom+p2JmjvFpBrPKgxQqn3U
	2Eo/pAZycroSHipMENZiP8uBncOGrVx+ex2VktO6d821AfypXpFPXDw9RYOWwYosf2hBUqD2CBJ
	Cg68l1qMFkdSSp7Owl6dGfW3AwZ4Ewqj/9GwPmR1GWjW9wnqbJWj4WmYIf1eF4TDauxzSiZL6jl
	lWW1xIpbGTytDGJMMkX9/2cpPyP40=
X-Google-Smtp-Source: AGHT+IGIgnw7CDjq0fpnsLtUjTEZ73eF0bdJWF2fyLL7lw2+x9X+bKjReBfIZfCnd2FsYgdRnHLNnA==
X-Received: by 2002:a05:7022:62aa:b0:11a:72c6:22df with SMTP id a92af1059eb24-11b40e79761mr624220c88.4.1763098483110;
        Thu, 13 Nov 2025 21:34:43 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b060885c0sm6352228c88.3.2025.11.13.21.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:34:42 -0800 (PST)
Date: Thu, 13 Nov 2025 21:34:41 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <20251114053441.GA2037010-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <e629ec9c-9f25-48b3-8fb4-1c94cf83604b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e629ec9c-9f25-48b3-8fb4-1c94cf83604b@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_213444_493102_5D6603F3 
X-CRM114-Status: GOOD (  44.59  )
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

On Fri 2025-11-14 04:56:52 +0000, Chaitanya Kulkarni wrote:
> On 11/13/25 12:23, Mohamed Khalfella wrote:
> > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > tagset, the functions make sure that tagset and queues are marked as
> > shared when two or more queues are attached to the same tagset.
> > Initially a tagset starts as unshared and when the number of added
> > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > with all the queues attached to it. When the number of attached queues
> > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > the remaining queues as unshared.
> >
> > Both functions need to freeze current queues in tagset before setting on
> > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > hold set->tag_list_lock mutex, which makes sense as we do not want
> > queues to be added or deleted in the process. This used to work fine
> > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > made the nvme driver quiesce tagset instead of quiscing individual
> > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > set->tag_list while holding set->tag_list_lock also.
> >
> > This results in deadlock between two threads with these stacktraces:
> >
> [...]
> 
> >
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> >
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> >
> > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > semaphore for read since this is enough to guarantee no queues will be
> > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > semaphore for write while updating set->tag_list and downgrade it to
> > read while freezing the queues. It should be safe to update set->flags
> > and hctx->flags while holding the semaphore for read since the queues
> > are already frozen.
> >
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> I think there is no better way to solve this in to nvme code ?

I can not think of way to fix this issue within nvme code.

> 
> will it have any impact on existing users, if any, that are relying
> on current mutex based implementation ?
> 

I audited the codepaths that use the mutex to the best of my knowledge.
I think this change should not have impact on existing code that uses
the mutex.

> BTW, thanks for reporting this and providing a patch.
> 

No problem.

> > ---
> >   block/blk-mq-sysfs.c   | 10 +++----
> >   block/blk-mq.c         | 63 ++++++++++++++++++++++--------------------
> >   include/linux/blk-mq.h |  4 +--
> >   3 files changed, 40 insertions(+), 37 deletions(-)
> >
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index 58ec293373c6..f474781654fb 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
> >   
> >   	kobject_uevent(q->mq_kobj, KOBJ_ADD);
> >   
> > -	mutex_lock(&q->tag_set->tag_list_lock);
> > +	down_read(&q->tag_set->tag_list_rwsem);
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> >   		ret = blk_mq_register_hctx(hctx);
> >   		if (ret)
> >   			goto out_unreg;
> >   	}
> > -	mutex_unlock(&q->tag_set->tag_list_lock);
> > +	up_read(&q->tag_set->tag_list_rwsem);
> >   	return 0;
> >   
> 
> [...]
> 
> >   static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> >   				     struct request_queue *q)
> >   {
> > -	mutex_lock(&set->tag_list_lock);
> > +	down_write(&set->tag_list_rwsem);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > +			queue_set_hctx_shared(q, true);
> > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > +		up_write(&set->tag_list_rwsem);
> > +		return;
> > +	}
> >   
> > -	/*
> > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > -	 */
> > -	if (!list_empty(&set->tag_list) &&
> > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > -		/* update existing queue */
> > -		blk_mq_update_tag_set_shared(set, true);
> > -	}
> > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > -		queue_set_hctx_shared(q, true);
> > +	/* Transitioning to shared. */
> > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> >   	list_add_tail(&q->tag_set_list, &set->tag_list);
> > -
> > -	mutex_unlock(&set->tag_list_lock);
> > +	downgrade_write(&set->tag_list_rwsem);
> 
> do we need a comment here what to expect since downgrade_write() is
> not as common as mutex_unlock()|down_write() before merging the
> patch ?
> 

	/*
	 * Downgrade the semaphore before freezing the queues to avoid
	 * deadlock with a thread trying to quiesce the tagset before
	 * completing requests.
	 */

Yes, this could use some explanation. How about the three lines above?

> -ck
> 
> 

