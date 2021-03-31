Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C9AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:46:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936A761007
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A761007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/4ou9VKVIcnf3tz8CwPsfCgluzx4wafI8cGyW1eAdu4=; b=dTmUtu6UMbaOzximqyHBohyGy
	2Lo9ldbs5YLjCcCPblX4XKYG10MTqAbjQbuQWbPoEyIaNkCVlMdEjtQs/lhBnJoXxsyVk1KYab6XR
	fxDFjoRnCXqUoKQ2nbMEZo5xhcBceNDZuji4sYkwOjkcOy30XaY00steGCQ1qNJvvtgapfzKbv19B
	zGEK2otlrjZ627by7J7mISYkjaApuq3+oeu8aEwVuRo5N/p15EhOSeWrnIV0Aqjbps0UjmuZqYSSW
	4+jJNV8+qH6O0e0gelItVbbGTquN3zgGQMN9i74F1AnnxsALAsnU4vZoXgNf0+v6rlBYZbZgca0iO
	7ZL8Z+5jw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRjax-007sto-JS; Wed, 31 Mar 2021 22:45:51 +0000
Received: from mail-oo1-f52.google.com ([209.85.161.52])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRjar-007st5-Kg
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:45:48 +0000
Received: by mail-oo1-f52.google.com with SMTP id
 p2-20020a4aa8420000b02901bc7a7148c4so87086oom.11
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 15:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EOqTZjvOtKZyAzEufUl3W2zhwDuczUwtqHDCSIORHDk=;
 b=Rdzm39cXVdgPD+RU5nvRIOYCbUy+EPURx0/LByL7x4UPVb2FlDb0MMym+nT3cdMBRC
 S/IIK2rMZinvZ6T0MMP6gtYxlKeAvW9qISzAPW8BamuXnG9NZc8akcDi8K2uVOJAzO4h
 0Zt7tJQkYBjoSH1xpCDjK7CYCmd4uxayl6lYQCG+1ay9g2eAKALcuYLkXloqPVDxL38f
 15qqT4SU0BdYjkDNjkjkSDdbYyGrfKB/N1huy0BsKs1X4mg3nBfCUS/K4omhjsRbM31w
 tQ7dxESjYCNiwbfVLKQTHf6rK1E9LqIqNWhoX+wmrTO/rFuWnCMWJvhm/dDmT/YR4+Jo
 /lGg==
X-Gm-Message-State: AOAM532yYnR72iFsfaXhtv9yiFajdzk2gpCb8Mz0B3YImebglEg8EDfj
 Cg443YdISkExwf0jeAa+HUw=
X-Google-Smtp-Source: ABdhPJxKbTNXGc4dXfZWT5ii+vgn8d6LkP3JYai65be0BEoBBI6urFlwPdyop1ZzrV2UAmjMqVrRYg==
X-Received: by 2002:a4a:8c0d:: with SMTP id u13mr4410121ooj.59.1617230744502; 
 Wed, 31 Mar 2021 15:45:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id h24sm790468otg.20.2021.03.31.15.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 15:45:44 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <027410bf-1563-47ce-1f69-73071df81ae3@grimberg.me>
 <20210331222644.GA28381@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71bf89c6-4e45-e9d2-0c73-65428712dceb@grimberg.me>
Date: Wed, 31 Mar 2021 15:45:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331222644.GA28381@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_234546_818848_CA70416A 
X-CRM114-Status: GOOD (  21.75  )
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


>> What is the workload you are running? have an fio job file?
>> Is this I/O to a raw block device? or with fs or iosched?
> 
> It's O_DIRECT to raw block device using libaio engine. No fs, page
> cache, or io scheduler are used.

I see.

> 
> The fio job is generated by a script that cycles through various sizes,
> rw mixes, and io depth. It is not always consistent on which paricular
> set of parameters are running when the error message is observed,
> though. I can get more details if this will be helpful.

Try out a debug patch [1], and when this happens we can get some more
info on the request itself.

>> Also, I'm assuming that you are using Linux nvmet as the target
>> device?
> 
> Not this time. The target is implemented in a hardware device.

Ha, cool...

[1]:
---
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..b218a41ac088 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -37,6 +37,14 @@ enum nvme_tcp_send_state {
         NVME_TCP_SEND_DDGST,
  };

+enum nvme_tcp_cmd_state {
+       NVME_TCP_CMD_QUEUED = 0,
+       NVME_TCP_CMD_SEND_PDU,
+       NVME_TCP_CMD_PENDING_DATA,
+       NVME_TCP_CMD_DATA_DONE,
+       NVME_TCP_CMD_DONE,
+};
+
  struct nvme_tcp_request {
         struct nvme_request     req;
         void                    *pdu;
@@ -56,6 +64,7 @@ struct nvme_tcp_request {
         size_t                  offset;
         size_t                  data_sent;
         enum nvme_tcp_send_state state;
+       enum nvme_tcp_cmd_state cmd_state;
  };

  enum nvme_tcp_queue_flags {
@@ -482,6 +491,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl 
*ctrl)
  static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
                 struct nvme_completion *cqe)
  {
+       struct nvme_tcp_request *req;
         struct request *rq;

         rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
@@ -493,6 +503,8 @@ static int nvme_tcp_process_nvme_cqe(struct 
nvme_tcp_queue *queue,
                 return -EINVAL;
         }

+       req = blk_mq_rq_to_pdu(rq);
+       req->cmd_state = NVME_TCP_CMD_DONE;
         if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
                 nvme_complete_rq(rq);
         queue->nr_cqe++;
@@ -503,6 +515,7 @@ static int nvme_tcp_process_nvme_cqe(struct 
nvme_tcp_queue *queue,
  static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
                 struct nvme_tcp_data_pdu *pdu)
  {
+       struct nvme_tcp_request *req;
         struct request *rq;

         rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
@@ -512,11 +525,12 @@ static int nvme_tcp_handle_c2h_data(struct 
nvme_tcp_queue *queue,
                         nvme_tcp_queue_id(queue), pdu->command_id);
                 return -ENOENT;
         }
+       req = blk_mq_rq_to_pdu(rq);

         if (!blk_rq_payload_bytes(rq)) {
                 dev_err(queue->ctrl->ctrl.device,
-                       "queue %d tag %#x unexpected data\n",
-                       nvme_tcp_queue_id(queue), rq->tag);
+                       "queue %d tag %#x unexpected data cmd_state %d\n",
+                       nvme_tcp_queue_id(queue), rq->tag, req->cmd_state);
                 return -EIO;
         }

@@ -755,7 +769,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                         nvme_tcp_ddgst_final(queue->rcv_hash, 
&queue->exp_ddgst);
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
                 } else {
+                       req->cmd_state = NVME_TCP_CMD_DATA_DONE;
                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+                               req->cmd_state = NVME_TCP_CMD_DONE;
                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                                 queue->nr_cqe++;
                         }
@@ -796,7 +812,10 @@ static int nvme_tcp_recv_ddgst(struct 
nvme_tcp_queue *queue,
         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
                 struct request *rq = 
blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
                                                 pdu->command_id);
+               struct nvme_tcp_request *req;

+               req = blk_mq_rq_to_pdu(rq);
+               req->cmd_state = NVME_TCP_CMD_DONE;
                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                 queue->nr_cqe++;
         }
@@ -944,6 +963,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                                 nvme_tcp_ddgst_final(queue->snd_hash,
                                         &req->ddgst);
                                 req->state = NVME_TCP_SEND_DDGST;
+                               req->cmd_state = NVME_TCP_CMD_DATA_DONE;
                                 req->offset = 0;
                         } else {
                                 nvme_tcp_done_send_req(queue);
@@ -979,6 +999,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
nvme_tcp_request *req)

         len -= ret;
         if (!len) {
+               req->cmd_state = req->data_len ? 
NVME_TCP_CMD_PENDING_DATA : NVME_TCP_CMD_DATA_DONE;
                 if (inline_data) {
                         req->state = NVME_TCP_SEND_DATA;
                         if (queue->data_digest)
@@ -2329,6 +2350,7 @@ static blk_status_t nvme_tcp_queue_rq(struct 
blk_mq_hw_ctx *hctx,

         blk_mq_start_request(rq);

+       req->cmd_state = NVME_TCP_CMD_QUEUED;
         nvme_tcp_queue_request(req, true, bd->last);

         return BLK_STS_OK;
---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
