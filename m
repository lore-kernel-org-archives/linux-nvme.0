Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8B8CCD19A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 03:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YuMDq3EAHV9Hf5tDPdEXp65geuqpRY/9VYhZBt32+nI=; b=BkozG35cZRLa23VTytlzszmcEy
	nC19y0Hh7uPKGUrSq8jn/xRzXd7buw31881ABhuIGJY/p0OcJ3dJVL5p4GZ3xYablF1Noaq1S1JJ0
	lua1cvQKr0TReoZ1J3ySGH3zy0ucyzMat0MF0gdn7Gva/iiEK1g6NOAM8WDvkeIetodnWJLoFLE9v
	zriPuvJdIl9WRsiHZKYO2Ttc5xdObO/upmptySuZj/rdmZAU2TpCBMNLfWJXJ4ncNlOJGcqeimKAJ
	11AEvXSCfMtqhY+k+BxlYu+eYW9TzoNqdX3wl7bZM3O4wPRt0tG7vGm3fd8CEj2ZSnlTtl7XjdYZn
	UcCQyoig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLCdX-0000000HJph-3PAi;
	Tue, 18 Nov 2025 03:44:11 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLCdU-0000000HJpA-3Aj1
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 03:44:10 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-b98a619f020so3841279a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763437448; x=1764042248; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuMDq3EAHV9Hf5tDPdEXp65geuqpRY/9VYhZBt32+nI=;
        b=IKpywryOBLLzKtdklNobfeTlAOfd93UGFpqTjQHolF1fPHYXAqTQu3iQcDfI79tO9w
         UOH9OEU9/8cUkK5vWys4i9Elj04RM1YciheBRhc9x9TCqh5fx0lRsHsHyjF7jaro/0YS
         vjR0WUSkVUxsDoHqRFZZLG3tzWB6drO19JXBm8NoalVTHpmuLNvFItEaqaX9wvpH24Ay
         aItOmiHllOb+YM9xJfoUFjQUtauGTSJPbbNlrUOFHyMPvwHn75KZXFiJVM8/aYcHXDZ3
         hPU7cho1nRjbfnlfZ7D/saPXI35GB3XNcSmP3EPIUabkE4S5bbLxUyL7OvgRy/fFbiNw
         iHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437448; x=1764042248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuMDq3EAHV9Hf5tDPdEXp65geuqpRY/9VYhZBt32+nI=;
        b=Mo1r1p4c03K/XEqLSg/PVjmh1SHNGH16BIlAnytWHtcmPk64GLeviFAKByIks2Nl7T
         ZHMXAS6iGhMvvgxNAKnUNUyRZnFPiqJIFk1cMfsVZkR1avZrDZ1iNl0+8sji10Fbc799
         L32ahAbRbyIGhnvdHnVQQKEey/GVhWY1t4OQRXiy4S0CBdxMrEOr8RXKTn1ohUQD5oFN
         owd1Ceil0J3237C7YhKP9UlQHiHSrbr0qLZYaPiVgc2Ta+03CqjiLQsAc48rnrX+IXpW
         I5/MEF+p6Q/7YxZVBPg65NtE5ZkJQIYEFD7FU6yhBysyaY6g/Ab+hL5QkTVOxBgr1/p5
         W1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoUl1aISsXIixKdbjucorDqvml7q0L6Rrbzts5565OMx6AKLXqUYBJlLzJU9MQhcxqsgJlP7yGPix6@lists.infradead.org
X-Gm-Message-State: AOJu0Yzc5nFYciT3iu5eBEoFhLfVuayr1At4COZQcvMvi+utlRK+TqEC
	Ntc+CwMbBFXDi+www5pCFc8VSUS8IqsKZr6f/Igm0h3Rd2d5/0n6mWpIoPJlPbOP4Ks=
X-Gm-Gg: ASbGnctnwJ1O8Kx9Ij8quP+mpXSVy7ynjCfaIR0aqI7mDcsUWMvD/duiMRTZqTfS6X2
	1Ow3Se2Ob2Swjkiv2BhkQsvKAr+M0VwGy36OBxi0nbJQ0nz01aemhK+By4EWTRXEjIWczGrKiB5
	SBU58vQ6Ef8gSnnvQ7e7Yj3RpDcR0OZpQFgMo4MjMvNPjDjVNRBWqyGDu2j5l7Ud0/S/OScZf6W
	J9GlUKUo0plncvZk4ViH752VziHO5CQuePBbyd9qz2ajJy3/PlFyyVmii/gz2TWKAZ9RmiPIzK6
	RI4E56JF1+AOGl0/jXOTy63yV4Wm0lydB1AABXeCalmbCwx4jgOSV6B2LqBBV2W2tW/EmpWMQLg
	9NryJwVaqSfvpTED0/B0uQvOuBwlkOHVL8boLvIF5dPih8sMCMUfP+3VreqRZ9W1kPPO/TgCA/+
	+fS38bac0uZZLF4Vfo
X-Google-Smtp-Source: AGHT+IFfQz7Ek6tvG3wigeBakizxwVFmYJ3H2HNKhxbtlVrj11hKdPLnYxrjN2OWgodPVTXUuCGF5w==
X-Received: by 2002:a05:7300:e607:b0:2a4:3594:72da with SMTP id 5a478bee46e88-2a4aba9f1a8mr6635089eec.9.1763437447193;
        Mon, 17 Nov 2025 19:44:07 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2a49d9ead79sm69675621eec.1.2025.11.17.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:44:06 -0800 (PST)
Date: Mon, 17 Nov 2025 19:44:05 -0800
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
Message-ID: <20251118034405.GB2376676-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
 <20251118021504.GC2197103-mkhalfella@purestorage.com>
 <aRvaXFA9mG2WDIXA@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvaXFA9mG2WDIXA@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_194408_847031_12AD47F7 
X-CRM114-Status: GOOD (  28.80  )
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

On Tue 2025-11-18 10:30:52 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 06:15:04PM -0800, Mohamed Khalfella wrote:
> > On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> > > On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> > > >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> > > >  				     struct request_queue *q)
> > > >  {
> > > > -	mutex_lock(&set->tag_list_lock);
> > > > +	struct request_queue *firstq;
> > > > +	unsigned int memflags;
> > > >  
> > > > -	/*
> > > > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > > > -	 */
> > > > -	if (!list_empty(&set->tag_list) &&
> > > > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > > > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > -		/* update existing queue */
> > > > -		blk_mq_update_tag_set_shared(set, true);
> > > > -	}
> > > > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > -		queue_set_hctx_shared(q, true);
> > > > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +	down_write(&set->tag_list_rwsem);
> > > > +	if (!list_is_singular(&set->tag_list)) {
> > > > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > +			queue_set_hctx_shared(q, true);
> > > > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +		up_write(&set->tag_list_rwsem);
> > > > +		return;
> > > > +	}
> > > >  
> > > > -	mutex_unlock(&set->tag_list_lock);
> > > > +	/* Transitioning firstq and q to shared. */
> > > > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > +	downgrade_write(&set->tag_list_rwsem);
> > > > +	queue_set_hctx_shared(q, true);
> > > 
> > > queue_set_hctx_shared(q, true) should be moved into write critical area
> > > because this queue has been added to the list.
> > > 
> > 
> > I failed to see why that is the case. What can go wrong by running
> > queue_set_hctx_shared(q, true) after downgrade_write()?
> > 
> > After the semaphore is downgraded we promise not to change the list
> > set->tag_list because now we have read-only access. Marking the "q" as
> > shared should be fine because it is new and we know there will be no
> > users of the queue yet (that is why we skipped freezing it).
>  
> I think it is read/write lock's use practice. The protected data shouldn't be
> written any more when you downgrade to read lock.
> 
> In this case, it may not make a difference, because it is one new queue and
> the other readers don't use the `shared` flag, but still better to do
> correct things from beginning and make code less fragile.
> 

set->tag_list_rwsem protects set->tag_list. It does not protect
hctx->flags. hctx->flags is protected by the context. In the case of "q"
it is new and we are not expecting request allocation. In case of
"firstq" the queue is frozen which makes it safe to update hctx->flags.
I prefer to keep the code as it is unless there is a reason to change
it.

