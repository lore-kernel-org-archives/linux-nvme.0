Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DBC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XRj7pE+2OKMD/k2S+qby+nOM5l
	csg1m6FFn4+cBfeRUyCKC0SdiqWCdBoBRbV0q7Qp3Lq5YjCsa0/CI9bNxIzRTYCsBI6AFGW3XzhRw
	tnFGTkkYk44qyaMoKWRO60lOxY81lup1igV//PfpF8zWFI/TbzAG0pcg3Ykhb356EpdHlRZcu3PRf
	HEFTcYp/L1ZF3JMW1hWBH1YKzFdgLSaWcpbujJxGGjYwdOUdCjU9ItoOox/6YTjEF/8NdKYuD7kz8
	TKMsmxA0dsgwgjaGhTOJ7FahDwWoqj9MTTufll78gPK5VscCUvDG9ynFhrlZEgqkPdd3L49QScnWH
	OxfGRh0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw3e-00APwP-Oh; Wed, 21 Sep 2022 09:30:18 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavxl-00AN2p-FV
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:24:14 +0000
Received: by mail-wm1-f47.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso8106277wma.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nggIJ6FpQH4e8C93b3xF4WC1U1M5vdQ9w/BaC1z7cXlueM0B0HQrATmkO1RkdDo3+z
         LDyQh4jUntfQTZcuYrQQPmz+hahv4DcYX2zRDVM9aBeU+syerAlyPYsG6ih/qLSaM7+R
         ZkEPfKRc/eA0MnrZphgfKcP4/B2UFauwS3m96QshgcbZ1q7DvxzADVLEoWhKJ9ay0O/W
         vJkdOrlfi+tVnjeB8uKSU3pijHqNjzk2WHhbnurRO7EvSsWw+SpPTob2dq93jwh4irKU
         Lyznb7Kotek1ViTDG3vXtHMLKE8q1igme0M3b60bLISoyPDpXE/xFRciNfxVrNMHh9m9
         IQeQ==
X-Gm-Message-State: ACrzQf2BzAECn/vMnETBk9vTBDAxvEF6eEhLUtRGCuEdaxeseeWWyLmh
	lD441EpGaahN0BBsaMG638M=
X-Google-Smtp-Source: AMsMyM6QBTzJgsQHorDexdfI4ACsv/VaCmF9/9oEQZPMtlu8B7sjEnE8zw0oLZAlTAnLcww1JtgXog==
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id k7-20020a05600c0b4700b003b48604410cmr5204237wmr.51.1663752250893;
        Wed, 21 Sep 2022 02:24:10 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bw25-20020a0560001f9900b0022ac1be009esm2160806wrb.16.2022.09.21.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:24:10 -0700 (PDT)
Message-ID: <9f81efc4-ba04-2303-eb37-59ef1db8442c@grimberg.me>
Date: Wed, 21 Sep 2022 12:24:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] nvme: improve the NVME_CONNECT_AUTHREQ* definitions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171931.1289669-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022413_538259_F18D58E1 
X-CRM114-Status: UNSURE (   6.66  )
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

