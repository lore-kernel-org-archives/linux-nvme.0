Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CBDC001B0
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCulArU7T/2N0cjtt9v/Sb6kpK5zL9r3ISOsLR/eGqQ=; b=vruPY2BRGjd1WF+DS9aRr8n7PM
	xmM+wP7Z+hQ289pfKIr8iALEuQiSo84h/lcRRCo5wGBhFSJIIUTg83+DXdGsAxrmQXrGokP3PviLY
	/OSS3+TgTRu2tpMlrBqU9BqSJPxxUR/4UU9Cn0yV6u7ohBUigtubkrZBhXSYfjuNmau2BWXey6EW5
	V1Xh8Pydsvz3UXlsmsFKsyyaF5pZEQJUD190563WPy/S81nOvi7MFALJVTzCy1vf9AdON6lcXutW8
	SMZagwNGKZXUXjWcw8Bi1KwNtSylhv+CUzEBiHOoz4RzWMZIzM9VtwYw/tcJjN4eMf58xyNm16H4k
	0ptIagVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUaGs-00BkW7-1i;
	Fri, 11 Aug 2023 22:06:14 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUaGq-00BkVW-0l
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 22:06:13 +0000
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso7337825ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791571; x=1692396371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCulArU7T/2N0cjtt9v/Sb6kpK5zL9r3ISOsLR/eGqQ=;
        b=T59kN3vgDS3u17TCqCjydIOBUZhqQylY+FQzTcEXWU4kXPtP/C0sPLgvvcjCXPuvDq
         78B9F9c5Mae30zkuvwPDp6snK2cfJEEpCshzdIr3JkQQvuMSmR4lqczLpuipyYVbDQ6E
         uYzT6/7GFc6WgLHG5adxRBA7HaHUvI7Lvdn2p5IwU80BFFJEKeztxDIRidf/NBQUl3qd
         Et233xrW7LuAQwqFMiX6yJuFGv/+4Lr5diSnTENFOXDTpnZOBwijTsiJ5/TeYNpf32VA
         GKzRCjDOLBFuWJ/1HlfbViibEbi35P54oOO26MxzV2+po0qCtsT+5OUfqG6C4ZHux7TU
         uL9Q==
X-Gm-Message-State: AOJu0YzTI+cHSbZAhFM91RjKHsWiZOYK8Xe0OPwa8n/hhdwXK3c7SiHq
	B0x1NjVc24JBVLMo+Jg6QRA=
X-Google-Smtp-Source: AGHT+IGRDCvq8p2vjG6TVx2gDv6+cL2iFQ4Ue2nk9VRR38rhHkVlR+1xjT53rq6hRwjwXypPBI3lmA==
X-Received: by 2002:a17:903:244d:b0:1b8:5ab2:49a4 with SMTP id l13-20020a170903244d00b001b85ab249a4mr3374277pls.53.1691791571131;
        Fri, 11 Aug 2023 15:06:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001a183ade911sm4424160plh.56.2023.08.11.15.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:06:10 -0700 (PDT)
Message-ID: <2e263977-0ee7-ae78-5a8a-2a67df43df76@acm.org>
Date: Fri, 11 Aug 2023 15:06:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-doc@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_150612_294040_60841CE1 
X-CRM114-Status: GOOD (  10.51  )
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
> +		if (rem != chunk)
> +			atomic_inc(&cio->refcount);

This code will be easier to read if the above if-test is left out
and if the following code is added below the for-loop:

	if (atomic_dec_and_test(&cio->refcount))
		blkdev_copy_endio(cio);

Thanks,

Bart.

