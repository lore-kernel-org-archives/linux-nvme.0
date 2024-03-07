Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252E0C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Myr/j16sX+jhXWXpfttbQ2Qc+AcmyBlzUHvht77GW90=; b=LgEJTI6JuqPL4x2nPkqFCp4JP1
	eJu/a+N9zk2dazN2J14aqVCgDRGTl5oS1HcXW2Kgfha2gbfNRasALoNevHa2ho5hwkQabn89ykWV4
	svStsNFPnFUL0SgCJ4S5EEOvbjL3gF147JYo74+7+YGozgFCT5S12uzYDErQJuz8VS7jCZtdfcPUT
	VEcE5hNKlPXoODRCyUK0Pj5cSzRC54OvP4X1czbWfy/FXBv+KRrSSEdSeS3FIvIVkASOrW4d3YBAh
	iL1LJxXwHuHx4aL53kbr2t0oxjnayN8g47w18ul7rFTynhXTJG7P8U0weyRQoXbTBs5cIVm77IrCF
	5e70Q9cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBmE-00000004GYR-3zz1;
	Thu, 07 Mar 2024 11:19:06 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBmB-00000004GUD-3t7y
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:19:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e6fecc61so328945e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810332; x=1710415132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Myr/j16sX+jhXWXpfttbQ2Qc+AcmyBlzUHvht77GW90=;
        b=VDwdFy4K+MGSrOxn1WhZBHHC+Dyw095cRp/diO/uGkb/ERZSVfy2IQdtkUFPX5/mwt
         9lCEIxPUAs11CjkcBRMb36oMDNO6eeOezzSrUFLb6DbxlVztvpAtHof8sOALa8qC/LuT
         BdZwSHIPPPIH6csBCQ28oUSp5aH1mK+sIlnw+2XD+HLqJr10UDmPQ7k29ppTl38ieG2E
         vlvKru4BlHfe65hiXmLvv+Be76dqn7RJX5QsZ2IcyBytnp/jchN9J5CKpqbXB+EugS8k
         glBm9Iz5HecXfEzxXEAQNo032yEnY/jFRijT5WuBhLpKB86BIOl7PGpC4i0WHFmxlYqX
         uoyw==
X-Gm-Message-State: AOJu0YyEUALweDapbjH+qOy1TqCqI81LFPsKBdPmgAJPnFUgnGb3x2cY
	jfm2E4wE07lxmJRDgN+1dYI5d+14aY25dlpfi3pdR5OMIdxeUAYs
X-Google-Smtp-Source: AGHT+IHO+G/yvC5zfgZxvDPmYhxxkdHEIeLbgK0HSrrJI8z5OLW3o19N1JccRzhJeqUYkrYjD/dDIg==
X-Received: by 2002:a05:600c:3ba8:b0:412:eb6e:2171 with SMTP id n40-20020a05600c3ba800b00412eb6e2171mr1201171wms.1.1709810331597;
        Thu, 07 Mar 2024 03:18:51 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b00412f83e0c11sm2343940wms.22.2024.03.07.03.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:18:51 -0800 (PST)
Message-ID: <796911a6-c648-4af3-b633-463e03d3aecb@grimberg.me>
Date: Thu, 7 Mar 2024 13:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: he-IL, en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307110657.252120-1-brookxu.cn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240307110657.252120-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_031904_039700_C7558366 
X-CRM114-Status: GOOD (  12.55  )
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



On 07/03/2024 13:06, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> We found a issue on production environment while using NVMe
> over RDMA, admin_q reconnect failed forever while remote
> target and network is ok. After dig into it, we found it
> may caused by a ABBA deadlock due to tag allocation. In my
> case, the tag was hold by a keep alive request waiting
> inside admin_q, as we quiesced admin_q while reset ctrl,
> so the request maked as idle and will not process before
> reset success. As fabric_q shares tagset with admin_q,
> while reconnect remote target, we need a tag for connect
> command, but the only one reserved tag was held by keep
> alive command which waiting inside admin_q. As a result,
> we failed to reconnect admin_q forever. In order to fix
> this issue, I think we should keep two reserved tags for
> admin queue.
>
> Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

