Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F98C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 23:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqiujn8xuf98pvBM9WYFznxWvid6DTs8aK3cm2gjEbU=; b=ua+PHv76HrjwBCwFe/DqTbzdas
	SiFVw6+iwxxt9YC9r/shUaKBts5DIaw+fZvcbQrNVBcCyf5Wn1d1hKHZnzLvyUVJ/vwxPoaJ/2skQ
	aAgANaR/dsDarQFzPQz1u7OdlY3wLg/r5qVZaf5XwvDXASxp9MUqtnYobl9hVQ3TdEQAaiWtL8zbc
	3HIcVh81wVjQRD66EeI3Qkdbl1utswuMG2KYDBg1SF1twqJmXEatLzZNYutiAJxxU8y9uP5XppL0A
	fuApN7MyqjieT9KlP9t3v1gpjF5JVpVvXTNzn3iP3de6GKjYEb6wf6DBKYhQYj+1nbRsuIXcNk7Er
	pWvre0DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDDpa-00HG4A-MN; Thu, 27 Jan 2022 23:05:30 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDDpX-00HG3o-9l
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 23:05:28 +0000
Received: by mail-ed1-f47.google.com with SMTP id b13so6054331edn.0
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 15:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=gqiujn8xuf98pvBM9WYFznxWvid6DTs8aK3cm2gjEbU=;
 b=WhTLBCSvTaviONat8ZuUIsVXLvDR7mSY2PPH6E/V4ScFHa+K8awc7oFiX9cNfSAHzj
 MtEM9vRlbPW3ySgVWVaI+VfyjinmPpOYFrbuHRMc3MLcHsbp9ekV4z1zVgnnrfSXqMBy
 9FGMothVNRSt300KcE3s/OETzO8yPmQl5klbt7kBd21prqh9UIxzQP9eYTsSGr0+CxXI
 3qRDrQg4ZVHfaykGyhz7hV7gjhgXcOj+E9vHmX7p/n5VXiA0MYrOohhaDQhTTtGcy9pv
 rjzzedHlwF6bzabQmArmv7Ldtau5cgcT7VsKGOTV/aHSCsq23OnjHx+AFpHHqhQfXEOF
 N4Rw==
X-Gm-Message-State: AOAM530czVsMF5sHBTrM5Fcoz6QfjkF8/IJV9j8gMm0XZERj17guyhHL
 0aholDiT41+kWV5X3pHVBSXvdEbyWww=
X-Google-Smtp-Source: ABdhPJzYBPxX3sFz4QuDJH8otMZR7O7GeBNM+CmSwrdv5yn1dVWigwmvbAsXA3Ce9m32wVVg6dZc5A==
X-Received: by 2002:aa7:d687:: with SMTP id d7mr5583006edr.222.1643324722580; 
 Thu, 27 Jan 2022 15:05:22 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id o18sm9174227ejb.111.2022.01.27.15.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 15:05:22 -0800 (PST)
Message-ID: <d33f5615-0e40-2e6e-76a1-b9450fa9ec6c@grimberg.me>
Date: Fri, 28 Jan 2022 01:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
 <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
 <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
In-Reply-To: <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_150527_376580_D05D5DC7 
X-CRM114-Status: GOOD (  24.97  )
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


>> Thank you for the following detailed description. I'm going to go back
>> to my crash report and take another look at this one.
> 
> No worries Chris, perhaps I can assist.
> 
> Is the dmesg log prior to the BUG available? Does it tell us anything
> to what was going on leading to this?
> 
> Any more information about the test case? (load + controller reset)
> Is the reset in a loop? Any more info about the load?
> Any other 'interference' during the test?
> How reproducible is this?
> Is this Linux nvmet as the controller?
> How many queues does the controller have? (it will help me understand
> how easy it is to reproduce on a vm setup)

I took another look at the code and I think I see how io_work maybe
triggered after a socket was released. The issue might be
.submit_async_event callback from the core.

When we start a reset, the first thing we do is stop the pending
work elements that may trigger io by calling nvme_stop_ctrl, and
then we continue to teardown the I/O queues and then the admin
queue (in nvme_tcp_teardown_ctrl).

So the sequence is:
         nvme_stop_ctrl(ctrl);
         nvme_tcp_teardown_ctrl(ctrl, false);

However, there is a possibility, after nvme_stop_ctrl but before
we teardown the admin queue, that the controller sends a AEN
and is processed by the host, which includes automatically
submitting another AER which in turn is calling the driver with
.submit_async_event (instead of the normal .queue_rq as AERs don't have
timeouts).

In nvme_tcp_submit_async_event we do not check the controller or
queue state and see that it is ready to accept a new submission like
we do in .queue_rq, so we blindly prepare the AER cmd queue it and
schedules io_work, but at this point I don't see what guarantees that
the queue (e.g. the socket) is not released.

Unless I'm missing something, this flow will trigger a use-after-free
when io_work will attempt to access the socket.

I see we also don't flush the async_event_work in the error recovery
flow which we probably should so we can avoid such a race.

I think that the below patch should address the issue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 96725c3f1e77..bf380ca0e0d1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2097,6 +2097,7 @@ static void nvme_tcp_error_recovery_work(struct 
work_struct *work)

         nvme_auth_stop(ctrl);
         nvme_stop_keep_alive(ctrl);
+       flush_work(&ctrl->async_event_work);
         nvme_tcp_teardown_io_queues(ctrl, false);
         /* unquiesce to fail fast pending requests */
         nvme_start_queues(ctrl);
@@ -2212,6 +2213,10 @@ static void nvme_tcp_submit_async_event(struct 
nvme_ctrl *arg)
         struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
         struct nvme_command *cmd = &pdu->cmd;
         u8 hdgst = nvme_tcp_hdgst_len(queue);
+       bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
+
+       if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
+               return;

         memset(pdu, 0, sizeof(*pdu));
         pdu->hdr.type = nvme_tcp_cmd;
--

Chris, can you take this for some testing?

