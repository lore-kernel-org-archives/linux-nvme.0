Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FD3CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=S5xltbnNzDKsQlUwkgcrKGKSM1
	RSW93U6yK+gfwhDtJ4PiYbu5t1tVscSDAmwbeQp+M9gLGsVYp+KOqJj4sPoIA5KdjvenEOp9IC4io
	mit145betmgiUrqmA76ktHg9+gVCqbpANpYpDGDOzPSKxeq0TvbouXlrzxzNGe3GTwSUHQCtK7Axq
	uN2FApwC4cT4DdJzJ8OdqyhvryApp0I4H5psNztN0UfZv73UObMT5xv6fbhrFAr4prH6nGTk4JziQ
	D5N4/1zWNxchZk+g7pzdfNCl4vYNYN8rp9IzBfgLZEcvgWOGl9DJ7R9MqA+H9B/JOfYe7TVOsxhBj
	iqPtYodQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCWO-0000000BkW8-1TiW;
	Sun, 10 May 2026 22:21:12 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCWK-0000000BkUi-0bVl
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:21:10 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-441209fb77eso2142335f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451666; x=1779056466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fpwa/1b3A9kZuKBsIC7PpVhG0KkMS/7GCK6jBy90q7Tt/IqYtS+udJnpNGotDW24wa
         sB6K5oryeC1CJYc/AD7tD8NQxM0FSDHN0NanCH85x+wZDQseCqidJ2Zxs3gHgXImQw0/
         yYYONwJakA66Wi53IviRNOfS2UgXK8+A1uQJpQzXxWBieRT2VvBnHtmWADDK68u6DHbu
         uOI+sWc9sSPGQABPykJRmT8HAlYVY/iu84T6Bwxv2vk7cwGfmSqs/L9FDOQUPanQBjIP
         29C8qjlfLd4aOxcGFfVX8DCgAuz0NKJ5W7/KaRJtqTAW9DQhIr8gcN9z1mq09N56ZB2T
         hwsg==
X-Forwarded-Encrypted: i=1; AFNElJ9UnElzbF1qGzlOf3ibVMIr1IbG4+zb0L6blsSteYAZJHtfKOWRmm9vW9VcN+/5679V/CWx/zKw/TO6@lists.infradead.org
X-Gm-Message-State: AOJu0Yyi7iqNbW07HFbt9g1uo6MGXhMSSkCW02l/Ng2S09QFi2BRoZqi
	7QoahBSqAacPBvgNFY2arm+JfzSnola1QRa/DRPPmk3YUNFq0xoyuC/o
X-Gm-Gg: Acq92OE8zvIKhglhSsLjxUXOdgz+6YetGzCJrCZD95Wtd8+va8jsg1/gD//lDDdLdjP
	5+vUSyG5BfloEzfIB673ZBG+3S8v1TMuQ4cqnB7pqnKvu3rEgtQto9OYHOfS6kfARM2z+l2cCgq
	DuanN1/TiLMbEmNp8sUdtLuWMPpMfKsl/YHq923BpPl1taEBOjSD9POqO9aAGnnxlkydDhAiLe0
	rwXKPkh8626NS3yqo47asma9/AB81gb+ECRoiNDJIH3pXG09N8Gl6BynaosRXFMLTCOY9I1wbjS
	7MJGKAawMVHEAomjbCEK536Qeo7Ipirn9VSJNNmWBLYGG4ZoEcWGpvW1xFxgmE32cJjOWYX3Ofq
	dMyn2I2wPkgJhQu+CYxK0vFtB9aUwoiaOyR/r+yIkSZNeUUuJSqDLTS7bRcr0R6ibAgY9WEIlaT
	w+mLvHZmFSKEsNqYJdEF0=
X-Received: by 2002:a05:6000:3109:b0:43d:7874:5d3b with SMTP id ffacd0b85a97d-452e84649a4mr25038954f8f.9.1778451666047;
        Sun, 10 May 2026 15:21:06 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm20290132f8f.2.2026.05.10.15.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:21:05 -0700 (PDT)
Message-ID: <1674e1ac-abd8-42ae-bcaf-6497cdedd6a5@grimberg.me>
Date: Mon, 11 May 2026 01:21:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix bio leak on mapping failure
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20260506131900.2367091-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260506131900.2367091-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_152108_180702_E3CFD428 
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

