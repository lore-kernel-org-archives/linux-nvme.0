Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 09:28:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0DF20663
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s7WHS5l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0DF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LNjgeBcRk46Ow5KKaxN8ouaj+yzQ4Z7r2airgZGRwqU=; b=s7WHS5l/BobWnUIVFcfH2aQ1g
	DDGdjW8GfAsgjvOTFgASW/CkN81zadFCfMx7QWNzbdZbsZ2BHrZeyRfMcJN1C7WESfKH38zoiU7sT
	UTO72LUVUHIFL1faz8nDZREOkHpNefwkHZq8LfrbAWnTs3lcF3qTo2N/T1ihOihLvwGnZXN7b0KWx
	m0ERDhKWs/w5E2xJBTE83Om4G/7Dw0KcL7A7UyhpWRRT2i8h3TMtwGG8+YNqLHS/TBpEvxzS1pZ5B
	mSOLNGc5YNYJwwunpLBWzIofmcQ5w8EnZz6gjXObCWvh4gGLHOS15lHafAtZaynADjY+PFjFAKvF2
	lQCQXHWfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0iNx-0000Cq-79; Wed, 29 Jul 2020 09:28:29 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0iNt-0000CR-6o
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 09:28:26 +0000
Received: by mail-wm1-f49.google.com with SMTP id f18so2229167wml.3
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 02:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2Go+BIgVcM2YgspeZh+sMFROOfy2365hnPrdIAuV7Qo=;
 b=Ide5Bv+Ptm4v3C/y5i4jzDnz5Y4yBdQqQxh3uYuN5aflvIw4fmM6cMEzvh5kEDmfGm
 7uhOZ6Pj7oxthomAZiwB9s5Ou5x62UNR41c3WVQeHZ25xmpzw5+h2hv5VtC9bWFcl+/8
 UmEHN5YMCThiOwevh0xC1k0rjof+eRAg1FkqzWxYaHiFypYvlU2t/R2nskJCqErRN6nK
 Tdaqeu5Q05/6ewA/uU0FfShPFSwVYkrXFrXrjJI5Ml4dXq+IVtz+BxUAJPLIlyMQppgQ
 i38nEEASUdnZMYEzCUpZX0ctqi45PgWj6H+xxxX2Dt0Z3mythWKk/k2XF3GYVYunrAWb
 OZBQ==
X-Gm-Message-State: AOAM532PvkWx8ZqxpcGNAS9HBeqYHmn95sILuI/83FgA+U3ya0LFWNve
 rKQS4VeazIT0TQPuivHaWQT6TIO+
X-Google-Smtp-Source: ABdhPJyAPAIGD8TN+IWQ1sD8JzcanVqF6zoAOz3X6GPfpHLz5HVCj/f6mYqnmykPilJsdV0w1k6IGA==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr5579575wmg.88.1596014903817;
 Wed, 29 Jul 2020 02:28:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c?
 ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
 by smtp.gmail.com with ESMTPSA id c194sm4180010wme.8.2020.07.29.02.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 02:28:23 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
 <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
 <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
 <20200729085711.GA5762@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a7044cb-f85e-4a59-4ebc-273cbb483042@grimberg.me>
Date: Wed, 29 Jul 2020 02:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729085711.GA5762@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_052825_294990_21A5C466 
X-CRM114-Status: GOOD (  23.41  )
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
Cc: bharat@chelsio.com, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> This time, with "nvme-fabrics: allow to queue requests for live queues"
>>>> patch applied, I see hang only at blk_queue_enter():
>>>
>>> Interesting, does the reset loop hang? or is it able to make forward
>>> progress?
>>
>> Looks like the freeze depth is messed up with the timeout handler.
>> We shouldn't call nvme_tcp_teardown_io_queues in the timeout handler
>> because it messes with the freeze depth, causing the unfreeze to not
>> wake the waiter (blk_queue_enter). We should simply stop the queue
>> and complete the I/O, and the condition was wrong too, because we
>> need to do it only for the connect command (which cannot reset the
>> timer). So we should check for reserved in the timeout handler.
>>
>> Can you please try this patch?
> Even with this patch I see hangs, as shown below:

While it's omitted from the log you provided, its possible
that we just reset the timer for timed out admin commands which
makes the error recovery flow stuck.

Can you please try this:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960..290804d2944f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -464,6 +464,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl 
*ctrl)
         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
                 return;

+       dev_warn(ctrl->device, "starting error recovery\n");
         queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
  }

@@ -2156,33 +2157,41 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
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
+               /*
+                * Restart the timer if a controller reset is already 
scheduled.
+                * Any timed out commands would be handled before 
entering the
+                * connecting state.
+                */
+               return BLK_EH_RESET_TIMER;
+       case NVME_CTRL_CONNECTING:
+               if (reserved || !nvme_tcp_queue_id(req->queue)) {
+                       /*
+                        * stop queue immediately and complete the request
+                        * if this is a connect sequence because these
+                        * requests cannot reset the timer when timed out.
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
                 /*
-                * Teardown immediately if controller times out while 
starting
-                * or we are already started error recovery. all outstanding
-                * requests are completed on shutdown, so we return 
BLK_EH_DONE.
+                * every other state should trigger the error recovery
+                * which will be handled by the flow and controller state
+                * machine
                  */
-               flush_work(&ctrl->err_work);
-               nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-               nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
-               return BLK_EH_DONE;
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
