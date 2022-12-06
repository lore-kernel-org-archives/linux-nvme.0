Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096DEC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAtXqOKZkT5uhsu1tyPzUgHEvmgpPsUXGZbcD1dkrQc=; b=za48LJBVWDwH5tVEbyf8y/Tb4f
	8DSjWrbM0uzGAq6Je9iKvm1RT+cyEG7fcor+hgdkdlk1HaWY/r7uug9eLbu0wI6YAsNgOWLo30KFz
	ps9AyvuFuZ7Kv9KmZlQ/D7A0tmHpFcbo/qtvNA+QIPh0pGJkeXVD9GLJEPhLMHBahsG6sL0Pepbtt
	QdWaLyK0jEel1Vyhg58/G0zfFS9Hw/Qttu7/ZZR4XU9x2ZqMUn+E7xEDpGf0xUD+v7T6PmkffV7DD
	HgLgWTU6OuWsYRntdROUKOQ1l2LJzefUX0wrFNJDtF7pMkY/4J+C7lE7+XZabOSP5SIC7JrKjAbNj
	60ujuRIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wc6-008t6g-RZ; Tue, 06 Dec 2022 11:59:54 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wc4-008t3c-3Y
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 11:59:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id m4-20020a05600c3b0400b003d1cb516ce0so437818wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 03:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAtXqOKZkT5uhsu1tyPzUgHEvmgpPsUXGZbcD1dkrQc=;
        b=egOlgdev2ID/jJjMEnVH/JjO5rYeKc/K9qo2Yuy4pFbztWzyUNKTPIWqA+MYfV3T3o
         DEQEeJdo36hucvmMUkaCL3zupoLYcbtANtIcn/ma9CMTsWoIS7MJd3qCVpxZItHnxQO+
         jrwS6MVF+Z6ZDPM0sen2TlVF4K68H5tDisHZYfvely2LfrRtEJfdAaAoIcbNkQnKta2d
         KvWOzMLd64ruOtl1KO2kKiIo8e1E6wEvXBSzBV+YNJJDGL7RyX3DLdFp+Vc9M7Oosq4/
         Aw5RCj857KolRkliA4m2wfKvQ8zNuS4QFP0TaMUCFR2OFWDzftWFcUBR7HR5ahEYXqEk
         u/Gw==
X-Gm-Message-State: ANoB5pkHTwaJ2N6k1ZPc2xJE0mcfAQlBPEEjDi0OE4y2tBMJmWLbns3t
	3+7joUfFAbjLy4yDicFcR8w=
X-Google-Smtp-Source: AA0mqf4wlBkOjRN26ODUAL0nH5dRthKnICT4qDUoX6HpM3t8/mHC0VitwEix6hktmfDrtcuEDTP3rQ==
X-Received: by 2002:a7b:ca49:0:b0:3c8:353b:2553 with SMTP id m9-20020a7bca49000000b003c8353b2553mr61768845wml.18.1670327988390;
        Tue, 06 Dec 2022 03:59:48 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b003cfaae07f68sm26682533wmo.17.2022.12.06.03.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:59:47 -0800 (PST)
Message-ID: <de84ad28-3e3f-e287-b103-bc1de3278b99@grimberg.me>
Date: Tue, 6 Dec 2022 13:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/5] nvme: consolidate setting the tagset flags
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-3-hch@lst.de>
 <3b03aa7f-ea25-2973-3efc-900676f11220@huawei.com>
 <20221206084621.GA9440@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221206084621.GA9440@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_035952_171910_886E403E 
X-CRM114-Status: UNSURE (   8.70  )
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


> On Tue, Dec 06, 2022 at 04:43:45PM +0800, Chao Leng wrote:
>> tcp should set NVME_F_BLOCKING in ctrl->ops->flags, I did not see that in this patch.
>> Did I miss something?
> 
> No, I missed that I got lost during my rebase.

With that looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

