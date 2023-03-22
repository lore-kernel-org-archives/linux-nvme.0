Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C4C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlUlfJH2jEDcVl2IXNvhN66n7VhhkTLFG1ri1AhZ96E=; b=xeuw9p7eOhPVyNv6eMAoHvwsxm
	AmZp792x+AaLYueD/oTFsV0+DjbNmiJdoPpzQxqc9H7yg3MbaNg2Fkf/oI1VQf087m3eWJcFfBrz6
	vBYr4IdcCKTFQ6nyefryTFLFE6N3tV3TFxvuK0kmS4bE7h+svuUic33ri0eePAtdRQp6dcnYiNCn2
	uyY8xJiDeLUcdsraxxFuw8n/kmFilB8BQq0PYwKn197Zt046ycC9DN9UV04p6o488jpS9pjSlpZTw
	uC4om7us7l9gbb/R6oBa88zjKilvg/4Y5pK0icm/OsUEtgHm+qNdjl2LK9A7sMru6762lEc6qE8oS
	C+tzvyrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pey4d-00G2tm-0n;
	Wed, 22 Mar 2023 13:00:15 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pey4a-00G2se-0t
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:00:13 +0000
Received: by mail-wm1-f50.google.com with SMTP id m35so11475463wms.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490010; x=1682082010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlUlfJH2jEDcVl2IXNvhN66n7VhhkTLFG1ri1AhZ96E=;
        b=rtlHfTSNBwiyZJKZ1uHR6TF7LA3puRTYsnDLtyhtM71E7kVC+Y/xWPv0eTma2zyFay
         IyDtySHT1teclUstY85WztLtR76nPDlO+h2rfGkKV3v7nCNEkeW6t0wyRiNA2sJ2a2u+
         R0RbB5xMQHloFf2BoJHo883Cxo/f8+jxr75LX0GoL91Jqp2Rp4EGwEtTrF2zCFT5+f55
         /mpJgEZULEGhLHzc9ap4HNKODAFxa+BY8cE7dG7qg9ADrKK3GEi8uFI0/1SS/SGOfRlp
         Z7u9nFcc6/lWzO5/vwplAdphFtFK3FGzC9pxICMtCi1w3ca52lsUlVAyB78RS/CvTsF5
         wfmQ==
X-Gm-Message-State: AO0yUKW2ZMXA2xLvufi5cfvEXNT8GkpC7nwKzHq2bcqGQnnetSAn5qzK
	xYVLUjDmO6VDk/N1dfgNxUA=
X-Google-Smtp-Source: AK7set+3oUSz7A4kh2FyzoQg9sqDXCoYN+c+BOuSNV8kIVgOcTlwAFyKWAkkyKCNyFAx1AjCmCWoXg==
X-Received: by 2002:a05:600c:4ec7:b0:3e9:b564:fae4 with SMTP id g7-20020a05600c4ec700b003e9b564fae4mr5917655wmq.0.1679490009972;
        Wed, 22 Mar 2023 06:00:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm13829688wrs.44.2023.03.22.06.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:00:09 -0700 (PDT)
Message-ID: <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
Date: Wed, 22 Mar 2023 15:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBr6kNVoa5RbNzSa@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_060012_314915_587B7677 
X-CRM114-Status: UNSURE (   9.39  )
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


>> No rdma device exposes its irq vectors affinity today. So the only
>> mapping that we have left, is the default blk_mq_map_queues, which
>> we fallback to anyways. Also fixup the only consumer of this helper
>> (nvme-rdma).
> 
> This was the only caller of ib_get_vector_affinity() so please delete
> op get_vector_affinity and ib_get_vector_affinity() from verbs as well

Yep, no problem.

Given that nvme-rdma was the only consumer, do you prefer this goes from
the nvme tree?

