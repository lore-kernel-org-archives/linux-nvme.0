Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C9C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 23:23:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E9B61151
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 23:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E9B61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w7P4+TdxbEQe9exEzZF5ZDagWHWei28ODhFIx15w2T8=; b=ljZ1vHcBHxPndw5ZSe5Hvn0B8
	a0p9MeEMhvWbx6YgTI97mb/fNo6/Hk978JcI+ZDZfyZSRSFdVUqGu86noK91vtRUafyaWHUkJ/aQU
	J1AvZbbArnCMZLWnBnxQbUppNe+ZLXTVQgcHzZESpX9JtUAuGPoUl6SwowSQwqu4taiGwKIq5pk/6
	nFoUYgKbirgUICUdaeGhXTDojbrGvTmD6uStRTpiqrnNDyaePBpqMNjxk99s9Tj8wngRlf81FohA4
	uGJlRXLjbWOd5L2W+PNsP5uNCKTXKGz8Hid21ttFWUkNHTY/F2SA6QphSPDCW4MhFamnr6SZcf48R
	bZFkvrUgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf9nu-008HCG-AN; Fri, 07 May 2021 23:22:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf9nt-008HBz-0S
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 23:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=AeMAgGMTkDgLFETy4/5ZhdU7A3yaAgfsfiIqjLKnijw=; b=RUGPXS0KQxHstqURkrl/ZWZSpH
 wY4tgtaJtIIdCIP84RS+0svM8pwZ4c+jdvEvPTJ4bnTLcriXUS2L485y5ay37Ju6KXaftgB1OGoxT
 1Btu4+I6wvw2dgOmjvdToJw396EdmvutyDPc/biSu/zki14InauzucDBY/wAgewBt5oP60E1WMYuK
 u83ifkt2VW1x/MU7SPJzhps6IGY5KY+58XU4mZIoIAH79Guy2uRnWRYMJwRRUJ0ZM2mpNK8uEB3zT
 kaGls3Vm72H38i0MBXBEIbTsWdQ6FIEa8RQnsGOTzkvvgV6RiytJEK82ATJOqKDPV27dejVwLz8Wp
 8rOmm9qg==;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf9np-007FIi-UW
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 23:22:39 +0000
Received: by mail-wr1-f45.google.com with SMTP id a4so10776808wrr.2
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 16:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AeMAgGMTkDgLFETy4/5ZhdU7A3yaAgfsfiIqjLKnijw=;
 b=ZjHv14MDrzSz3vUwd1xo2219erM7CO9kt72x4uoTawZiBFOEIz7Or8zWq2586tsk/2
 vdKn1qrLUly8UErSUrW3XlLrqyjwKn1TmNv0V8SeSbdzsJjThMFXW6hVIgvlfZGqkloG
 4zythxZkSvPVoxxCBQM5UQ58vVEyuIMc7gWSqTc1kK6ljFfsCfZ59LwR4DfDyVs8vy3e
 sYQ+jMGRrKqGOFm+ZKVzW1P47pIxirLpTHuTMc756IkfShupMwsbzi/2WK43uuIgvnGP
 PBuOYPkNj25ci21seuBUVx0Z/YmbN/MFJ2luucQxDTvpA9jvqd0hJA1jlEWmRm6MbtBH
 f14w==
X-Gm-Message-State: AOAM531ULP/ysBQmGwV+6kBuGS4gTtZYwVRFZrmij8afpDPT+1BPrzML
 NNeti1Bo45+TWFSqFtoesew=
X-Google-Smtp-Source: ABdhPJy2p4vW4Ry9KxdXZerkIqNmXSbHpniiWGU+uZG0+Cs4IUGrqeWKmnZuBI6p8BPp1iPFggxxuQ==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr15534517wrc.346.1620429756228; 
 Fri, 07 May 2021 16:22:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d07b:68ce:2d70:258f?
 ([2601:647:4802:9070:d07b:68ce:2d70:258f])
 by smtp.gmail.com with ESMTPSA id y17sm11296111wrw.90.2021.05.07.16.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 16:22:35 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
Date: Fri, 7 May 2021 16:22:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_162238_029865_9601D4BC 
X-CRM114-Status: GOOD (  22.27  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Well, that would require a modification to the CQE specification, no?
>>> fmds was not amused when I proposed that :-(
>>
>> Why would that require a modification to the CQE? it's just using say
>> 4 msbits of the command_id to a running sequence...
> 
> I think Hannes was under the impression that the counter proposal wasn't
> part of the "command_id". The host can encode whatever it wants in that
> value, and the controller just has to return the same value.

Yea, maybe something like this?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6612971f4eb..7af48827ea56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1006,7 +1006,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
struct request *req)
                 return BLK_STS_IOERR;
         }

-       cmd->common.command_id = req->tag;
+       cmd->common.command_id = nvme_cid(req);
         trace_nvme_setup_cmd(req, cmd);
         return ret;
  }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..96abfb0e2ddd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -158,6 +158,7 @@ enum nvme_quirks {
  struct nvme_request {
         struct nvme_command     *cmd;
         union nvme_result       result;
+       u8                      genctr;
         u8                      retries;
         u8                      flags;
         u16                     status;
@@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
  };

+/*
+ * nvme command_id is constructed as such:
+ * | xxxx | xxxxxxxxxxxx |
+ *   gen    request tag
+ */
+#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
+#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
+#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
+
+static inline u16 nvme_cid(struct request *rq)
+{
+       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
+}
+
+static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
+               u16 command_id)
+{
+       u8 genctr = nvme_genctr_from_cid(command_id);
+       u16 tag = nvme_tag_from_cid(command_id);
+       struct request *rq;
+
+       rq = blk_mq_tag_to_rq(tags, tag);
+       if (unlikely(!rq)) {
+               pr_err("could not locate request for tag %#x\n",
+                       tag);
+               return NULL;
+       }
+       if (unlikely(nvme_req(rq)->genctr != genctr)) {
+               dev_err(nvme_req(rq)->ctrl->device,
+                       "request %#x genctr mismatch (got %#x expected 
%#x)\n",
+                       tag, nvme_req(rq)->genctr, genctr);
+               return NULL;
+       }
+       return rq;
+}
+
+static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
+                u16 command_id)
+{
+       return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
+}
+
  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
  void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
                             const char *dev_name);
@@ -594,7 +637,8 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)

  static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
  {
-       return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
+       return !qid &&
+               nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
  }

  void nvme_complete_rq(struct request *req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..92e03f15c9f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1017,7 +1017,7 @@ static inline void nvme_handle_cqe(struct 
nvme_queue *nvmeq, u16 idx)
                 return;
         }

-       req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
+       req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
         if (unlikely(!req)) {
                 dev_warn(nvmeq->dev->ctrl.device,
                         "invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 203b47a8ec92..ab5b7d175488 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1727,10 +1727,10 @@ static void nvme_rdma_process_nvme_rsp(struct 
nvme_rdma_queue *queue,
         struct request *rq;
         struct nvme_rdma_request *req;

-       rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
+       rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "tag 0x%x on QP %#x not found\n",
+                       "got bad command_id %#x on QP %#x\n",
                         cqe->command_id, queue->qp->qp_num);
                 nvme_rdma_error_recovery(queue->ctrl);
                 return;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 919f6fe69cb3..c51b70aec6dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -488,11 +488,11 @@ static int nvme_tcp_process_nvme_cqe(struct 
nvme_tcp_queue *queue,
  {
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag 0x%x not found\n",
-                       nvme_tcp_queue_id(queue), cqe->command_id);
+                       "got bad cqe.command_id %#x on queue %d\n",
+                       cqe->command_id, nvme_tcp_queue_id(queue));
                 nvme_tcp_error_recovery(&queue->ctrl->ctrl);
                 return -EINVAL;
         }
@@ -509,11 +509,11 @@ static int nvme_tcp_handle_c2h_data(struct 
nvme_tcp_queue *queue,
  {
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag %#x not found\n",
-                       nvme_tcp_queue_id(queue), pdu->command_id);
+                       "got bad c2hdata.command_id %#x on queue %d\n",
+                       pdu->command_id, nvme_tcp_queue_id(queue));
                 return -ENOENT;
         }

@@ -600,7 +600,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct 
nvme_tcp_request *req,
         data->hdr.plen =
                 cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
         data->ttag = pdu->ttag;
-       data->command_id = rq->tag;
+       data->command_id = nvme_cid(rq);
         data->data_offset = cpu_to_le32(req->data_sent);
         data->data_length = cpu_to_le32(req->pdu_len);
         return 0;
@@ -613,11 +613,11 @@ static int nvme_tcp_handle_r2t(struct 
nvme_tcp_queue *queue,
         struct request *rq;
         int ret;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
         if (!rq) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag %#x not found\n",
-                       nvme_tcp_queue_id(queue), pdu->command_id);
+                       "got bad r2t.command_id %#x on queue %d\n",
+                       pdu->command_id, nvme_tcp_queue_id(queue));
                 return -ENOENT;
         }
         req = blk_mq_rq_to_pdu(rq);
@@ -699,7 +699,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
         struct nvme_tcp_request *req;
         struct request *rq;

-       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
         req = blk_mq_rq_to_pdu(rq);

         while (true) {
@@ -794,8 +794,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue 
*queue,
         }

         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-               struct request *rq = 
blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-                                               pdu->command_id);
+               struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+                                       pdu->command_id);

                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                 queue->nr_cqe++;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1b89a6bb819a..9f1f5d572960 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -107,10 +107,10 @@ static void nvme_loop_queue_response(struct 
nvmet_req *req)
         } else {
                 struct request *rq;

-               rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), 
cqe->command_id);
+               rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
                 if (!rq) {
                         dev_err(queue->ctrl->ctrl.device,
-                               "tag 0x%x on queue %d not found\n",
+                               "got bad command_id %#x on queue %d\n",
                                 cqe->command_id, 
nvme_loop_queue_idx(queue));
                         return;
                 }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
