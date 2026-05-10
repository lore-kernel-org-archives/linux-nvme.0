Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A559CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KNfZE41yjsTFuPqQZQDon3dmpl
	gEnkLcc4r86YMIjR5Iw0m9IXaVNok62FdrhzrXMO+OoQLzv1wZTeX0/v23QEBfkcivdV1oYgSLqT/
	9QzYDuHhtnREXwgTAOPilGG4MRRYl2krnMPCGDYlGEc7r7aNorl3eovh4coAf3o3ShzhdNKwmQJ/d
	nkelThGH7U/qlqjFveuBjj66SN3R1+aLEh868ZaDKVwLxeLkU2YSfOSoh+DTJdKIfiU9EFgB9zbIV
	a1rLxu6f7kVO0twV4A122n1xT24w0DuAtkqEA0IVXxtGxt6OOjc818hgrfGcu9QL57V9zHU9Zh2g/
	4x7+FfgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBWC-0000000BdGV-0dQ8;
	Sun, 10 May 2026 21:16:56 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBW9-0000000BdFv-3VTK
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 21:16:55 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so27467645e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 14:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778447811; x=1779052611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=suTzK0TaZGqfnlW4DgsNvk0fMcArezvWcMoSx9FNuFWEG82tkHk62+xbpgCAuibsZh
         vkYQXfeiQ8/mS6jbHk5pU1YHMccjunZ21vyGkCIA+/ZQfMQjDsWi9tee5l2GDESjsABw
         plc3h9KVhwf2fQeg0VBy7BAwtpo0BHRFyETwRvIaLvuJlI1mubMSO+wRsLXAXCuOPbNA
         5m8KmSIbNi4YFBwUtRjyaYBplTTaNBhrG13lRwrtxeg5G/1Ip1PoxMpD9vxKsaMh95kt
         W+RBk77y640J3K9POxpSRcuP7PtTRe5K46rPAbCH6llr3pRDzOZz1a9/zPn/gH/CsmyJ
         6XiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3CkPXpggF+thnDbbh+vRaXj9dEtoQrH6QFGWba0fBoQBBPax8FwqVItCE6InVkMULg4TZlhsCe1yz@lists.infradead.org
X-Gm-Message-State: AOJu0YyJWNRtRWN7GwqPi8XwVES9iKiulcZ9zoqbTBXkXMl56b8shs9m
	KfRQO7OXOEOYGEP0+DaEF/XF/MhaJeNIWj5EtDqr9+6CgpHrZup2cck1
X-Gm-Gg: Acq92OESDQA9nWazlqFJv5NBDPwQRXkGY1KHv4u9JyYSkP3lsdkCfx7o3QsXQ7RvLRR
	/AjloefApUSU+SNgSn249xEXx72da4NeESYkYUpizwh4UFrgY5A3ujg1zhli21w1WsavNwG51u6
	X/gb0Uq3UlUtHiLTmsTMV3vwqD6VXoVtzZmFms4lpZ7NYCz2jrM7bZsX5kEL75/9pv06MBkPFHX
	J3jipxAyAVDRtIkexN2WNl8ntIGLEEoAeoZJLraXeggPjBOfSqb6IRTd6gdVAt42yobdP2BJ3eU
	46i4gLcZvKoAqLJu3uioK1odY43tL5v4x+lET3FriyEjkSt4ZBj4atEdECxvxWm64lVJwIREv1u
	bT5DKD4tMdjtr0t8uGb+Wh62aN3seD9zq93F1txd0N4kwM6EPdzZr/FKqM12ZcuYZyC2yvg72cS
	rghIyDuJmZzf6dcXUjXKK4GBIz5RdGUg==
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr242969865e9.6.1778447811464;
        Sun, 10 May 2026 14:16:51 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm87643525e9.0.2026.05.10.14.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 14:16:51 -0700 (PDT)
Message-ID: <adf158da-9488-4979-9fc5-73febeb965ba@grimberg.me>
Date: Mon, 11 May 2026 00:16:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] block: clear BLK_FEAT_PCI_P2PDMA in
 blk_stack_limits() for non-supporting devices
To: Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de
Cc: linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 kmodukuri@nvidia.com
References: <20260416212633.72650-1-kch@nvidia.com>
 <20260416212633.72650-2-kch@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260416212633.72650-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_141653_957940_693C8EA4 
X-CRM114-Status: UNSURE (   3.80  )
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

