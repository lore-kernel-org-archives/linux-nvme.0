Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE9E8B362
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA9JI8TdIYc3JTfIvpt0pvGbpY26uLbnQsKyCOsUQh8=; b=Agn70vylQMYrVCQWj550KF4wc6
	kMRnZvqh1Bdty2PcbITdjoipZXHHg8xLhDOakwTrR/ngPYZg6lMYrP4nKbiWdiCwI4O9Gdpr/pNBQ
	8PoRpAS0i8zFZCbYwgusAiYjutYpj9aBZBBs9fg2lqDqHpuiaGdSTYVWSJ3K9G68/IHqFMXOX52g/
	vPjdXAHWIrvrS4SxjJDbXV9Vo4RasXn34M7wbRQtERcsd+C5ExxJxVEGDtU/pusoPviCtqysMrkvN
	eIKxv+6sGMi5vksWDq/hVH5lLz2foohC8yh3RjQk8c2XRLv7rzUHdG6IwXsPzwqcW5rj7DZ+mAEZq
	MqABsdxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnNxL-00000007NSh-2IzB;
	Tue, 03 Feb 2026 21:29:07 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnNxI-00000007NSG-0Kb1
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 21:29:05 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1233bc1117fso198956c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770154143; x=1770758943; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OA9JI8TdIYc3JTfIvpt0pvGbpY26uLbnQsKyCOsUQh8=;
        b=CTkBLWz5eByPKiYJ1OCAkNgRsyouO2qfYiyb2asBc9NplWIXrIAPMwK1V5SSxd68nl
         ybeZ7Ozsu+LG88/NX87EN7sO5nkWrtEAUjlQa/Tn7V+/ULCNqOJK+keImuN6uG3w4nFZ
         GBRVGIQZlbBGzPtvvJphmoR9PEi4y2AuDXZ/G15/zC/gOc46wW3AJcFfEa4iVn7pJ7qK
         ksxBZlbCOSiqmSBtL0RncpCmaPum29AO1Ek3/F5LV5+ZNvz5FDmQ8hB4yK8DyM4ULFbS
         CwRAR6qGSOpTPHp00lw4bA2l0LTEI0OFADi5n2Tn34jBVC6eQNF9w0bodkHaCzUMN1ev
         Ewxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154143; x=1770758943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OA9JI8TdIYc3JTfIvpt0pvGbpY26uLbnQsKyCOsUQh8=;
        b=UCCTmsF/Mc5QJG/UaAKzV2oUlmvpT7XG0s+LOBmFQaEB413hi04UQP0xgPYzP9p75q
         9wjCd+TOHnyYy+PE6sfDAnu2RzQBgW9a6ikiMAKV1PGEkCNF4jNNA/m4mcICwT3MASv1
         YKpOxvAh/asfI6VaEoLaCP1TIEuoX+mNWNx5UzKXRQvoFWVbq8mxNP1iJGEjJCnt7x70
         /vwxVVZ/QZ/TWDlsue+JWeSEk7222WRfpfnFH7ColgRwrxWuyvmxWWefCBXl1xnbMjB9
         LKm0bbQI7f50QGVhoKUp3sC9ko+aq68dDJkYbyr9IqaM4zwLnmctIHbf/rc/VtOUmbxJ
         u+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrFZYKqbClwRSqgwtjAiGwUUYICGIxJ2ZykbloYZk/XW9izNs+HGuztzh+jcuAOMh7rKJOmscHjcL4@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5CwqomeoGXHLnuAeQC/RDHIih30+2NO4U0mkAZRZhT2fZd1cw
	0Z/kQUX84vhV3Zt6GXwRa5qwZ9L7FkHdArCybFUfKlGrSHketfMF7HHUa+L3hZ8sYtw=
X-Gm-Gg: AZuq6aKFmRwoTJ+4e33QmCc5CJT7r9H8/MX3n589Gyys/2zvS2xuhkzEstoQsvJVAJI
	ydIEjq4l7u3930GOPxvggd6cAqFomMfTF4IrQeNE7DAscZkbRIIiTanSa23zua3BrfCCJc7glos
	KYUB0Mj1W0vB8C4CifaFnDjllFAPQRvfdxIPT5I9JsI+zIEp53zETuqQeaKVEI+lQdKKLyHiD7D
	jOq7q0+jUxkwtycXvGYchbTbVIjQePQy3CG21/SJmVNAc5nXaMPFbtBaK0FBAyTYY957uo7Zngk
	3zLRP//nTOlN+FzZw87E8XsOTXIJ5VCfLa9ZjcGtOZO5AzFgvqomaMxEzXipOrqU1qq+VviNKJ6
	GAh33Xd1tC9RoFX52IZALHhM9sr2L1w1YmAaLMrHuLl9g2dS0x7SVafGscYZ9enYpl0W91mVXVN
	XqTkEjmbs2eOHNTgVxt9mgKRNrL9MiDS9O9IFq5z6dqA==
X-Received: by 2002:a05:7022:a8e:b0:11b:c86b:3870 with SMTP id a92af1059eb24-126f478f123mr368399c88.4.1770154142792;
        Tue, 03 Feb 2026 13:29:02 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f503087esm432805c88.12.2026.02.03.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 13:29:02 -0800 (PST)
Date: Tue, 3 Feb 2026 13:29:01 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from
 controller reset
Message-ID: <20260203212901.GH3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <692717f0-d0c7-4674-8e65-f8bae8dad4fd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <692717f0-d0c7-4674-8e65-f8bae8dad4fd@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_132904_129847_6CF2D2E6 
X-CRM114-Status: GOOD (  32.76  )
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

On Tue 2026-02-03 06:40:28 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> > in CONNECTING state results in deadlock reported in link below. Update
> > nvme_fc_timeout() to schedule error recovery to avoid the deadlock.
> > 
> > Previous to this change if controller was LIVE error recovery resets
> > the controller and this does not match nvme-tcp and nvme-rdma. Decouple
> > error recovery from controller reset to match other fabric transports.
> > 
> > Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
> >   1 file changed, 41 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index 6948de3f438a..f8f6071b78ed 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
> >   static struct device *fc_udev_device;
> >   
> >   static void nvme_fc_complete_rq(struct request *rq);
> > +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> > +					 char *errmsg);
> >   
> >   /* *********************** FC-NVME Port Management ************************ */
> >   
> > @@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
> >   		"Reconnect", ctrl->cnum);
> >   
> >   	set_bit(ASSOC_FAILED, &ctrl->flags);
> > -	nvme_reset_ctrl(&ctrl->ctrl);
> > +	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
> >   }
> >   
> >   /**
> > @@ -985,7 +987,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> >   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
> >   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
> >   
> > -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
> > +static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
> >   
> >   static void
> >   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> > @@ -1567,9 +1569,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
> >   	 * for the association have been ABTS'd by
> >   	 * nvme_fc_delete_association().
> >   	 */
> > -
> > -	/* fail the association */
> > -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> > +	nvme_fc_start_ioerr_recovery(ctrl,
> > +				     "Disconnect Association LS received");
> >   
> >   	/* release the reference taken by nvme_fc_match_disconn_ls() */
> >   	nvme_fc_ctrl_put(ctrl);
> > @@ -1871,7 +1872,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   	struct nvme_fc_ctrl *ctrl =
> >   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
> >   
> > -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> > +	nvme_fc_error_recovery(ctrl);
> >   }
> >   
> >   /*
> > @@ -1892,6 +1893,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
> >   
> > +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> > +					 char *errmsg)
> > +{
> > +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> > +		return;
> > +
> > +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> > +		 ctrl->cnum, errmsg);
> > +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +}
> > +
> >   static void
> >   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >   {
> > @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >   		nvme_fc_complete_rq(rq);
> >   
> >   check_error:
> > -	if (terminate_assoc &&
> > -	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
> > -		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +	if (terminate_assoc)
> > +		nvme_fc_start_ioerr_recovery(ctrl, "io error");
> >   }
> >   
> >   static int
> > @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> >   		nvme_unquiesce_admin_queue(&ctrl->ctrl);
> >   }
> >   
> > -static void
> > -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> > -{
> > -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> > -
> > -	/*
> > -	 * if an error (io timeout, etc) while (re)connecting, the remote
> > -	 * port requested terminating of the association (disconnect_ls)
> > -	 * or an error (timeout or abort) occurred on an io while creating
> > -	 * the controller.  Abort any ios on the association and let the
> > -	 * create_association error path resolve things.
> > -	 */
> > -	if (state == NVME_CTRL_CONNECTING) {
> > -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> > -		dev_warn(ctrl->ctrl.device,
> > -			"NVME-FC{%d}: transport error during (re)connect\n",
> > -			ctrl->cnum);
> > -		return;
> > -	}
> > -
> > -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> > -	if (state != NVME_CTRL_LIVE)
> > -		return;
> > -
> > -	dev_warn(ctrl->ctrl.device,
> > -		"NVME-FC{%d}: transport association event: %s\n",
> > -		ctrl->cnum, errmsg);
> > -	dev_warn(ctrl->ctrl.device,
> > -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> > -
> > -	nvme_reset_ctrl(&ctrl->ctrl);
> > -}
> > -
> >   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >   {
> >   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> > @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >   	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
> >   	struct nvme_command *sqe = &cmdiu->sqe;
> >   
> > -	/*
> > -	 * Attempt to abort the offending command. Command completion
> > -	 * will detect the aborted io and will fail the connection.
> > -	 */
> >   	dev_info(ctrl->ctrl.device,
> >   		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
> >   		"x%08x/x%08x\n",
> >   		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
> >   		nvme_fabrics_opcode_str(qnum, sqe),
> >   		sqe->common.cdw10, sqe->common.cdw11);
> > -	if (__nvme_fc_abort_op(ctrl, op))
> > -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
> >   
> > -	/*
> > -	 * the io abort has been initiated. Have the reset timer
> > -	 * restarted and the abort completion will complete the io
> > -	 * shortly. Avoids a synchronous wait while the abort finishes.
> > -	 */
> > +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
> >   	return BLK_EH_RESET_TIMER;
> >   }
> >   
> > @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >   	}
> >   }
> >   
> > +static void
> > +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> > +{
> > +	nvme_stop_keep_alive(&ctrl->ctrl);
> > +	nvme_stop_ctrl(&ctrl->ctrl);
> > +
> > +	/* will block while waiting for io to terminate */
> > +	nvme_fc_delete_association(ctrl);
> > +
> > +	/* Do not reconnect if controller is being deleted */
> > +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> > +		return;
> > +
> > +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> > +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> > +		return;
> > +	}
> > +
> > +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> > +}
> >   
> >   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
> >   	.name			= "fc",
> 
> I really don't get it. Why do you need to do additional steps here, when
> all you do is split an existing function in half?
> 

Can you help me and point out to the part that is additional?

Is it nvme_stop_keep_alive()? If yes, then it matches other transports.
I am okay with removing it and we assume that the work will stop when it
hits an error, like what it does today.

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

