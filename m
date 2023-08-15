Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84388C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pw0UHhhOPHishLq/zr/VSccwCF6VDU0y9FMOAFcVt4w=; b=DkTXpebl8rVKzItMC8+wx0cgvY
	rj52yf38rhLutQp9AX62FCc3LKGDHwt0aJIc4Odey5t6UW3QDusz6nFisTRWM02DsfgXbebIXqmbU
	t+BbtFgFa9HSbyZlxZoAV6cv+KVBxV1IM+Qs4Ab40IXwYWrEMjbQxMeRospa1dLMXAwNykgHMUP3G
	s02RougMFd/03Hoa5o9Hpj0MratYD3jKA+apm5EvNe4L51gXidDhjP4sMLHVUqCT5jCn7nzMEY4Zs
	OK+WZuv5DjgTivPAD95Lt40pvB5+CAqNoffK8BVnYvQIuTP583rFyCItTrlfkLgPlJOrXuxCLDX+/
	ga0GOzIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVqHv-001CYZ-1G;
	Tue, 15 Aug 2023 09:24:31 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVqHt-001CYD-1T
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 09:24:30 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so10562455e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Aug 2023 02:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091466; x=1692696266;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw0UHhhOPHishLq/zr/VSccwCF6VDU0y9FMOAFcVt4w=;
        b=b8WsE7JVVBgQYKci15zuV/cM33/rcO2PiBTV+c0Tr5BWAqo+pZFKxsBfwjaUhqeyMI
         +wGeOu5nsih4434+4I3/C9+EauRkfEunkokU+2QUKEbK2A9m8icgOBUsuMilG0A3m0rk
         0zle5NKdGwBVGvVr83DElTvpL5fR1ww9Kbzs/M81MNow0o8AGLMgfer/Gbi2iXhSZdeH
         MEak5shDThk4qQGhkQpiTXtANzhYuC2RpEcTGTS5u0oQ4GiSXJoR2Q15mE5vqqdsEbxb
         1BrFLcYR2G72vbwIYkQMzOx97ML2LX0+xFWT7WL3WRZXh/s6RrRzYCS5PWcJJ/SRP8kC
         6a4Q==
X-Gm-Message-State: AOJu0YxauWy8V80m/TMoFMQHfWrRYk7eaRW5byI8vti0tnEQCZ0KyAiZ
	v1P+Ur9UZkBgmQhRCr09l5s=
X-Google-Smtp-Source: AGHT+IG+lMY3xaQb7IX3Zw5oN6VsuKWLpDkY3wEvilIomXQ8KbBawECeMEbHXnx126n75dvXLaOsfw==
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr11426041wms.1.1692091466288;
        Tue, 15 Aug 2023 02:24:26 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c029800b003fe2397c17fsm19751806wmk.17.2023.08.15.02.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 02:24:25 -0700 (PDT)
Message-ID: <9085f43a-eeb0-e32b-d243-409cd232a834@grimberg.me>
Date: Tue, 15 Aug 2023 12:24:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] nvme: switch to use kmemdup_nul() helper
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
References: <20230815085927.1155834-1-ruanjinjie@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230815085927.1155834-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_022429_497651_5816FF7A 
X-CRM114-Status: UNSURE (   7.75  )
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

Looks fine,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

