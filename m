Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3EACD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=iUPBJVI0NmMO4Nig9zrTSKnBGM
	up/xMXEDorB54Sra2gb4pIxcurCAlDP7daFtpO4l95nWTAgWkZlHtT2ZDRQgmbMwL2j7+7JwuyETw
	luK+yiYwuCX6kFsZGLLa2dimfWdHx6/SxlnEVH1EPWjTTEWMTO7YnwHKtCuyGAEHG01VyGaxmEyZ0
	PXVhhDDHTfolisTGbW8vLNjC7GX7eyEAytGgAWSv93iI5Il/6HGoRqsKiBnFBZFjzvL1xhZ8YUJNe
	+uQh3yE1TZtldHkYRjOydNdxSPSauAqgb5wgwN9zrvFNg9lu7OQ+iuHZWxuLhsx2dIQZroQFJQ2AP
	/NJxJeCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNQvT-00000004sOV-3Jto;
	Thu, 14 May 2026 07:56:11 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNQvN-00000004sO4-2Bej
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 07:56:06 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso63944405e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745363; x=1779350163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EidJ2qSo/eOFTbkyUKHQW5f6+BeL+17cjfaYm7y49TsxkJm2wz14OtDSvQDs0CnAM3
         LVBInmkSlT0bZMpbDj3mjk9z3Ne8Xf3xko9OfbPQJwvd1DpeF/v4iXZ0U+CcPvDoNW2z
         gBFXbY1vb30ce/akOMazLwb/O9UVEp6+WWdPOtn80Az5fYBTmKERHO5CPLR7K/CQC7La
         Qt0IjLmz+D91eLOodYsd3NklTy5a8ZlS9j9UIWefrmC6d8/w60K/nqEUZrbmTT9vSKBI
         0KtwX/4KJlX8soStZ8ZNk3kC/GmBvZwRu85BxBoXQs1qYLeMdjcyNJoG45RhFPsaziIG
         H6Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+W5lzJBLGpxHN0cPD22smznq1YVdXBMKq0kDAdBk7F6YVaWTGfcLeDZ9wQZE7cYomGwaJFbbVEXWXW@lists.infradead.org
X-Gm-Message-State: AOJu0YycgxagTzaThgIXnV4//SC5t+PRNtW48k8mHODzXug7WS6b4OeV
	LpP71K6/oBW7e9gG2QEGPLLfWcKLsUSe7WT1KGjYj49w9Vn+bK41C1ybhhV5d70a
X-Gm-Gg: Acq92OEgPXHo8I5iKtG1qNxQlJap/0QnH4AiJoocvmOj7qPuOQ+lLgcARupPJ711G6+
	rB9WDirH98bnzBiA/ejcvBn3InqX4Ls+PiRhvkSeN/ksXzWJAFJS4BDY4TboojBoRERjOo0rkTn
	1rIoSyb55a9KNqR0rq9o//3CFCg9LHWKAQV62MEK/cSnPq5CrBL+R2f83gSavQCew0agqOetPto
	YV4+mZjrtIxVuF3ugMPpz+pFAZWdkFMHthqS4pDtyopDG9fnUz1Y9rMz7sW/xXPpF2WLxVNa3FP
	k8zUNHo8Hm4TPZkmQnYA+reAH/SdLiJOZT2+i2Sya/qXOnDq2BPYlrvjgcotpDSrb0BBB/8wcXA
	Cn6PKVt9tZTtCgaqlvEF7dm8gaFyu10xrBKqef8NmwRIh4VlPsix2yMwuVJgO1BVKOK33JEpmgc
	oduJg4s2c4wSwP5IaVnQI=
X-Received: by 2002:a05:600c:828d:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fc9a0eda5mr98069235e9.12.1778745363039;
        Thu, 14 May 2026 00:56:03 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm5286557f8f.10.2026.05.14.00.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 00:56:02 -0700 (PDT)
Message-ID: <7a4a75ea-5a23-46b5-9c62-f13e35ae2dd4@grimberg.me>
Date: Thu, 14 May 2026 10:56:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
To: Sungwoo Kim <iam@sung-woo.kim>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
 Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260307194636.2755443-2-iam@sung-woo.kim>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260307194636.2755443-2-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_005605_559544_7C5BA5E1 
X-CRM114-Status: UNSURE (   6.85  )
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

