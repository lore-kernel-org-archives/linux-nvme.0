Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87957C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 03:29:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2274160FE5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 03:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2274160FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DGHpOZPxpwUUdA1j/9GQMKkng9sJGmiHEd7ABpAyDco=; b=p0Ea6k8dJ83pSwNjrrCVe8To6
	+fNg8JOLNRPTedSppv8IioxDcggfSYo8sFtl3lGXgDyy3f1QuuOlN0uYkqmFZwLDdWY72me6xlD1T
	+r1bSLErx2Ze8r/wpOEYuBEbA2wrGc+cbf2Cga+BeVS8e9E0O3qk+4L2pRj38hm7WujT1BhwmM+G1
	Tlf+Em940nvQsvF9/tkTx7cmUW7kZj4w6xtjxsKCLb6e3d8vgHX9tG3fBu0oXGAnCvJOpfAUpIDzs
	rroIW1d1cd8fTqD/vbG0uRiuEbbF84J7kKzLwYt5Ano2Jyn6DPLC5dRkOjEZfsMTtjkK70huyrt75
	phC+asJsg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTcOe-001LPT-24; Tue, 06 Apr 2021 03:28:56 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTcOZ-001LOd-54
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 03:28:53 +0000
Received: by mail-io1-xd33.google.com with SMTP id z3so11335639ioc.8
 for <linux-nvme@lists.infradead.org>; Mon, 05 Apr 2021 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mcy//HQYjiWH6i1KSvUtxYyyfu+GROCaX1a+daIUMOU=;
 b=tKMtSFlrJwis729xaj+H2BO6cLn4mel46nXAjHizFg+DpiOFZ8MU2Q7ez/afgB1bCH
 qbbSdc97FTr6qBYfBFzYcf6uBS281PjLLSfoibFDqPfnd1VO6IlFkcC0SszyshZT4Bqu
 FscvWFmR+AlaHxuZgfpSbz+sGl9Z6SSXv7+YdXFSzfWBCFBXrE/lv9U6+MM2c08Cq2rT
 GQuMOpTsKRijk92blEYFAYs7BBCRPLSucIfwvnM30i29Xy7x+nGtyefzVhEQaw/1EURo
 x54vLvhj+Rqf0zxlcjk/wDiPv3yZk1kWEAjTAPih58r2CDT0PLtSv9kZn/s8YkMEPp1N
 cz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mcy//HQYjiWH6i1KSvUtxYyyfu+GROCaX1a+daIUMOU=;
 b=h5m5oafv7aCaWxb0IMZ2sSiao+U2XkhvBKLCZztKEYSyn0nIupv+kvzmuueZh+pzt9
 ow9bp3yGTND0C56ckt8H3gNAM8mNjLn3zXCsGS2mXyZbtDmbu2JXTLW2WsbNZ1tePVwk
 A3tUF+/7Du2NKueBLiKs6H9zxou6FGlDggz1iz/UbTh7FDs+PsBxCNc2UbkrcxJIapSk
 uV2Wc0IZYYOqVSVWudnYnzrddf3kDtiGxsCQBlZMWKgcPrC7dzJID0DjI3HWmNAsYLWL
 epf8KYjmzGZnLuFLkSCqEFrRoz9UWGHTaS3EAnfeYCyzpFUN/Nv8frh4Jbi+JlQuNJJO
 gI5Q==
X-Gm-Message-State: AOAM532ZVk8Ne1TsgSwvFh5BSOppdEbgiFnQ+aG7ZQW97EsxgkslgwOW
 XjdujU4IfKxFgMyVQbV3E2uRX3sm6W+icCuhtAc70/C1QSE4Lg==
X-Google-Smtp-Source: ABdhPJwnIeJittbbq5yQkJ5cwznWFFtpbWJeZG/msQGjnhqEvB2kV/Nl94iaV9poaaErPAQn2umTte3CvTmCm2htbvM=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr21486209iop.50.1617679729315; 
 Mon, 05 Apr 2021 20:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
 <DM6PR19MB40119BA91B16B1AEA03147E4EF779@DM6PR19MB4011.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB40119BA91B16B1AEA03147E4EF779@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Date: Tue, 6 Apr 2021 11:28:38 +0800
Message-ID: <CAKHcvQgw2E8q3G633M3vb+bdCwKzfEdfG_Max7hJfrRbve0v4w@mail.gmail.com>
Subject: Re: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
To: "Grupi, Elad" <Elad.Grupi@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_042851_658442_D4B5C80B 
X-CRM114-Status: GOOD (  29.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 6, 2021 at 3:03 AM Grupi, Elad <Elad.Grupi@dell.com> wrote:
>
> Hi Hou.
>
> I tested this patch on our system and it solved the issue.

Thanks.

>
> I think there is a minor issue with the spaces indentation in the patch:
> +                   len && len < cmd->req.port->inline_data_size &&
> +                   nvme_is_write(cmd->req.cmd))

Hi Elad,
I run scripts/checkpatch.pl, there are no errors or warnings.
We could find such indentation style in many places in tcp.c
or other files.

Thanks,
Hou


>
> Thanks,
> Elad
>
> -----Original Message-----
> From: Hou Pu <houpu.main@gmail.com>
> Sent: Wednesday, 31 March 2021 12:13
> To: houpu.main@gmail.com; Grupi, Elad
> Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
> Subject: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing error
>
>
> [EXTERNAL EMAIL]
>
> From: Elad Grupi <elad.grupi@dell.com>
>
> In case there is an io that contains inline data and it goes to parsing error flow, command response will free command and iov before clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> ---
>  drivers/nvme/target/tcp.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index d658c6e8263a..0759eef3f4da 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -525,11 +525,36 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>         struct nvmet_tcp_cmd *cmd =
>                 container_of(req, struct nvmet_tcp_cmd, req);
>         struct nvmet_tcp_queue  *queue = cmd->queue;
> +       struct nvme_sgl_desc *sgl;
> +       u32 len;
> +
> +       if (unlikely(cmd == queue->cmd)) {
> +               sgl = &cmd->req.cmd->common.dptr.sgl;
> +               len = le32_to_cpu(sgl->length);
> +
> +               /*
> +                * Wait for inline data before processing the response.
> +                * Avoid using helpers, this might happen before
> +                * nvmet_req_init is completed.
> +                */
> +               if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
> +                   len && len < cmd->req.port->inline_data_size &&
> +                   nvme_is_write(cmd->req.cmd))
> +                       return;
> +       }
>
>         llist_add(&cmd->lentry, &queue->resp_list);
>         queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);  }
>
> +static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd) {
> +       if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +               nvmet_tcp_queue_response(&cmd->req);
> +       else
> +               cmd->req.execute(&cmd->req);
> +}
> +
>  static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)  {
>         u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue); @@ -961,7 +986,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>                         le32_to_cpu(req->cmd->common.dptr.sgl.length));
>
>                 nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -               return -EAGAIN;
> +               return 0;
>         }
>
>         ret = nvmet_tcp_map_data(queue->cmd);
> @@ -1104,10 +1129,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>                 return 0;
>         }
>
> -       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -           cmd->rbytes_done == cmd->req.transfer_len) {
> -               cmd->req.execute(&cmd->req);
> -       }
> +       if (cmd->rbytes_done == cmd->req.transfer_len)
> +               nvmet_tcp_execute_request(cmd);
>
>         nvmet_prepare_receive_pdu(queue);
>         return 0;
> @@ -1144,9 +1167,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>                 goto out;
>         }
>
> -       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -           cmd->rbytes_done == cmd->req.transfer_len)
> -               cmd->req.execute(&cmd->req);
> +       if (cmd->rbytes_done == cmd->req.transfer_len)
> +               nvmet_tcp_execute_request(cmd);
> +
>         ret = 0;
>  out:
>         nvmet_prepare_receive_pdu(queue);
> --
> 2.28.0
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
