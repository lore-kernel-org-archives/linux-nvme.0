Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA61048924
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=havewdMOqWEAGK7hQIis2n7tDRk976XBnYGEqxZK/wY=; b=tilGKbK1Vzc3QQOIEdQco8C53Z
	dsG52SFwex7sWhjj978PaS4VljBaPdZshMmpQQpbA9BK+N4pleuCl4CJavhHIBfJLQ//2D1KrbE1a
	K6XhHVY0VQb415r6Lfy+7Ig0luEFbF9G5io3Z9+Vvbnf0WUKkknwiM3VGPf0920NTeOtzYGjPnrxE
	MtNmFaf9upxFNj+X7q0Y/bmhK+s8p+jK08mlmOw99J86GlN4/HPgmUNKmlzw1CJtf/cJ4ntp4iSgV
	O9C7DNIxBpH8VKMi6VQOaJsr8fIXnfOod/gwVhZ0/aox4CaaonJSdPKJeBojTNFkDc5BART03oGSx
	t8x1+SXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8qw-00000009N0s-0NuR;
	Sat, 28 Feb 2026 01:10:42 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8qt-00000009N0X-17DA
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 01:10:40 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-896f82e5961so39257766d6.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 17:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241038; x=1772845838; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=havewdMOqWEAGK7hQIis2n7tDRk976XBnYGEqxZK/wY=;
        b=mXgq4pIWBOFRQcaweB7GR51WWCMZxNFEh8HSGCfCCd7zYBV5WK06MlemzcMuuw5C0B
         7VSH2J6JssVh+xRwnVklLLiu/c7ibg27RfoBg4Hc1sXHhb47Cjk3Kd0kTISpmFoygGiF
         ZxBY3TJGVm1F4eLoApaDXOWDnCZgB+FU9rG/3KIpKsA4xf5BV53psduBIAtFe187vxi9
         4icvl5L04rWWoPXt66+I4ZJiKkH7ba6DxmWT9SuqHV15sajVQRyIiOmeclLsmRwx5eog
         lva+cAtxln1tVpS3ijUO747ZEZ7oMYsw7iRS0gj3PBLw+roFOodZui3NGcc69Ca4O+Rl
         bNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241038; x=1772845838;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=havewdMOqWEAGK7hQIis2n7tDRk976XBnYGEqxZK/wY=;
        b=EpKIL/cVlTAbGnZJC3QL1yYv30JLHNKYkEOE57gdJqXZNUoaBAp2rvQJkm21dnVb9m
         V5MnaVedD4uOxcbWmUnRp1tZRZYbHSgTxiimiWPbS8w/rA7vS33cDoLiOEWu86Qq4NHo
         iH5IvwsZmGajOCIy98mwAkpqyE+Jdu7KRI+FO1YSXF8l37B42G+bO3p9KcF2xy0xqHYV
         Il3rRJg5aLLgY/YNX7VHgpSeDtg7Ok+OXHFCwM4QVExwBxurDGPSN3WRNtqWNdI9zMB4
         FiGvcwJf6Rny2OKYJRtHZGW+R035AUqt+SBJ/a2neZn9r5iJVqsBF3hFW+dG3sA81/l3
         glgg==
X-Forwarded-Encrypted: i=1; AJvYcCV3zzvWqQCZk0re3j5A93uuCB3WPdTTDJRMiDbtWtQ6SmujXLWdRntEy2bu6NuwTyDdyCor+2IIPJnP@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/MgraCfha0rIGzXEalTkAkuLcBop+uMII9XwZOiueRK2sKruY
	8oN9LB72tGGTF+Wh3Tt6MyBmp3SyF4IfxF0bdzZHB9+q9fZU/KNaxpPo
X-Gm-Gg: ATEYQzy2fj8DwDVbAMTyK8Tmu4AbIGw4KyGzHuDeaqCK2nvbgxy6Y75AixBl3wkH6V1
	jeL7aoyHvqZn3XcQoeC77iO9taAniGWWNKWuUu8Fv4hc+o61kpCP1MwKNQS3JJt9x7bxj97Rmx4
	gcXEADoQl57pgtIyCJxuOAEYXuO5lHOD+zk0bUVTKjtr41JUD4Mgwt9zIOcy5xUwniegEye5kEE
	YwDeMgaOSysoKR5H7Nc4Z2gfdaAZuVW3HAhx+92je5zHV7j7sdBZH/G9B+SXtFKeaNZV7f7NL0V
	8t14wlD45/wL5rKjQBNcEqH3xMm7UMWnw/1vO53sStcFX3UEFCau9Toc1DekP+qat1qOxKrBh4R
	/F6jFCEJVocLWB5zMc0iybSnAigTDNpU4ApW4VaVPkoJ+sGdO9aWiUhfzPbHdI3+vf4v0daRteK
	CcojXl3+z8TWesW10AvqHG4j8IYCDd3Dh8cXF+6ealIxQIibguBBJtzmc=
X-Received: by 2002:a05:6214:411c:b0:897:1ff:a6c with SMTP id 6a1803df08f44-899d1d6c87fmr69692456d6.10.1772241037706;
        Fri, 27 Feb 2026 17:10:37 -0800 (PST)
Received: from [10.69.56.189] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm6645211cf.22.2026.02.27.17.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 17:10:37 -0800 (PST)
Message-ID: <b54285b4-6d68-43af-9fae-2cf960846642@gmail.com>
Date: Fri, 27 Feb 2026 17:10:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Smart <jsmart833426@gmail.com>
Subject: Re: [PATCH v3 14/21] nvme-fc: Hold inflight requests while in FENCING
 state
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, jsmart833426@gmail.com
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-15-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20260214042753.4073668-15-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_171039_331008_95D4A096 
X-CRM114-Status: GOOD (  30.60  )
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
> While in FENCING state, aborted inflight IOs should be held until fencing
> is done. Update nvme_fc_fcpio_done() to not complete aborted requests or
> requests with transport errors. These held requests will be canceled in
> nvme_fc_delete_association() after fencing is done. nvme_fc_fcpio_done()
> avoids racing with canceling aborted requests by making sure we complete
> successful requests before waking up the waiting thread.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 61 +++++++++++++++++++++++++++++++++++-------
>   1 file changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6ebabfb7e76d..e605dd3f4a40 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -172,7 +172,7 @@ struct nvme_fc_ctrl {
>   
>   	struct kref		ref;
>   	unsigned long		flags;
> -	u32			iocnt;
> +	atomic_t		iocnt;
>   	wait_queue_head_t	ioabort_wait;
>   
>   	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
> @@ -1823,7 +1823,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
>   		atomic_set(&op->state, opstate);
>   	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
>   		op->flags |= FCOP_FLAGS_TERMIO;
> -		ctrl->iocnt++;
> +		atomic_inc(&ctrl->iocnt);

the atomic change is probably what corrects deadlocks you saw.

>   	}
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   
> @@ -1853,20 +1853,29 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
>   }
>   
>   static inline void
> +__nvme_fc_fcpop_count_one_down(struct nvme_fc_ctrl *ctrl)
> +{
> +	if (atomic_dec_return(&ctrl->iocnt) == 0)
> +		wake_up(&ctrl->ioabort_wait);
> +}
> +
> +static inline bool
>   __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   		struct nvme_fc_fcp_op *op, int opstate)
>   {
>   	unsigned long flags;
> +	bool ret = false;
>   
>   	if (opstate == FCPOP_STATE_ABORTED) {
>   		spin_lock_irqsave(&ctrl->lock, flags);
>   		if (test_bit(FCCTRL_TERMIO, &ctrl->flags) &&
>   		    op->flags & FCOP_FLAGS_TERMIO) {
> -			if (!--ctrl->iocnt)
> -				wake_up(&ctrl->ioabort_wait);
> +			ret = true;
>   		}
>   		spin_unlock_irqrestore(&ctrl->lock, flags);
>   	}
> +
> +	return ret;
>   }
>   
>   static void nvme_fc_fencing_work(struct work_struct *work)
> @@ -1969,7 +1978,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   	struct nvme_command *sqe = &op->cmd_iu.sqe;
>   	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
>   	union nvme_result result;
> -	bool terminate_assoc = true;
> +	bool op_term, terminate_assoc = true;
> +	enum nvme_ctrl_state state;
>   	int opstate;
>   
>   	/*
> @@ -2102,16 +2112,38 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   done:
>   	if (op->flags & FCOP_FLAGS_AEN) {
>   		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
> -		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +			__nvme_fc_fcpop_count_one_down(ctrl);
>   		atomic_set(&op->state, FCPOP_STATE_IDLE);
>   		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
>   		nvme_fc_ctrl_put(ctrl);
>   		goto check_error;
>   	}
>   
> -	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +	/*
> +	 * We can not access op after the request is completed because it can
> +	 * be reused immediately. At the same time we want to wakeup the thread
> +	 * waiting for ongoing IOs _after_ requests are completed. This is
> +	 * necessary because that thread will start canceling inflight IOs
> +	 * and we want to avoid request completion racing with cancellation.
> +	 */
> +	op_term = __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +
> +	/*
> +	 * If we are going to terminate associations and the controller is
> +	 * LIVE or FENCING, then do not complete this request now. Let error
> +	 * recovery cancel this request when it is safe to do so.
> +	 */
> +	state = nvme_ctrl_state(&ctrl->ctrl);
> +	if (terminate_assoc &&
> +	    (state == NVME_CTRL_LIVE || state == NVME_CTRL_FENCING))
> +		goto check_op_term;
> +
>   	if (!nvme_try_complete_req(rq, status, result))
>   		nvme_fc_complete_rq(rq);
> +check_op_term:
> +	if (op_term)
> +		__nvme_fc_fcpop_count_one_down(ctrl);
>   
>   check_error:
>   	if (terminate_assoc)
> @@ -2750,7 +2782,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   		 * cmd with the csn was supposed to arrive.
>   		 */
>   		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
> -		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +			__nvme_fc_fcpop_count_one_down(ctrl);
>   
>   		if (!(op->flags & FCOP_FLAGS_AEN)) {
>   			nvme_fc_unmap_data(ctrl, op->rq, op);
> @@ -3219,7 +3252,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	set_bit(FCCTRL_TERMIO, &ctrl->flags);
> -	ctrl->iocnt = 0;
> +	atomic_set(&ctrl->iocnt, 0);
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   
>   	__nvme_fc_abort_outstanding_ios(ctrl, false);
> @@ -3228,11 +3261,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   	nvme_fc_abort_aen_ops(ctrl);
>   
>   	/* wait for all io that had to be aborted */
> +	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
>   	spin_lock_irq(&ctrl->lock);
> -	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
>   	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
>   	spin_unlock_irq(&ctrl->lock);
>   
> +	/*
> +	 * At this point all inflight requests have been successfully
> +	 * aborted. Now it is safe to cancel all requests we decided
> +	 * not to complete in nvme_fc_fcpio_done().
> +	 */
> +	nvme_cancel_tagset(&ctrl->ctrl);
> +	nvme_cancel_admin_tagset(&ctrl->ctrl);
> +
>   	nvme_fc_term_aen_ops(ctrl);
>   
>   	/*

This looks good

Signed-off-by: James Smart <jsmart833426@gmail.com>

-- james


