Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724DDCCD19A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 04:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+za5bpe7k71RSNz1ZZSlS9cG3UfbTIZDcQkUGjZWi8g=; b=pvkkVchoZms2PmgyAuEwqBGcfd
	XL7tZAqMko/CIxaghwyZGey41hcxGiZUp9Zc1leoBVQ+dJMUVF7fPrdzeNLVpbk6X/WtRUOGkWNPo
	+vD6nl+2KtloNSNg9IyyocqP6y5o0V1TkX6ln70uuVL43nxEwlzEvv/1LogQCxnKU82nZd3Ox04WR
	BGYgsmFbhznGVNzMV16+hzmGrBF6Dj3/nEHM7nYp9d+ZbSeauj6Y9QDJAF3DrA4Q2QXasZMIMkaZI
	DmPTszYq7+SZTGVh+rhvqFvv09lJkGfhMERf4KN0UkAjMTrsx5lfNCSP1CPiYrQU8bqdwQcnuwH4b
	6t2AUmRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLD8s-0000000HM1p-1Gue;
	Tue, 18 Nov 2025 04:16:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLD8o-0000000HM1S-2PJc
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 04:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763439389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+za5bpe7k71RSNz1ZZSlS9cG3UfbTIZDcQkUGjZWi8g=;
	b=H/vd0BCy+MS8tRW1w9ckmM7Laz2JfU14Q1dUSDrZ+Jd00lclu8YiGd1PSbRLpq/+CyYnRJ
	aDu8ergI3WX9Dm4JF11pfQgWsXSfhT7D5q6ZL50oJebpVFCFckAwozsZM1WWuNOPZq+twS
	CPwm/swxNu4U8MWAfA1KXxECogicDFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-_WonIOKVOMGBMmOshQOHGQ-1; Mon,
 17 Nov 2025 23:16:25 -0500
X-MC-Unique: _WonIOKVOMGBMmOshQOHGQ-1
X-Mimecast-MFC-AGG-ID: _WonIOKVOMGBMmOshQOHGQ_1763439383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 549C1180028A;
	Tue, 18 Nov 2025 04:16:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.204])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30611800451;
	Tue, 18 Nov 2025 04:16:15 +0000 (UTC)
Date: Tue, 18 Nov 2025 12:16:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <aRvzCs_FXa_liTWv@fedora>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
 <20251118021504.GC2197103-mkhalfella@purestorage.com>
 <aRvaXFA9mG2WDIXA@fedora>
 <20251118034405.GB2376676-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118034405.GB2376676-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_201631_033737_96271C58 
X-CRM114-Status: GOOD (  30.12  )
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

On Mon, Nov 17, 2025 at 07:44:05PM -0800, Mohamed Khalfella wrote:
> On Tue 2025-11-18 10:30:52 +0800, Ming Lei wrote:
> > On Mon, Nov 17, 2025 at 06:15:04PM -0800, Mohamed Khalfella wrote:
> > > On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> > > > On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> > > > >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> > > > >  				     struct request_queue *q)
> > > > >  {
> > > > > -	mutex_lock(&set->tag_list_lock);
> > > > > +	struct request_queue *firstq;
> > > > > +	unsigned int memflags;
> > > > >  
> > > > > -	/*
> > > > > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > > > > -	 */
> > > > > -	if (!list_empty(&set->tag_list) &&
> > > > > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > > > > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > -		/* update existing queue */
> > > > > -		blk_mq_update_tag_set_shared(set, true);
> > > > > -	}
> > > > > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > > -		queue_set_hctx_shared(q, true);
> > > > > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +	down_write(&set->tag_list_rwsem);
> > > > > +	if (!list_is_singular(&set->tag_list)) {
> > > > > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > > +			queue_set_hctx_shared(q, true);
> > > > > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +		up_write(&set->tag_list_rwsem);
> > > > > +		return;
> > > > > +	}
> > > > >  
> > > > > -	mutex_unlock(&set->tag_list_lock);
> > > > > +	/* Transitioning firstq and q to shared. */
> > > > > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +	downgrade_write(&set->tag_list_rwsem);
> > > > > +	queue_set_hctx_shared(q, true);
> > > > 
> > > > queue_set_hctx_shared(q, true) should be moved into write critical area
> > > > because this queue has been added to the list.
> > > > 
> > > 
> > > I failed to see why that is the case. What can go wrong by running
> > > queue_set_hctx_shared(q, true) after downgrade_write()?
> > > 
> > > After the semaphore is downgraded we promise not to change the list
> > > set->tag_list because now we have read-only access. Marking the "q" as
> > > shared should be fine because it is new and we know there will be no
> > > users of the queue yet (that is why we skipped freezing it).
> >  
> > I think it is read/write lock's use practice. The protected data shouldn't be
> > written any more when you downgrade to read lock.
> > 
> > In this case, it may not make a difference, because it is one new queue and
> > the other readers don't use the `shared` flag, but still better to do
> > correct things from beginning and make code less fragile.
> > 
> 
> set->tag_list_rwsem protects set->tag_list. It does not protect
> hctx->flags. hctx->flags is protected by the context. In the case of "q"
> it is new and we are not expecting request allocation. In case of
> "firstq" the queue is frozen which makes it safe to update hctx->flags.
> I prefer to keep the code as it is unless there is a reason to change
> it.

Fair enough, given it is done for `firstrq`.


Thanks, 
Ming


