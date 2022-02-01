Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B13C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VALN+nS+xO+mE4KVPw/Q6/DKUt1CY4LVmRwFRUh+FIg=; b=s+U5MyoQYs2SvVW5njYFI0WTgX
	5xG1QFpIgwXWTaDxrHC1BJ2HPWSy3wkl6e9O84/UNdNFiVJ+WowDt7ysKFZkSwBIaV4Kf8SMDuorZ
	fPdfjKh9UgO/312YFgSr1qTqQBclSfXbYjlDK507dmE6l1l3zgeGFgmINOfFg2UCgUPNLfcjEnh0P
	3e6a/2iHy94VQFnavylkVxaqwkZxauVEfp+g/MCBYqt1Hf2sSRORgzVTH6DNguSqLO6nmoS8nWy4s
	K4tW/4v9b5m6CB1VAUc2Dr5FRrGeX7adA9cz/phjWTO7jO0W//c14SsAtNAiTDwM47TnbY3Q9D4i0
	1Ne3OFqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEsOL-00C68r-NG; Tue, 01 Feb 2022 12:36:13 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEsOF-00C67v-34
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 12:36:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 l129-20020a1c2587000000b0035394fedf14so1743795wml.5
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 04:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VALN+nS+xO+mE4KVPw/Q6/DKUt1CY4LVmRwFRUh+FIg=;
 b=mBcAGMljxOmMb1AHsw12u9iVc+tg3ZCNYn2ABD583qu1De/rDnzow+y4Yt0nnqzdWt
 zoIqcctRldC/JqYzOvPdcVPa2Axln6/726xYFlJVhm4xgqYVsPtiFRD3mC9C7aFtUnTZ
 A5+ZejeTWPoUyhtyocmVPaek0FjYI27shr2fdUC52i7htLMCJff9fVuaRyGIFWfkUe7f
 00JARXBJeBbwW1AoWieEQkXyyUkBixMKemZSQNFXmZ5O1PcK974djUj/cH2we8PJTERj
 qGtbhyZ2Hxt/tCOLbMF1dNbVnr4Hch/sA+YTC9kxrujrRHGQCgrEvWyngKZhdxo8wuJC
 4/Qg==
X-Gm-Message-State: AOAM531nfHoI+3V5GbCUnQI2AstqnnBZvjmJ2+wAdqS1Nmdpqiy0rqJU
 hUNw7NL12bFNz4UXBkv9Txg=
X-Google-Smtp-Source: ABdhPJyiDIhIFqIZKBYNMyUdDwUI9T18EejtfkBDb24L+jmKZTZgd78zctbcgvy0lrjlfnrEqjBw6w==
X-Received: by 2002:a7b:cf2e:: with SMTP id m14mr1617980wmg.26.1643718965036; 
 Tue, 01 Feb 2022 04:36:05 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id m2sm2109837wmq.35.2022.02.01.04.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 04:36:04 -0800 (PST)
Message-ID: <654808ec-81e9-0205-779b-7502ee6c5b0a@grimberg.me>
Date: Tue, 1 Feb 2022 14:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in controller
 reset during load
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chris Leech <cleech@redhat.com>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-2-sagi@grimberg.me> <20220201080335.GB29518@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220201080335.GB29518@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_043607_166754_7F09606F 
X-CRM114-Status: GOOD (  16.33  )
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


>>   	struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
>>   	struct nvme_command *cmd = &pdu->cmd;
>>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>> +	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
>> +
>> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
> 
> Why do we need the local variable?

I can remove the local variable, didn't want to have a multiline
if condition.

> Also what prevents the controller or queue state to change just after
> this check?

The driver will make sure to flush ctrl->async_event_work _after_
changing the controller state (it is flushed in nvme_stop_ctrl).
Only after that it will continue to free the admin queue. So if
this check passed, it is safe to submit the aer command.

I think that the ctrl->state check should be sufficient. In fact, I
think we can move it to the core instead of doing it in the drivers:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..d60a6e65ff75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct 
work_struct *work)
                 container_of(work, struct nvme_ctrl, async_event_work);

         nvme_aen_uevent(ctrl);
+       if (ctrl->state != NVME_CTRL_LIVE)
+               return;
         ctrl->ops->submit_async_event(ctrl);
  }
--

I'll send a revised patch.

