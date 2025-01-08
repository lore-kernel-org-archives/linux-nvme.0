Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BA7E7719A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=odzJOE89mvVjuAymTIDl4mqtqkpFi0QvREDYkft5dtY=; b=Xnxr5fUThYS3wutZiKMQUI5qYQ
	kNVAJOEd49j1jmSsdE2z4Vz76xNOi2JPNzW1T4Uu/9ejdMfD5BiJeRVpvzH0ywby+nPnUeopjjbDd
	/BHKd8j0ltMcY5Qj78u8/TnoD2RBvqitQUuNU8wGOUK5OJZ90edS21l4owbrP3+yo1UW924D2pK2M
	Go3wD/iXXm02GaK9hN+yecH58RC3F2xl9GBDgQ6daOAbhzStkaxca99Gh1RD8Uc2rilP9+0AP41wq
	Nay6V7Kv1QODvl1t/0fo01ZPo0iB01OXQewUWUBGb14qkbk99AAUqhx9xwm74zKqlsISTEVfJMcqU
	WZnguBIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTmh-000000086Zx-21Jh;
	Wed, 08 Jan 2025 10:59:35 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTeI-000000083qd-145n
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:50:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43621d27adeso114849755e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 02:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333453; x=1736938253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odzJOE89mvVjuAymTIDl4mqtqkpFi0QvREDYkft5dtY=;
        b=pL6GCSakJhoKL+ff0jlJlUoJZKQ4KqFcIdmADzGso5I1Bh/Naaha1FVEzfre+ibD4m
         8s4eV/ELr4D01o3TLbBniSutnsX9UQgiS+KIceAAzxv+zj05FAvy0ntiwk9XUBESeb3q
         wlwcrSKFYe2GMFRQggA905D7+dAbXXZb9pKjDLXVccVh7tUVVR4ymbfYWMbZ6bc4Qe93
         7bzGZlFnzVYZpP4YElDkFrDM0wXs2M2fbhfW3R5VNjDiqnBvhl/62JsHh4m7vK5xtPSL
         Bm606JD9c8cvPzIG8xP+ambgQqHK4T1lRM/fVHrflX0bemmnRT+/LW3VL7GrBET4+ECj
         bJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzhvxYlHvk/dIpF4ni4ph9fSDitxFq53pZw7P695IzdLjcllkSlUJILoMKBQN22YICVhUPxRhz8jbR@lists.infradead.org
X-Gm-Message-State: AOJu0Yzgg4I8pgnMt3OtP3/UO8OBuP0Mr3CNVNjlbj/HfXR9Q105ajEn
	+afaxE12wSmHUEhf0aLH4I1kKP4r6uH5oo27HF2BPPu/UHNN9RWm
X-Gm-Gg: ASbGncuowAs6N3X4bNELEZMphG5Rm63wEHJR6DtPE21dV/xQQXAmZvyKNyKuTLAMP6y
	bwi5ID7UjSvUs99I7VvSXmlIaNBZDJQcfgrHyjvkWaBuRsTwLqeHkjNtiLg711GzPfnA8MVx+Hi
	5e7paWBlfw3GNmZ/mAmDuzNk5tkCfde7XciIvP5oAN7+YmMyLzWKoxxLyG0b/ExWcni26w4UaKs
	hLKK7E9iZYQ9bDW6X18slWhe702NjnLvyBDUKUJodYIPdGkWF3P9lTuFNsSMltVfuEUNuY2nYH1
	08XBp7IUEig/P0EmDYCfWKg=
X-Google-Smtp-Source: AGHT+IGyJIn1+FUTSTjaqFHuvNbDlz2LfdKbLFnG0S/LcdjitsAv0ZLQ/c6wEokgaGCbwAr2f6Fagg==
X-Received: by 2002:a5d:5f4b:0:b0:385:ed16:c91 with SMTP id ffacd0b85a97d-38a872e8ab2mr1439214f8f.24.1736333452447;
        Wed, 08 Jan 2025 02:50:52 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2de8edcsm16567425e9.23.2025.01.08.02.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:50:51 -0800 (PST)
Message-ID: <b69d5f8c-9bf3-4f31-985c-902bb3bbe93c@grimberg.me>
Date: Wed, 8 Jan 2025 12:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
 <a8c476ee-e639-4886-a2dd-6e7d08060fa2@grimberg.me>
 <693187ac-9fe2-4ba3-8fcf-e34204fe7247@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <693187ac-9fe2-4ba3-8fcf-e34204fe7247@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_025054_296204_3780D04F 
X-CRM114-Status: GOOD (  26.03  )
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




On 07/01/2025 16:38, Daniel Wagner wrote:
> On Tue, Dec 24, 2024 at 12:31:35PM +0200, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>>>    		dev_err(ctrl->device,
>>>    			"failed nvme_keep_alive_end_io error=%d\n",
>>>    				status);
>>> +		/*
>>> +		 * The driver reports that we lost the connection,
>>> +		 * trigger a recovery.
>>> +		 */
>>> +		if (status == BLK_STS_TRANSPORT)
>>> +			nvme_reset_ctrl(ctrl);
>>>    		return RQ_END_IO_NONE;
>>>    	}
>>>
>> A lengthy explanation that results in nvme core behavior that assumes a very
>> specific driver behavior.
> I tried to explain exactly what's going on, so we can discuss possible
> solutions without communicating past each other.
>
> In the meantime I started on a patch set for the TP4129 related changes
> in the spec (KATO Corrections and Clarifications). These changes would
> also depend on the kato timeout handler triggering a reset.
>
> I am fine with dropping this change for now and discuss it in the light
> of TP4129 if this is what you prefer?
>
>> Isn't the root of the problem that FC is willing to live
>> peacefully with a controller
>> without any queues/connectivity to it without periodically reconnecting?
> The root problem is that the connect lost event gets ignored in the
> CONNECTING state for the first connection attempt. All will work fine
> for RECONNECTING state.
>
> Maybe something like this instead? (untested)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c4cbe3ce81f7..1f1d1d62a978 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -148,6 +148,7 @@ struct nvme_fc_rport {
>   #define ASSOC_ACTIVE		0
>   #define ASSOC_FAILED		1
>   #define FCCTRL_TERMIO		2
> +#define CONNECTIVITY_LOST	3
>
>   struct nvme_fc_ctrl {
>   	spinlock_t		lock;
> @@ -785,6 +786,8 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   		"NVME-FC{%d}: controller connectivity lost. Awaiting "
>   		"Reconnect", ctrl->cnum);
>
> +	set_bit(CONNECTIVITY_LOST, &ctrl->flags);
> +
>   	switch (nvme_ctrl_state(&ctrl->ctrl)) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_LIVE:
> @@ -3071,6 +3074,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (nvme_fc_ctlr_active_on_rport(ctrl))
>   		return -ENOTUNIQ;
>
> +	clear_bit(CONNECTIVITY_LOST, &ctrl->flags);
> +
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d}: create association : host wwpn 0x%016llx "
>   		" rport wwpn 0x%016llx: NQN \"%s\"\n",
> @@ -3174,6 +3179,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>
> +	if (test_bit(CONNECTIVITY_LOST, &ctrl->flags)) {
> +		ret = -EIO;
> +		goto out_term_aeo_ops;
> +	}
> +
>   	ctrl->ctrl.nr_reconnects = 0;
>
>   	if (changed)

This looks a lot better to me.

