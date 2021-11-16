Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A02C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8DC613AD
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A8DC613AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYs70cN1U/JowrHQLw06EcTQPJ9ZNnkRcNjDsFNXdPE=; b=KbU9fPKETBT5xzLUdpq2cF5Lm0
	QxM/pkMl/w4yq3mhY+fODUs7uxxvZavhzZL0JP/vrz3lK+XzelrLrFqxp8CWRPS7/BquqJR2Ewg72
	5noq6DAdPRRqyWeqKR/DrTTPVwJlqvV5OVQT/5p9OjSadXN49UgT8hkBMeJ+QsUdhkcli8bJrpLbc
	yHq34PQC1q4C+CXe3nXFt5dV3Z01ZU/71St/J8EpcBFj/MAAmdvtOTVxxSHodYtbQ5hWaEZ3LcHo4
	WYB+aq19Fy8io4ycsnOj8O6WNtiJmZXIOl14qdegH0/uSFU32E4n9r5rY0sYWdSnpWj9ciMOQ8+yh
	PZSsiTTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvRn-0017sx-UR; Tue, 16 Nov 2021 10:12:15 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvRR-0017lA-LV
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:11:55 +0000
Received: by mail-wr1-f50.google.com with SMTP id t30so36394191wra.10
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 02:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IYs70cN1U/JowrHQLw06EcTQPJ9ZNnkRcNjDsFNXdPE=;
 b=vZOwR3fbckoFOpB+UBWXPXq+x6KFWcKrk+MuaEBC5PNE9nKwtZBB6N/UFvL8J+2D/u
 ulMB6TfFjYCXqWbgk7S5PII5Om/cUU/ffJ56SYIKMJQeMQEtB6nNnl5c90b4vW6niJJS
 KaxdFf6P7/3xDGcAs6Kg3b6EkG4dU9rw1Ks/DLAzx96+eAjoen1mU5vQNDxnvuAoeR9U
 cFq0rXQBECNKNvYrCPiwoAigudeP1DCo2A4kQx/vwUvKx8zmqhM/yIHVSQANxe6N/AhE
 hy4Laz7YkFQKUPFx4ptKQv78L1LnnaK7EgaE9EJ9TeDNvaSjwoDyVKVzKHLSYB7PZ5l2
 y83Q==
X-Gm-Message-State: AOAM5305e+BkRV3BfP/y9LvkVXc21onbfDm7P6v0vHsZ+0PhSs13lqz3
 Rvjqt4+X5BlCO6qnhDY1kJo=
X-Google-Smtp-Source: ABdhPJz1pS/imfbBEXWbHoMOjGInVSSFR1pPNfQ0R+Ip6wTNJmLKztyCyTDOCQoelVPQ5+jiMUt/fA==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr7574971wrw.151.1637057510285; 
 Tue, 16 Nov 2021 02:11:50 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o5sm16329716wrx.83.2021.11.16.02.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 02:11:34 -0800 (PST)
Subject: Re: [PATCH V2 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-4-mlombard@redhat.com>
 <6f864cab-8460-3956-5784-2c3669069028@grimberg.me>
 <20211116092248.GG21836@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <be8b41bb-f477-3848-9923-14aa12606f6c@grimberg.me>
Date: Tue, 16 Nov 2021 12:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116092248.GG21836@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_021153_738690_F0AC3F1A 
X-CRM114-Status: GOOD (  18.28  )
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


>>> If a reset controller is executed while the initiator
>>> is performing some I/O the driver may leak the memory allocated
>>> for the commands' iovec.
>>>
>>> Make sure that nvmet_tcp_uninit_data_in_cmds() releases
>>> all the memory.
>>>
>>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>>> ---
>>>    drivers/nvme/target/tcp.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 028b47ff0f0f..5a238fa067cd 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>>>    	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>>>    		if (nvmet_tcp_need_data_in(cmd))
>>> -			nvmet_tcp_finish_cmd(cmd);
>>> +			nvmet_req_uninit(&cmd->req);
>>> +
>>> +		nvmet_tcp_unmap_pdu_iovec(cmd);
>>> +		nvmet_tcp_free_iovec(cmd);
>>
>> I understand how unmap_pdu_iovec is re-entrance safe, but sgl_free
>> called from free_iovec is not. What prevents it from being called
>> for commands that have already freed their sgls?
> 
> The commands that have already freed their sgls
> will have the pointers set to NULL,
> calling sgl_free() against a NULL pointer is safe (it does nothing, like kfree())
> but if you prefer I will add a check.

Oh, right.

So,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

