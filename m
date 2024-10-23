Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE7CDDE40
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BO4IKSBHt1Q1mT9S6U7vhhQdn4yhc4ey19Jpo4ZbbSM=; b=RYbxleKF06L9tpC47Lv2SEa172
	cm1WjhWiPxV2/tUekrrCBR0wlBb+T8ILyyLfOeQnHOSfb6dVtmgxrZ3sGRgIU32r2BxPDnOis2q7b
	OBVyej/gAufB4RiChXAhWXt88WoO7TEZy2V2y9CYedMjCYCAXBpr7S8G+ZpHsunEOr5cDiMCt2fOw
	Dl6d2KAh7fomW2yKcedetjZo8QQPCjH8ngp9ju3/M5a7XPvvS0Em3mdr0NKnXrbKyPLpIzKvdeJcn
	Himdn1dctowBi9nBmk9ol6Y5NHqNlGBMiH1pzXBnuBrr4wmCyqUWkdDE43rLOAAdIuOvI/m2HHyjI
	2trL5ZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YAH-0000000Du1t-45t1;
	Wed, 23 Oct 2024 10:00:29 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3XtC-0000000Dq92-3My5
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:43:00 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso362835a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 02:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676568; x=1730281368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO4IKSBHt1Q1mT9S6U7vhhQdn4yhc4ey19Jpo4ZbbSM=;
        b=LRMnpq6hLGvOw1DH91skQGb11U+bDRUOqB+apzNZQEijSKoAXOzonXe7TYhtMDPsfK
         5tykhXIhnezOvIX6Au/JUulFRWuHjE/SEynDRKuHfPd9WaS1qrQ3CVsp6RF/1do5kgip
         X23uC5uhePw+OmalNcqwdb7u/XRY7/G9SgVfYWqwrFJCo2o/OvasbjbIemOFFOWolKiL
         k9auI2+XGhAncuR/Kml4cVaZQBkSrmXSMQ1el7VEc1eT0ZwdhR86IPuH5lIqx9rNTj5e
         ER+F1so2daJsbWwD2Xg2yrf3ojLr5RC8HOux3BlokseF9lFn8QH1svOsBKBJugo1QJhb
         +aWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnfel76sqKZ8FiK131oZ57TqNA99uRYltSKZRF0FZ0ifG55KOvtulVw0APEXUXs/R70mwt5WDMerHd@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu+D0sU2xgQ8vJSwR8cS1sJnIL2uCT5FKRrzBhrDkP32g4ULdD
	bteLvZxM3a1ROKEqfpl0ooh+cYtHJDBuIFLqxbtiMfDcfX03mbNN
X-Google-Smtp-Source: AGHT+IEY9r0hhRI68S05Re1NMWBeDSLewD/olC9sdYV9K4kcHMpuA1lxmq2LKhabH/W4oqe0Yo2YEw==
X-Received: by 2002:a05:6402:1ec8:b0:5c8:a2b8:cab3 with SMTP id 4fb4d7f45d1cf-5cb8b4e5b8dmr2190463a12.4.1729676568263;
        Wed, 23 Oct 2024 02:42:48 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4181729a12.72.2024.10.23.02.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:42:47 -0700 (PDT)
Message-ID: <1a948684-aa1a-46cb-a51b-e16b1da1c358@grimberg.me>
Date: Wed, 23 Oct 2024 12:42:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>,
 axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
 <Zxb8KaoUVstRCxiP@fedora> <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
 <20241023051914.GA1341@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241023051914.GA1341@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_024250_892134_2AAB8456 
X-CRM114-Status: GOOD (  17.88  )
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




On 23/10/2024 8:19, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 04:23:29PM +0300, Sagi Grimberg wrote:
>> I agree. NVMe may have a unique need here, but it needs a tag from a
>> specific hctx while the context requesting it does not map according to
>> the hctx cpumap. It cannot use any other tag from any other hctx.
>>
>> The reason is that the connect for a queue must be done from a tag that
>> belongs to the queue because nvme relies on it when it does resolution back
>> to
>> the request to the completion.
> I wonder if we should byte the bullet and not use a request for the
> connect commands.  We've already special cased the AEN command because
> it was causing too many problems, and given all the pain so far connect
> might also have hit that treshold.

That would be trading one set of problems for another. We had some hard
times in the past to correctly fence AERs against controller states 
because it
is not a normal block request.

Plus, unlike AERs, connect has a timeout, which we'll need to take care 
of...

Not that it is not possible, I'd just like to avoid this option.

