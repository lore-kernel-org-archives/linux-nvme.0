Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF7C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00o3TCa+8VgZEtv89I/31a7QD0UJtBkuqwq7fRGeG+k=; b=hArsVx4bv4owcdAv2j7kpEjw6z
	dp8/pp0Ug4uXSD5e1UcJPWGlES2C2NgFaixaZ+/KacEj5OdhJJfWgNEh0z8jCpPTtBQk/pGu40+QO
	wE4n1wCM9O5xbburslemEXjTe/P7EHbt5+BRnNtHQ/6VpHDcb9Yua/98YP8MsbeBihjKUqiNgmJkI
	XlcZQHKXHGIq6i8RnKzifEZQGJQrRaxi7UKhvUKTlgkyC0pneI3LH4eVesWAdITzpPn07MXuB1PYb
	SWeF9dwA0btq8pEsVu/43/0qtICk3TTPfK//SJuc1lLhRZLHbg1hnm/6Ltu1wMUEjRJHNuFFhrD8S
	ypP6GHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8lL-00000006PKP-1XsM;
	Thu, 23 May 2024 13:45:43 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8lI-00000006PJq-3J9a
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:45:42 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35503846fc5so24338f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 06:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716471938; x=1717076738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00o3TCa+8VgZEtv89I/31a7QD0UJtBkuqwq7fRGeG+k=;
        b=bofU4IbhdKHJfyMvB+lKwdzC9dm5XwWFxOupqRQ03AYazY5XoW+as/GMXfTY+jLWR7
         lDKZIdKQ0RbEh50Y0FCk4MSGQDoYd5A8gdTwW58VEIfAJSDESo/WMV5ISgcRKvOFPgY3
         FJ3fXN/P4JSHBxv4fQz3JkEpQlLT/9W5h04JlON2KV3eCr1HWrdTVowxmEKt9YTfqtJ+
         Os56IHImaZOOruYIV3VX9sOOjE3aKUxaZffoFBqnSy/iFiDQrkO3YW5tvijsvTCgjSNn
         QjXKCb1PPUxBa5SN1BvsfHqDzRagBaUTQtFr5ZvWBWC1onNmTpFZtc8fSDOmnbRoKHUm
         DlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh1Yy9NeUZ5PI7YsPO3m6p3XFwXP6w9IesIZFG+xUwkV5mWD4uniDyanRT2nL67yGBI0R1x9TTZR0pHgd/mhB07fO23sLEgf5dB5ETbf0=
X-Gm-Message-State: AOJu0YwiMMOL3nE9HJTOs7+pR9XWzWejL2aumYCKBBUxs3tm6GtCWit8
	nqoF4jHvqB0PoL2NSyEvkbD/2B/dMmjW+egqbwncu+evnNMqobFJn5n/aA==
X-Google-Smtp-Source: AGHT+IG/cKJrcTeMUQBL/rBRpIfqXfYLnSAG/IoPNtF6VuiicOvClK990ZoNxOCMjSJRO0JSrzchkg==
X-Received: by 2002:a05:6000:1788:b0:354:cbc3:bd9d with SMTP id ffacd0b85a97d-354d8bb2211mr4400274f8f.0.1716471938385;
        Thu, 23 May 2024 06:45:38 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc334sm36674236f8f.103.2024.05.23.06.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:45:38 -0700 (PDT)
Message-ID: <535e843c-2617-40d4-9ced-009422b4973e@grimberg.me>
Date: Thu, 23 May 2024 16:45:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
 <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
 <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
 <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
 <20240523065412.GA29137@lst.de>
 <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
 <20240523123949.GA20758@lst.de>
 <4509c11d-b3ae-4be9-9904-5aaf2628f7f2@grimberg.me>
 <20240523131933.GA23660@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523131933.GA23660@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_064541_049093_49F2C094 
X-CRM114-Status: GOOD (  14.73  )
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



On 23/05/2024 16:19, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 04:02:43PM +0300, Sagi Grimberg wrote:
>> I just want to have good testing before we touch these areas that
>> are all done in ctrl reset and error recovery which historically manifest
>> most of the issues...
>>
>> and all this because lockdep complains on false-positives...
> I still haven't seen any proof that it is a false-positive.
>

The explanation is that the nvme-pci timeout handler will only disable 
the device when either
it is able to transition the ctrl state to RESETTING or if the ctrl 
state is terminal, and in both
cases the reset_work is not running concurrently...

It was also proposed moving the call to nvme_disable_ctrl to a different 
context (returning BLK_RESET_TIMER from
the timeout handler) such that blk_sync_queue() does not depend on it. 
But Keith said it won't solve the issue.

Keith spent more time thinking about this, so I'll defer to him. I just 
want it to stop bothering Shinichiro and
others running blktests regularly...

