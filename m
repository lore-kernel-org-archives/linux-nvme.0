Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011E606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y7s40bYS;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Gc3PthF0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AmBBAIm3prH8kTpiX53UrfBCPaNJtwirI+Fnb++A7x4=; b=y7s40bYSi4gVHLASF+ywONAtz2
	tqaCkL3vl9WgdXFsRm1+1MV3TSHVpaC+YqkGarEUDpzOk47l492KNH3+aSnDNr9GxLyVl5h6u1ozI
	jThQOLYFgE2DGecxiFAab8HbSZPeneebLZ0MlpPQh4ERXbNQNhHsznNow+UoIh3XgmUYkQECujVgo
	MdBkjSRVorZY7gGheJndAQi3qaTxMu3fnI+GTJe1rHGQvrMKsk7fdTr2TavHO4ovVgVsL6Rkn/BmX
	G6X9Rdf6i8vmRhhWBv8hE7bJAUEGL0KU7NFZIdGC95sW0MozEayzphMlHS9ts9LM30bfmWPyO1DcL
	PZ3JbABQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdn2-0000000CvLT-16uk;
	Wed, 21 Oct 2026 21:24:04 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdmz-0000000CvL2-09e4
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 21:24:02 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-15943c9c005so1420435c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 14:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792617840; x=1793222640; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AmBBAIm3prH8kTpiX53UrfBCPaNJtwirI+Fnb++A7x4=;
        b=Gc3PthF0LI9TA7jqrBXUPy4dtu0TnBMxrhZUQHV3YHYTz1ORazdILPKGvdpJK3QPdr
         llIR8VqdouiO+C1fMfzRpf9onISIeexQih3LJA/Xnw0f34vHNqLBdEAPripZnjENyI7d
         fL8984gzyDhEzOIDFVqc8NT/TWyUe77lP0izHEnwn9HKhQp8Y7C0OHpK6MHsyqF9KaTE
         YzDlNI1PUkrTquVNGxIU+4epjJP1K1rAB7c2bIz6d8CFhvk7TB0LKnGzRK2WUhS1iRil
         y22glr9Xn5GUa4qW2+Hr/G7d16N7p6eXVf2jG5HmCGUDttAoIrJZlJjlL4j3ByEfaJkE
         uYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617840; x=1793222640;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmBBAIm3prH8kTpiX53UrfBCPaNJtwirI+Fnb++A7x4=;
        b=kc9ZK6avHJE0B0Ikgksx33+uE1KVDbtzXNQ0jGG5aROM6y4+oaxicrOi7oRfEmeix/
         0k8eGjSEfa1aJabLk7VpQjycPcBn5qaGTO4SpwWkgmPUGeZSfUHUrw9PYS5t0vNHJydC
         3FDq49RyKJZEZn+0qQurG8V72MUN4DcRCbkzzEMIUWMgGZ+3rclw535haFQAiO4/AyQs
         4v+DfmrUEkwOtY0CD+1q9Hc6dHtcNydTx5oi7PA9T5i0sz7l+7Sy/PRUcUM2Wjs7f2AB
         TKg9wc68Jl4oUWKOJbg958SVQsZ+gI0CJ6ibuo6TMKplTkQBBpyn4YApdxavAsK3ybCH
         2rBA==
X-Forwarded-Encrypted: i=1; AKwUvBwm7aPCFsTWnz2jA1GbQU1IAS64NvCmLeedk3qUUF8ws273Nc7yVBf+sYRS+Nti8mW+V09f95UOJdI9@lists.infradead.org
X-Gm-Message-State: AFq9FYLaYqRIbTcaawYsRhkcI3N6T0/lAz2nlXLVxoo/dDL0DQRorUHY
	V+8/0T6pj+Zt+SPOUTX0/4FoVhYwN238CA6aE9G8XvfHMDcTRdlwRrNpUA7OCAsgQM4=
X-Gm-Gg: AYBFou37nuR+kS9Z/mAznYFT+9q5WHeQl5YUJpzx6DsebZO52WsqsPr5s/8c5AZCkLA
	YkfFjbuX+RKqvo1v4CjTjZr6z8We1YJPaBD+YNb1whgGrhjrcxk+SQi+NLnMZppVc4AhdN2MIyU
	nTTHAub77bpSqhUADw/RAn3IdBqX3EyGiaLWA/4hIyPhQAie2tsH8hbwuCfpxPvlrMcWtWM6W80
	tEYfs9cgZOHVY9biTJxxvfe5RQDm9bLm7HD4/sQAUJqGbhQ4aztnyIwWwQ3+frja49BMtXWK3RF
	80OvQcTxLthZYL9xXmEaztKY9s3xl9lkTf4yQpS4glcBwXAthER9Ak3yKk56RlbmqJGgUHBQ1Ys
	8pZtTIl3G2+ha6JWIRJxzDkHrcF1Jz9CHgrAt1rB7OmXsL4+PrYXGsmWU82NGk45rrhgg/s0RIh
	dDHb+8Zne0P6Och7eEKjmwgRT6tpEqOUHsy5JW4pWd6z0Rya7NHQHh0HZZnf6ePiSvFUkRV6fbt
	WAr2taGOsZ4sItspRYsaCajSVMCEbrBwMaTJXR/F0DytDA+736PyFJIcuMfO4xh+zp5h2vcEtiQ
	Q3LfrLKgTLBekMK3bsWCig==
X-Received: by 2002:a05:7022:5f04:b0:166:4b44:66e9 with SMTP id a92af1059eb24-190a87a48d6mr3690427c88.32.1792617839532;
        Wed, 21 Oct 2026 14:23:59 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903e02901fsm9050248c88.22.2026.10.21.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:23:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:23:57 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <20261021212357.GZ2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_142401_306751_DB47E8FB 
X-CRM114-Status: GOOD (  20.66  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 14:21:59 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:13AM -0700, Mohamed Khalfella wrote:
> >  static void
> > -nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> > +__nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
> >  {
> >  	struct nvmefc_ls_rcv_op *disls = NULL;
> >  	unsigned long flags;
> >  
> > -	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
> > -		return;
> > -
> >  	spin_lock_irqsave(&ctrl->lock, flags);
> >  	set_bit(FCCTRL_TERMIO, &ctrl->flags);
> > -	ctrl->iocnt = 0;
> > +	atomic_set(&ctrl->iocnt, 0);
> >  	spin_unlock_irqrestore(&ctrl->lock, flags);
> >  
> >  	__nvme_fc_abort_outstanding_ios(ctrl, false);
> > @@ -3287,11 +3328,18 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> >  	nvme_fc_abort_aen_ops(ctrl);
> >  
> >  	/* wait for all io that had to be aborted */
> > +	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
> >  	spin_lock_irq(&ctrl->lock);
> > -	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
> >  	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
> >  	spin_unlock_irq(&ctrl->lock);
> >  
> > +	/*
> > +	 * Wait for a started nvme_fc_fcpio_done() to complete before we
> > +	 * proceed with cancelling inflight requests. This guarantees a
> > +	 * request is completed by one of the two codepaths, not both.
> > +	 */
> > +	synchronize_rcu();
> > +
> 
> The synchronize_rcu() protects against nvme_cancel_tagset() racing with
> an fcpio_done() for an op that completed normally and therefore wasn't
> counted in iocnt. Wouldn't it be clearer to make the hold explicit in
> op->state (e.g. FCPOP_STATE_HELD) and only complete held ops in
> nvme_fc_flush_held_requests(), instead of using RCU as a barrier for
> running callbacks?

Adding new FCPOP_STATE_HELD will result in a more invasive change and it
will result in nvme-fc no using nvme_cancel_tagset(). My intent with
this change is to bring nvme-fc closer to other transport and only
cancel inflight requests. synchronize_rcu() is a simpler in this case.

