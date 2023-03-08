Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082F3C64EC4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISfAQu9wKsKEwf6EqUAvt5CYh7GPx/RMRttbgYkfGAQ=; b=YQ6wJ7kVm6rCjkahavDFeyRVt7
	qqBa+keb3AobtxbLbVi2Em6XER2+s/awD8C1UK+USvEmuTgQE4UNRbHLeQBAt9d28kqm0JLzBW+jC
	Cou/PKlf9KPvlxckpSELJ41EuvOemUyeo7e53ZHG6famjkLAhulN+4Nz821AEafhKY2iaCNP9Yku+
	P4xAR+g3iO21z+3wDfFekeyfTua7THiID62FsqRmKlLyy4xkCxmy2qoy4AZ02Bw2ZuzePDQfuJCgj
	w0E1EfGNk95LWUQLgOAxKkHEJ8b8Fjj2LEVfK+ZrT+xSenGEBt6f2/eVZbLsEuvAHwJH2xQOrSahc
	Spia0Abw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrdB-004XcG-EB; Wed, 08 Mar 2023 11:06:49 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrd5-004Xaj-L7
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 11:06:45 +0000
Received: by mail-wr1-f42.google.com with SMTP id bx12so14937279wrb.11
        for <linux-nvme@lists.infradead.org>; Wed, 08 Mar 2023 03:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISfAQu9wKsKEwf6EqUAvt5CYh7GPx/RMRttbgYkfGAQ=;
        b=jpm+LJ1Q4Er05OOha2Coy4xgqt/T8mNNFOntyfrXg5XyWL/o+hesD/D8f+MoL5DrNl
         2c5mqgHc3PfruEdQ4CVn6IExpgu1cuyZa6fzE3AjoFuVWmIvyhslLsUU+DPoV2Yqs9ae
         zCcMvHYIB5xwz5y26ScBLJ4uBgJ2Pode30Tmlsn6gVclrFMarTFRWsOySEATaBXNahn4
         QDfsEb09B3hKTNOiW+OopTSMJamMQre38yrW/nPS4B1QUb/dfJKs/Ib9mbcnzjOMDQkc
         BxMVHUwuRON8DHXzBnah0XjfFbylHSYb2xikndKHg9nur/ztEqNQsfN9alkIW9KV1dmI
         yb4Q==
X-Gm-Message-State: AO0yUKUxck0Z7SdFqi6BTjRMmPTYspFRWFvFhB7ccCRjZj7/FyTSM1lD
	UoyiC3U2RYu1k4WMuImF+k4=
X-Google-Smtp-Source: AK7set9rbLj9zz9dqqpvqgqIse6w8ImplQCay2UE85nflRlsI9ssvr4SQpE46lQYp+CeY7/qrvOAMQ==
X-Received: by 2002:adf:e2c4:0:b0:2c7:17df:507c with SMTP id d4-20020adfe2c4000000b002c717df507cmr9257006wrj.2.1678273599132;
        Wed, 08 Mar 2023 03:06:39 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j29-20020a5d6e5d000000b002c59f18674asm14890941wrz.22.2023.03.08.03.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:06:38 -0800 (PST)
Message-ID: <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
Date: Wed, 8 Mar 2023 13:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>
References: <20230307163045.5882-1-akinobu.mita@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230307163045.5882-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_030643_724883_1ED4D441 
X-CRM114-Status: GOOD (  20.87  )
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


> In timeout and error handling, various information is reported about the
> command in error, but the printed opcode may not be correct
> 
> The opcode is obtained from the nvme_command structure referenced by the
> 'cmd' member in the nvme_request structure.
> (i.e. nvme_req(req)->cmd->common.opcode)
> 
> For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
> points to a structure within the page fragment allocated by
> nvme_tcp_init_request().  This page fragment is used as a command capsule
> PDU, and then may be reused as a h2c data PDU, so the nvme_command
> referenced by the 'cmd' member has already been overwritten.
> 
> To fix this problem, when setting up the nvme_command, keep the opcode in
> a newly added member in the nvme_tcp_request and use that instead.

I'm wandering if we should just not reuse the cmd pdu for a subsequent
data pdu...

It will take more space allocated per request (up to a few MBs for lots
of requests and controllers)...

but will prevent from propagating this to nvme core...

Something like the below (untested):
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ef27122acce6..ffbcd5c7cb26 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -207,6 +207,16 @@ static inline u8 nvme_tcp_ddgst_len(struct 
nvme_tcp_queue *queue)
         return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
  }

+static inline void *nvme_tcp_req_cmd_pdu(struct nvme_tcp_request *req)
+{
+       return req->pdu;
+}
+
+static inline void *nvme_tcp_req_data_pdu(struct nvme_tcp_request *req)
+{
+       return req->pdu + sizeof(struct nvme_tcp_cmd_pdu);
+}
+
  static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_request 
*req)
  {
         if (nvme_is_fabrics(req->req.cmd))
@@ -470,7 +480,8 @@ static int nvme_tcp_init_request(struct 
blk_mq_tag_set *set,
         u8 hdgst = nvme_tcp_hdgst_len(queue);

         req->pdu = page_frag_alloc(&queue->pf_cache,
-               sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
+               sizeof(struct nvme_tcp_cmd_pdu) +
+               sizeof(struct nvme_tcp_data_pdu) + hdgst,
                 GFP_KERNEL | __GFP_ZERO);
         if (!req->pdu)
                 return -ENOMEM;
@@ -613,7 +624,7 @@ static int nvme_tcp_handle_comp(struct 
nvme_tcp_queue *queue,

  static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
  {
-       struct nvme_tcp_data_pdu *data = req->pdu;
+       struct nvme_tcp_data_pdu *data = nvme_tcp_req_data_pdu(req);
         struct nvme_tcp_queue *queue = req->queue;
         struct request *rq = blk_mq_rq_from_pdu(req);
         u32 h2cdata_sent = req->pdu_len;
@@ -1035,7 +1046,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
  static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
  {
         struct nvme_tcp_queue *queue = req->queue;
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         bool inline_data = nvme_tcp_has_inline_data(req);
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         int len = sizeof(*pdu) + hdgst - req->offset;
@@ -1074,7 +1085,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
nvme_tcp_request *req)
  static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
  {
         struct nvme_tcp_queue *queue = req->queue;
-       struct nvme_tcp_data_pdu *pdu = req->pdu;
+       struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         int len = sizeof(*pdu) - req->offset + hdgst;
         int ret;
@@ -2281,7 +2292,7 @@ static enum blk_eh_timer_return 
nvme_tcp_timeout(struct request *rq)
  {
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
         struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
         int qid = nvme_tcp_queue_id(req->queue);

@@ -2320,7 +2331,7 @@ static blk_status_t nvme_tcp_map_data(struct 
nvme_tcp_queue *queue,
                         struct request *rq)
  {
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         struct nvme_command *c = &pdu->cmd;

         c->common.flags |= NVME_CMD_SGL_METABUF;
@@ -2340,7 +2351,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
                 struct request *rq)
  {
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         struct nvme_tcp_queue *queue = req->queue;
         u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
         blk_status_t ret;
--

