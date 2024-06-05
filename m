Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F8CC27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zuFr/HGJoTiQF+zMRvZ0rmnn7/
	VkuPXOzptvzVkAwpnN4b+yXCx4P2hMPxQXjVs5ATqvrS7tNkKbOYdIIKL8JG+jgdrQy5WzVWxkSOI
	zgRroGKBxLoRyUE9DdJsPwmJ/Z0uEutzC1VE4mDz8tqZAMMUfIudN0RzT5qQDaSsULPKILdWBckpI
	HSBkpo1phkyGXKdHZBfspGeAaLvXkvPMWuGGrhawKGk8y/tRj3ITWlZhN1HkaiHR5EbJBalsFA5Qz
	YeIDDm/yT8yZftgggAn55dj5ULvRehhX3mtQzRxC2aKXFM0NS5JcDrlK/w+mNQow7LROGxzzuVUGP
	whTee0hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmQe-00000005IoH-1Hhj;
	Wed, 05 Jun 2024 08:55:32 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmQa-00000005In4-3Mf2
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:55:30 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so6676255e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 01:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577726; x=1718182526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=C2VyLFhrekXpFv3T7/q2V7zZGOLLq3cF1PXoNTNgOI0OXO9Oa/0qfhzWpHWX+/R0ei
         o/6NruIZbI1HxQLE0cSWr8B5uRlmmx/0yJM5bYeZKBjTpZTxBye2Xiisvpz6e4GLYYJX
         LN5//c8eWzmm6ic4L2k4LJAUF1nBAYim32V4wtm/nB4EyqpBEwh+smS+g9Gv81+SqnB8
         sT/mL+x5/brBHHsiAY9UyPAdCvaGhLqDoI0xxltBb93xs9JPZqYhgvsGXrGcttdFZH1Q
         00+7WZq8GWWFcnle7QC7zQfN2R4YB2uPpbd44BbXVc84LAm2yDbX/DJ/czWXZ1s4xWiz
         /CYA==
X-Forwarded-Encrypted: i=1; AJvYcCVuL8ubkjgrIL5hKHWQ42CU9ORSzLuXT/ZccscdJaLoD4TbuLLoZyF6jD+lLB7zoZaibbhzWo3GyoP+vO63tg95p5KlZ1um58t9ZPh1kfg=
X-Gm-Message-State: AOJu0YzywhHJST09puiFJWdDgo/PjeWQ3HLLSMbcVw1uY4wYUfY4Ofst
	kUHHGuPzINUkuEGg6MBv7TSf1wRhvgBQbh+ZHqd8uZzxmq9LmieFCC51fH5s
X-Google-Smtp-Source: AGHT+IFW33I8r8NGEZ5IjSt9qzBSYn5TqFgWh4x2BoQh0/dzC0WQrysuWa0xZ0C/RDL+cTtDrcBMdQ==
X-Received: by 2002:adf:fe0c:0:b0:35e:7e09:c3cc with SMTP id ffacd0b85a97d-35e929c7c5fmr1219412f8f.6.1717577726074;
        Wed, 05 Jun 2024 01:55:26 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04e845bsm13760547f8f.65.2024.06.05.01.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:55:25 -0700 (PDT)
Message-ID: <a90fd7c1-cf76-4e82-a064-1000cfeaa629@grimberg.me>
Date: Wed, 5 Jun 2024 11:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] nvme: fix status magic numbers
To: Weiwen Hu <huweiwen@linux.alibaba.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
 <20240603125702.97368-3-huweiwen@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240603125702.97368-3-huweiwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_015528_938129_BDA7059C 
X-CRM114-Status: UNSURE (   5.39  )
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

