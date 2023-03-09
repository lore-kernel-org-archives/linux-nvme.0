Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82438C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTw3d7pcKPegUBQS56tzFOKTRRcDq70XB0ZdvbkHN8s=; b=ZobLuGPA8j86gwStSpf8Po8nMG
	DAY0cB38/qVWsuI4PZTr51ZKsgxVKncN90w7EOJamrpJsZhsvrA4aWQNn20P1VwOknbsd3WNssBQE
	3mdyK+6IjGOfPnzbZqN3idSJykab+zPvYlFm/8gsEjkg3bF/LHc1yzvNQcCE38WSGjMGMkw5eMRdy
	rjVQesGQI1tL9lLB7fgxPbzznl545yVvp0EEkSiwKWLr90/NcSzPA2pI/JM0rSCNRV0t67BhzZ0OQ
	FEsLJFpRay5+knqyftw1rzi5vOhe4z/6GO4TXBKyA+WVaAzHYFUaXgDK15kG5bUtn4WWVkTLhgU0Z
	JSCNGUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCIB-008iyG-3q; Thu, 09 Mar 2023 09:10:31 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCI7-008iwn-O6
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 09:10:29 +0000
Received: by mail-wm1-f41.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3057705wmq.1
        for <linux-nvme@lists.infradead.org>; Thu, 09 Mar 2023 01:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTw3d7pcKPegUBQS56tzFOKTRRcDq70XB0ZdvbkHN8s=;
        b=P/vzNdSN+Iey1zqQefir8lvpptDWt1QaRkgNPTMW0m+ij4BLczUUbZmbWwRQ92+MDW
         EKxmKHcYgq604iXDhdIfWOlSqCF3KKDEYPHlFoF96/dRU7VK36QGWNDZWJh0Zo2MzlkJ
         hn6L/G8qz73FWRHM/eBX/nyRno3ufJgTTAVHw0hkwWS9Zr/usLmCt3V/Q6n/jr6LCboi
         /uuN/LD6slouZ8xglef1Punb1iXjazWv1xOL9H8iPY3aqvKcqqkn8nwmOMrihNlTMJHX
         JvBfXew8eBJaE2fyny+w2nDww4DxmmpAxPOON+SSJHBLo29p3xlI+23uY9fdy0upaVwT
         SDbg==
X-Gm-Message-State: AO0yUKVCFLokyyTlaPr5O2zsmj0wB039jw5Wj+WyuP3PVT3v7MRVBD7Y
	54zcQ0zgE49o3+EE/ccIs7c=
X-Google-Smtp-Source: AK7set9fi+LcgAdX+mXyxjGDzJRFSNSj+KHGOVTeQL8ZUiwNuYmM9LVccLJra4ABwmg4MfHr8k7Z3w==
X-Received: by 2002:a05:600c:1d13:b0:3e9:b564:fae4 with SMTP id l19-20020a05600c1d1300b003e9b564fae4mr1534686wms.0.1678353023005;
        Thu, 09 Mar 2023 01:10:23 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b003e00c453447sm2025385wmq.48.2023.03.09.01.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:10:22 -0800 (PST)
Message-ID: <dd738a2d-4867-723e-c03e-a9018a7ae633@grimberg.me>
Date: Thu, 9 Mar 2023 11:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, Hannes Reinecke <hare@suse.de>
References: <20230307163045.5882-1-akinobu.mita@gmail.com>
 <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
 <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com>
 <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_011027_803448_92B0611A 
X-CRM114-Status: GOOD (  23.04  )
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


>> Sagi,
>>
>> On 3/8/23 03:06, Sagi Grimberg wrote:
>>>
>>>> In timeout and error handling, various information is reported about the
>>>> command in error, but the printed opcode may not be correct
>>>>
>>>> The opcode is obtained from the nvme_command structure referenced by the
>>>> 'cmd' member in the nvme_request structure.
>>>> (i.e. nvme_req(req)->cmd->common.opcode)
>>>>
>>>> For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
>>>> points to a structure within the page fragment allocated by
>>>> nvme_tcp_init_request().  This page fragment is used as a command
>>>> capsule
>>>> PDU, and then may be reused as a h2c data PDU, so the nvme_command
>>>> referenced by the 'cmd' member has already been overwritten.
>>>>
>>>> To fix this problem, when setting up the nvme_command, keep the
>>>> opcode in
>>>> a newly added member in the nvme_tcp_request and use that instead.
>>>
>>> I'm wandering if we should just not reuse the cmd pdu for a subsequent
>>> data pdu...
>>>
>>> It will take more space allocated per request (up to a few MBs for lots
>>> of requests and controllers)...
>>>
>>> but will prevent from propagating this to nvme core...
>>>
>>
>> Is there a way we can do this without increasing the memory usage ?
> 
> The data pdu has to go somewhere. There doesn't appear to be another free area
> other than the command pdu, so if that's off limits to preserve the original
> sqe, then more memory is needed.

If I take a somewhat extreme calculation, where a host has 16 
controllers, 128 queues of depth 128 for each I end up with additional
6MB, which is not insignificant for a driver...

We could go with the original proposal of storing just the opcode, but
it then propagates to the core...

Or...

The cmd pdu has a size of 72 bytes (header + 64 byte command), perhaps
we can still reuse the same PDU space but rather take the last 24 bytes
of the cmd pdu?

Something like:
--
+static inline void *nvme_tcp_req_cmd_pdu(struct nvme_tcp_request *req)
+{
+       return req->pdu;
+}
+
+static inline void *nvme_tcp_req_data_pdu(struct nvme_tcp_request *req)
+{
+       /* use the pdu space in the back for the data pdu */
+       return req->pdu + sizeof(struct nvme_tcp_cmd_pdu) -
+               sizeof(struct nvme_tcp_data_pdu);
+}
+
  static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_request 
*req)
  {
         if (nvme_is_fabrics(req->req.cmd))
@@ -613,7 +625,7 @@ static int nvme_tcp_handle_comp(struct 
nvme_tcp_queue *queue,

  static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
  {
-       struct nvme_tcp_data_pdu *data = req->pdu;
+       struct nvme_tcp_data_pdu *data = nvme_tcp_req_data_pdu(req);
         struct nvme_tcp_queue *queue = req->queue;
         struct request *rq = blk_mq_rq_from_pdu(req);
         u32 h2cdata_sent = req->pdu_len;
@@ -1035,7 +1047,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
  static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
  {
         struct nvme_tcp_queue *queue = req->queue;
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         bool inline_data = nvme_tcp_has_inline_data(req);
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         int len = sizeof(*pdu) + hdgst - req->offset;
@@ -1074,7 +1086,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
nvme_tcp_request *req)
  static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
  {
         struct nvme_tcp_queue *queue = req->queue;
-       struct nvme_tcp_data_pdu *pdu = req->pdu;
+       struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         int len = sizeof(*pdu) - req->offset + hdgst;
         int ret;
@@ -2281,7 +2293,7 @@ static enum blk_eh_timer_return 
nvme_tcp_timeout(struct request *rq)
  {
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
         struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
         int qid = nvme_tcp_queue_id(req->queue);

@@ -2320,7 +2332,7 @@ static blk_status_t nvme_tcp_map_data(struct 
nvme_tcp_queue *queue,
                         struct request *rq)
  {
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-       struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
         struct nvme_command *c = &pdu->cmd;

         c->common.flags |= NVME_CMD_SGL_METABUF;
@@ -2340,7 +2352,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
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

This way we can still abuse the pdu space without allocating additional
24 bytes per request, and live with it until it bothers something else?

Thoughts?

