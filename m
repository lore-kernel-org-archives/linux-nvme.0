Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E5CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MRz+FueenQz48zF7s1KwbMdUae
	YHklmUYouBURblseg/UwYYtIXpxUdol6khNM9aCvJKKfh+9PgE8i7/WfV9QpwizAi8BVAw/LStfYW
	lVNGGWTGGDWZWwi3pHWQ5zrYgxdQA4N2X9+Zerz9f8+FYdE/DlqxF143hNKa0o4Vwh/Bo5yBVD1Wo
	o1Hc1LStBYp5Kr+09wr6/eNsMdC5VQUbg6H/2Q8cU1Ma/hMrTLljdyiMkYNU1ZBUuKDOOLPINbKXx
	2NNy7hL09ZRNCT5H8TrUNnSLZL/RDIY6sfLIxDhKoaG5Eq61GkwZQ6m5MAsOBH+OyZhNEwiERDJUv
	060MZnKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHm-00000002dwj-09fx;
	Sun, 30 Nov 2025 22:52:54 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHj-00000002dva-1idY
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:52:53 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219db05so21163505e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543170; x=1765147970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=u6cQ0dSaGIg4Ep8+uTdRRzCIpzKvEiipTQ87KGnZV2u7vSGSPiYHLueWnTQjKFN5jL
         0ZkSND8BLEx/uDHvDF8/iUESGAbMIsjCOr6351d516jAFroZjMuxk+XdSXbfEuDXyFd8
         W5mEy+gWWU/CLkNRFXGNNj9DPG4HUhy8G20vRmd5LBFm7wdM3IEwliHvWiuO7zAZ3XxY
         YVeFaqCBP2nyq4Wg4vlblxzoTgM5XEkcR/G+ZM+BK64K7nwkHVnNCJ2zQz4NOFdo1cT/
         Z6pXF1MjO2bbQOT/MRt0m7+42B7JvFo0qLvHCPJoq3so3IGv02fqkW3PmmKGWjK0c7E6
         CRcw==
X-Forwarded-Encrypted: i=1; AJvYcCWRN+DuBsB+EFDWU5997vKGQ/Iszh5WyF6wgHejOEI56rW20isvrmu/zm+A4MpGkTr0NE/qkqpwyhMV@lists.infradead.org
X-Gm-Message-State: AOJu0YyA3F5/7cULv7WtsUnLJeTc3qwJTsTNIqiFC7e1/Q81YQP7AxB/
	qyCZnQmwGQnZ/NzCDQKOrFqYi91Mz0lGZLJ+uMqbBHw+PBXafOjMhJou
X-Gm-Gg: ASbGnculMvjDWY8Cqqurmx53p8PaAguH0UuKvJ6H2fx4RgmMbljRGJgvo8sGCtDRf2j
	wSbEHYaYTsolh9jGmSQZnQwMEtPhUQItS8p5VonlpPMDXlputtzQyI3jS+a7xVZ5zqYUa83FhTO
	wZsi0sJAD6jjsLNbftX1Nmrejh88jaGGhJRhiEhfjHCvCLfMorc66VLlMA5UHsTHwufea99bh/U
	0X30icYlH0/0n7pFD/P8X2Fo6sZFrlK4vnIHRV167czy80J4uTcN5SaWfK733y0VMRBq7hFYr9P
	dNUk2jpArtkeMKZ0MIvBpBSThi7uac2iKbpP0BDjv+DXS0F5CxWxAyB95+rGRFLHmEtSdykh0t8
	HGQ1nc9XrXWMIwocRHkrIDX5aD0WzacSfnsfg1fVXwPyL0KSI/t3F3PIrbonuN2zKF8fmmEtsZR
	wvz5Kxp7RAtR1kGTJqC/ui63Bx8p+a/ODfyM6KPfjTeihdK0gWlaM=
X-Google-Smtp-Source: AGHT+IECNVxQzCcqL0KalRssA/rr2F7h+qiyoBTQrvQg6zuOhSR6fdE2/PeP3To9S7MH3DcPzNpNSw==
X-Received: by 2002:a05:600c:1d0d:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-477c1126d1emr327455585e9.28.1764543169619;
        Sun, 30 Nov 2025 14:52:49 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm271968105e9.5.2025.11.30.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:52:49 -0800 (PST)
Message-ID: <71f666ce-9991-4d13-9bc7-3c4cc150aba6@grimberg.me>
Date: Mon, 1 Dec 2025 00:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-tcp: Use kvcalloc for commands array
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
Cc: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
 <1763966961-32140-2-git-send-email-israelr@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1763966961-32140-2-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_145252_063187_55A1CEBE 
X-CRM114-Status: UNSURE (   5.15  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

