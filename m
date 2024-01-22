Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C20C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2KdM4BOKYiqNcDbWc7X9J0OTMO
	mnddqIliAgUSjvflCHQ5SkaHPfXCJakCcURprMG28asQDISf+yUyGbQDLIZfF3Fl6AKAXA0FSA5nj
	oHhaa7OE6llf03i0BXJz+lRIwen5UB4DBG2Ga2Ost90AcYdFAS0p6VRHRY6LHWElpC4eT/qezgIiu
	Bl/jONPN0yfTU96MQOcIgyxE/5DEdMvkG2s5RzSQb8YUrZ+UdzrLnDFqORkaSvB3KG0nOVHQ+k7oc
	B4TFf3hSeBpezG9mxArUSOm7ARyxvxUWNaRLLjuSHQgg60X+5zGCWKu4bhi27QrSQoXbXcr9HSwlb
	iuINjfQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyGf-00DIPv-38;
	Mon, 22 Jan 2024 17:39:29 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyGX-00DIHn-26
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 17:39:27 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so4117205e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 09:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945157; x=1706549957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vGAtWH1N5xMayAjjGoa1fZKKHFRWhiR0LjrHdTLn5MiphYsjNQ97I9u1i8kUOdBKBe
         G6i5c6+XvtEwz/ax/YJW0Oz81DiRk9Ey8Jp9blDBoXEvbFGHRAoWn50AelohSfgKTG/Y
         nEwh57zgUNEGwpgNHbWnHnxGZJqkbuwbrZEnzpox0u83SvwIgThbHGxhbVJV7Gi9lZDl
         bsq/+4TQMUIYUPBtWBir64FCQh5WHs/Ybnh+AYFUb1Ixb3ZI+6coEQ6bUrMKABv63M45
         S7E1rmLsmYt5kvC/CF26NMzcjaUMsLTQyMXvtQZIFKt0WTAc7MrKMTb3F1a24ZTtPTeS
         V2IA==
X-Gm-Message-State: AOJu0Yw8VBYf4JDZkWlTip+A3Awu0AjVuA2x+Hg+xnW5zYO1es/3j3Bk
	LSPZtWK1Lk7gY0iNkhD5X0PGhz4DDyca6zG9ghANFlcGuvdmfquP
X-Google-Smtp-Source: AGHT+IEt4Ce2/To5PhschlTmwKnN2HRpuUfmLuz38gMQhDEbDg912KUb9sLEYHFnas9/Fj6SfILapA==
X-Received: by 2002:a05:600c:512a:b0:40e:af30:4bd7 with SMTP id o42-20020a05600c512a00b0040eaf304bd7mr1647376wms.3.1705945157365;
        Mon, 22 Jan 2024 09:39:17 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040e8bf3c9a9sm19139146wmq.21.2024.01.22.09.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:39:17 -0800 (PST)
Message-ID: <3eb1489b-5ba9-4d9b-ae5f-f4ff78f77e32@grimberg.me>
Date: Mon, 22 Jan 2024 19:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-7-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240104092549.25721-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_093921_697874_FF03AE73 
X-CRM114-Status: UNSURE (   4.51  )
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

