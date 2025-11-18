Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC555CE8D6B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 02:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jGMa27cxj+L83AG/Ch3KZQsv3/A1P3JcCisXJsT+KB0=; b=M+Q2CcAFJf1gulal3ADyOMCpa+
	Ssv5TjriAV8cg1gYoLOP8GqXe21OxwXFF815lGa/vrc6g5s1uyk7JwgsOCpY3NXFBaPciSLT3lUpJ
	+MamEZQsPypUHiBwI4e/xs5zFhYNU6adb9mIFCwFEvmk17Tkd/VLXTK9zrZzS3GUahG7kTueuV5R1
	kR+q7yb04QEljWze1IuBqU/yCkjbK+cyffPe5rGvm0x7jkIclwRyBcpfnBvNueoxLPaeRS7l17AAk
	iczGBjvv79+6URJG7M0bEbJQrxtn4QTKzEhET3LLhBgSeHwqok/J8SHc4/re1Fs01yFT0hLH7xMDK
	XyzpbOEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBFR-0000000HD4t-1ioG;
	Tue, 18 Nov 2025 02:15:13 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBFO-0000000HD4I-2VNP
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 02:15:12 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so7482191a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763432109; x=1764036909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGMa27cxj+L83AG/Ch3KZQsv3/A1P3JcCisXJsT+KB0=;
        b=Y0UzPiQ1dUv4Yte82kPJdf9Z+HSqtjVJFMr5fI4zIjYQWMkhWP8bJ6TquL51l/Xx7f
         TXOB5ceYZDBQDEr4rrKaW8liYQf3BC+4vKewCdKw8JEMkHc8CTVhGZj2ETUakl8zEC1d
         L7v+CVMu5goa0ErLQsndGws5qa18c+jl4tDqnFo1bx6gjSQFuCfpkUbpuUqziEySssbR
         MHY1oINPxSz8RDB6y2KWxlZzcElkIKBeKyZUC2a/L+Smwi3v4rR1qixc1jSYRCbxeO7g
         SoNPJSCE3yDFWPCw0qYv/hbxZAuuOcAGPw7r79jwiBa+wikb23FjZjo6dNkcuxHkQLZm
         /Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432109; x=1764036909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGMa27cxj+L83AG/Ch3KZQsv3/A1P3JcCisXJsT+KB0=;
        b=cBz37+jg7mPpXWU4/68EYUQP/AGy9xVFlUuhOCcHjbl8hAQUgVjF/gg7BpZQ8GaJmH
         vDZ13OQWgmCl2l4L2ikLVwwnbQjROR7wUJmi4zqTt9ct/Trklfy2rgtN5vfXGdv1Dhmt
         y/0JSiOdRxHY77mfsJAJhiY7+dIIhTJq90XZbWIX/iPPmr39ALhVBSKInA6NnQJPCrXp
         gQJPT+jVoI4gb+oqhehf/RidhrKZh6eWNVgRyH4Z0831Cs8UFC5egtMZBl9AXpY5Qtuo
         YkzP210t4eWn2l2T6IXKTosE/0wJuMgqJW8raR/haChWDFUicYGMGPy020PbPzzCdS92
         GC2g==
X-Forwarded-Encrypted: i=1; AJvYcCW+o7gJG99bHgFVBq0iFrhuSmsCXA17BBM2dCmIStDw2r3APMh9NH2eK5JIOd8YS70TceeUMI08Qnoo@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7qohnlW2HcecB33wKyc1eAKiJjN6W4qdOXayMAvZ8pFattRzi
	IXw1sY4VBMUhncx3lUpx1V/vNQoeazI0w24qlsnFSOB+KFCyu/lBeucSf2W1Ti/i33g=
X-Gm-Gg: ASbGncv8w1O/sB3D4WRoJhUqsyevd4OyvXz2IFxCGjEECJbEe5hFogziQ+tSFpcL4ah
	jkuClyAVwW3xU6ExLbjl5/fUeklK8CGjl9evZtLRH+fYKRcL81AG8bY6c+agN9DxkXBZaloJOvq
	baaIuYrhd/ZL7+oR8iUbj4aqnscVXBh2JSUk7YcJRgkXEh7oLx214SIPKbchSPdSELvWVm1uS9X
	TIpOwChfwtPVNEU7KFE4Xt3559ID+nmWXPoSX/hfsCtxmwk54QhlalOM1XCWV99fqMgm9ZCHM9Z
	BMtn79FTL9MBbLlnktcvT9cnQlJ5XIrC1bSkiWmycpYDPHrbfWNBEEQsCEYhcb3JBZlnJy6jvko
	Tvv22pm2AAIJ9WYR84Var9modNDmM3q4GnmyLxRPM5/Qmhq2Q2scHcN3olJLI+xcA+V2vX+DsO7
	Ff6O2BYw15ne5LPLHy2yyPrB/sEnnzMZ2VB9Lx9UhbDA==
X-Google-Smtp-Source: AGHT+IEhsxRqYMWn9WCaeLlWRezRAzHORagLlYnSMXZULZHeBeD6LLRB1gCGYfGzQ1H6NKdpdLyKDA==
X-Received: by 2002:a05:6402:5112:b0:640:a356:e797 with SMTP id 4fb4d7f45d1cf-64350e2092amr12555421a12.13.1763432108722;
        Mon, 17 Nov 2025 18:15:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a4ce83dsm11546963a12.34.2025.11.17.18.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:15:08 -0800 (PST)
Date: Mon, 17 Nov 2025 18:15:04 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
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
Message-ID: <20251118021504.GC2197103-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvTM5LbnehQU77-@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_181510_654124_FC82376C 
X-CRM114-Status: GOOD (  19.90  )
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

On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> >  				     struct request_queue *q)
> >  {
> > -	mutex_lock(&set->tag_list_lock);
> > +	struct request_queue *firstq;
> > +	unsigned int memflags;
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
> > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > +	down_write(&set->tag_list_rwsem);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > +			queue_set_hctx_shared(q, true);
> > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > +		up_write(&set->tag_list_rwsem);
> > +		return;
> > +	}
> >  
> > -	mutex_unlock(&set->tag_list_lock);
> > +	/* Transitioning firstq and q to shared. */
> > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > +	downgrade_write(&set->tag_list_rwsem);
> > +	queue_set_hctx_shared(q, true);
> 
> queue_set_hctx_shared(q, true) should be moved into write critical area
> because this queue has been added to the list.
> 

I failed to see why that is the case. What can go wrong by running
queue_set_hctx_shared(q, true) after downgrade_write()?

After the semaphore is downgraded we promise not to change the list
set->tag_list because now we have read-only access. Marking the "q" as
shared should be fine because it is new and we know there will be no
users of the queue yet (that is why we skipped freezing it).

