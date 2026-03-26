Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828B410A88F1
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3F5UJjPKIs+RVyn9q5QF21wAHd9eT+mZHlFuJucRmw=; b=KugbJ105YIv/oFsz/wQyozYiKQ
	/YKFj2H+akaeNkV8+OF++VMsWCpkEmU1Cs5HNptIC46J0iO33ZfCLwIwnkr2fEU6KQXhLYkRSRM7K
	7y9NtuVRYVxuADOdYn3V9SY+pdHCJKnvPIFVhmby/oQIlziXFqKesLCjVNArYIP65U3dW8G4wBNJC
	HAVwQNMF0sNM6ZegGNbcaBmBwxXgMle7IzT8f46Xf8Ap3Yp1OBXP2xn43bLBG7GaBz8CZ4Y4H39Mt
	1gH4nNrcXgWdJbnrJhFV1yDsM2M6bUB2xsyBpnZ01bgCSMMO929UB91B8sgejHIhPV9k4YHOEu7KZ
	9WiIxd6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ogv-00000005yN8-0FiA;
	Thu, 26 Mar 2026 17:40:21 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ogo-00000005yMZ-2mvV
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 17:40:16 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2c0c955a481so2685352eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2026 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774546814; x=1775151614; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3F5UJjPKIs+RVyn9q5QF21wAHd9eT+mZHlFuJucRmw=;
        b=GhG9+2OpPfVH8RKlGNVesrNIMkTOQigXqnzTLeVi7NB7xbyTvE1uLgfrCdECL3rRVu
         sbizUb9uFfhth6vHDaTvvYToveCbezaFDNWXrv32KoDVd4BW7NkcHu86dcTPa9H9JXFH
         6MADgaVEJYk9qapTjlIA+hbgezSvM+pnnPhd62FVf4Ev7KCZ//MPD9TvnwrbvPLTiGxK
         PhuTqNrk1dTeJMc1lXdB5Nt/G1d3vr2c06ViP1CBnNcuOaH8uAgCA9jCL3c0l35MpOao
         /JduwdNtR+tTD90MawdBgjW5WZFDglrMebTDlFM1joWcU0ee63KHgjLj8zVe/LSDKRlG
         FrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546814; x=1775151614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3F5UJjPKIs+RVyn9q5QF21wAHd9eT+mZHlFuJucRmw=;
        b=WJYGh2UZLQ+2nWjgazFnjb6IjwtPpy/3gdxAr/wMlNm52fwNNoCRu4LU7PBMWQ78Qc
         M1rFrnrFq3/gTgpwqrxv8A0Vl4iT8UAGr1kDhvqkP3Xjk2402V/Pc5kD07jmW14gn/8k
         /j64+AyLX5jMdz/44mtmdq6pAvpIPqWtu3Ch+IrbCZtygIY5N7ndTSOgYhXjsJ87bWS2
         rHe9TOAg/LfHFEVszhdUtrwT9H9Z+DFIXlWlPa9NBwVxlc0GZqaXkLPBT3hyPaP0ke+P
         0y9QDQJZvgUruENBZ3YqLym3+4nvMGEpisngjLqDUuwKkzFU5K5HlXZIHhH4FYgu9sRd
         lNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMFuL2Lr1tNO4tYu9+O26ybU8M2v9re5vAqH8LlEfe2SbXagPQLeD5MISkR57GzQk+oGDo+G8m6yC4@lists.infradead.org
X-Gm-Message-State: AOJu0Yyi7WkHPO+UJP6QjaHc6TpYiYk8FKtafGeK5VXCRtM3g9uXP7kq
	FBzoAZ6a5BVC+PhtEy+fdIiw7H9ZZjH4yKLRoeQpr2bzwikBOMgNM7K0BhwSUSzGK+s=
X-Gm-Gg: ATEYQzyn1nfndaQxzPhi58ti2eJxw1d5AMHDBEKG3nGru30Lb8T4quVgOmd+Vrqq39H
	hfxsu386MqKaEeyrW2yeNl8YkSrF4YnBJtKlwNdFY/81NGtpzTS7gvAYXamUgPM+DmLMlwDEX4f
	dWOcZbRtMjuu+vDK8IePqf4W0WgXENT76NdADjnxYjoC1wnirW86vN48qJbvHIOCI3tF4nzF67x
	lgXu70BMrUhF5YpLZv/59LOd3wMjk9+DWy6MzzFoLnyHTHoum8dctt67LOdF4H6D5R+8gT1Vb7k
	cMWEts4/Cq2UItOvFm/Psebg1hFod9MUGxphwEyaB5rdTQ/+KjmIqSvWCNuKzTxZkNI/6qwCGDO
	jiAHHA6gwxelcXcnYrU1ywjJynC4tTrH6kHk4ydB7IkA5XxCDmRIRpc1mtnxFm9lAu47OoJBvnD
	U0ONWCvUbTtSk2khGMeNhBA/wA6bs0YDDYP4hBKlLde1c=
X-Received: by 2002:a05:7300:fb87:b0:2c1:102e:5694 with SMTP id 5a478bee46e88-2c15d42acf5mr5211027eec.34.1774546813386;
        Thu, 26 Mar 2026 10:40:13 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2c16ee01674sm3365692eec.27.2026.03.26.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:40:12 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:40:11 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/21] nvme-fc: Use CCR to recover controller that
 hits an error
Message-ID: <20260326174011.GP3435530-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-14-mkhalfella@purestorage.com>
 <d6013719-8169-4ad0-bb05-a626a717e8b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6013719-8169-4ad0-bb05-a626a717e8b1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_104014_744828_3FBF3416 
X-CRM114-Status: GOOD (  29.66  )
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

On Fri 2026-02-27 17:03:55 -0800, James Smart wrote:
> On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> > An alive nvme controller that hits an error now will move to FENCING
> > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > terminate inflight IOs. Regardless of the success or failure of CCR
> > operation the controller is transitioned to RESETTING state to continue
> > error recovery process.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/fc.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index e6ffaa19aba4..6ebabfb7e76d 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
> >   	struct blk_mq_tag_set	admin_tag_set;
> >   	struct blk_mq_tag_set	tag_set;
> >   
> > +	struct work_struct	fencing_work;
> >   	struct work_struct	ioerr_work;
> >   	struct delayed_work	connect_work;
> >   
> > @@ -1868,6 +1869,24 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
> >   	}
> >   }
> >   
> > +static void nvme_fc_fencing_work(struct work_struct *work)
> > +{
> > +	struct nvme_fc_ctrl *fc_ctrl =
> > +			container_of(work, struct nvme_fc_ctrl, fencing_work);
> > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > +	unsigned long rem;
> > +
> > +	rem = nvme_fence_ctrl(ctrl);
> > +	if (rem) {
> > +		dev_info(ctrl->device,
> > +			 "CCR failed, skipping time-based recovery\n");
> > +	}
> > +
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> 
> catch the rework of prior patch

I ended up not dropping ctrl->ioerr_work. There are situations we need
error recovery work to run on a separate thread.

> 
> > +}
> > +
> >   static void
> >   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   {
> > @@ -1889,6 +1908,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   		return;
> >   	}
> >   
> > +	flush_work(&ctrl->fencing_work);
> >   	nvme_fc_error_recovery(ctrl);
> >   }
> >   
> > @@ -1915,6 +1935,14 @@ static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> >   {
> >   	enum nvme_ctrl_state state;
> >   
>  From prior patch - the CONNECTING logic should be here....

Yes, it is here. The check for CONNECTING state is at the top of
nvme_fc_start_ioerr_recovery(). 

> 
> > +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
> > +		dev_warn(ctrl->ctrl.device,
> > +			 "NVME-FC{%d}: starting controller fencing %s\n",
> > +			 ctrl->cnum, errmsg);
> > +		queue_work(nvme_wq, &ctrl->fencing_work);
> > +		return;
> > +	}
> > +
> >   	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> >   		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> >   			 ctrl->cnum, errmsg);
> > @@ -3322,6 +3350,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >   	struct nvme_fc_ctrl *ctrl =
> >   		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> >   
> > +	flush_work(&ctrl->fencing_work);
> >   	nvme_stop_ctrl(&ctrl->ctrl);
> >   
> >   	/* will block will waiting for io to terminate */
> > @@ -3497,6 +3526,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> >   
> >   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
> >   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> > +	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
> >   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
> >   	spin_lock_init(&ctrl->lock);
> >   
> 
> there is a little to be in sync with my comment on the prior patch, but 
> otherwise what is here is fine.
> 
> What bothers me in this process is - there are certainly conditions 
> where there is not connectivity loss  where FC can send things such as 
> the ABTS or a Disconnect LS that can inform the controller to start 
> terminating. Its odd that we skip this step and go directly to the CCR 
> reset to terminate the controller.  We should have been able to continue 
> to send the things that start to directly tear down the controller which 
> can be happening in parallel with the CCR.

Depending on how the target is implemented ABTS or Disconnect LS do not
guarantee inflight IOs are terminated. CCR main point is terminate
inflight IOs making it safe to retry failed IOs.


