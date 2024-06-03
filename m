Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB0DC25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5xzErDAmbdmISQVPCaa1tqc9grd1xDfpbrLoCt0N4A=; b=mVI0Lq4mpamRyf+WMv9fY/UKiH
	IgQqOvLz9/HF8/gqS7DGQkY3UI0WJzb0zS+VA9MoGqdx/2Mc/1wSy7VvIWCHg7qX6AGcs6w31Fa6L
	CfLI9VF48hsuxcUymJ9MD14sRAGM1HgxVDykPBrBcoXuSAqilaJOztVOcLuVx3lJY9OPbpYUuTZhi
	we201bJJow1/YkrGZBSjiEYd1r3aTkbCTynaROFjHmHcMhBZmYEaXsCZLi2y75eHtktCyg2K3TAZ9
	7q3caYwVt7881TyM/ENGWXMK2N+GIAYqeZepTnIO0gj6Xvb6K/CmIxWzPJdKcq3TSX3WPTi7cxIJL
	CeKCKtlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1p4-0000000Fr0U-2PnR;
	Mon, 03 Jun 2024 07:09:38 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1p1-0000000FqxY-03ST
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 07:09:36 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ea8e92c0b7so4207971fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 00:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717398568; x=1718003368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5xzErDAmbdmISQVPCaa1tqc9grd1xDfpbrLoCt0N4A=;
        b=iWyiIafMwJftcVhejACYT9zxYWkqZZEgE0zrLlTrqwqWh5rAMJ5V3wEikLGB0RMP0O
         gPqUnhK0/A5s03QYukedOpwfJ4uLyi13gEJO7QbDgm71dkH5k2JKInUNxRHHvUoGCn4M
         rdBhXPkMtoNQJ54GULeaK2tCbdWPSRJlqc7pacbnLbUiyL95NyOUQ41et7ieEyRMdVGY
         2OtcaTsBftOk4hBBAItyAu//ksKGeqO+L3hK1E3UlTDZEb7r3ZifSydvhW717gNIt3RX
         gvAGu80Ut57/E6NqENtroi7Hps+HZhOTDetwv96atw5nXbEuiSfCtvYow70L8tFZzqHY
         5pcg==
X-Forwarded-Encrypted: i=1; AJvYcCXo9G43Zc01Thi7K587Nc140FDIAWA8chSJXmEnPLmVeFYBZBTLPI9cwhS3Pq1e+Smhc9vpzc2TA5ZLNW4/lOGZGJChyz0G9O3EYQRyQ50=
X-Gm-Message-State: AOJu0YwTitPI+tIvcsDyu3jdMTfgUcZw87WY0pE3PJvPy2M93NBAd0Gh
	Tso6aIFzosnsKyj2dmuW3swSm8QBG6k81UjV5KOISq2R9eNCmQum
X-Google-Smtp-Source: AGHT+IE5r0soLdabb6igj9MUhMvzBhhVUB3h1THX9KOP4A2vIvTn24IsAKgih+iOUrLVnDfjUfYBRw==
X-Received: by 2002:a2e:9899:0:b0:2e8:60ab:c6e7 with SMTP id 38308e7fff4ca-2ea950e6688mr52910291fa.2.1717398568094;
        Mon, 03 Jun 2024 00:09:28 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm27099335e9.0.2024.06.03.00.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:09:27 -0700 (PDT)
Message-ID: <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
Date: Mon, 3 Jun 2024 10:09:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240531061142.GB17723@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_000935_091595_5198B07C 
X-CRM114-Status: GOOD (  18.38  )
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



On 31/05/2024 9:11, Christoph Hellwig wrote:
> FYI, I still absolutely detest this code.  I know people want to
> avoid the page copy for NVMe over TCP (or any TCP based storage
> protocols for that matter), but having these weird vendors specific
> hooks all the way up into the application protocol are just horrible.

I hoped for a transparent ddp offload as well, but I don't see how this
is possible.

>
> IETF has standardized a generic data placement protocol, which is
> part of iWarp.  Even if folks don't like RDMA it exists to solve
> exactly these kinds of problems of data placement.

iWARP changes the wire protocol. Is your comment to just go make people
use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?

I think that the former is limiting, and the latter is unclear.

 From what I understand, the offload engine uses the NVMe command-id as
the rkey (or stag) for ddp purposes.

>    And if we can't
> arse folks into standard data placement methods we at least need it
> vendor independent and without hooks into the actual protocol
> driver.
>

That would be great, but what does a "vendor independent without hooks" 
look like from
your perspective? I'd love having this translate to standard (and some 
new) socket operations,
but I could not find a way that this can be done given the current 
architecture.

Early on, I thought that enabling the queue offload could be modeled as 
a setsockopt() and
and nvme_tcp_setup_ddp() would be modeled as a new 
recvmsg(MSG_DDP_BUFFER, iovec, tag) but where I got stuck was the whole 
async teardown mechanism that the nic has. But if this is solvable, I 
think such an interface is much better.
FWIW, I think that the benefit of this is worth having. I think that the 
folks from NVIDIA
are committed to supporting and evolving it.

