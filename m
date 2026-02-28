Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ABC1048925
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 00:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mlqixyLL+YmCQPrWDOn1p0QVoFl05wbSMCiPcDscAMs=; b=Jqc1WkBQYcKUJjXilsbco2Jkd9
	Rn3jPquDvS6xHhMiZc21rfuQPmft5hySFB/zd8G/bnUm6cfzlvYuZGRvvH1gJndNFC18Rue2bN3vW
	fKuckxf/HImqOviulcSz1cnR+1XhgumZuHvlYAozp7W0IrBXD+jvMsFuVlBhnOr9TFsiV0lIJ4AC4
	VKxvgPbZhQ3YS34QpqsKCF9AQMuvgFtp5dT/2+QIV8Ts8KlsP1oRnfcKccHDpxNSX2L1djcP5gOLf
	DAxTo4UGcwIiqX7rObg7ypzSsbxNePt3qFRIeOV2PP++L6PJwH2/OcU9230b7KuOVcs950Y1RkaKy
	sQxVf6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw7wK-00000009JHm-1n4K;
	Sat, 28 Feb 2026 00:12:12 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw7wI-00000009JGb-2Zza
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 00:12:11 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-899a917a4feso43909216d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 16:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772237529; x=1772842329; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mlqixyLL+YmCQPrWDOn1p0QVoFl05wbSMCiPcDscAMs=;
        b=FH29C45RmL9N7plZcznaARKWaeN2toy6Av+yfgqGiNS/ZmYFImB4zHGAeGnuTJjC/L
         t6/9IfFhHL62ZGk37iCm5d+WgayUk3TkdS1ucA+nzP2EEVfO3sZG11F0/u5v7RM6zUrP
         VzTQku4p8TyoAYpwGCaNrl/jFMJ4onbw7baJzDMckSZ4dbDBn4mCZaJ83m7XFJcm6YXU
         jzJ2LjidZq7UhbSUdbrLql9EAEPgQJPENakrg9uh4326wdCr0sr48oyrQenmENuGwe+5
         fdGZbm5N7O4B+S7YLmqKlN40Mr7XY+o3rAP8p3xcfbppUVlI0Q2vkKL0qryGcbJuL6hO
         bkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772237529; x=1772842329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlqixyLL+YmCQPrWDOn1p0QVoFl05wbSMCiPcDscAMs=;
        b=Kolud/Cb7D3nhAkdhzzsLewVoBylNFom0zhxVYCbCvIOQAx75goXifSXsPrPe4MrfK
         imC+qXpzgM/E8eizlByRJ5+S114wqvH3jLw89cMjpjrTDCPM1c341V3ZcTVnAtRqevQr
         Aec65NtRLexA+xr0DWQIPMqIh6ZepPH1WEdwUM73LoZo0JE6mN6iPMO+/2evBU9TyiV0
         YcNXPXP2dtL9b21vSpBdBD1N9ea1jJMuqsTiyOzspSjIASxZcBOvBDh2vZ6UBpYRoSZH
         T5CItDR4RNcTeIYJvnAs1j/kzkq7I4bBCrz8efVnU/EJSGfE2eolgrmWnZ9h0cuePA6F
         aaGw==
X-Forwarded-Encrypted: i=1; AJvYcCWTOyuDuQuNpMWL90OWG8ruCweJgD6p35GQZXjrLv2rMZoF08RABqrssFfVIR/b6LLqgAc6ehoxH0Ag@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1huB8Ct/Qhnqb11KVfyGgSaKJEuqXD+KN/baWsP3pa6xW/5EP
	J1aGsLMz6Y0X0mRtbocyYKvEcKCrJL4Q6kgVszMvYSFpI8UjviqG9G4j
X-Gm-Gg: ATEYQzy6p9u3Ig/8R056qX+O10wnYOUrXgR30+oZKYU/e6KORgt1BSDStoNqTy0BK0O
	qzRunZ1rUaMhaS4qPcY18G8o+ynSy300XTB17qlTtyy/smvCYcA8hhGQdb9iVc+G4cQwdK1JgGp
	JRHkYA9ICVEz+gStrvEEqjfc50du1l/xJYxiVWNToY3M1krrXWXt+4ejyS44PsfVBHBVhnwY37R
	+26d+mJ9LHslQTY0hpdVGagx9Lw9VdRZu/Ej6JWbdhvgzD0GppsZQwRkH1f+Rg+UVF8jnTP564T
	tunzO+tDs7wzMZsJMlmKHQAg+igWcEBhmMwgvxyZLQGJcyagsr25910T5ITfB5fdgWZbLsK8wxN
	uTyL52k/WCc54OcPj5H4mVNlGapijf1CjuOVOpgwcXmuXUcYTQXJrHyHHSrU51579GEUZvHuN06
	72WkEaU2chrS1BBpShARwP993EV4Md+fW5TP6zpmzAUTVfwzTon4jbrOQ=
X-Received: by 2002:a05:6214:da6:b0:880:51f0:5ba7 with SMTP id 6a1803df08f44-899d1e2b726mr70507756d6.42.1772237528712;
        Fri, 27 Feb 2026 16:12:08 -0800 (PST)
Received: from [10.69.56.189] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716c53dsm52250196d6.13.2026.02.27.16.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 16:12:08 -0800 (PST)
Message-ID: <f3886902-12ed-4d9c-abee-0b2363a0ada8@gmail.com>
Date: Fri, 27 Feb 2026 16:12:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Smart <jsmart833426@gmail.com>
Subject: Re: [PATCH v3 12/21] nvme-fc: Decouple error recovery from controller
 reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jsmart833426@gmail.com
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-13-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20260214042753.4073668-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_161210_691284_2B5022A9 
X-CRM114-Status: GOOD (  33.28  )
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

On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> in CONNECTING state results in deadlock reported in link below. Update
> nvme_fc_timeout() to schedule error recovery to avoid the deadlock.

This seems misleading on what is changing...

How about:
Add new nvme_fc_start_ioerr_recovery() routine which effectively
   "resets" a the controller.
Refactor error points that invoked routines that reset the controller
   to now call nvme_fc_start_ioerr_recovery().
Eliminated io abort on io error, as we will be resetting the controller.


> 
> Previous to this change if controller was LIVE error recovery resets
> the controller and this does not match nvme-tcp and nvme-rdma. Decouple
> error recovery from controller reset to match other fabric transports.

Please delete. It's irrelevant to the patch.


...
> @@ -1871,7 +1874,22 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
>   
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> +	/*
> +	 * if an error (io timeout, etc) while (re)connecting, the remote
> +	 * port requested terminating of the association (disconnect_ls)
> +	 * or an error (timeout or abort) occurred on an io while creating
> +	 * the controller.  Abort any ios on the association and let the
> +	 * create_association error path resolve things.
> +	 */
> +	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_CONNECTING) {
> +		__nvme_fc_abort_outstanding_ios(ctrl, true);
> +		dev_warn(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: transport error during (re)connect\n",
> +			 ctrl->cnum);
> +		return;
> +	}
> +
> +	nvme_fc_error_recovery(ctrl);
>   }

ok - but see below...


> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +					 char *errmsg)
> +{
> +	enum nvme_ctrl_state state;
> +
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> +		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +		return;
> +	}
> +
> +	state = nvme_ctrl_state(&ctrl->ctrl);
> +	if (state == NVME_CTRL_CONNECTING || state == NVME_CTRL_DELETING ||
> +	    state == NVME_CTRL_DELETING_NOIO) {
> +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	}
> +}

What bothers me about this (true of the tcp and rmda transports) is 
there is little difference between this and using the core 
nvme_reset_ctrl(), excepting that even when the state change fails, the 
code continues to schedule the work element that does the reset.

And the latter odd snippet to reset anyway is only to get the CONNECTING 
code snippet, which failed the RESETTING transition, to be performed. 
I'd prefer the connecting snippet be at the top of start_ioerr_recovery 
before any state change attempt so its in the same place as prior.


...
>   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   {
>   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> @@ -2536,24 +2539,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>   	struct nvme_command *sqe = &cmdiu->sqe;
>   
> -	/*
> -	 * Attempt to abort the offending command. Command completion
> -	 * will detect the aborted io and will fail the connection.
> -	 */
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
>   		"x%08x/x%08x\n",
>   		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
>   		nvme_fabrics_opcode_str(qnum, sqe),
>   		sqe->common.cdw10, sqe->common.cdw11);
> -	if (__nvme_fc_abort_op(ctrl, op))
> -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
>   
> -	/*
> -	 * the io abort has been initiated. Have the reset timer
> -	 * restarted and the abort completion will complete the io
> -	 * shortly. Avoids a synchronous wait while the abort finishes.
> -	 */
> +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
>   	return BLK_EH_RESET_TIMER;
>   }

I eventually gave in on not doing the abort of the io as the 
start_ioerr_recovery() will be resetting the controller.


>   
> @@ -3352,6 +3345,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	}
>   }
>   
> +static void
> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> +{
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	nvme_stop_ctrl(&ctrl->ctrl);
> +	flush_work(&ctrl->ctrl.async_event_work);
> +
> +	/* will block while waiting for io to terminate */
> +	nvme_fc_delete_association(ctrl);
> +
> +	/* Do not reconnect if controller is being deleted */
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +		return;
> +
> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		return;
> +	}
> +
> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> +}
>   
>   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.name			= "fc",

There is no reason to duplicate the code that is already in ioerr_work. 
I prototyped a simple service routine. The net/net is showed what little 
reason there is to have an ioerr_work and a reset_work - as they are 
effectively the same. So I then eliminated ioerr_work and use reset_work 
and the service routine (kept the nvme_fc_error_recovery() name).


Here's a revised diff for this patch... I have compiled but not tested.


--- fc.c.START	2026-02-27 14:10:07.631705123 -0800
+++ fc.c	2026-02-27 15:41:09.777836476 -0800
@@ -166,7 +166,6 @@ struct nvme_fc_ctrl {
  	struct blk_mq_tag_set	admin_tag_set;
  	struct blk_mq_tag_set	tag_set;

-	struct work_struct	ioerr_work;
  	struct delayed_work	connect_work;

  	struct kref		ref;
@@ -227,6 +226,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
  static struct device *fc_udev_device;

  static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					char *errmsg);

  /* *********************** FC-NVME Port Management 
************************ */

@@ -788,7 +789,7 @@ nvme_fc_ctrl_connectivity_loss(struct nv
  		"Reconnect", ctrl->cnum);

  	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
  }

  /**
@@ -985,8 +986,6 @@ fc_dma_unmap_sg(struct device *dev, stru
  static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
  static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);

-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char 
*errmsg);
-
  static void
  __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
  {
@@ -1569,7 +1568,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmef
  	 */

  	/* fail the association */
-	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+	nvme_fc_start_ioerr_recovery(ctrl,
+				     "Disconnect Association LS received");

  	/* release the reference taken by nvme_fc_match_disconn_ls() */
  	nvme_fc_ctrl_put(ctrl);
@@ -1865,15 +1865,6 @@ __nvme_fc_fcpop_chk_teardowns(struct nvm
  	}
  }

-static void
-nvme_fc_ctrl_ioerr_work(struct work_struct *work)
-{
-	struct nvme_fc_ctrl *ctrl =
-			container_of(work, struct nvme_fc_ctrl, ioerr_work);
-
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
-}
-
  /*
   * nvme_fc_io_getuuid - Routine called to get the appid field
   * associated with request by the lldd
@@ -2049,9 +2040,8 @@ done:
  		nvme_fc_complete_rq(rq);

  check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
  }

  static int
@@ -2496,7 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct n
  }

  static void
-nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
+nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,	char *errmsg)
  {
  	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);

@@ -2515,17 +2505,15 @@ nvme_fc_error_recovery(struct nvme_fc_ct
  		return;
  	}

-	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state != NVME_CTRL_LIVE)
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
  		return;

  	dev_warn(ctrl->ctrl.device,
  		"NVME-FC{%d}: transport association event: %s\n",
  		ctrl->cnum, errmsg);
-	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
-
-	nvme_reset_ctrl(&ctrl->ctrl);
+	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+		 ctrl->cnum, errmsg);
+	queue_work(nvme_reset_wq, &ctrl->ctrl.reset_work);
  }

  static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
@@ -2536,24 +2524,14 @@ static enum blk_eh_timer_return nvme_fc_
  	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
  	struct nvme_command *sqe = &cmdiu->sqe;

-	/*
-	 * Attempt to abort the offending command. Command completion
-	 * will detect the aborted io and will fail the connection.
-	 */
  	dev_info(ctrl->ctrl.device,
  		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
  		"x%08x/x%08x\n",
  		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
  		nvme_fabrics_opcode_str(qnum, sqe),
  		sqe->common.cdw10, sqe->common.cdw11);
-	if (__nvme_fc_abort_op(ctrl, op))
-		nvme_fc_error_recovery(ctrl, "io timeout abort failed");

-	/*
-	 * the io abort has been initiated. Have the reset timer
-	 * restarted and the abort completion will complete the io
-	 * shortly. Avoids a synchronous wait while the abort finishes.
-	 */
+	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
  	return BLK_EH_RESET_TIMER;
  }

@@ -3264,7 +3242,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nc
  	 * waiting for io to terminate
  	 */
  	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
+	cancel_work_sync(&ctrl->ctrl.reset_work);

  	if (ctrl->ctrl.tagset)
  		nvme_remove_io_tag_set(&ctrl->ctrl);
@@ -3324,20 +3302,27 @@ nvme_fc_reconnect_or_delete(struct nvme_
  }

  static void
-nvme_fc_reset_ctrl_work(struct work_struct *work)
+nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
  {
-	struct nvme_fc_ctrl *ctrl =
-		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
-
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
  	nvme_stop_ctrl(&ctrl->ctrl);

  	/* will block will waiting for io to terminate */
  	nvme_fc_delete_association(ctrl);

-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+		/* state change failure is ok if we started ctrl delete */
+		if (state == NVME_CTRL_DELETING ||
+		    state == NVME_CTRL_DELETING_NOIO)
+			return;
+
  		dev_err(ctrl->ctrl.device,
-			"NVME-FC{%d}: error_recovery: Couldn't change state "
-			"to CONNECTING\n", ctrl->cnum);
+			"NVME-FC{%d}: error_recovery: Couldn't change "
+			"state to CONNECTING (%d)\n", ctrl->cnum, state);
+	}

  	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
  		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
@@ -3352,6 +3337,15 @@ nvme_fc_reset_ctrl_work(struct work_stru
  	}
  }

+static void
+nvme_fc_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *ctrl =
+		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
+
+	nvme_fc_error_recovery(ctrl);
+}
+

  static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
  	.name			= "fc",
@@ -3483,7 +3477,6 @@ nvme_fc_alloc_ctrl(struct device *dev, s

  	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
  	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
-	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
  	spin_lock_init(&ctrl->lock);

  	/* io queue count */
@@ -3581,7 +3574,6 @@ nvme_fc_init_ctrl(struct device *dev, st

  fail_ctrl:
  	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-	cancel_work_sync(&ctrl->ioerr_work);
  	cancel_work_sync(&ctrl->ctrl.reset_work);
  	cancel_delayed_work_sync(&ctrl->connect_work);


