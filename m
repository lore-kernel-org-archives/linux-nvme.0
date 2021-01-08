Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCFC433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7447A23AC0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7447A23AC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aR5GGrulTE9YDbMtgYbPeLEzF2ureHGowe4WINXXeAI=; b=Q4JrW8wYjU/LvniFlKyj3ACdC
	miCTLcpKtC4IKG0ih7BR+59TMmstNVn/zlvFSrC8uxVvzgMNFNKpObFF6IgdyDVEfaggNCoNsmqZ8
	vJ86Pzz7IZBdA0vb56EvTCz/7ZxitLeGDnjE/z5hZzgdIul+yuy2rA6Oe2uPLKHSY9+Il+KFDjNg1
	7sb4Iuzdon66UMYaTUb0oy/3d91wNYzV6WOdn66aFPl0rIr7aQ8RwmlivXY1SEYN9VS4jgUQvc7wS
	q3Ex7QHsc+VCDh5bdKS4iPQ6LcGHJ1PasbfZjDH1TOqVOKriN7InhSv6amSp5D0HBiBuvPbbsciOx
	I5DLAs8QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxyIo-0003bc-IO; Fri, 08 Jan 2021 20:24:06 +0000
Received: from mail-oi1-f172.google.com ([209.85.167.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxyIk-0003aY-L6
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 20:24:04 +0000
Received: by mail-oi1-f172.google.com with SMTP id d203so12805332oia.0
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 12:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gkHlTk67HT9dIY8TS2DWa8VjYb84w7fj1W1Xt1Mo/cs=;
 b=mzeszCVMyGymZs4wshIEG+kYCcXNNOtsURuiQ+HvpyJvKYEVam79xwS+T9U6nVsU7X
 t2RxxKQ66OhdzX+CHY+25dQCWo0vkmab/KPCI6KxYmRdUd3H41SMCkPkcOQIZJ7UkHGj
 7JXH+tk67tVdxImBpOCG3LNxuAMT83q+VdWZZZetGBbMYBIN3dNlhC3EvNqezD+yX/nK
 pU3S4WtggAoQEoIr6DhegfWS/Li319tC73FOLH836cxK+oasGbmRsk1MEBk/TK5bUR65
 ZaUEJD6zD/jHrYR3QGx+5kWWkcuhk/zYpv4WEadLpw/Eaa/TH/M23KNc03kD3HBQCw5F
 xMCA==
X-Gm-Message-State: AOAM531OQc3t0kDRAWyCraBXINv8SDdZr6jyfQreVprxdHDybWe4Ryeh
 oqzrOpRytTEanA16MfPwKtc=
X-Google-Smtp-Source: ABdhPJwXLXvHuY6rel13XrIBKrjdwvOI7RjspLrO2LXFpg5DXjEAhcX06I9PYVbfcBIZdWU5HVDDhg==
X-Received: by 2002:aca:bac3:: with SMTP id k186mr3307536oif.93.1610137441736; 
 Fri, 08 Jan 2021 12:24:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:bedd:602e:8a53:5431?
 ([2600:1700:65a0:78e0:bedd:602e:8a53:5431])
 by smtp.gmail.com with ESMTPSA id c18sm2180159oib.31.2021.01.08.12.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 12:24:00 -0800 (PST)
Subject: Re: kernel panic in nvmet_tcp when receiving malformed admin command
From: Sagi Grimberg <sagi@grimberg.me>
To: "Engel, Amit" <Amit.Engel@Dell.com>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
 <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <DS7PR19MB4439372515F931BA5A1578ABEED30@DS7PR19MB4439.namprd19.prod.outlook.com>
 <dec5fc1d-62d6-1c1e-e2f8-4aa5aeb084af@grimberg.me>
Message-ID: <2f2b2df4-ba06-a7ae-23cf-31eb17998c6e@grimberg.me>
Date: Fri, 8 Jan 2021 12:23:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dec5fc1d-62d6-1c1e-e2f8-4aa5aeb084af@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_152402_743293_6D046C58 
X-CRM114-Status: GOOD (  20.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Sagi, is the patch addressing the below issue is already out there?
> 
> No, thanks for reminding me, I'll have a look into this.

Amit, Ran,

Does this solve your issue?
This needs to split to patches but would be good to understand
if this works.
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..c41902f7ce39 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -204,7 +204,6 @@ nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
         cmd->rbytes_done = cmd->wbytes_done = 0;
         cmd->pdu_len = 0;
         cmd->pdu_recv = 0;
-       cmd->iov = NULL;
         cmd->flags = 0;
         return cmd;
  }
@@ -294,6 +293,7 @@ static void nvmet_tcp_unmap_pdu_iovec(struct 
nvmet_tcp_cmd *cmd)

         for (i = 0; i < cmd->nr_mapped; i++)
                 kunmap(sg_page(&sg[i]));
+       cmd->nr_mapped = 0;
  }

  static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
@@ -341,6 +341,14 @@ static void nvmet_tcp_socket_error(struct 
nvmet_tcp_queue *queue, int status)
                 nvmet_tcp_fatal_error(queue);
  }

+static void nvmet_tcp_unmap_data(struct nvmet_tcp_cmd *cmd)
+{
+       kfree(cmd->iov);
+       cmd->iov = NULL;
+       sgl_free(cmd->req.sg);
+       cmd->req.sg = NULL;
+}
+
  static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
  {
         struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
@@ -375,6 +383,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
         return 0;
  err:
         sgl_free(cmd->req.sg);
+       cmd->req.sg = NULL;
         return NVME_SC_INTERNAL;
  }

@@ -571,17 +580,13 @@ static int nvmet_try_send_data(struct 
nvmet_tcp_cmd *cmd, bool last_in_batch)
         } else {
                 if (queue->nvme_sq.sqhd_disabled) {
                         cmd->queue->snd_cmd = NULL;
+                       nvmet_tcp_unmap_data(cmd);
                         nvmet_tcp_put_cmd(cmd);
                 } else {
                         nvmet_setup_response_pdu(cmd);
                 }
         }

-       if (queue->nvme_sq.sqhd_disabled) {
-               kfree(cmd->iov);
-               sgl_free(cmd->req.sg);
-       }
-
         return 1;

  }
@@ -609,9 +614,8 @@ static int nvmet_try_send_response(struct 
nvmet_tcp_cmd *cmd,
         if (left)
                 return -EAGAIN;

-       kfree(cmd->iov);
-       sgl_free(cmd->req.sg);
         cmd->queue->snd_cmd = NULL;
+       nvmet_tcp_unmap_data(cmd);
         nvmet_tcp_put_cmd(cmd);
         return 1;
  }
@@ -665,6 +669,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd 
*cmd, bool last_in_batch)

         if (queue->nvme_sq.sqhd_disabled) {
                 cmd->queue->snd_cmd = NULL;
+               nvmet_tcp_unmap_data(cmd);
                 nvmet_tcp_put_cmd(cmd);
         } else {
                 nvmet_setup_response_pdu(cmd);
@@ -1082,15 +1087,16 @@ static int nvmet_tcp_try_recv_data(struct 
nvmet_tcp_queue *queue)

         nvmet_tcp_unmap_pdu_iovec(cmd);

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len) {
-               if (queue->data_digest) {
-                       nvmet_tcp_prep_recv_ddgst(cmd);
-                       return 0;
-               }
-               cmd->req.execute(&cmd->req);
+       if (queue->data_digest) {
+               nvmet_tcp_prep_recv_ddgst(cmd);
+               return 0;
         }

+       if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+               nvmet_tcp_finish_cmd(cmd);
+       else if (cmd->rbytes_done == cmd->req.transfer_len)
+               cmd->req.execute(&cmd->req);
+
         nvmet_prepare_receive_pdu(queue);
         return 0;
  }
@@ -1120,14 +1126,16 @@ static int nvmet_tcp_try_recv_ddgst(struct 
nvmet_tcp_queue *queue)
                         queue->idx, cmd->req.cmd->common.command_id,
                         queue->pdu.cmd.hdr.type, 
le32_to_cpu(cmd->recv_ddgst),
                         le32_to_cpu(cmd->exp_ddgst));
+               nvmet_req_uninit(&cmd->req);
                 nvmet_tcp_finish_cmd(cmd);
                 nvmet_tcp_fatal_error(queue);
                 ret = -EPROTO;
                 goto out;
         }

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len)
+       if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+               nvmet_tcp_finish_cmd(cmd);
+       else if (cmd->rbytes_done == cmd->req.transfer_len)
                 cmd->req.execute(&cmd->req);
         ret = 0;
  out:
@@ -1139,7 +1147,8 @@ static int nvmet_tcp_try_recv_one(struct 
nvmet_tcp_queue *queue)
  {
         int result = 0;

-       if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
+       if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR ||
+                    queue->state == NVMET_TCP_Q_DISCONNECTING))
                 return 0;

         if (queue->rcv_state == NVMET_TCP_RECV_PDU) {
@@ -1333,10 +1342,26 @@ static void 
nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)

  static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
  {
-       nvmet_req_uninit(&cmd->req);
         nvmet_tcp_unmap_pdu_iovec(cmd);
-       kfree(cmd->iov);
-       sgl_free(cmd->req.sg);
+       nvmet_tcp_unmap_data(cmd);
+       nvmet_tcp_put_cmd(cmd);
+}
+
+static void nvmet_tcp_unmap_cmds(struct nvmet_tcp_queue *queue)
+{
+       struct nvmet_tcp_cmd *cmd = queue->cmds;
+       int i;
+
+       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
+               nvmet_tcp_unmap_pdu_iovec(cmd);
+               nvmet_tcp_unmap_data(cmd);
+       }
+
+       if (!queue->nr_cmds) {
+               /* failed in connect */
+               nvmet_tcp_unmap_pdu_iovec(cmd);
+               nvmet_tcp_unmap_data(cmd);
+       }
  }

  static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
@@ -1346,12 +1371,12 @@ static void nvmet_tcp_uninit_data_in_cmds(struct 
nvmet_tcp_queue *queue)

         for (i = 0; i < queue->nr_cmds; i++, cmd++) {
                 if (nvmet_tcp_need_data_in(cmd))
-                       nvmet_tcp_finish_cmd(cmd);
+                       nvmet_req_uninit(&cmd->req);
         }

         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
                 /* failed in connect */
-               nvmet_tcp_finish_cmd(&queue->connect);
+               nvmet_req_uninit(&cmd->req);
         }
  }

@@ -1370,6 +1395,7 @@ static void nvmet_tcp_release_queue_work(struct 
work_struct *w)
         nvmet_tcp_uninit_data_in_cmds(queue);
         nvmet_sq_destroy(&queue->nvme_sq);
         cancel_work_sync(&queue->io_work);
+       nvmet_tcp_unmap_cmds(queue);
         sock_release(queue->sock);
         nvmet_tcp_free_cmds(queue);
         if (queue->hdr_digest || queue->data_digest)
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
