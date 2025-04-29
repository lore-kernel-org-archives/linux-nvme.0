Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A59C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ct21xWdxCB9HRUiwxLc9z7fHQwq6ssXoKt/SvcdUbtQ=; b=ngR0XcDb8he0eO/L29IzA/+FXP
	W1DQ2WBqgM1Ceq1weJhgYruz+6EmZwxjdZP2KD7Q8mSEwv0Ltowu5FweuE4oq7dQ17UnFJLfBafIv
	Um8xSv6VicEjSnxFttx3emjHjkxbIQWGgCykzGuSZBNsXr7iyt2sKH2cWWXkE0IcZQxn3xvhLYLJS
	5gjjASWtsEOQZ+cFI5tmf51bdS4G4f77CyDDYr7E+EMe8RqhBkwg3qUN+SklGz8Y6iiFfCncEUXQB
	8Ii0yZFnjUzSOjrUziFFnsPstgb6nHFOdjSRr2lmXDTJt9CX1CbsKRzCwLfvkaCBQXaRfsLetWEB3
	u6CYO5Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9o64-0000000AIXW-1ywM;
	Tue, 29 Apr 2025 16:46:16 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9lmp-00000009w8A-0aXI
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 14:18:16 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3d93c060279so15237425ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745936294; x=1746541094; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ct21xWdxCB9HRUiwxLc9z7fHQwq6ssXoKt/SvcdUbtQ=;
        b=fo/zSy59NfoqP2bpSChHhP8MBjEQCLQqQdjUjU2LgWVC89dPHCd+gwhLwuV7MpP7pE
         zMJpqZ0WPqRlBDZT1E1efVziGmSWwN+Iz7vRNgeXXzdJxbZFQZuR+N/hE4XZjMdSGTsf
         cKoUPrh70A02pZbP+xur7lzYpO50/8plmMeIkg4xCcdbpKLvYEZuzlnXrDZxPxv/PUzH
         O/LIr4yQhBq66TsLuuKni9WEg8QwyxkmohXOSyuSCZ36zFj67mN1PZITZkhVsNPO+dZe
         ElJl3OL+lfsPUamit6Zvw3LLXt09G7bQwriLuIS4htVOUH+K+J1NeXhkTmbT1xoU1tF+
         EvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936294; x=1746541094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ct21xWdxCB9HRUiwxLc9z7fHQwq6ssXoKt/SvcdUbtQ=;
        b=wGD3jTB8KugKwcY9jcPuJrbZCWEN8aCfCdd4T4jDWlOwOw4BmuuHqPiTF884JlJTJl
         s3e6vkuCygRE0h/wfN6ieS5x+Nis+1F8EnX+p5GTL82DbTDkc6Js3knrPW4VcmQrnQNs
         CrGn8u2mV2xqHc4b0cSMHk5fw9UD7KwvUd38qoPEXYehvZ+lBBtMFL/cCaF9S6amVcZj
         ZpaOrcZDBNsSLllB9gHm5WqTip25hBLX1mELejPAQUPuLSZD3uX6xUQIPs2baOA/pShw
         ElnIaF49RFArUVKJiBrpE8meOOPbNhJ5QEiW6J1PYknlEsnac9uDwJt14fg8i7vc43Mj
         SAdw==
X-Forwarded-Encrypted: i=1; AJvYcCXCpIRjOfda1qmIrgh2amhuOLDeviJ0Wit5eedR7Gymv4W9PsWPjR62H4c8lyq0uMe0U71T1SdWWU6c@lists.infradead.org
X-Gm-Message-State: AOJu0Yynsi/a3VZ0pDnYtM3QbTxCoFUO7/Xad3Eg9EEClKBqugjkdvZc
	iezoxBNDEYs2eqqUSH95b4c0sOH3hx+0Rx3hS6DJb4Q10AKK6SF4krJGPDCqRKk=
X-Gm-Gg: ASbGncsSOOYtbfiVNQilhMMLjDn9fxNlkIbMaMvLC57QDVxoRi3xwFcrN8cPZWBuZWP
	5YT3J2Kv8Pu/qcVB8XfUB/98QD1Mb4tl1/oj+LxbmZY3NxE180RbpCRXN60gf82AqQFy1fSzrs0
	t4iNJmgKclZiSTraGrfzh/Fdb97Pc2s4EZh+yjRkX7tCet7x9K2YzXLjqeZnksYRVIEmcHDmj2e
	pKELajT+r1A71dprHN4pWF8JJ7NLVH+5vSop2EY9kUms0DzD9izsd/I1exRRYfu+3aNgHFB4J9F
	xRk5BnQUDYxq0WbEGUTGiSV+ATQLP4l5Qvn3rQ==
X-Google-Smtp-Source: AGHT+IHuiCJGsqae9ZdX+4qg1+WYrhBCWzNGXs395/7RKh0IZae2mEXWpmr4vKGMEWDLTxiPRMPSxQ==
X-Received: by 2002:a05:6e02:1a0b:b0:3d8:2197:1aa0 with SMTP id e9e14a558f8ab-3d95d274128mr35517885ab.11.1745936293716;
        Tue, 29 Apr 2025 07:18:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2b4d6asm3520465ab.24.2025.04.29.07.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:18:13 -0700 (PDT)
Message-ID: <061eef36-4a3c-42e8-95c7-1b45d00844c7@kernel.dk>
Date: Tue, 29 Apr 2025 08:18:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
To: Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair23@gmail.com>,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
 <a2aa71cc-b30f-4d48-aa1d-9058fcdbb6d0@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a2aa71cc-b30f-4d48-aa1d-9058fcdbb6d0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_071815_455135_2D1A7D8C 
X-CRM114-Status: UNSURE (   8.59  )
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

On 4/29/25 7:17 AM, Hannes Reinecke wrote:
> On 4/24/25 12:13, Alistair Francis wrote:
>> Ensure that TLS support is enabled in the kernel when
>> NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
>> used out of the box.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Fixes tag, please...

-- 
Jens Axboe


