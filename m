Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332AEC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 20:20:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6172065E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GcKFenRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6172065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UMhBxFcLH8IaoleBwWKL9Uck/3Y0a8KtFMGiQOVHU5k=; b=GcKFenRUT2b1oN64WSDoNgCE7
	SPJuylWn7ZRtGPVdC0ASqvn8xHiQajnPiLdsBK9sc+PR+3+/B4LMOWHHhurj6auN69bibW3ZyRICs
	u74spogcBRg2HEVvQ+baxxtRpQdlw/dHqheK7Vim90GIhZO/k9kLBvkgTr7CQD9JOj0nFBs9H+iqa
	YjXazPwHFqxqdj4CoogdDd1h0QTcN8bSak13zwl5iTrsJP1zzPppyT404qRQlTgGTL/YlPgvWxow3
	oH8RNWzJcWlNjz+kD0su5xjtmmGsxZk5M6Th/JM+X/oqdqoAMVKm0e03oMbtC6i9Ifzsg0YbWkTUd
	Ul53asWMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0W5e-0005cA-0r; Tue, 28 Jul 2020 20:20:46 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0W5a-0005bi-W2
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 20:20:44 +0000
Received: by mail-pl1-f194.google.com with SMTP id k4so10567403pld.12
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 13:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gef16de5EpPX1YeoY9rwySs9VcunkRYa4UoYB5zUiY0=;
 b=jfzlv0MIbzg62y8RUsQfe6lE+O5kvB/bkke310SRBUUIXtq/wmhk8R+83weMZgtU/t
 beMbE4YFBJMKNpkfUx+kTrq54L1/0ECA7D7sNkqDyePQZik79YSFqfCKeAGPytJPs6Bc
 qhivaEVTu7B2URNBAT4L7F0Mzheg1Be4B2C5nCzjhscXG8udRswXvznYMRSvgsZq4fJf
 nRR6KwtJ83gw3qdoxoJkHYeindUQ/7ivXqOK3DtKRT+2hErYv4Yfx9QP+1I8XBev3r42
 sqn/Po2zm3Z9/nQuIrNpmxqw/VnDa3KO9Z2inW1JOl+thKOwTks+WZCb5PFlTVggNcze
 UfhQ==
X-Gm-Message-State: AOAM533UKaRwL8Uup4as+0cpEegQNizFt0HkapfzNJ3G0/0giE7Z0yVM
 1AKWSpcS1xBo3fDPyWGJuHcFkN8W
X-Google-Smtp-Source: ABdhPJyAwJgram0zIs0QZFhwwRwEYyn8Z2/U0hhhcXwICWWPKWOHQ5fbr03Bhd/NjD5JmFFBVlUx2w==
X-Received: by 2002:a17:90a:fd03:: with SMTP id
 cv3mr5957620pjb.111.1595967641522; 
 Tue, 28 Jul 2020 13:20:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id s18sm9585186pfd.132.2020.07.28.13.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 13:20:40 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
From: Sagi Grimberg <sagi@grimberg.me>
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
 <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Message-ID: <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
Date: Tue, 28 Jul 2020 13:20:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_162043_103587_A6BF0049 
X-CRM114-Status: GOOD (  21.33  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> This time, with "nvme-fabrics: allow to queue requests for live queues"
>> patch applied, I see hang only at blk_queue_enter():
> 
> Interesting, does the reset loop hang? or is it able to make forward
> progress?

Looks like the freeze depth is messed up with the timeout handler.
We shouldn't call nvme_tcp_teardown_io_queues in the timeout handler
because it messes with the freeze depth, causing the unfreeze to not
wake the waiter (blk_queue_enter). We should simply stop the queue
and complete the I/O, and the condition was wrong too, because we
need to do it only for the connect command (which cannot reset the
timer). So we should check for reserved in the timeout handler.

Can you please try this patch?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960..c3288dd2c92f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -464,6 +464,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl 
*ctrl)
         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
                 return;

+       dev_warn(ctrl->device, "starting error recovery\n");
         queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
  }

@@ -2156,33 +2157,37 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
         struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
         struct nvme_tcp_cmd_pdu *pdu = req->pdu;

-       /*
-        * Restart the timer if a controller reset is already scheduled. Any
-        * timed out commands would be handled before entering the 
connecting
-        * state.
-        */
-       if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
-               return BLK_EH_RESET_TIMER;
-
         dev_warn(ctrl->ctrl.device,
                 "queue %d: timeout request %#x type %d\n",
                 nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);

-       if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+       switch (ctrl->ctrl.state) {
+       case NVME_CTRL_RESETTING:
                 /*
-                * Teardown immediately if controller times out while 
starting
-                * or we are already started error recovery. all outstanding
-                * requests are completed on shutdown, so we return 
BLK_EH_DONE.
+                * Restart the timer if a controller reset is already 
scheduled.
+                * Any timed out commands would be handled before 
entering the
+                * connecting state.
                  */
-               flush_work(&ctrl->err_work);
-               nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-               nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
-               return BLK_EH_DONE;
+               return BLK_EH_RESET_TIMER;
+       case NVME_CTRL_CONNECTING:
+               if (reserved) {
+                       /*
+                        * stop queue immediately if controller times 
out while connecting
+                        * or we are already started error recovery. all 
outstanding
+                        * requests are completed on shutdown, so we 
return BLK_EH_DONE.
+                        */
+                       nvme_tcp_stop_queue(&ctrl->ctrl, 
nvme_tcp_queue_id(req->queue));
+                       nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+                       nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+                       blk_mq_complete_request(rq);
+                       return BLK_EH_DONE;
+               }
+               /* fallthru */
+       default:
+       case NVME_CTRL_LIVE:
+               nvme_tcp_error_recovery(&ctrl->ctrl);
         }

-       dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-       nvme_tcp_error_recovery(&ctrl->ctrl);
-
         return BLK_EH_RESET_TIMER;
  }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
