Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA5C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 20:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlytvZP5X3CSrXmWUdkGKMPgo0qr8e0WWy1oK5IDg2s=; b=pGrdqH5xN3RtW/gov5Wsm54x/c
	ezxIWIMZ8LUCJPbwn5LHVonW0bZ2Znhkh+qTwd73z/7otV2zLZlA2v/fc/Si3vj56O3Jgcnny/k6E
	h+lIfgS/25OSvc0dcTu3yStF9XoL3mw0UQ4x09dhdQt9XGvkOQVZwkhOX5ZKnkM0Nxs2GwRvQl4ES
	99zk8MhSOzF+c0dY4qlEBdUZn1o0i+H/tJx2UtrP12iOLQhskshAbmxbWOmpk1EtKvo33Dxsg6/kF
	3vH9VpZ0BOd+Ub5SDgymRv+t++dcWfKt7pIYVjkro9hkhgbuU7zQ6ZX1yJkMEF/FFeKYnNd1TODnQ
	+5GMIXFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QR4-00000003TJm-14pn;
	Mon, 14 Apr 2025 20:29:42 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QQh-00000003TAU-1i0G
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 20:29:20 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso8963817a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 13:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662558; x=1745267358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlytvZP5X3CSrXmWUdkGKMPgo0qr8e0WWy1oK5IDg2s=;
        b=EnKemFRGuOlcNoYF+KEc2V8kgEZToSVoXYV2haxoyy8Mfu9f1Z559pu5lNTZLn3/r4
         JDFi5g0rMSMC3wcC6WSfStdzrVRNgpnQsD8iTqxmnHNap4oFqo2Sds2TpHOGp1+phwWn
         YuzM9hvvbsucGR8eQuCi4q0RUCvrTzdT6KNX09rtUqZeuLSICHmJO7WZHbiQ805PDdFw
         CQdL/ueE7J7Ejt8rvy7abw8dtoUJSCcY8H03qO8EwsgTR7fH5Jcswp7E5B6+M0bCD2EN
         tmzlaMj7SboYkil9k5lIVRyN850KIIefHClw+3NWOUrFzAf2v3m/XlG+RZDdr4N09Pnv
         9cEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnoXeYO4aDCM40UfSro2bT970nANUzEN8RmU9n3hKLARy5Du381uRrNJoBehKAU1QxxVxU3Gw35euj@lists.infradead.org
X-Gm-Message-State: AOJu0YyPrpBUSlWcq7/750lcv30k0lSv2xEO7iFMG4eWNQmk2QlEyAY1
	hpQaQ6x/+7FeUSw20g9tqbylAf0c8+KzVh+qwZWmvJDamAZX5Y41
X-Gm-Gg: ASbGncvBOqL+ffyDdB1eKLrOwmWMAniPVmyaA1IiuQzzctVqWY0q6XYdZbVHgibQ9u9
	/JUrelkxa4WUlgukjaKzFektgTWx7YXfCNIcVeg4fHjBGvM06WhGSKdNSCz9H+EFyLQRhj580QH
	OhMvtju1zONfHg+lD5o+cD3q+VvcBayi/StFt89/fzdX+26O4sXO9PJAu8LmlcuxgmevfAq1Xr2
	g8GmGWwDA8tyeHx6DULjO2q2d4o1U36oWncx4JVDPZcebz6xldrMGCxaLdiHHfKxVth2D8v7SXq
	F8KwTX7lnecwZQpXNGLWT0gmTh4SRcvUT7xu5tLE3cu2Auy89vcCeuY16WrennC5McZu5Y1B
X-Google-Smtp-Source: AGHT+IGqIrTYsuxHXeCb1GmEWBbCf7GeBZn8udIbwTsPefrG5bmRbeUC5ajXnAoRhxUZycAM6conIw==
X-Received: by 2002:a05:6402:26d1:b0:5e6:13bf:2c7c with SMTP id 4fb4d7f45d1cf-5f36fb8a121mr9524802a12.9.1744662557747;
        Mon, 14 Apr 2025 13:29:17 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee5500dsm5394725a12.4.2025.04.14.13.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:29:17 -0700 (PDT)
Message-ID: <5feed30d-4752-41b6-bf53-2f9abafaf3ad@grimberg.me>
Date: Mon, 14 Apr 2025 23:29:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-3-hare@kernel.org>
 <f30a41f0-496b-4ad7-a0aa-01f2d5eade73@grimberg.me>
 <a7d0fb4a-e0b4-4ede-911d-993acdfebd42@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a7d0fb4a-e0b4-4ede-911d-993acdfebd42@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_132919_446471_88B34383 
X-CRM114-Status: GOOD (  18.22  )
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



On 14/04/2025 15:35, Hannes Reinecke wrote:
> On 4/14/25 01:00, Sagi Grimberg wrote:
>>
>>
>> On 03/04/2025 9:55, Hannes Reinecke wrote:
>>> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
>>> part of any list, otherwise a malicious R2T PDU might inject a
>>> loop in request list processing.
>>
>> Not clear what do you mean by "malicious R2T PDU".
>> Can you please clarify what you have seen/observed in the commit msg 
>> (i.e. what led you to this patch)?
>>
> This is coming from code inspection only.
> In nvme_tcp_handle_r2t() we are looking up a request by the 'command_id'
> value in the pdu, and then add it to 'queue->req_list' without further
> checking.
> So if a malicious R2T packet is received containing the command_id of
> a command currently on 'queue->req_list' we'll end up with duplicate
> entries on the list.

I think this falls into a bucket of a bunch checks that the host does 
not do. But ok.

>
> [ .. ]
>
>>> @@ -773,7 +785,8 @@ static int nvme_tcp_handle_r2t(struct 
>>> nvme_tcp_queue *queue,
>>>       nvme_tcp_setup_h2c_data_pdu(req);
>>>       llist_add(&req->lentry, &queue->req_list);
>>> -    queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>> +    if (list_empty(&queue->send_list))
>>> +        queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>
>> Is this change mandatory? looks out of place.
>>
> Arguably an optimisation. I can leave it out.

When it comes in this context it is not clear what it is designed to do. 
Don't mind having it,
but lets separate it from this patch.

