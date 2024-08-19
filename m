Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23932C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2gNaJa8SOx8kd7BVTNZW60iNJokErViNwd3jtMu9d8=; b=wsA6FYBDu3kJ3s2uQQxxwvWstz
	4BekI4OPptCJyrEWPXL73V+trbAxk8d5rprmUyxKmWxHpAKSkR85pH3iNlmmJKt0JDuODfxa6CSJE
	Elx/I3Nvv82izalYFugCYNF52FdU/9NSAxF0Dis0gu0JpHFc6+T97WLma0ohfGg4SEO9tolxQIXZX
	KQmRkvjoIyzHNrR173lGYLVOea0tvXMwgyfW1ms52XEjDmqULaaQMLTCK05kAz+DTEghVFTmjdeSX
	EETDhpMKxGbOHgvlJG8Ujc4CPpWomNR48fht/oHjtWmk0I+s+3DJKhcUO7akhomyvkhhDk8fU1KKw
	C+2cY96g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3I7-00000001jfk-3Bqi;
	Mon, 19 Aug 2024 14:23:27 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3I4-00000001jdZ-3Axh
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 14:23:26 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso5957965e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Aug 2024 07:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077403; x=1724682203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2gNaJa8SOx8kd7BVTNZW60iNJokErViNwd3jtMu9d8=;
        b=MBxprZ/D/eG6NPTjeS3sfqZiW3ht3YaPEzNwNPW/KPJkUYxCOs19b67wgNGKyY1QJH
         gU4VeXVcxv6e1QCeMy/uPGKHv0Su3KBAUjDDbg114fL95zt0/pgRGED+iVpxeeNXL9Ih
         v7Myy6Z+JlNsJMNpYp8ZUuiAIloyUgJqWwHHwajKjwfUbr/QpJFxsMSxRqo13kPeer6X
         lrhPpeosocl/VX0/Rie2V9OZEBMzgJczUpiHDgR/TMC4yq/10Fp6iw7eBw3jp90miSxE
         MMsxMbA702/oe732lccD6n1yVQ5ty6ccA9uECIdquQoB9gw/oPRPw3Y3Y+mSZQV5zl9x
         VYWw==
X-Forwarded-Encrypted: i=1; AJvYcCWimezxIsk1gTC6VF5SrME3Ks0yBpf5UoAwuZDtfLqGOXngye7D70BrPRVMCu2d4nK8maTVVfRdTJgi@lists.infradead.org
X-Gm-Message-State: AOJu0YwX9ksPYRcknW7Cm6P3ac0zv0wvOCNMR+pi7d0IyxsKgkxBcxey
	DRfAuqjYF9+R4ustWpOg+v6ubKbBa1QXBdQpPmTNQcMUMbZsomqh
X-Google-Smtp-Source: AGHT+IGyczUYdWHjJXNYfwfuW+IrqAoI7Q51/TuzfIn2bKzyMJkJCTgbvgSHWiqhUw5wQDrV7tDpzA==
X-Received: by 2002:a05:600c:1d0b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-429ed7f95cemr45374265e9.4.1724077402709;
        Mon, 19 Aug 2024 07:23:22 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650402sm114187165e9.11.2024.08.19.07.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:23:22 -0700 (PDT)
Message-ID: <e94fad38-0769-4e70-a8f7-22021322ebff@grimberg.me>
Date: Mon, 19 Aug 2024 17:23:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix typo clearing NVME_NSHEAD_DISK_LIVE
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122736.57863-1-hare@kernel.org>
 <1512e3c7-ef59-4096-ae8d-0e158addda42@grimberg.me>
 <1502800d-f2f6-4c44-9d73-c026e3fdeeb5@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1502800d-f2f6-4c44-9d73-c026e3fdeeb5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_072324_834764_968CA143 
X-CRM114-Status: GOOD (  12.06  )
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




On 19/08/2024 16:50, Hannes Reinecke wrote:
> On 8/19/24 15:18, Sagi Grimberg wrote:
>>
>>
>>
>> On 19/08/2024 15:27, Hannes Reinecke wrote:
>>> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_nshead', not
>>> 'struct nvme_ns'.
>>
>> Hannes, what is the phenomenon here? Is anything leaked or functionally
>> broken?
>>
>> The patch looks good, but please explain if this is caught from code 
>> inspection
>> or a real issue that surfaced.
>>
>> For the patch itself,
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> We've seen the issue popping up during repeated map/unmap operations
> with reusing NSIDs; occasionally we would end up with stale multipath
> namespaces and non-existing generic devices.

Great, please reword the change log to explain _what_ is fixed in the patch
title and how you fix it in the patch body.

