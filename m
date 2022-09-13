Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A00C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Sep 2022 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bKk1dOLoFNDtGjlfxF2T0TW/9hiUFGj+sV+jZxHxlo=; b=K9dxXbF0fiz3HccFW4OY33vDwC
	TIfxAwk8dJvdGY4N3Qfc1ma6lJFobNlScMTAT4qpOtt/tAbZ/DSvOQaTTgcE8jsP1ap6raw/+73nk
	EC1TiSx32XECdLTXwMuip8R8x7oHMBT1FkG9ULhZpJUjWLaH9/TdZ4HljuC9Wvfej1qBWWrM3bz+V
	yNt+r3AGZwBAGTnscoUj0GrDlKjRx20Hj53jC/yax6duCmbVAJkzWi6/BpUtwX1HdMKKkrtXDxYBr
	VV8kaB9tUGxkAkOST8XMAYJG3c1H70o6fEvqxp/ZZP9RIMpVVDR7CNRIRtURvmSr3h9AZdEZCQiIZ
	ciwbECdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXtSD-00G9He-SV; Tue, 13 Sep 2022 00:07:05 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXtS6-00G9CH-93
	for linux-nvme@lists.infradead.org; Tue, 13 Sep 2022 00:07:04 +0000
Received: by mail-qt1-x834.google.com with SMTP id s18so4537852qtx.6
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6bKk1dOLoFNDtGjlfxF2T0TW/9hiUFGj+sV+jZxHxlo=;
        b=HstkE/b9qwL8hMmX5psb9bqO8my6J9vyXetls7LqXeYiC9fAczqRSNPuGYLytGoHqr
         halIbdWBS2USSO/NuV3aVDoGvbIfqm+4Q4wgdfcs8rW/gDYfsGbcDlZowFECH+tM5n3A
         Ypd6/GQCJYUS4TAxS5sw1l28URQvo8NexDaefzLyK6bBQHmOMq7D634cxW/TFeYvpy/K
         I6oZ4bZlbxRxSNVvj/0WCzhlYJYxZ9dt8y+bd1tLZTHkThPZg5bVxnTwKXmACd4eyBe1
         pgLFC9hQOx+3cd4yUBOlYutiUnM9PS+U2UCcRqaYkLMVnkm/lhsV1chdMxXOFc3sAGqj
         AXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6bKk1dOLoFNDtGjlfxF2T0TW/9hiUFGj+sV+jZxHxlo=;
        b=ZKe9RIN/hDxTu+BoX20+qhqdkNeMm9on+8YTdH/7gCTB8AGGYdLHY/tIZAXflZt7eU
         5ksnuE7b+W3i2lcQyI8RfS6h3PzB26OOrs5ZuZ5Jqxr6cZ0an4dyAbfpkLQ0rMXwMLBw
         p3ZpQgtBl54o2y+Qk0rS9G036sFufJ9FoNJpg8M1XtyZK8rxvVRHqk5BlDaqDu4uXKX+
         b3abXb7tb3v0WO2ilBdushiMsZ1ZyzBTtBFU5bRVErR0dZfVRcycHYrfpS2wPV+XgJ+p
         PVNhcVyLUYCqyqs8qzzVj/Zx9HnP5wJPTDKgft3rjLEC7NbgNUJbfV9Iil1rEC6lHiTD
         jaOw==
X-Gm-Message-State: ACgBeo132S9kSJ7HllBKaD+rPd9YKvwpGc27zubpO/linSiWXqZVhe3+
	30sLktu12bfukeBQ+7vTsHk=
X-Google-Smtp-Source: AA6agR7QfdwlycK9Crp1XR/V0d6tWUXz2gJS+7NlDHYfshKNS/6JbEh6GoRFTX9FH2wMbjyoQJeN+A==
X-Received: by 2002:ac8:7d44:0:b0:344:57c4:5f54 with SMTP id h4-20020ac87d44000000b0034457c45f54mr24861662qtb.446.1663027610510;
        Mon, 12 Sep 2022 17:06:50 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x26-20020a05620a0b5a00b006ce40fbb8f6sm2641289qkg.21.2022.09.12.17.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 17:06:50 -0700 (PDT)
Message-ID: <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
Date: Mon, 12 Sep 2022 17:06:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_170659_122493_5D8497A7 
X-CRM114-Status: GOOD (  26.34  )
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

On 9/12/2022 5:39 AM, Sagi Grimberg wrote:
>>> When a discovery controller is disconnected, no AENs will
>>> arrive to notify the host about discovery log-page changes.
>>>
>>> This attempts to fix it with a new connection parameter asking
>>> the kernel to send a dedicated udev event for this case. Prior
>>> attempt tried to use "connected" event already sent by the kernel
>>> however this also applied on the first connected, causing undesired
>>> side-effects when issuing a simple 'discover' command.
>>>
>>> The patchset includes the nvme-cli/libnvme counter-parts as well.
>>
>> Sagi,
>>
>> Do we really need another parameter/option ?  seems awkward to need 
>> userspace to figure it out.
> 
> It has a rather specific use though..
> 
> I was looking for something more fine-grained because I initially
> used the generic "connected" uevent which had some negative side
> effects, so I decided against adding yet another generic "reconnected"
> event that nvme-cli would use, and may/may-not fit other use-cases.
> 
> I thought its better to have something that is as specific as possible
> like "send me an event only when a persistent discovery-controller
> reconnects" and I also used the name to indicate the semantic of
> the event, so in the future, a possible consumer of this event will
> know exactly what it is used for before opting to use it.
> 
>> The transport certainly knows the difference between 1st time connect 
>> and nth time re-connect - perhaps this should be a simple flag on the 
>> nvme ctrl struct set by the transport ?  Simple thing for rdma/tcp to 
>> set flag at end of successful xxx_create_ctrl(), while FC, given it 
>> does reconnects w/o a first successful connect needs a little more logic.
> 
> I used ctrl->nr_reconnects to decide it, which introduced the constraint
> that transports would clear it _after_ calling nvme_start_ctrl(). Open
> to better suggestions though...

I was thinking this rather than the new option... The bit would only be 
set *after* the first successful link-side connect, thus the initial 
nvme_start_ctrl would not send the reconnect event. Every reconnect 
thereafter would.

-- james


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2429b11eb9a8..43c8b6590164 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4814,6 +4814,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)

  	nvme_enable_aen(ctrl);

+	if (nvme_discovery_ctrl(ctrl) &&
+	    test_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->flags))
+		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
+
  	if (ctrl->queue_count > 1) {
  		nvme_queue_scan(ctrl);
  		nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..ff1dd8f999b0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2947,6 +2947,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
  		goto out_delete_hw_queues;

  	ctrl->ioq_live = true;
+	set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);

  	return 0;

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bdc0ff7ed9ab..9b4260d60516 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,6 +356,7 @@ struct nvme_ctrl {
  	unsigned long flags;
  #define NVME_CTRL_FAILFAST_EXPIRED	0
  #define NVME_CTRL_ADMIN_Q_STOPPED	1
+#define NVME_CTRL_FABRIC_CONNECTED	2
  	struct nvmf_ctrl_options *opts;




