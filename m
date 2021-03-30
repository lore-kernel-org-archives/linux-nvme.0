Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB2C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 05:49:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61B261585
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 05:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61B261585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jgaOMzWOQhVYvqZmehreRlAquUizTTlS2cA6/0hToms=; b=WJfGeXhTNYhTdfaPbzrp5ljLC
	aBVEHIvTFeOdPJodg2rsk72U4l6MHnVQ+1Y72h9NR9OvSC6xXuqzIet0Ds9emmi9WzohBt7NjOAqQ
	u0fnGU8tJ+vEavntEpQLNmoM0JT/cIwYwegNxiavzUM1f7ezH5fISsqXvjNUq8fLKRGy8YeoVmyrY
	YvnTruuEIjQuNnPPd3RHhvQ2mIZpXe3hHF5AgnEiWywQya6O+6e4sNByM9dBiaEafUKMrdKYW5iSJ
	vwC2zx56cY+h6CmwpjSKfoGc4CNe7bY97QKjKPwEl4aHnjdCPefFJuHT8jlt+HSPC12SMV+13Plg2
	S53FwE1VQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lR7FZ-002n4G-7v; Tue, 30 Mar 2021 05:49:13 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lR7FN-002n3P-Vn
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 05:49:03 +0000
Received: by mail-pg1-x530.google.com with SMTP id v186so10915574pgv.7
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6QKm7AJGCOYlLqPfujwjj+NGOKxgnhkUNEhRvj17pbI=;
 b=n19E18iRlgzLbkswPEAdtN6yKbHC5ucty2pAkforC5MuNK2XzMD4cNxRUuuZQJt6Kv
 5ulm5USWtF5aFlsQUvM6iLZ3XrnA5BXaF2qPD7hjRPLX5A69KUduzn8bkqNYgZ5NaGBT
 5hCZ0eAJphegy7Qn8xNUZokDkssukQyAcoF+bcU4Qwrxa0DVIMBB1XMsbIUZyrz/ZhzN
 qCDGLoS+Q86soSpmyOPUTT12Ntsc9zb2q0NRLW3y/twpJ090bJsGwmP0K/JSWPiyN0eK
 m7hin6JN4U3P+kfn6aoreFLxTUGyvn75q1RfF9cyvTmRjBr0p4igHTrk+5piC38V798Y
 oHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6QKm7AJGCOYlLqPfujwjj+NGOKxgnhkUNEhRvj17pbI=;
 b=YauUtPzDm5uoLw4C3k5BdafWKQmXkYOFpwykgriRNp+VYr3wv4lb5jUowdOBoQPtqd
 gEBI9+BLVHlE+TYRnldcWp5dDWSI3fgmBIsr1EvKX59K3oCv+9wQTZmM7y9Gknxmp4Fx
 92mefcX6TZZE/l+idxavd8Xg2MiEkFOx6+BlwTxMClzSpYdGr9ovdCYLcX52Y3vUN/VF
 mm7z2W8K0SB59fHGmQfovPXzvGA6uyznWcQhbXPIXm969N8Cn1fZG8/oXOgPI2acqkSb
 7puseS74kRoNLGtI1hvvshyOqHQkb+Zgi/gdcKCkmTjmlLWIysYz3zRF3u9bHpul7zxs
 SVnA==
X-Gm-Message-State: AOAM533GZGDa+fHVtHVCOC93AMLNhAPpN2dCBtRYO5GAlj/cTwAvuMzY
 EJprMNhOhHgNItgtMr/hCfA=
X-Google-Smtp-Source: ABdhPJxn7L2CsdA8CN08zOBp1QczTGlBzqBS0td4cg7Qs7fQa2eE1FgNXzaliB0O/+RVEhpG/kga+g==
X-Received: by 2002:a63:e19:: with SMTP id d25mr20518591pgl.24.1617083340512; 
 Mon, 29 Mar 2021 22:49:00 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id h68sm18797382pfe.111.2021.03.29.22.48.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Mar 2021 22:49:00 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: houpu.main@gmail.com
Cc: elad.grupi@dell.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Tue, 30 Mar 2021 13:48:49 +0800
Message-Id: <20210330054849.5596-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210330041219.3069-1-houpu.main@gmail.com>
References: <20210330041219.3069-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_064902_289559_065DFA77 
X-CRM114-Status: GOOD (  22.33  )
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

On Tue, 30 Mar 2021 12:12:19 +0800, Hou Pu wrote:
> On Date: Mon, 29 Mar 2021 21:01:25 +0300, Elad Grupi wrote:
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 70cc507d1565..41102fc09595 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -525,11 +525,34 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
> >  	struct nvmet_tcp_cmd *cmd =
> >  		container_of(req, struct nvmet_tcp_cmd, req);
> >  	struct nvmet_tcp_queue	*queue = cmd->queue;
> > +	struct nvme_sgl_desc *sgl;
> > +	u32 len;
> > +
> > +	if (unlikely(cmd == queue->cmd)) {
> > +		sgl = &cmd->req.cmd->common.dptr.sgl;
> > +		len = le32_to_cpu(sgl->length);
> > +
> > +		/*
> > +		 * Wait for inline data before processing the response.
> > +		 * Avoid using helpers, this might happen before
> > +		 * nvmet_req_init is completed.
> > +		 */
> > +		if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
> > +			return;
>
> Is it queue->rcv_state ?
> I tried this patch, the identify command could get here. And nvme connect could hang.
> We need to figure out a way to tell if it needs abort queue the request. Or maybe we
> could use the v2 version.

Adding nvme_is_write() would solve the problem.
Also as we skip queue queue->io_work, we should return
0 instead -EAGAIN like below to consume the inline data
in nvmet_tcp_try_recv_one(). Or the io_work might not
have a chance to run.

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a10a3bd59..f3d117771 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -537,7 +537,8 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
                 * Avoid using helpers, this might happen before
                 * nvmet_req_init is completed.
                 */
-               if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
+               if (len && queue->rcv_state == NVMET_TCP_RECV_PDU &&
+                   nvme_is_write(cmd->req.cmd))
                        return;
        }

@@ -984,7 +985,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
                        le32_to_cpu(req->cmd->common.dptr.sgl.length));

                nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-               return -EAGAIN;
+               return 0;
        }

        ret = nvmet_tcp_map_data(queue->cmd);


Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
