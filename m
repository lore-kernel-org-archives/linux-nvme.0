Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3231DC369AB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKvupK0kFMuv87h84KnhuI4pxcpKOLxjmuEk9QDadj4=; b=lSU2hIzkt9RgLEN2pKvO/60QVs
	3O9dNM7oJ2c/AYioUXTO5U30c2MRn3h7ph3vdP2E8zsXwl1ic1+2llrDsyLj4ajMyV7BdXLI2Ikk7
	N+a92BJa09YtOjoFjrJPTWDBjKh3VijkCC7GMYwPUHMX63okjcKvCNVIaxWDOH5ZjGKa/m4RlHJxS
	YiogcYuZjOw7nsP8/3xiNxGgmNcJ0FMSvO/L/UCaZA0K2qyaOh0mX6yiRBnU50Vu59mlY5aL48+sn
	2gJ/mf1TJv58qz2wlvBp2H0dpjlItWNbccvkjLhRPlrvwTe9iLyJFxhXJHoy22/0Rboya8Rcx0fJX
	cDuPdwmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qpC-00000007gO6-2LUW;
	Wed, 16 Apr 2025 00:40:22 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qp9-00000007gMg-1u6P
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 00:40:20 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-b074d908e56so2326553a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744764018; x=1745368818; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKvupK0kFMuv87h84KnhuI4pxcpKOLxjmuEk9QDadj4=;
        b=dqWzx/tNK50zGhAATVD5XfHTW3AgF15hNYnCiXoYVmRnl5NRyAg1Pe5vHqb+85HsBe
         7F3vne+h/ynhZ8Q1q8Wt6InqyLZQv76Kw/GZaOhAyDoWiXERU33li0y8vM1RhaMo6gAl
         wUMwTRS87O6KxgsDUr1bmLohKTIf0KKoim/1nUZuWoTU6kxrM7qUYlBJJxGaXi8t5nq5
         ZzykMfITwgwI4QJxpxnavOjQNOsq2asE+FWJrXMblEkj2r4HuhjEHJYW3dllYuPjaMdi
         CP5V0Vr9BWr8MlWF4bWUFwK+RGBb1GkWy3t63sxgmD4YL4Pn9st0OcnJt3NyxA9j5KTX
         g16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744764018; x=1745368818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKvupK0kFMuv87h84KnhuI4pxcpKOLxjmuEk9QDadj4=;
        b=rQsDIWjF/ZdCQqdGuOtV6lrZraYLL0paOt5V7+JyGzBhT8TH7KbSwM5miW7gF1bid0
         18Kyhuss9f5603y1Fpq+HsojpBCW9RGgyUAqi4eDtu46YmLCfDL36rnBDsy2mIiRJEH7
         YN2VV3ES2cB4hS7r4LGSlM5AtMwV5op5Df+2+JzwBS9FTqhOGqOn81hp9vWZooUFvr3U
         QvX51uuhLkPDm6+0EVSm9q8+eQPrYxSPfKZkYcmHw7HttZrRDH2sBlvpphWmuHmUG7Cg
         x8ZLPoRj+aNY589WIvNTpocMijKKelqcm4LO+EyFUksJxFybRBvYwGmU45f6G2qENODn
         1H+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvzsrjH8rbf16cftYuKttWZ8pEtZpe5nePKkOo0B5enLzAKGPiaso7O4QxokgVTVDC8Y2wy9br1L1v@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6ohOY2UNpvxDOfuvYsfmdQ6L8IpI+rsnT/1B+6mR1TiK/VRtF
	XYUBuV3WGJD57G3VF6CZPYkXiFUA028xFEQHavDZLWIcfv2Q5KzUGpiPWxYqIIw=
X-Gm-Gg: ASbGncvv4QFxabV+YrOAgyTOU/H7dqlKiE0IBMumhWBHqxoKaQmLIVx3LP2sFZR44Xz
	2W4i262zO+ByMCqI6HwbuWJ1tmzaDV5Bk+rlelaT7kgsrXlfMat+XkOPtAKZ54IBY0JJWAg+9mf
	WTTDcXTxMyS4yekay54k+feaCXP49CD+AdXY9Tz/lvqQux3Awk9cWt2F79Kos4D8/yEDuVmWtf9
	XVAVVagyzLoWVbG7UiQGgmiRe3Y+GMX2qevP+mTvAmnJNewJ09UQyiIYp7NhT0YA3278GsaB9Ea
	ghXMNzquiT8LxCbLCXoOyhW9MnLp1sqp4Num0zfH6HbweWlOuFX4RuZSZx/czQ==
X-Google-Smtp-Source: AGHT+IEsrlIBzKt6yTxcyg6Hws7JrK8IfsbekYUm7Fhq39aPcW8AFdlZ5Qt88SVUn25nWyBkBOgvMA==
X-Received: by 2002:a17:90b:582e:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-3085eea783cmr1842670a91.3.1744764018287;
        Tue, 15 Apr 2025 17:40:18 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-308613b3719sm275979a91.33.2025.04.15.17.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:40:17 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:40:16 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <20250416004016.GC78596-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_174019_533481_82E73449 
X-CRM114-Status: GOOD (  27.71  )
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
> 
> > - What about requests that do not go through nvme_failover_req(), like
> >   passthrough requests, do we not want to hold these requests until it
> >   is safe for them to be retried?
> 
> Pasthrough commands should fail immediately. Userland is in charge here,
> not the kernel. At least this what should happen here.

I see your point. Unless I am missing something these requests should be
held equally to bio requests from multipath layer. Let us say app
submitted write a request that got canceled immediately, how does the app
know when it is safe to retry the write request?

Holding requests like write until it is safe to be retried is the whole
point of this work, right?

> 
> > - In case of controller reset or delete if nvme_disable_ctrl()
> >   successfully disables the controller, then we do not want to add
> >   canceled requests to failover_list, right? Does this implementation
> >   consider this case?
> 
> Not sure. I've tested a few things but I am pretty sure this RFC is far
> from being complete.

