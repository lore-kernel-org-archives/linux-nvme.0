Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C006D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MK8iOyT68uTwYDM4nUUD7HACjnrHxqKZjkHBRY78i1g=; b=tyccF7QS4sdufK5iWzANZ/t3pa
	hHodBC6VqD40mj5ppoDcpTsfgKNuBwhuvHy0+DJa7pscEALxNxO+cqwfoQfJjoS6+HCPMoRhajWV7
	NDmSO6OBjRvzkFLR5mRWzifhqv3COTHMMMd8JCD7/cJ1DeQ996g067Q/5WSCaVTKq8J/7ufiYMiyi
	hyuBmIpcAG2CBDB8fpXp20B0SJSyKbaarMtWJpRWYDH/4cIQ+FdLW3Hj7NwiVtpG4afRCG6kpLO4I
	iFrsBPQgwaopLwYP0DKMOSYt54oOoCCLfwq0y0jM5di0i+30/wNWi1ZWXc3S7TEvXHkXj6jaKrqoT
	scnvhVEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpm5-00000002cdC-3Vq4;
	Sun, 30 Nov 2025 22:20:09 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpm3-00000002ccp-487V
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:20:09 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so22625645e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541206; x=1765146006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MK8iOyT68uTwYDM4nUUD7HACjnrHxqKZjkHBRY78i1g=;
        b=FTqLxSEEhHp6bRm+7/d3ejo4gZ1LL+xzMQ4MoBirxn+kHPY4R/cEhBrJy/K6wdvQXN
         /6Ct8biQa07zS2A1GHYSXJQCObessYlxkknSCOYEL6VmXN3mq1poGpowVDJ0dXdHQgZu
         yn0/FVPrlhV400CfwvJqNjypwGk8obeiEI9h9FAnfdVtUJi+dl1P+TXB2wvWh+Fl4DEx
         sCcF7l/rTZM3FQtWj/L+64yvuT9t2o6O60PlkTYBHzMCd2uuH/m3MZs1k5t5l8GskHA2
         vCkxXsH3Ag4dHy9CUS5SLyLxtCGB2n0SAkud8Pb1KX298seavEL/mKefSXpdAfNPIYvK
         OVvA==
X-Forwarded-Encrypted: i=1; AJvYcCUJWK7PuFw5+8SYonJ1o+cX54Rk8vZR6jlN+7fdfEypBh4TEFxoTLrOLMwjzHZ3cuxCOt7VC39C8V5c@lists.infradead.org
X-Gm-Message-State: AOJu0YztcHcSFEc1zXG2UJx8WAYLC/h7Jy4hLKk6/MxXf599hVQjRWym
	zvShgAwYAvLrIrpa8j206lnyZrtK/FLeljqNaJflfBwDAG8MWOMxpZDD4SnXkg==
X-Gm-Gg: ASbGncsMIJycXz5f+67EnkoIgeJCly5InEZNHjG/wGE2tlh92kqftjbKAKyoDLEcvXm
	bt3cXLS/YqtTrGMtDBRyc0JHdFqmFdNAO9XrqtBlcZoxmjr39riD0S40TNePz7kFHwcWm4s+Nhn
	mZrZK/aFahkpK0EbPA1NT3BAMhXCidgfbGpfNhoWQGlEWyXvC1VpHBvnN2AXLkGFug7ixNNxPIr
	Sbe9nTQXsr52Klv8P4pkLBkbxPSKYqrLUHhYWwn5GMVW2668rw75j7DayoUakH9YG62PZATLAEj
	aB93YsmQ1wL0Yoa1tgjpSJN2RqFRRfAYdalTbzGpg1YSbWuSlBvQFhXmjQEJCCHNgWLIDack20e
	hBgq4SxU9tMDmV2PGeEPl814UXmorD8Ac8VMOI4iWDPvvYeaTt34cruoBhITzkSgEnP4jLyQG/q
	hdqAhKtR8518lTfUNmP2V6svN6FnWl/o9e4qSp8MsA
X-Google-Smtp-Source: AGHT+IF5uQOTcJv09f95vlUdzQFWw4u3uwwRi1AYDrMwsvowx8yGwq1f6KIXa1PJBgPPJypVSpOrrQ==
X-Received: by 2002:a05:600c:1f8f:b0:477:a0dd:b2af with SMTP id 5b1f17b1804b1-477c01ea502mr321465525e9.33.1764541206088;
        Sun, 30 Nov 2025 14:20:06 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111565a1sm201200255e9.5.2025.11.30.14.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:20:05 -0800 (PST)
Message-ID: <3d2cb8e7-aecc-4ae4-a114-04bd59741e7c@grimberg.me>
Date: Mon, 1 Dec 2025 00:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
To: Eugene Korenevsky <ekorenevsky@aliyun.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <aSdiqVR-o6yNav6I@localhost.localdomain>
 <aSdoeEX_L2-3ccpF@kbusch-mbp> <20251127144916.GA9423@lst.de>
 <aStQImuBjWph8Ywd@localhost.localdomain>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aStQImuBjWph8Ywd@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_142008_057511_8D4D6146 
X-CRM114-Status: GOOD (  10.00  )
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



On 29/11/2025 21:57, Eugene Korenevsky wrote:
> On Thu, Nov 27, 2025 at 03:49:16PM +0100, Christoph Hellwig wrote:
>
>> I think we'll need a somewhat more complex check that at there
>> is at least enough space for the len member.  But I prefer that
>> style over a table lookup and magic name pasting macros.
> Okay, simplified the patch. See v2.

Did you send it?


