Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E519BC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XvSyrTS/T7ownHui2qE7emhkso
	qnrY9+pqUB58qthNqZdpudZT6SdsG8UYOSNe0P7//huGdzfAiHacdNieb1vJlF5IKiCZ2iYkmxi1F
	JWzeg3x+OA21rQ3DiXSIOqL1R+Sf5xbuksl3hGvkbzWOZCMv6NpMgzejkCOeYKSB58wvphopwVSEY
	wIByUpaj69bR0CNc7PWFH9uPiAvOjmMIdYT4uXiB20CDUOrBHpQ2CsQ7SAW7qls5DHH0lczP4JX9K
	Ri8VDsZHTcB6jH1Y9MmRvuN1t0IwZBitigffot+I4QdN3EJALPRgOD6xJ/iwnota3mW48ktAYh+wQ
	mYdh7yYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw8n-00AS45-8L; Wed, 21 Sep 2022 09:35:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw01-00AOA3-Pg
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:26:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id v3-20020a1cac03000000b003b4fd0fe6c0so128047wme.5
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=x615azNTPZ2mI9r6SUfVOS5RAQEsXxouPQp0OgsrzvowMdTtFQiwsdJT07hwXdDDyf
         7Ue+2QgK+OTpClSOk6x7ELpdSv+8ONnrP/CFCDNNxyI0zgPbYkycD2iEREW2TUuYFjqV
         gM+b2UAXJr96BoNzTYI3hFY5t9ZbtTUVMzPsNaZnxeI0nUbvRKrVUD+5Fm24j551qneH
         Mv6werr/MVYtV0BXQ2vwJ8VVN5fUzToYqodbpS+YzqbNm8ur1Prst+wULve6nI1BhCHT
         xQIq8FyP5cmKRu3AWC9bpFuCx4Evo2gsmUQjk/tefEjz37iAscVzeq8IrOOaAVQ4FTvB
         QDqg==
X-Gm-Message-State: ACrzQf29qsIANBa4P1D2gg8gcXuJqwt3wNUTP88IRyms1mfpVREGkGkU
	fceUa42fw2YtSwoPT8Kv7mg=
X-Google-Smtp-Source: AMsMyM6pgUvPLYM74j5BVopSnI29AfqININ/ZSEr7GauBBxaeXF7kpgetpj7ehhTqW8F4AGnOu+8Fg==
X-Received: by 2002:a05:600c:3d8f:b0:3b4:aab6:4a97 with SMTP id bi15-20020a05600c3d8f00b003b4aab64a97mr5296691wmb.82.1663752389780;
        Wed, 21 Sep 2022 02:26:29 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b002253d865715sm1949821wre.87.2022.09.21.02.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:26:29 -0700 (PDT)
Message-ID: <6f89012e-1e79-f57b-9cee-9946b4602e77@grimberg.me>
Date: Wed, 21 Sep 2022 12:26:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] nvme-rdma: store the generic nvme_ctrl in
 set->driver_data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022633_845786_2560328C 
X-CRM114-Status: UNSURE (   7.40  )
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

