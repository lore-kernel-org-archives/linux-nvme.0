Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81327C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB8A20717
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rm7juTAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB8A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tM6A9DY4NpAwqoPdKOqMIeajxMWm6Rikidr9ulB4DqA=; b=Rm7juTAAZJ1KewVHOoxFehGu2
	IBahRoT8gYQjiS6EA4+ZpD+s7BSQ5g/UryIBeDTbl11IvKpFZOthIDXDtoSczGFBTQWH8dniMxehs
	8UhXLoH1fd3yubyUgUSNpWoRqnS8Ym3wJ5iowE8r0hFJ4QLVMXVTp22PRvBD+V7RrVaHLMNDz5yLc
	lK7lSeJTEsgyUL/G2DVCpmOySTKb/bBUATywGi+HaPuM1tXO61ZhKXF21UnIK9RKF1NKeI2yXVtEE
	9y6dq1/sOg6uu830EdxYd6Un8IAM3fbj/Y+Amsew2CkLmhtbE7VDQnQI+nGRAwMi44CI9ZfSSe7pL
	2UIgjUoHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNQj-0004t9-HP; Fri, 20 Sep 2019 18:14:53 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNQh-0004sb-8Q
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 18:14:52 +0000
Received: by mail-wr1-f67.google.com with SMTP id i18so7678194wru.11
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 11:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yC1KSJwZu6S3UtcVF44MU19IxoT9nhEMiVnLl9xqoE4=;
 b=kdS8pRPSrvxGgMQjzwe/JDiHJPPweLDFipad5fLOwvagcOvZXCC52LKX5BkXTWpAVn
 R/CysJP/PyqA8K1My6R2vINmAOhb/TDXJYZlIfUPXIWgOxUX2nzJMOQWlJ1aXfDB6Q6I
 3ZeZ8QDwzvPOsEE81QLSRMoVsa6oXEWfLyeeDhxnCsLsnT4rH/d2jeiN113f7jU35Leb
 wnv9bwOy7imRoLh4DovKR9i5pL/JkiR6NUE/85x/nddqr7qLhuEZ9DWGUWlqbUofP2Pl
 mPvgImPJXcP8oWzE1eTgELzIYSaxl9H7gF48HTmJ0+7a4mYk1mkkLn2dmjAtRhrEK2sM
 8uUQ==
X-Gm-Message-State: APjAAAU7JLGLN0sz6xGIytkzLQE4Wt14I44Zoe5Orl/HpqHVEbtGpnfi
 SDvUyfDQiBQ5DtK7s5PhUSS+ztbN
X-Google-Smtp-Source: APXvYqyY1xDloc+nD1xTwJQ3fkTjGL61YsfIG1s8+etZzI0eTyLDdQpgdrTTlpM0fw3nMANbP9b1Lw==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr1674049wru.12.1569003289350;
 Fri, 20 Sep 2019 11:14:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t203sm3635127wmf.42.2019.09.20.11.14.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 11:14:48 -0700 (PDT)
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states
To: Keith Busch <kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org>
 <c31bee2b-5f43-9744-8fbc-971c3504622e@grimberg.me>
 <20190920180853.GC97854@C02WT3WMHTD6>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c245d52a-c030-a643-8095-9637908e01dd@grimberg.me>
Date: Fri, 20 Sep 2019 11:14:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920180853.GC97854@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_111451_302187_0845983F 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 95b74d020506..33b5729763c2 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3742,15 +3742,14 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>    		if (time_after(jiffies, fw_act_timeout)) {
>>>    			dev_warn(ctrl->device,
>>>    				"Fw activation timeout, reset controller\n");
>>> -			nvme_reset_ctrl(ctrl);
>>> -			break;
>>> +			nvme_reset_continue(ctrl);
>>> +			return;
>>>    		}
>>>    		msleep(100);
>>>    	}
>>> -	if (ctrl->state != NVME_CTRL_LIVE)
>>> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>    		return;
>>> -
>>>    	nvme_start_queues(ctrl);
>>>    	/* read FW slot information to clear the AER */
>>>    	nvme_get_fw_slot_info(ctrl);
>>> @@ -3768,7 +3767,8 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>>>    		nvme_queue_scan(ctrl);
>>>    		break;
>>>    	case NVME_AER_NOTICE_FW_ACT_STARTING:
>>> -		queue_work(nvme_wq, &ctrl->fw_act_work);
>>> +		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>>> +			queue_work(nvme_wq, &ctrl->fw_act_work);
>>
>> btw, what happens if someone just initiated a reset here when the event
>> is handled? just ignore the fw activation?
> 
> Yep, if someone reset the controller before the driver got to handle the
> activation notice event, there's nothing for fw_act_work to do anymore
> since CSTS.PP is not valid after toggling CC.EN.

Strictly speaking, this is not testing the CC.EN, and it is possible
that it was not toggled yet. But I get what you are saying.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
