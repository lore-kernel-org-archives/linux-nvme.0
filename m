Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3443FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2SLSqGyEqCVCFyRJjJ1FWWgUfwr+NH72nZQlIiDXkE=; b=YAikz2HFjO0q3rZofE6UKbKv5V
	RXekELxIGeruqKQtlAbszmhJtIU3kNT/+03ZyW0a6ZYeKtuMmZydQazNXnX/LStNGJsf6tL43Gvj6
	P+ugCLc7v4jMEnju0XGqO9L4/SPv9qLerG6hKVCDhs+NaR4eODMBmUrf7LKBMvssNCI3c5/e/8ANA
	EQMreXRQdx/DgWBGzCIAH664urM+aeC2Iqg5iIY4zse5rwy5Yl/cwS9MaRW6Cmi4NW/p9rxacs3AX
	McLwZUiJBYCmxtrJFjwgkmsQKRvrbFkfofAAcSpqngNhGAU4zAPzeCjNnUPS4g50Lq7DWR6YQZaI4
	ipTFCBJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nraiq-005aeq-4d; Thu, 19 May 2022 07:37:24 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nraim-005adP-Jv
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 07:37:22 +0000
Received: by mail-oi1-x235.google.com with SMTP id n24so5472908oie.12
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v2SLSqGyEqCVCFyRJjJ1FWWgUfwr+NH72nZQlIiDXkE=;
 b=WGH+dwO8se/FhSCRNeba5p0sFNVXE9263uBNF4pPqfMXnry5rIkoWqXyxpL05G1WrY
 QpxdnWeESUL2Jcw7W14nVn/l0UsamZ+cLeNPpzInyI78mdma0Gqa6mPR9tSH91PqtKEe
 d+F1slgbSCjdeKXdikIAyUP/P7nSmCCjYqk5UzVkJyM7k49wQ1ZUKOb145UGggRpKkmq
 ww5c1wwpsiPAl7YyV2GRnKQFZQdOzanHh+pqPm+lTBYHCI22FGFFy3JmGBjpCyKQMJlc
 LIv8+o8zZwSij2D7xzGuAqyCPY/9/aSLfrZTwnqvMyRptI1JbMZ6laihx3nCxyU2pg1z
 Ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v2SLSqGyEqCVCFyRJjJ1FWWgUfwr+NH72nZQlIiDXkE=;
 b=GAfK9R/+GH25KWIWEL6GJeaWNcOenHTB9wqzR4pHWlxKNsex7kZeU2d+OG7ePkJrn4
 hicEjIVQQjLLt6AfNplX0HO0wGK7Zpb4GUOKuN/mH0pbQaC2h2AXC2csl9O5OmqYGH00
 SytRuKkKIPDHyvyaUkJcyCgO6FtJAMQDl4qawoNEdfsp18KSCYiGYAxieqx0t+t/JM5p
 qtJMBYTn+gbZBoTU9rKZollR+XhVxMBh6ysOba/7TBJsVhpbwhz+WQDvISZWQm6AHHqc
 UP1TEKa1HGe3T/8qbgVcJMztR7SFFS8r1+bKgZSBxjO3KxeuciJD0HCZQdcfM51iyxdA
 8bxg==
X-Gm-Message-State: AOAM530DYSUjs0qMNHiCerpsPzCUlhqOrgKfQ0KyWCKyXwlWGgRtVm6l
 giqIdk9GhBbeC8IwyEGPYQoYSr0qx05eM5W6xQo=
X-Google-Smtp-Source: ABdhPJxItnrTnSxOkneZOHQL9ziiuGMoBB3E3m/OksHC5WeGBfxAGNmnO1Z75T1qIL7SU2nLEi+149x6QZzHgSL53EU=
X-Received: by 2002:a05:6808:180d:b0:328:b7dc:d68b with SMTP id
 bh13-20020a056808180d00b00328b7dcd68bmr1988751oib.15.1652945837787; Thu, 19
 May 2022 00:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220517064901.3059255-1-hch@lst.de>
 <20220517064901.3059255-4-hch@lst.de>
In-Reply-To: <20220517064901.3059255-4-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 19 May 2022 13:06:51 +0530
Message-ID: <CA+1E3rKZkP=Rekf0zA5wvewxzFEuBFqa0v2uH4wxcewz0beFSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] blk-mq: remove the done argument to
 blk_execute_rq_nowait
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_003720_703983_7003EF28 
X-CRM114-Status: GOOD (  26.42  )
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

On Tue, May 17, 2022 at 12:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Let the caller set it together with the end_io_data instead of passing
> a pointless argument.  Note the the target code did in fact already
> set it and then just overrode it again by calling blk_execute_rq_nowait.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c                     |  5 +----
>  drivers/block/sx8.c                |  4 ++--
>  drivers/nvme/host/core.c           |  3 ++-
>  drivers/nvme/host/ioctl.c          |  3 ++-
>  drivers/nvme/host/pci.c            | 10 +++++++---
>  drivers/nvme/target/passthru.c     |  3 ++-
>  drivers/scsi/scsi_error.c          |  5 +++--
>  drivers/scsi/sg.c                  |  3 ++-
>  drivers/scsi/st.c                  |  3 ++-
>  drivers/scsi/ufs/ufshpb.c          |  6 ++++--
>  drivers/target/target_core_pscsi.c |  3 +--
>  include/linux/blk-mq.h             |  3 +--
>  12 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0169b624edda1..c832011bc90dd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1189,7 +1189,6 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
>   * @rq:                request to insert
>   * @at_head:    insert request at head or tail of queue
> - * @done:      I/O completion handler
>   *
>   * Description:
>   *    Insert a fully prepared request at the back of the I/O scheduler queue
> @@ -1198,13 +1197,11 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   * Note:
>   *    This function will invoke @done directly if the queue is dead.
>   */
> -void blk_execute_rq_nowait(struct request *rq, bool at_head, rq_end_io_fn *done)
> +void blk_execute_rq_nowait(struct request *rq, bool at_head)
>  {
>         WARN_ON(irqs_disabled());
>         WARN_ON(!blk_rq_is_passthrough(rq));
>
> -       rq->end_io = done;
> -
>         blk_account_io_start(rq);
>         if (current->plug)
>                 blk_add_rq_to_plug(current->plug, rq);
> diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
> index b361583944b94..63b4f6431d2e6 100644
> --- a/drivers/block/sx8.c
> +++ b/drivers/block/sx8.c
> @@ -540,7 +540,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
>         spin_unlock_irq(&host->lock);
>
>         DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
> -       blk_execute_rq_nowait(rq, true, NULL);
> +       blk_execute_rq_nowait(rq, true);
>
>         return 0;
>
> @@ -579,7 +579,7 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
>         crq->msg_bucket = (u32) rc;
>
>         DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
> -       blk_execute_rq_nowait(rq, true, NULL);
> +       blk_execute_rq_nowait(rq, true);
>
>         return 0;
>  }
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 510e3860358bb..22aa5780623da 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1206,8 +1206,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
>         nvme_init_request(rq, &ctrl->ka_cmd);
>
>         rq->timeout = ctrl->kato * HZ;
> +       rq->end_io = nvme_keep_alive_end_io;
>         rq->end_io_data = ctrl;
> -       blk_execute_rq_nowait(rq, false, nvme_keep_alive_end_io);
> +       blk_execute_rq_nowait(rq, false);
>  }
>
>  static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 7b0e2c9cdcae3..a92cc686ffbc0 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -453,6 +453,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>                         blk_flags);
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
> +       req->end_io = nvme_uring_cmd_end_io;
>         req->end_io_data = ioucmd;
>
>         /* to free bio on completion, as req->bio will be null at that time */
> @@ -461,7 +462,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>         pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
>         pdu->meta_len = d.metadata_len;
>
> -       blk_execute_rq_nowait(req, 0, nvme_uring_cmd_end_io);
> +       blk_execute_rq_nowait(req, false);
>         return -EIOCBQUEUED;
>  }
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aacf1c0d5a5f..068dbb00c5ea9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1438,8 +1438,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>         }
>         nvme_init_request(abort_req, &cmd);
>
> +       abort_req->end_io = abort_endio;
>         abort_req->end_io_data = NULL;
> -       blk_execute_rq_nowait(abort_req, false, abort_endio);
> +       blk_execute_rq_nowait(abort_req, false);
>
>         /*
>          * The aborted req will be completed on receiving the abort req.
> @@ -2483,11 +2484,14 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>                 return PTR_ERR(req);
>         nvme_init_request(req, &cmd);
>
> +       if (opcode == nvme_admin_delete_cq)
> +               req->end_io = nvme_del_cq_end;
> +       else
> +               req->end_io = nvme_del_queue_end;
>         req->end_io_data = nvmeq;
>
>         init_completion(&nvmeq->delete_done);
> -       blk_execute_rq_nowait(req, false, opcode == nvme_admin_delete_cq ?
> -                       nvme_del_cq_end : nvme_del_queue_end);
> +       blk_execute_rq_nowait(req, false);
>         return 0;
>  }
>
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 5247c24538eba..3cc4d6709c93c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -285,8 +285,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>                 req->p.rq = rq;
>                 queue_work(nvmet_wq, &req->p.work);
>         } else {
> +               rq->end_io = nvmet_passthru_req_done;
>                 rq->end_io_data = req;
> -               blk_execute_rq_nowait(rq, false, nvmet_passthru_req_done);
> +               blk_execute_rq_nowait(rq, false);
>         }
>
>         if (ns)
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index cdaca13ac1f1c..49ef864df5816 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -2039,12 +2039,13 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
>         scmd->cmnd[4] = SCSI_REMOVAL_PREVENT;
>         scmd->cmnd[5] = 0;
>         scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
> +       scmd->allowed = 5;
>
>         req->rq_flags |= RQF_QUIET;
>         req->timeout = 10 * HZ;
> -       scmd->allowed = 5;
> +       req->end_io = eh_lock_door_done;
>
> -       blk_execute_rq_nowait(req, true, eh_lock_door_done);
> +       blk_execute_rq_nowait(req, true);
>  }
>
>  /**
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index cbffa712b9f3e..118c7b4a8af2c 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -831,7 +831,8 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
>
>         srp->rq->timeout = timeout;
>         kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
> -       blk_execute_rq_nowait(srp->rq, at_head, sg_rq_end_io);
> +       srp->rq->end_io = sg_rq_end_io;
> +       blk_execute_rq_nowait(srp->rq, at_head);
>         return 0;
>  }
>
> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> index 56a093a90b922..850172a2b8f14 100644
> --- a/drivers/scsi/st.c
> +++ b/drivers/scsi/st.c
> @@ -579,9 +579,10 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
>         memcpy(scmd->cmnd, cmd, scmd->cmd_len);
>         req->timeout = timeout;
>         scmd->allowed = retries;
> +       req->end_io = st_scsi_execute_end;
>         req->end_io_data = SRpnt;
>
> -       blk_execute_rq_nowait(req, true, st_scsi_execute_end);
> +       blk_execute_rq_nowait(req, true);
>         return 0;
>  }
>
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index 81099b68bbfbd..796a9773bf3de 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -671,11 +671,12 @@ static void ufshpb_execute_umap_req(struct ufshpb_lu *hpb,
>
>         req->timeout = 0;
>         req->end_io_data = umap_req;
> +       req->end_io = ufshpb_umap_req_compl_fn;
>
>         ufshpb_set_unmap_cmd(scmd->cmnd, rgn);
>         scmd->cmd_len = HPB_WRITE_BUFFER_CMD_LENGTH;
>
> -       blk_execute_rq_nowait(req, true, ufshpb_umap_req_compl_fn);
> +       blk_execute_rq_nowait(req, true);
>
>         hpb->stats.umap_req_cnt++;
>  }
> @@ -707,6 +708,7 @@ static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
>         blk_rq_append_bio(req, map_req->bio);
>
>         req->end_io_data = map_req;
> +       req->end_io = ufshpb_map_req_compl_fn;
>
>         if (unlikely(last))
>                 mem_size = hpb->last_srgn_entries * HPB_ENTRY_SIZE;
> @@ -716,7 +718,7 @@ static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
>                                 map_req->rb.srgn_idx, mem_size);
>         scmd->cmd_len = HPB_READ_BUFFER_CMD_LENGTH;
>
> -       blk_execute_rq_nowait(req, true, ufshpb_map_req_compl_fn);
> +       blk_execute_rq_nowait(req, true)

Missing semicolon here. Otherwise, looks good.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

