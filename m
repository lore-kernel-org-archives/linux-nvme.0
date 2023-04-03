Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EFAC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+IErd2IA4fcR93Rgt+5h4G+aheq7AXp8NF5PWVFD/I=; b=H+3LKT1sWnaUJhEyf3HLh9rYaK
	3aORhPWsQB0uONn1/gAHojODHNBSs0yi73phOc5vD3IakH8+St9bvrCQjCoyhMC0OLEwzqmXCR22i
	GxRCIoNyW7XBSJe1Wnp6o6NH7MIlQb8UZQAnjpbZpV/9ylQpTje43xqty0bJMMN5tv/KSPZdWQHgs
	clUJYFV/hTgC7ZmUgpnbBytCBZozkS6/7iDI+PeD8KTCPIP2/2v/v5xurQ3rX/x3BsL5k1CBV1zqy
	yDm6l09PscBE9Gyw7G3T5vSA0vjlgVTcE5HFI+MO0dqn6fQVp1z9hk0DeqtVddA92ReR9LdPOTHYP
	m6xT6N8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSox-00H67x-2g;
	Mon, 03 Apr 2023 22:38:39 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSov-00H66P-07
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:38:38 +0000
Received: by mail-ed1-f42.google.com with SMTP id t10so123155820edd.12
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 15:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+IErd2IA4fcR93Rgt+5h4G+aheq7AXp8NF5PWVFD/I=;
        b=0HmDFj4BRmAklJZkZisBTv71psI2PiZj3O8CAbmGJPLkI0skts+YMZx+E/h/ON5kK6
         PH0gGRMF2DiOx2vfTUSBMNWz3PTz+dsXqcb0D6qBThzi4iC2lLyiPsQCRKbsK6GstYti
         SjTFwCoOT7XuyUeH1o85zhL8+sxoNP4mUMQOlVcx0nxP210TeOSyU10yaHdC2iWiB9db
         aJdTufMo42QOTqDXMnI4mS7vD5B0JnPRFHYA5wyUMeX+OxxKZOFVm5jPVpt78Lmbj26j
         /y6MqGhDqCeJAmFmFj9GO2IB6uI5lkulF3t8Ez71/85yV6eJbqSaz/lrN85Ltyw4dK+9
         YSiQ==
X-Gm-Message-State: AAQBX9ciH5Y65AE4Ajt3oJAlAZaNDfJHh8tOtfirpa69Otq+pH1aLKD5
	rVGrbwZ/Fb9XF4HZcz5ek5Ac94CXYlQ=
X-Google-Smtp-Source: AKy350b0YAHI315fJISPKHzKNGJtKn0tUUFghzMF4rNdrC3tvE9BeWK2oVXiXg+gog9DEItPGRfbHw==
X-Received: by 2002:a05:6402:268f:b0:501:ea97:519c with SMTP id w15-20020a056402268f00b00501ea97519cmr724578edd.4.1680561514003;
        Mon, 03 Apr 2023 15:38:34 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090625d400b00914001c91fcsm5060496ejb.86.2023.04.03.15.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:38:33 -0700 (PDT)
Message-ID: <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
Date: Tue, 4 Apr 2023 01:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: alan.adamson@oracle.com, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
 <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_153837_365334_3A3714D8 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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


>>> +    if (!nr->ctrl->error_logging)
>>> +        req->rq_flags |= RQF_QUIET;
>>> +
>>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>
>> Question, if we already introduce granularity to this setting, why
>> not per-ns? why only per controller? I'd think it makes more
>> sense to do this per ns. Will also remove access to ctrl in the hot
>> path...
> 
> 
> Meaning we should have both:
> 
> /sys/class/nvme/nvme0/passthrough_logging
> 
> /sys/class/nvme/nvme0/nvme0n1/passthrough_logging

No, just the namespace logging, why would we need the
controller as well?

