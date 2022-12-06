Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA49C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=uyiZ0ffXSc3Bc3ZYCxiNpf/e9D
	SefLHwjXHX1wTcM0FjJgpvFUyZrmEpee1BOzTRRaMns0tgCwKVvFSHEiB23Jk9tdOjt5s/gJD9VV7
	bSCRDLPAEjvw1grUyI3vh7A+iBBkfqfdZDpNqbdiL4RaB3e50//vGrBXO8wTsfmGYY/e2O3U0zsur
	4fny05JzPwbHQQ4hDzdRQq4e3IJAmvfr1PX3cWuiZPonjzmkqFDuNfboqagvXUIOAg0yxlI+nc4ii
	uDrrIIUgIRa2e+JPWjSZAsiJThtErlg/Yo9GDW2TbPpnp56fK7rc+YffDrkMloa74ggsF7sAW5OOA
	Uc2eR1xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wwl-0092V1-Ph; Tue, 06 Dec 2022 12:21:15 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wwg-0092Q5-Kf
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:21:14 +0000
Received: by mail-wm1-f43.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so7847847wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZrmiCXUpDk/KnyncnRAiir6R8JyC0GjBFnIC6v8chaUmPC9/GrfIesCHPVfwyP0Awc
         JG7PKoC86Gchldm8CNorCb7AjlYu0ilurBLg1crYutaLEBUv6WO9ieHqRTK/BKotT/L2
         a6seNmgO+fhhLRUDTE5LVyaV0OQdL19Oe4ynuO4Y2XJnXJ/TOxHkUyFFFPP3nu6bBIQ5
         b21Ow0Q3V+oHKSSuVyLD02LjMMXzSYnaWSS+kUYMAiKfri+i7GCUFLfZEcauEq5KNBB/
         Knznbib/z+vE22245Gh4u6jqnBBAi4b4RwNkLajeEYTxgjH3jrssLoUjlzG6/lQ4UADL
         5sFw==
X-Gm-Message-State: ANoB5pm5mjw4eUE7TsEdBk8re9LQr5uQxCDOY7vVvq3J7IL+gRHHFdOJ
	AEaBxOfRD6RPq/MOZEqE0A4=
X-Google-Smtp-Source: AA0mqf4Bl+rqYD9EYc6bbxa2BG4H3CYghtZvSoCuTmKz00sJ1FWy1XysOb+B7/Ws9XTIjA0z4gk05g==
X-Received: by 2002:a1c:f401:0:b0:3c7:84d:72d with SMTP id z1-20020a1cf401000000b003c7084d072dmr49355206wma.181.1670329265740;
        Tue, 06 Dec 2022 04:21:05 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id m42-20020a05600c092a00b003c6c4639ac6sm19927679wmp.34.2022.12.06.04.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:21:05 -0800 (PST)
Message-ID: <6e2806f9-ae0d-1c23-57d0-8cecf611a7a8@grimberg.me>
Date: Tue, 6 Dec 2022 14:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/9] nvme-pci: rename nvme_disable_io_queues
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_042110_685455_8CDAE414 
X-CRM114-Status: UNSURE (   7.08  )
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

