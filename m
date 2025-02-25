Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524AFC021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VtHgCtgfr8kMGFXYx/22y+EVV+lxGjoO290xg333FMA=; b=eDuk847NgNAWV7WbPSLhXE3XAF
	EUeRS/NOmiNM9b6qNMvW4pm65BC5il3Q0tnFQhRj7I28l/mqw9WI8CgdmZOgpBrm8zr+lsOX653hn
	XwdVuQxS/8+icA033oeRExUFuKxjRxmHuA0wm2RKMJJpx3S510Ul+7CpAAjgAMR/1dyq00YS4iRzl
	yKShlvgntc6/olLRb93kyJQ+vQqcAScJDVk1ZvgfPzO6kaP1gbYX38ZsK1wOIy+8VlvQuUmPzw3Yb
	a4DPXLSLf0hwc5+uDYaVD/JSQ32VFlDFO9A+57KswscQaajG6C1YdQDBGBJiuCtjOFaCSGMmgQ1Bl
	g6+l0zEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpZO-0000000GEQO-2hxs;
	Tue, 25 Feb 2025 07:41:34 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpYF-0000000GEGQ-0dbD
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 07:40:24 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4399d14334aso45774715e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 23:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740469221; x=1741074021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtHgCtgfr8kMGFXYx/22y+EVV+lxGjoO290xg333FMA=;
        b=TXykPqJXvMdEd7U/XYBmOjLEeyI+gTt8AQt9w9xnEklw1kJpbgUx+YqfSjQDnL7WvJ
         ivXdXA5OWme6XP0eZ/BtTXR4NcuwacMtwCVthlayOppWKCEWgGFO8t1L1h8msNbo6XQA
         jqwDdpbgG5crfwrorBl0h/KavgfXVwAvPPKRUF/OYVwwLAgGlxEcGES4tmqb3Y+WRe6t
         AfWNjWS9W8eHzCFAlW0X+P3aqEHbQX16hmUoMoH1hVwfCwYGVMtUH0cV0YUYmVg+xwHI
         nLN26rl99dsAA7L5Acw3/fl1xnm6F6KcCUXTHXgcJQiAOKvHMZcnb0o8kIKgXKzZ0k69
         cqyw==
X-Forwarded-Encrypted: i=1; AJvYcCVYsnW5xQUEgeOJyFeu07ejeF47UHjj/VF5qjuLsA0A/w/oepOl9rdPCXefzb0cbhyAiA6mxK7unMWk@lists.infradead.org
X-Gm-Message-State: AOJu0YxD/TV0bCl4hMmBiJb7h9sFgQsPWInHo/MwTzX2PqPw/1GFKrs2
	rIx36kqMFNI+1NWFJdCx/MyKKB0AUj/SFwv1bdj51/n17p7Dgzt9edyixg==
X-Gm-Gg: ASbGncu4Zeqz65KqoFocORcvl0zEuukjVO4EHI1KCSY3EF54IUv5t729Qu6BUSeGDTt
	HivWA1WaiNwVTrBwB6ho8BULG7r06EvephUUPGO5JpGI8BJ17GVqTNoQRY1OibVFovCVGcg1E2M
	AOCfWGC+gWGkNqjP1CvDUE/5VAXCI1ItIaj7W9pyfElwd9ardjKyBJTfk2SZd51lhyq6oEqIy7p
	EGjWbvZB7/7NjuZgx/t28gTOsrNSn5NFzO6EhagRxcGQ7ycK3NLYhmCcxi5wMcoeRYRHnLF7P0O
	myw5/rxkqphyDmdcOOdAdW3rN1Nw+0iBpD2WjNAjXQ52yd2ChugFfOv8jX3W6KJnO9j+
X-Google-Smtp-Source: AGHT+IHQnbyvhTyOrlHcZfHR9ent/NJDXIZfcWbDk/8GcX0KgndwlgQnKywMtHhfzAceRVpWe1sbsA==
X-Received: by 2002:a05:600c:3508:b0:439:9225:2f76 with SMTP id 5b1f17b1804b1-439ae1f3b7bmr136034925e9.18.1740469220448;
        Mon, 24 Feb 2025 23:40:20 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7114sm1357162f8f.74.2025.02.24.23.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 23:40:19 -0800 (PST)
Message-ID: <cc262c19-009f-4ca0-9fbc-f94f7bc30f38@grimberg.me>
Date: Tue, 25 Feb 2025 09:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Christoph Hellwig <hch@lst.de>, Meir Elisha <meir.elisha@volumez.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20250223072845.3470297-1-meir.elisha@volumez.com>
 <20250224141349.GA1022@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250224141349.GA1022@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_234023_194391_8B061FAC 
X-CRM114-Status: GOOD (  19.95  )
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



On 24/02/2025 16:13, Christoph Hellwig wrote:
> On Sun, Feb 23, 2025 at 09:28:45AM +0200, Meir Elisha wrote:
>> The order in which queue->cmd and rcv_state are updated is crucial.
>> If these assignments are reordered by the compiler, the worker might not
>> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
>> the correct reordering, set rcv_state using smp_store_release().
>>
>> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
>>
>> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
>> ---
>> Changes from v2:
>> 	- Fix barrier semantics
>> 	- Use rcv_state instead of state variable
>>
>>   drivers/nvme/target/tcp.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 7c51c2a8c109..714d920d14e1 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -571,10 +571,13 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>>   	struct nvmet_tcp_cmd *cmd =
>>   		container_of(req, struct nvmet_tcp_cmd, req);
>>   	struct nvmet_tcp_queue	*queue = cmd->queue;
>> +	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
>> +	enum nvmet_tcp_recv_state queue_state = smp_load_acquire(&queue->rcv_state);
> Ovely long line.
>
> And another thing purely cosmetic: while I generally like initializing
> variables at declaration time, doing that for something like
> smp_load_acquire which should go with a comment looks kinda weird.
>
> So maybe just split the assignment out from the declaration?

Makes sense.

>
>> -- 
>> 2.34.1
>>
>> This ordering is critical on weakly ordered architectures (such as ARM)
> Something weird is going on with this description below the actual
> patch.  This should normally go above.

git am of the exported mbox seems to correctly drop it from the patch 
either way.
But I agree it should go above below the --- separator.

