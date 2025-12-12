Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C074BD49229
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oqhS4q9YE87pr1XK2d5M9VOdVX
	tQF2O6YYNTGLcS6uY3vFtKYLNIWITpN/T17OuV3wM8bRQAkEjcY6OGX/JZkMcPfee2ZTz3c6XdCCt
	Mra8dp2G8LC9KhhAfjUT+1Oc4mHLkhcKBPCXbU4BSh0bW8Zg7pFIhe6E28HVCFSpalYfRCRbpMhgj
	OrHc2T4bupTFnLWy/MVN6OyIW9pwrryUcZpw/mE6cq5wTIcnPoKruQk8cld9GL+CsVOMf/8fJ2EhW
	7XfhC5eNb1OAPGOOegHRHku6MO1/87JviXnFM/q40fOyzybblXjZ+NHx9yb/uJwUjodtPQUPeu2oj
	Jze93/yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Wg-00000000a4a-0vjD;
	Fri, 12 Dec 2025 13:49:42 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3We-00000000a3h-2DdG
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:49:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so9894485e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547379; x=1766152179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=S/zzPNhdW7ZbbVd0K1DsjSYPGJlSWfPeQzsx3VcxFzOUl1DPzj0EzIArJ0xpC+q8IW
         mCuAfUc0VNgN4lP2IVK4SHmJNBEx9OIS9jkUAyYCRK6C5aolQqmOwpnZN0INZU/fYvJP
         gokJe4oE4ev/KUwpyQOErprD7pnuzLHOG2+ecNgCV35LxhAk+OiptyXGRxi7MabmY/Z8
         8W9Tz3YpF7C+tavWJYWvSHmbDGeM9b+HJpIyLphKaG6HQXD7ac9Li0oj5A5C8fV1beyL
         2i4MTtlmzsXBjzltEm4nvP9QUQ4GsKLToutLY+UaHjNsFGh/dEyJF9yh75Nd/EJ5r5Nn
         0WBA==
X-Forwarded-Encrypted: i=1; AJvYcCVVMkfOHiTP28I07gWxdK8OGy0UL73R8rQFxHTdqKddnwLbT185+W8spFdDn7rzN7VGSYOPDJyAb/Of@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7HSlFKC2ifaARmAjqN62IPgrFHW1SI+6PUfkBVyP6wN8qyUK8
	WhtE5pFwHCD5coPqtVTDzW7pLMfXi2Jn8vL1+VxQc8R+6qQ0qfdTE+MQ
X-Gm-Gg: AY/fxX7MV09MESKVk2SnODs7Jo1tJj3vK9Yvfh1bGuRoPPMZ7uawGsbZzjigD8cLCwd
	8AfBLX2U+azQiHHGZteWu3GDL8LYhJ+kaqLMHgkj48CmKxpL+ef+1wCFcQfNDMOHGQPVvl5Wft9
	YSFao7X1CCkm32ICbLeeOZusFPPO34YgYOCqNbH5P76djbzTvIL0ArusMgr7vBY6Im7Kt2bbWkD
	EqNvWGQCPWEFLe2kRVJgkF1EoDHIM9ZUO6hjQBBjYxCf84qTayUj/DJT623kT/HLlbvW8Ayyj2M
	N1CL8Pw5/EveVbr1Y1rcM4ynPgPBqbTNL2FlTbXXK1G7qNK9/yNl+sSleTRcxjXZSv0PLD1cRV2
	uungRzlkqq3oEbfqSC4JOGpwdMCui0b11Mq275KEiY+9XShLvOqmwR2xUtQYpSWQAfsf5p6rm+k
	ULeqxxiA3DC4f1m4oeY53r+qbFnexGqIQ1Mqa3d99jLtlJvQ==
X-Google-Smtp-Source: AGHT+IE9KOMsOQzJZafm+0TQ9uZYpR2FxJd0+curuLJ8CFzd1zsY4t5qNoDTGQoABw2tGkkXDkEOfw==
X-Received: by 2002:a05:600c:4f56:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-47a8f9055edmr23188505e9.24.1765547378586;
        Fri, 12 Dec 2025 05:49:38 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8d9d63sm31502205e9.9.2025.12.12.05.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:49:38 -0800 (PST)
Message-ID: <c61f07ed-5719-4362-9d83-274dff8aaa54@grimberg.me>
Date: Fri, 12 Dec 2025 15:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] nvmet-tcp: Don't free SQ on authentication success
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis
 <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <20251202051755.1312158-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251202051755.1312158-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_054940_570012_CE1F4C3C 
X-CRM114-Status: UNSURE (   4.11  )
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


