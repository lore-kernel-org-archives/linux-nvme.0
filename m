Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632F606A326
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LRRol6ST;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=JeU+DmJM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0CbKdMAQ3nfycPreHgu2fI9LHIGPNt84yRSgRWibZ00=; b=LRRol6STmHGYxSsSNJgPrIqjaB
	uEmUEcINF8bPpy2WYiL8QxPaqz9nPqBxWXwG/DEOn3T8lxPTA8TSY3LxB2vsKkM06SQfmrvyqdLtC
	BpWk3ZzYnZ6KkRLpVpnkYDxaUNv2PWJN450cYhD64ucyB94Nf4/buPEmNNB9wIlI1z0GCS5mQp3Am
	V5E3K2Tzw1q31Zt/FbYNwNWF0rqEhI8nxJzJJHKcoTp7rYeMDvLqRFi4sfkF9epof/NFTJc6yjHVL
	/w5b/1zo8AMS2QGX9gDwfti7rETTmRo9nCV0FzBuSyOnOW/lrNJ319vpKwv7vi6/pgW+WhprGBf1V
	gIdiKc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJVS-00000003T3o-3shC;
	Tue, 03 Nov 2026 18:45:14 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJVQ-00000003T36-0nup
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 18:45:14 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-170135e43c7so2923888c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 10:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793731511; x=1794336311; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CbKdMAQ3nfycPreHgu2fI9LHIGPNt84yRSgRWibZ00=;
        b=JeU+DmJM7jSr5d4ORXE/XMKqnnn6/bpyR5deribNd3OtrdJaYfu1XQ8D1/HHRRc85q
         r8We4NktN7iIQ3/MGOP8MGqR1Eqvl1TPBwmRKh6ocBfgsTsGu/YtwFPUq/18T6DJB3hx
         72hSZ82T9GiAKMDLLUzf2wYR5uuKCW+hFCaeP0HShOubUUNTe/KEuiJ+UfX0jU7e1RwP
         sZFJ1Sq0a1eE3wABklvG8O+SynRpHzzal+NSmf42ZMrVglBg2XPe2dIMDmta+TcSpWlZ
         PMXW7DOV5wupaW+Y04bdkiDUZJ+Y43MdsC9HeDUxjNffF2aIr9QPnDVysV6+UGUEbjog
         NTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731511; x=1794336311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CbKdMAQ3nfycPreHgu2fI9LHIGPNt84yRSgRWibZ00=;
        b=GcQ/4D2ys9lbS9j0IW+2iLrbe74ZbOmZhM+aGfQWnfCHF0DEKo1bwiBY4hWy0B+OvQ
         TY/cFXhXDCUw2kNJa8zQy4UFIYG7leDmzlkgha9uw179AzsA3LRftcEEgnN3lxadHssY
         TU6pZERmK2B7Ql0pkjgcTuZNPAAHsPqbkmidAgNdFwlaw6QdN9lN0RwiKOXPIfa41a1F
         8dOqjEzC4/ewrjcNi/IQvk7K1JiAr76Ux9JuJXm+ESOMHL5IGQgYjvfwwaFzrn8xD0JB
         9lCB8TbCHBZcdsQ9jPQusE6ZS8PvSVH8GY9wzcixVhr/+cireJqn/Pqfesvwb0stKNhm
         Aa3w==
X-Forwarded-Encrypted: i=1; AKwUvByhGpmg/kB+jUXyl1+JklSonXcsS1p1WIhaX4HqLH+VmOoY30w7xgfuWyU3Uk4HRGWsyD7CXYUkbw1w@lists.infradead.org
X-Gm-Message-State: APuU4Z+qFOB6wjPWjUoaAvXNK4ZJVl22pSTY2wx713e989XVxj8n+jDo
	SmTlO0XTq7OfLGBb3UINYJxI6/jreZoAV/Xv/SttHiCKTcB07gTlih+yIFJ45IrVc5k=
X-Gm-Gg: AYBFou17wry1LYEYXYqc7T5it4bVJEkk3BJyhGbcSx52cSM6J+RsXjDshlZddftosJy
	PTKSvzegaBoLSgL6Ztl7+Dj/UeojcxkC/LktUwgEcCNBGmpskqceQsGBOWX+PAPhUSYD6wHNNeZ
	3IV+yPmBMLB7swdAt1+LYH4M/3ubnd+EN/jXsPw9dRXTpT8onixob708/5I2U2SSUdTfNrkk0Lh
	NheQIPhaXgaDOdbp7uc/v8TV972ysl/yO4gbRu8tcLLRUikHM8QZZsKCtOEyfZFP+j+bZtclrOw
	RK9nsdS2RjQ2e0+uuHcQCPw1dKaoS2AgOkV0v3rMGJZN0yPdpSWVwOhyf8HiSF5iiOXPhssW49g
	8Ysj3QH0AGl34cKuyyxd5jxWtFiSPx8biCsZB7whK+JfcQsQhhfJn05saPy4WmS2aEEIF3It9qB
	vawXEiTJ63F3TK+iAZtl06/UL3bYqJI7K0staJ2y8vJBEISYhDAVd452Bo4O+bS9QL5mfUnbUDS
	EHqk0iytS3I+25uSlNIR7dX84YAdVECkR+XVWt4G1421TWRpq22QNKCiD8H5HYDESsWR99joD7K
	wrw4uq71SBZMsrzC/GvRRhy/H8P1QYqe7WDtlY7qYyplR7YJ
X-Received: by 2002:a05:7022:e807:b0:1b2:4188:840b with SMTP id a92af1059eb24-1b2418884a4mr3350184c88.25.1793731510547;
        Tue, 03 Nov 2026 10:45:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b245c772fdsm748585c88.22.2026.11.03.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:45:09 -0800 (PST)
Date: Tue, 3 Nov 2026 10:45:07 -0800
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
Message-ID: <20261103184507.GA5019-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
 <20261021212357.GZ2931-mkhalfella@purestorage.com>
 <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
 <20261103011851.GK122209-mkhalfella@purestorage.com>
 <80b5302d-1bcb-45d3-b926-0874470ee183@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b5302d-1bcb-45d3-b926-0874470ee183@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_104512_415672_22341F1B 
X-CRM114-Status: GOOD (  24.74  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-11-03 11:51:28 +0100, Daniel Wagner wrote:
> On Mon, Nov 02, 2026 at 05:18:51PM -0800, Mohamed Khalfella wrote:
> > -/* Complete the requests held in __nvme_fc_teardown_association() */
> > +static bool
> > +nvme_fc_cancel_held_request(struct request *req, void *data)
> > +{
> > +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> > +	struct nvme_ctrl *ctrl = data;
> > +
> > +	/*
> > +	 * A single cmpxchg decides who completes this request. If the op is
> > +	 * HELD, nvme_fc_fcpio_done() is done with it and we cancel it. If it
> > +	 * is still COMPLETE, nvme_fc_fcpio_done() has not decided yet: move
> > +	 * it to IDLE so its own cmpxchg to HELD fails and it completes the
> > +	 * request itself (nvme_fc_complete_rq() sets IDLE anyway). Doing this
> > +	 * as read-then-cmpxchg would let the op become HELD in between and
> > +	 * leave it with no one to complete it.
> > +	 */
> > +	if (atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
> > +			   FCPOP_STATE_IDLE) == FCPOP_STATE_HELD)
> > +		nvme_cancel_request(req, ctrl);
> > +
> > +	return true;
> > +}
> > +
> >  static void
> > -nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl)
> > +nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
> >  {
> > -	nvme_cancel_tagset(&ctrl->ctrl);
> > -	nvme_cancel_admin_tagset(&ctrl->ctrl);
> > +	if (set) {
> 
> Do we call flush when we don't have a set?

Yes, that is possible in case the controller fail first connect attempt
before the IO tagset is created. Commit ee38469f8849 ("nvme-fc: Do not
cancel requests in io target before it is initialized") added similar
check to __nvme_fc_abort_outstanding_ios() to close this gap.

> 
> nitpick: use the early return pattern if needed.

Done.

> 
> > +		blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
> > +		blk_mq_tagset_wait_completed_request(set);
> > +	}
> > +}
> > +
> > +/* Complete the requests nvme_fc_fcpio_done() held during the fence */
> > +static void
> > +nvme_fc_flush_held_requests(struct nvme_fc_ctrl *fc_ctrl)
> > +{
> > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > +
> > +	nvme_fc_cancel_held_requests(ctrl, ctrl->tagset);
> > +	nvme_fc_cancel_held_requests(ctrl, ctrl->admin_tagset);
> >  
> >  	/* re-enable the admin_q so anything new can fast fail */
> > -	nvme_unquiesce_admin_queue(&ctrl->ctrl);
> > +	nvme_unquiesce_admin_queue(ctrl);
> >  
> >  	/* resume the io queues so that things will fast fail */
> > -	nvme_unquiesce_io_queues(&ctrl->ctrl);
> > +	nvme_unquiesce_io_queues(ctrl);
> >  }
> >  
> >  /*
> 
> Yes, I'd prefer this over the introduction of RCU in this code path.
> 

Okay. I spent a lot of time thinking about these two atomic_cmpxchg() to
make sure they cover all scenarios. That is holding all requests to be
held and at the same time not leave a request in a held state and not
get to complete it. Let me know if you think I missed a scenario.

