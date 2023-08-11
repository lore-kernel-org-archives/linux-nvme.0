Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CCDC001B0
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrI+uxp3aYoFCrzZoU6uRvoRMnje8fjhUyPHKIqWtFA=; b=hpbvXyXo2HW3H0KNQh6Iry0Rpe
	oTee2xFgT7sMkVOg+3Feb4wiLUTXfVHomgAoW0L1r2uTBEqMrIDS8JmnOwjmhMrfLvgnJ5o6bOY2e
	oO3EDjXEZJ4Zse5RdAh5Ek6b2X81bgDztBBKksmjmpGj+cF78rfdamLMiyhdSbJRnosagNUDSPT+F
	idrhUPZeSugqTkX5HjUuhZ0mJ23Z1cwNjw6FDreJj6apgeIXoGwSH+2t3k2+SqDs9vT2Heyow7viQ
	AHycZEEFmbq9+4+er4+aU0zjbbmSgD3FpneJhlEbhA6dCIZHJcMsvFLIDP5eXzupBdAEOp5DBIHkk
	8T0UYIew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa25-00Bj0o-2j;
	Fri, 11 Aug 2023 21:50:57 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa23-00BizR-1T
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:50:56 +0000
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bdc6867ec4so3320365ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 14:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790654; x=1692395454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrI+uxp3aYoFCrzZoU6uRvoRMnje8fjhUyPHKIqWtFA=;
        b=LOiAmclW0LaffKRlnoX5qXNSPzvE9/ZgPXuj9dY+FmK540z4ihMG3xztiksZcVQwVb
         xQyGu+cqWUyXSen/C6PDLdnKwvT1cCPdCdnkuCnmNg2+BXWqgb5R9oKl/IF+sH4SubRY
         vyI00gXcJKRmOj51R2N1Kmhj4t3n0f+ab0LlghstnPrGnRTwxu2aO4qnYO4vsCLK8xpn
         8fSJ8YD4fh2ftDU6pic/JfDcBM+8/So9xRRFX/98ctzQAoVUJ022h0g6c/p4z+IS1RDr
         J59DvcD013u89FAe/ohg17SWTum4leghk7qehd2IwaTl2kGU1MzURZZ54ueHilr63bXN
         hp4Q==
X-Gm-Message-State: AOJu0YymuWQBDtPv2xN21dYzCvZoasxp8mxHbnJ0MAicFwR5k4g899IB
	BCc47LpxaB8Mu+99QaEI3SQ=
X-Google-Smtp-Source: AGHT+IF8U+lGorQ6rte8/N0gRF/coyHYDMaevJEd+XYzOy0jSGnPMMJg+8prLKGskrtcXvIzIdxvzA==
X-Received: by 2002:a17:902:ab5a:b0:1bd:bfc0:4627 with SMTP id ij26-20020a170902ab5a00b001bdbfc04627mr1837548plb.40.1691790654475;
        Fri, 11 Aug 2023 14:50:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d30100b001b85bb5fd77sm4388437plc.119.2023.08.11.14.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:50:54 -0700 (PDT)
Message-ID: <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
Date: Fri, 11 Aug 2023 14:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 00/11] Implement copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-doc@vger.kernel.org,
 gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
References: <CGME20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96@epcas5p1.samsung.com>
 <20230811105300.15889-1-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_145055_519240_4BCFA1AC 
X-CRM114-Status: GOOD (  13.24  )
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

On 8/11/23 03:52, Nitesh Shetty wrote:
> We achieve copy offload by sending 2 bio's with source and destination
> info and merge them to form a request. This request is sent to driver.
> So this design works only for request based storage drivers.

[ ... ]

> Overall series supports:
> ========================
> 	1. Driver
> 		- NVMe Copy command (single NS, TP 4065), including support
> 		in nvme-target (for block and file back end).
> 
> 	2. Block layer
> 		- Block-generic copy (REQ_OP_COPY_DST/SRC), operation with
>                    interface accommodating two block-devs
>                  - Merging copy requests in request layer
> 		- Emulation, for in-kernel user when offload is natively
>                  absent
> 		- dm-linear support (for cases not requiring split)
> 
> 	3. User-interface
> 		- copy_file_range

Is this sufficient? The combination of dm-crypt, dm-linear and the NVMe 
driver is very common. What is the plan for supporting dm-crypt? 
Shouldn't bio splitting be supported for dm-linear?

Thanks,

Bart.

