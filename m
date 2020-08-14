Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70FC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:15:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47542074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O2459Cel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47542074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kloVmhq5zZpDcwwPeZtSvY2Q2Su86qvcCFyZjfPGLvw=; b=O2459Cel/AutXa+xeOcoEGVnZ
	bwMHqnqu+NgDLyge+U7KPGsq7pPvAFwNqUkr6uKcIZESww0QAXZBrGGi2kYYu/54CSz6J0iM1R3wH
	Mx5Zh5MfctuMoSNEbHGHoQywHipLlYEjQ3YRKRdqk4qZf0B/1/v6Scft/1UJG2xHRSXyIRMIQ6Roh
	R2rDIMSQ4NP8ui+wgROpa0z0qKYqxJKIchStqbdIKOBKJeXCPfcNVEdjbooFDDcbF3CKTPD2VoXgy
	P94PJMvvgsijrDjlC36NdRKAl01nk9+95+iDftgFVElFETflX2VxvOzFX92u0NVkneN3+luwNEeEj
	GVacgF/2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Tve-0001Qd-7F; Fri, 14 Aug 2020 07:15:06 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TvX-0001MR-PH
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 07:15:01 +0000
Received: by mail-wr1-f67.google.com with SMTP id 88so7450138wrh.3
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 00:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sOHM1aX2c3aFxojdB7PIffqhSvRPER/H6+7GJlQtEh4=;
 b=WKTUNRpX6gE+nE+0BKEDhiFk1HokOD40Uzl/4YlayfG+Z21dPxA2vD2qUXy9ohCtK2
 MGq2EhSUNfo8BgsoPtIfBMhvTZtksrIoNp8JLHDqNroWyVqwVw4Q18WOZ4APq5oKDdJQ
 lm/OPQj7nkp+w1Imu17jiQkA5ufmFWsubfpPemAonkocubYaGNrpU9uhq889IVI3YPEz
 k/1eHhENknw8TiiMoO4/TLQjWYuANz19aJoE1mp5C4zjhiQaoNohOIgJEXxvpJbrl1V6
 s/DVZkV+S9FPw6dotT+2pi9hq08q/9dL9AXoxuK/s+0DXCG7PNVgjCuyQsDgrgSFyuw5
 uLRQ==
X-Gm-Message-State: AOAM533Z2QqH/iIuXx+W9UEKQLaJyjUeRAjdJhcHfHI3jpH4IyGINq5y
 0vJTsVWrTB+c5XKYRopGPlc=
X-Google-Smtp-Source: ABdhPJzmRUc/k4jJCResFA9XtqKKVo5SeSxXh2vWUcVmEqo37RZDv0lLZwjUfGatAEGeBn8qchy9PA==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr1365469wrn.231.1597389298236; 
 Fri, 14 Aug 2020 00:14:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id 124sm13116916wmd.31.2020.08.14.00.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:14:57 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me> <20200814065230.GD1719@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b42e1454-838b-6bd3-0448-97f45ee02ea5@grimberg.me>
Date: Fri, 14 Aug 2020 00:14:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814065230.GD1719@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_031459_914696_B57C11C5 
X-CRM114-Status: GOOD (  24.66  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1185,6 +1185,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>>   		return;
>>   
>> +	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
> 
> Should this really be a warning?  I'd turn this down to _info.

I can do that. but given that this is a fix, I'll to do that
as a separate patch.

>> +static void nvme_rdma_complete_timed_out(struct request *rq)
>> +{
>> +	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
>> +	struct nvme_rdma_queue *queue = req->queue;
>> +	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
>> +
>> +	/* fence other contexts that may complete the command */
>> +	mutex_lock(&ctrl->teardown_lock);
>> +	nvme_rdma_stop_queue(queue);
>> +	if (blk_mq_request_completed(rq))
>> +		goto out;
>> +	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>> +	blk_mq_complete_request(rq);
>> +out:
> 
> Nit: I'd probably avoid the goto here for a slightly simpler flow.

OK

>> +			nvme_rdma_complete_timed_out(rq);
>> +			return BLK_EH_DONE;
>> +		}
>> +		/*
>> +		 * Restart the timer if a controller reset is already scheduled.
>> +		 * Any timed out commands would be handled before entering the
>> +		 * connecting state.
>> +		 */
>>   		return BLK_EH_RESET_TIMER;
>> +	case NVME_CTRL_CONNECTING:
>> +		if (reserved || !nvme_rdma_queue_idx(queue)) {
>> +			/*
>> +			 * if we are connecting we must complete immediately
>> +			 * connect (reserved) or admin requests because we may
>> +			 * block controller setup sequence.
>> +			 */
>> +			nvme_rdma_complete_timed_out(rq);
>> +			return BLK_EH_DONE;
> 
> A goto to share the immediate completion branch would be nice.  I wonder
> if we should also do it for the reserved case during shutdown even if
> that should never happen and entirely share the code, though:
> 
> 	switch (ctrl->ctrl.state) {
> 	case NVME_CTRL_RESETTING:
> 	case NVME_CTRL_CONNECTING:
> 		/*
> 		 * If we are connecting or connecting, we must complete
> 		 * connect (reserved) or admin requests immediately, because
> 		 * they may block the controller setup or teardown sequence.
> 		 */
> 		if (reserved || !nvme_rdma_queue_idx(queue)) {
> 			nvme_rdma_complete_timed_out(rq);
> 			return BLK_EH_DONE;
> 		}
> 		break;
> 	default:
> 		break;
> 	}
> 
> 	nvme_rdma_error_recovery(ctrl);
>   	return BLK_EH_RESET_TIMER;
> }

Maybe that can work, I'll look into that. thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
