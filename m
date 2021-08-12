Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA4C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 20:03:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD4D60FC0
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 20:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DD4D60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQvD1zNNcbcHEM2sh5E2G1s0gkxwMBgmz3HlMF+ElHs=; b=hyCg+SBdzp1UvfIX7tG0FZYuaU
	XUHkQbHAv4SULht2kJO53Zk/xjfgM1NM+z3zt+GPcMFyTOdIjEUBKHJ5eshMCg6c5w52wuruKj2WR
	xs1sT8G6VtJZyl/yzxsD7Ggcpj1oFMXc0aVymsU+0Kkw4xf8MBKoJItOKEcaBAjj2o/QqbFAGPvqm
	ECb4UZBHj9jOM+8zTkIefUTMSkEYQq0ziFfZTgGHJU3lG5MgNsFNF1jtAc+QL8fkxuybtyYAGyZnR
	Ok6l1tOE6uDl0KrCoy12ap2vtbclJnh0b12/HCRzTE134wCPYbYkURz83bQTraEKIzcFGPpvaZcxl
	uy3SuT+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEGv6-00B8E6-Pa; Thu, 12 Aug 2021 20:03:16 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEGv0-00B8CN-Pg
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 20:03:14 +0000
Received: by mail-pl1-x62a.google.com with SMTP id c17so3445091plz.2
 for <linux-nvme@lists.infradead.org>; Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NWgmDEccyBvUvz6V9WedwFoBsgEY8nM0D4Z4cC7Dw1I=;
 b=KPAXx1x0ghxtiKWnxWPLcRjyNaCb/MBL5gr9Di8dpaE8YepmpQG2Py4q8Km5krGwtf
 hd+78annMTSb2H0HMRRSTjqEUs4TihRPMXUVRnMUHRcbUTiVgQ26wUiwkvWpACTGEMqc
 w9Rql7eM/6wI6QrJYRxBaTdXaU9rCL5Wfk2lvKu4XmGieAfwjinEoU6SObJ0Kh2r6yyx
 nmntBx+tzxXS5gnEyXFT+0OCEKZnDXgfADScdkkVOwyxICnatOkR5/pws77rEAHtP8L+
 GIIw/KqLIR5y7OicfcKxB4kD4DOUs+QEhVPg5J/BQtezR3K/BL8eO2dnFkeh2ixMwXFV
 n+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NWgmDEccyBvUvz6V9WedwFoBsgEY8nM0D4Z4cC7Dw1I=;
 b=g/epx9B4r3Qsquu21qwpMzjOD2xA/Jk5V7HSqqjsFbD0iw4RC+smyOR8rHvlJV/GBR
 V0zlZ6PyTjPpjPoUmahnWFbXJRp1TNJx+rIIwRscp123Uy4G/vdJvb2mK4/Nn3UEwLW+
 p4B0GydhunCt7Xm0fMYXD7VTlM9zXlr4zidmfcbn6RLsbLQIyutivyDH0VR7VXyJUJdY
 Sys/MOLj0D0dcYpEhEhEYXjanfUCrv9zwWY1dGeXH+03t4s/w/8M59X9ZkuU0hLlzS4c
 2ELLFAdzG8TpMhd1NusbgP2qYTf+V365W4WPE0+6REWXIBiin0s6FDMReXLO1AbpIFDt
 uvxA==
X-Gm-Message-State: AOAM533rDvwNTu9XsJB1mwgJvrH0NWbJ9kguQkf8bhGVhHhc6imHbFwc
 1xTfC3oD7zVWJFH7qX27z4I=
X-Google-Smtp-Source: ABdhPJzWO9vakgn2ani735QDF0vnWMKiASMkhe7pnHHh6mQ14HrUJpPPjqx6RbxVrw8DLFjU6DlG8Q==
X-Received: by 2002:a17:90a:ba93:: with SMTP id
 t19mr18539852pjr.4.1628798589513; 
 Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l11sm4526447pfd.187.2021.08.12.13.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
Date: Thu, 12 Aug 2021 13:03:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_130310_900769_2F3DE636 
X-CRM114-Status: GOOD (  26.15  )
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

On 8/4/2021 12:23 AM, Hannes Reinecke wrote:
> On 8/2/21 1:26 PM, Daniel Wagner wrote:
>> From: James Smart <jsmart2021@gmail.com>
>>
>> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
>> exposed an issue where we may hang trying to wait for queue freeze
>> during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
>> the queue. However we never started queue freeze when starting the
>> reset, which means that we have inflight pending requests that entered the
>> queue that we will not complete once the queue is quiesced.
>>
>> So start a freeze before we quiesce the queue, and unfreeze the queue
>> after we successfully connected the I/O queues (the unfreeze is already
>> present in the code). blk_mq_update_nr_hw_queues will be called only
>> after we are sure that the queue was already frozen.
>>
>> This follows to how the pci driver handles resets.
>>
>> This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
>> controller reset hang during traffic".
>>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> CC: Sagi Grimberg <sagi@grimberg.me>
>> [dwagner: call nvme_unfreeze() unconditionally in
>>            nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
>> Tested-by: Daniel Wagner <dwagner@suse.de>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   drivers/nvme/host/fc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 133b87db4f1d..b292af0fd655 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>>   	 * (but with error status).
>>   	 */
>>   	if (ctrl->ctrl.queue_count > 1) {
>> +		nvme_start_freeze(&ctrl->ctrl);
>>   		nvme_stop_queues(&ctrl->ctrl);
>>   		nvme_sync_io_queues(&ctrl->ctrl);
>>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>> @@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>>   			return -ENODEV;
>>   		}
>>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>> -		nvme_unfreeze(&ctrl->ctrl);
>>   	}
>> +	nvme_unfreeze(&ctrl->ctrl);
>>   
>>   	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>>   	if (ret)
>>
> There still is now an imbalance, as we're always calling
> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
> call 'nvme_start_freeze()' if we have more than one queue.
> 
> This might lead to an imbalance on the mq_freeze_depth counter.
> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
> the if() condition to avoid the imbalance?
> 
> Cheers,

Daniel,

try this. Moves the location of the freeze and will always pair with the 
unfreeze.

--- fc.c	2021-08-12 12:33:33.273278611 -0700
+++ fc.c.new	2021-08-12 13:01:16.185817238 -0700
@@ -2965,9 +2965,10 @@ nvme_fc_recreate_io_queues(struct nvme_f
  			prior_ioq_cnt, nr_io_queues);
  		nvme_wait_freeze(&ctrl->ctrl);
  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
  	}

+	nvme_unfreeze(&ctrl->ctrl);
+
  	return 0;

  out_delete_hw_queues:
@@ -3206,6 +3207,9 @@ nvme_fc_delete_association(struct nvme_f
  	ctrl->iocnt = 0;
  	spin_unlock_irqrestore(&ctrl->lock, flags);

+	if (ctrl->ctrl.queue_count > 1)
+		nvme_start_freeze(&ctrl->ctrl);
+
  	__nvme_fc_abort_outstanding_ios(ctrl, false);

  	/* kill the aens as they are a separate path */


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
