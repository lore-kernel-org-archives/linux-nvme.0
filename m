Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862CAC5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MPLllZ36lUq8yG+IK6MApAgMsm
	QjoQkhHgCjQrQ0tZbud+MVJ3l04Gc8Gjp8Eu73+pfLmN2ISh4fNXW4Kgr6TbFgXNAGyvwEKAzPCVv
	R2+Du5IA9NeoWdfGGzS0UywG+9aqAx1ZiDPBZyrVSzja54Y8Tvia6OhowWnSYO/ou2YsC7Cc3iynI
	EaHOEIjzErOYuPAKWh4BMoUxSkbJ8+UCD6n3UnH/1yUdVAqOrVPFKxccQ5CPf+Ss5pMox60Xt3LDj
	DkY8FtBTI9qL4Pa1L4ClYBeinaQ5Vka+lUsm4O+lglEaY645zto8EHfQgBD4YHthoauIjc2513etw
	8AjdkhOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw0h-0000000EvIb-0qzo;
	Sun, 23 Aug 2026 00:24:27 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw0e-0000000EvHt-3ioR
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:24:25 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1670dad7a8so399798366b.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444663; x=1788049463;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bU8cnobicAzujCWUHNDSwKC1sA4Cs8rVwJAOnPB8zwDW8l4l/b1HCktixsjMtryKx4
         l6YWpgWEM6vRG2lj4p3IhFBAcoKxj0jcsK+/eJv8AWQnQfYh5PnSmrtqmOrnqzrNsy4R
         NBmTLaI3atZ1iSnxzt78YbFNYSOwfOJkTV7dqWQoSStd6U8tpItymvCysyEGcngMkfbH
         fgsnQYQHB+qlAjPnkzZfzGy4HlcxlgqvSON1i2RuXEQljuoJoDtgBtD1eIjJiBsF+ebC
         sQNF5/FHbTXoJh3I3Ansj8RZQAYEyiLXX1ZzFZovdvfsgD3he06etFDyJH4xi7cXjbbR
         +nOg==
X-Forwarded-Encrypted: i=1; AHgh+Rrtoo3X0cqiDEopG+210QxaaJRBE6HuTpTay4M4JJIf4N/bJkfzBklfb1NT/IvC5zhPnjL4/AroTRuq@lists.infradead.org
X-Gm-Message-State: AFuF++nQPgG2TJq+PNpdocV4Oh6HpVPtekC8bKKegfv6HqT5sBG0Tgdi
	9lwSwBD4/UVOeprQT/eSZ/aC+85HZ/GNRwnB+UXv03Q+OJuIgEVSI5/FahXDrQ==
X-Gm-Gg: AR+sD13d/AbP3WXwKu92sxzcCBfEe7z77tl4JgBCWgBmx5zJhASn+Jpsfn0EVipW6W8
	uH8fBs/r3T29jlpeI83CQymchPffu3a30rZCLsD+f/XXZOd32FXV2FpoNVLbszNejXpnO5ybKh2
	YiSYmNhb5+TqIrgiGpJLGgvM7g+hk3i+SRMFqN0SUemNeXgshc/uEnyT6dgIDmLycQ4Fi4tTUz9
	FE7iAz5EEBTMbxZLM6WPwn79vwPIiGGysq4gOMCP3UCyAjuMwgQ1ScFzn0JFp2uMnlR56YaNqm7
	ruyzI3Wo9HbTFQaH3CCnoJPLzRAG7IZz6dddUZ4KH/IyUNvTG14I/oc+2gmL+8gEVWaKC5jLxcK
	ez3J9lbb6g7ALGlzenSAtJSSQ9gubgEmQq3nVyhQ4/KN0DFHGUs7NUTLSNYZgsh8n4MX3bB4c+/
	vlI138Jem7gNX7EIRnPM4sVckktVPl7MrsXAIK7Rxf5TEDd8oNiPiDHf72xv5PNoz5jrTB3fxfP
	YIhoxqArPuc1lCwrkKOYLI=
X-Received: by 2002:a17:907:c50a:b0:c21:1b58:fa96 with SMTP id a640c23a62f3a-c246a39f3a8mr1806838566b.3.1787444662964;
        Sat, 22 Aug 2026 17:24:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2e42sm438723466b.59.2026.08.22.17.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:22 -0700 (PDT)
Message-ID: <528fee47-2eba-4a11-a7a8-4ded7388d532@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_172424_927040_BE0C3A92 
X-CRM114-Status: UNSURE (   5.00  )
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

