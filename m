Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BCFCD98D2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osznKCBfEFQCGLbmhEnQi6dIYbExH2J+9TBGF3q1rfE=; b=QU32FbHTlDIrvQ2rLIpyYCHvW9
	wVw2eAP5oqau2iQ5ZabazYqwsiXCi+QG4B4ktFCBjsF58i5WEwmqCzeErjAtXjoP1OzwKjJCTKPrP
	kxuwgzgF1pcWyVmiwh/9CouQacto8umyLmhvscerGFtI95LDZ6u6w5rSn72/2agNcG36tvFsHNBBx
	sg/UzBm51JFROuIOytwbWG10m3MYHaP7nm+DK2fp3xHMQEjypFYpGpSHXnrQlFVs9SEUMltYwPJTw
	wa+SX9a7rLiWUWh0Lbkhg5ZUpaJxskAvL7HS8sx0VyRqzk0k8TyUEM39WCpGCCDlQWpi2i06xwJIh
	CqyzXNWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe7m-0000000B5mg-02tY;
	Thu, 13 Nov 2025 20:40:58 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe7j-0000000B5lr-0xyZ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:40:56 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-43325879139so10072025ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763066454; x=1763671254; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osznKCBfEFQCGLbmhEnQi6dIYbExH2J+9TBGF3q1rfE=;
        b=cANw4hgPfV+r65/gCu5bVvsa9WGU+CR4al8sncxG2lGmwJ4DFsMnyJLE+l6APs5LI0
         hF/UDvO+sNHg8o9v/yNG5YuULFsANFXOBc2gQAjI2bqqULg10GeaV1r1a1AihuBmMXy6
         BHEcfA55p5y19AaaypU64nNuExpu9ZYEtD2E1sZC4tU4l0Ffs8NulTHRvDGuHq6S0t7G
         yX4UAPNWsW1VStlEM2oYNBTFUm58ZphBgbtMCK/7zqaFEKdiMZMBhuwQULvwdPELfoN1
         4M+uzCAz8Bq39x61mfjcTRPjsTp5Db0n4obl+O9c4HUwl352ca8HNSWaXsDL9Ag5smHt
         jMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066454; x=1763671254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osznKCBfEFQCGLbmhEnQi6dIYbExH2J+9TBGF3q1rfE=;
        b=bT2l4xhPW3gL3gEHXgLZJXHVvWlQTop0ycKpZIVEKmi7bfCGrFPGELChW2WW7/VVzD
         xCFyjc1gwVZW13RcUzMB/ADBD4+ReHdQM8UZo04WC2J4d6u+Mv8T5KLxwTaFDMlWLSQw
         pPu5olWq4qe/wf1seQOipc3xBhoQs6Wh3cWstPVteQ7aa1g3dS+P7wSNVl5nBdFceVkv
         +6bs42wKqcUWs+3c9inAGw9X4JCrxelZTTUrXUyD0t7cgnkR9OoT7FSA06ddP96f6H6h
         i3vvix1whVKA8VSoPgowDUxanMf3gD0kkWLHmn2oBcTVqL3GbJGZhpXxii132HnlzpRq
         F9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeBtbxjsAg8cZe8a8+IM8HG1fT0PvQ0Q1mREiWNpB63b8oZepNNZLDnZ3kdzaT2/nPXNScb1MQ+0AK@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+znqxiQxy6St+IMT0nScJ+IVQ2VuT5R9CtcqWJ/VDiJaIyqU9
	tVom3W4+P4cPiWEkgXvb5zkVw3gPiorga0YmhPyaSOUCVew0n68ch9Bwa/CoDKuON4c=
X-Gm-Gg: ASbGncv80CkB6GaqtAJEV6zruIWyqsII+avpbFdjt+EJsyWh+gkJzUCArLKZfdj7Pj7
	apjysgfCFnqfUh5hapHRHIKKl3AWnaLxg9LG5mYoZNl46+2TycjEIc0K2I+q397cIQVyWZnI9eI
	CW0u1x5RUNdxr67LUDzHvJJCokMxy/4eNR3s9kpqCAfSz8n08fPpxWwzymRJ76Y7cMojjEaKisT
	x/Va2Xx9pWQlZdF3hSOB23+6EpDkOnvhQPuoq6uQ99+MoUCL4NJjq5uuNDdIGj6MEjledCDu8sH
	AuwVrarc5+RTuMPv5arf7HMaG0Y3WO9WDzVSD+61L8utjqxKfwwR0XDuMpG7iET5oi20UUjInIM
	jk8rqcQ2fUmItN2e+f7H/ExuMkH9xRmqEEmC+A/UtHWbti5/XfvTR8oEu1K/GFhexvjxsmS1AOA
	==
X-Google-Smtp-Source: AGHT+IEKENnV7/NRGeIGQ2XIYLLt5iWsWtTU4O2KKL2oTQn4ke/vffhOdn+C7P0rpZj1Df3mhEH7qA==
X-Received: by 2002:a05:6e02:12cb:b0:433:7d37:38ea with SMTP id e9e14a558f8ab-4348c94e16fmr11150855ab.24.1763066454158;
        Thu, 13 Nov 2025 12:40:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43483990056sm10796925ab.19.2025.11.13.12.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:40:53 -0800 (PST)
Message-ID: <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
Date: Thu, 13 Nov 2025 13:40:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRY28IRvBFmTW6cz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_124055_536463_7EF650AB 
X-CRM114-Status: GOOD (  13.59  )
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

On 11/13/25 12:52 PM, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>> be a fatal error. And secondly, this just further backs up that there's
>> ZERO testing done on this patchset at all. WTF?
>>
>> FWIW, the below makes it boot just fine, as expected, as a default zero
>> filled iter then matches the UNKNOWN case.
> 
> I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The

Right, like most normal people :-)

> state is never set in that case, but I think it should have been.

If you want the patchset to boot, yes it should have been...

-- 
Jens Axboe

