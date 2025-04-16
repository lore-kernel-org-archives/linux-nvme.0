Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84143C369AB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 00:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfGcDf/DpbkHEBsh/Vn4tDO8cN+GHpaQalPKB5/PXdU=; b=jX2/u3QV7O+qgVELtq0mfLcKTB
	h0qVOs5wk6D0Y/SzlCjBbro9LP0FEcAsE3iwADN/4wKDT5IVsUEws+9EOTRZjrr/9wAwhFA10iZWa
	y74krw6UeFpVQQI1Tcdj2rLh4gVSMq5E5o88u9Okl35curVABDjxJFYEymQU+MYkg9K6Bt8BkjlA9
	5QQhCrTJoz3KP+y0fqEkqmBZbw4aHfNs3Hj6qbJwLPk0uEJHO/DNraKLMX6ERrcBfkZG2inoeg4o6
	D4ZFVW8crmwPri+wX2BWrrEix8e2gRABjpP1HKgJBHdiBKyOVcENKBV6LmtLpTowPFMO2+lQgMWbL
	Z2B1O3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qTI-00000007cc1-1gyj;
	Wed, 16 Apr 2025 00:17:44 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qTG-00000007caQ-0bvc
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 00:17:43 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso6079487b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744762661; x=1745367461; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfGcDf/DpbkHEBsh/Vn4tDO8cN+GHpaQalPKB5/PXdU=;
        b=Z/ThDZRRyKV7cVWc3A3NqkxT8q8/zxFYeeulBW8YoD0il2KGFRONukaCT0M8eeN5Cp
         B3Z545wSSUI0qCyeBbpxQ5bkKSbvn0rxI//zRABphoogAkXY6kjxj5pJjNNjubvNVzBW
         lEPPNMgt5rSing+9Yfh1rD2Pd70T7Qxkjk3oUieO+Q5euzz0p8e6Kb6Gemfck8y+5J8U
         Z9M0t+9zAxz272jneDz+mC2irz7QMA2eejgXsbKFDxaSDE0ryENr4m74zjDLcMWNVFTa
         +Q+iinLtCthDbIlcq4XT21hQIGB56qCu15reHEguwMX0KkX4s3GIOTpxHe5igNQqs3k0
         VHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744762661; x=1745367461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfGcDf/DpbkHEBsh/Vn4tDO8cN+GHpaQalPKB5/PXdU=;
        b=MbtS8aztXdhxv9CkUe6LaSlRHcrwY5uPR0ctTom+KxjCsUskK8GtTXnU06j3DZVcY7
         h+wBtXO3g/YO5ouB/4ry8NNjZ5gmOvgjw+EwID9QQKZl3PELsNbqH8iGT61cbZqybfiN
         1vCmD8lUfNbCcMpY92hppKEYNWiGjRS8Cbz4Ougm7SBy63ZlyGGKBzxBGL3RFP5BlLGY
         UL94EXcrCY9c/k2EhEVhFTPDrX9O/8rVy3VOI8vOqFdTQYvAe1X04kBCYFLPY4lPAlEW
         Ao2FNoCV7225rHw8JF59yTeXDtoTvA6esWsMXtAn1mDIHyciFf1ZzSagoJzCLQtFpWGd
         Upkw==
X-Forwarded-Encrypted: i=1; AJvYcCV8NUomxlnRook0QYeiqY5d2/giEdK3B0Cz3J+9PRUuB6NzurWBklRHAYAgGzecji+o88uekwBZDwoi@lists.infradead.org
X-Gm-Message-State: AOJu0YydECXJq7vcXs3wbuyGrHwRc6Ja8cztAFob62pcZPbGdam6mcXU
	5RkdWocvhS2qz9Wb1lD4sI/uF4Nq6x8uIOKut0s5Bh7vXvhJoa/aUkVbN/x0H+k=
X-Gm-Gg: ASbGncvFK2zEnG0KhxH7CzC9/SFA/ivujk4+AftEfLtkrFJfQ/iyUm36hOuuBqdwsNk
	48RwQlD/mf42P8UKdzh3Mul3x1Osg2EVhtx0lkA2m4MCr/DZAct6sQ3lntgdghPYJE1uD0XYCUM
	Wzl991V5ST5E7HOof9/arAWgmKC3SfUOZHU9kaenJ/wWKZIhKlgXSJXgNYjn3mfdSih3DsDCEKo
	CzxHgvtsgIQBva7N1jbDRn/jE+AYVDtgO/g/yWi4u6HAeZDS18kdpUSAWmOyQ1SKz92N/PFntxE
	N3FaRWLX3/cR4M5Xs1yQqHavVfG/qZWxuGUxLsoAbjulR0R3ZMYI5XQ3CufvNyCZ4pQawtV8
X-Google-Smtp-Source: AGHT+IEsZXbFUEWjm9tj/ceIf10A86DIbq4BRB2RJvH84hKcWqXJ5FZPGOYNVb6N98kev1z48eVeoQ==
X-Received: by 2002:a05:6a00:1311:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73c1fb3c5b0mr1924502b3a.20.1744762660755;
        Tue, 15 Apr 2025 17:17:40 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd21e14e9sm9157334b3a.77.2025.04.15.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:17:40 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:17:38 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416001738.GA78596-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_171742_189276_04538BD1 
X-CRM114-Status: GOOD (  27.35  )
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

On 2025-04-15 14:17:48 +0200, Daniel Wagner wrote:
> On Thu, Apr 10, 2025 at 01:51:37AM -0700, Mohamed Khalfella wrote:
> > > +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> > > +{
> > > +	unsigned long delay;
> > > +
> > > +	if (ctrl->cqt)
> > > +		delay = msecs_to_jiffies(ctrl->cqt);
> > > +	else
> > > +		delay = ctrl->kato * HZ;
> > 
> > I thought that delay = m * ctrl->kato + ctrl->cqt
> > where m = ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> > no?
> 
> The failover schedule delay is the additional amount of time we have to
> wait for the target to cleanup (CQT). If the CTQ is not valid I thought
> the spec said to wait for a KATO. Possible I got that wrong.
> 
> The factor 3 or 2 is relavant for the timeout value for the KATO command
> we schedule. The failover schedule timeout is ontop of the command
> timeout value.
> 
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
> > >  void nvme_failover_req(struct request *req)
> > >  {
> > >  	struct nvme_ns *ns = req->q->queuedata;
> > > +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> > >  	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
> > >  	unsigned long flags;
> > >  	struct bio *bio;
> > > +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> > >  
> > >  	nvme_mpath_clear_current_path(ns);
> > >  
> > > @@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
> > >  	blk_steal_bios(&ns->head->requeue_list, req);
> > >  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> > >  
> > > -	nvme_req(req)->status = 0;
> > > -	nvme_end_req(req);
> > > -	kblockd_schedule_work(&ns->head->requeue_work);
> > > +	spin_lock_irqsave(&ctrl->lock, flags);
> > > +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> > > +	spin_unlock_irqrestore(&ctrl->lock, flags);
> > 
> > I see this is the only place where held requests are added to
> > failover_list.
> > 
> > - Will this hold admin requests in failover_list?
> 
> Yes.

Help me see this:

- nvme_failover_req() is the only place reqs are added to failover_list.
- nvme_decide_disposition() returns FAILOVER only if req has REQ_NVME_MPATH set.

How/where do admin requests get REQ_NVME_MPATH set?

> 
> > - What about requests that do not go through nvme_failover_req(), like
> >   passthrough requests, do we not want to hold these requests until it
> >   is safe for them to be retried?
> 
> Pasthrough commands should fail immediately. Userland is in charge here,
> not the kernel. At least this what should happen here.
> 
> > - In case of controller reset or delete if nvme_disable_ctrl()
> >   successfully disables the controller, then we do not want to add
> >   canceled requests to failover_list, right? Does this implementation
> >   consider this case?
> 
> Not sure. I've tested a few things but I am pretty sure this RFC is far
> from being complete.

I think it does not, and maybe it should honor this. Otherwise every
controller reset/delete will end up holding requests unnecessarily.

