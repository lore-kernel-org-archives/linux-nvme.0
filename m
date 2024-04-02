Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB4C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uU48DJgFaHLx1/2t1/ZicKir2GW9GbUz5ocKNaf/XsY=; b=ZUM1CSHALRWOBmxdDUH7Mc2Pp8
	sEbHjxfUMAk15F2AD+eA4tue8/1MgfyxPu+wyoICWL7IDNaVkwQE4Jc9jAe0F1dU+nhLDJrmGS8Xx
	KaFIIR9Cw+DV8TW7bfMHgQQ9xu+Kk1h09//djbEKa+qAHnAmiiFW4wMS+gMpf1opm50+oq4IR2EMj
	a0i+KqcCoViE556BGBiIY+DZjD/i/Ub+hTcEU3pf4rDYVKazGkroZZQOdKxhduV+qrbzKzUw5v4oy
	Kne3mjI64IDm9VfAxdDiy6O80Mp8HGwZQ/iHZ0V6yhRULr1nBgqciqV9tNvOtveHyEVHEeGongp7j
	VmBv1faA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXqm-00000009wc2-0WXP;
	Tue, 02 Apr 2024 06:42:28 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXqc-00000009wbO-2fym
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 06:42:20 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3c4de6ea593so1720356b6e.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Apr 2024 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040135; x=1712644935; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uU48DJgFaHLx1/2t1/ZicKir2GW9GbUz5ocKNaf/XsY=;
        b=idlwgnDfRGweLGZJ+b7m4A51v+WsNOXhiXPbNDyLGpV0IZ3yFrEwgYMPYvgzk662XM
         9or2PrlE+7My5nfh+EYTv9NbQUxuyWduP7a2wn0RNQPL+SCopBPIlC9QfGatnTKH1Us1
         USrU43RdEih8EUvIRKPsrLNTXcDNGwdZNc/2h0FU80W9x+h7OGZswZlpL8HHTBZOW8d0
         l3t/5CX3AVyzvgOlgtqksPmaqZ37NbzP4kc2gbUiD1QMoIWYKLWiLBj5Z3QCaTwVHlBr
         8R3NZqvuu37ln85jmPLNs1uBe0TJJR3bNpK2k0VuhZhU2g/PCFUwfFRWk/e6c5h8WsKk
         ZmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040135; x=1712644935;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uU48DJgFaHLx1/2t1/ZicKir2GW9GbUz5ocKNaf/XsY=;
        b=ZtHCPDHtMC2MNBl1smuz5p934RGpOdl1S7gyKmDaQV5eO4mmCOTrgwg9N/mr95Om7h
         zwxquk9PEMOZRXXoUIaYk/FM6ko5k1T37xAnv2O0OiruQmMEdMOBQFp95/3U6+TVsL9h
         b99UQodq5iUlE+LwEf7IXSMD2z9QBfYhmPxM3JSoCpGaRQ5LeecU7XQIdP2TX6580RLz
         IUveRkCtATB2wM/I9kX5MHK+OhHGgVMUhvflqHzD5pPOHDD/VB5AC1Xpmnh+tEBkHOAc
         7Wq9DiIxVdNtcVPm0dQ7n1lccwPYVEW5A6ryPQzROHb3PVDdWV4SLRicDUJ3draSFO7N
         m9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVUiUBCSDCYErZXt2sAseXOLoyINDw9+sQsGvM1+aFpATiSNF3yRcFDs2aYhUYI1+ByL0NTnJchpBM4IDX+gf4PXcaAREiaxXRXsoDay9s=
X-Gm-Message-State: AOJu0YxMHwxvQrOoKn/8wbgGpoqht7ttV5w7tWCf922vaQvt/qc4U2eC
	64HehKrGX9VUX12ktVJUvc59Swe3+LkzS2pn7c4Oaxt9JTkxEJlJ
X-Google-Smtp-Source: AGHT+IFJBRPUzzyLOZ+Iz+JssAjGs8OrSAfHCaYLwSwDXfN3nVO69I7ZzxGjs/eatznGecPM52vC8Q==
X-Received: by 2002:a05:6808:19a1:b0:3c3:e621:4bd2 with SMTP id bj33-20020a05680819a100b003c3e6214bd2mr14487788oib.8.1712040135376;
        Mon, 01 Apr 2024 23:42:15 -0700 (PDT)
Received: from ?IPV6:2600:8802:3800:75a0:2378:fa3f:c6b3:24d1? ([2600:8802:3800:75a0:2378:fa3f:c6b3:24d1])
        by smtp.gmail.com with ESMTPSA id z9-20020a63e549000000b005cd8044c6fesm8907652pgj.23.2024.04.01.23.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 23:42:14 -0700 (PDT)
Message-ID: <f502ece5-4120-40dd-999f-2904ca5d0b38@gmail.com>
Date: Mon, 1 Apr 2024 23:42:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/30] null_blk: Introduce fua attribute
To: Damien Le Moal <dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-20-dlemoal@kernel.org>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240328004409.594888-20-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_234218_719145_53A0B506 
X-CRM114-Status: GOOD (  11.15  )
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

On 3/27/24 17:43, Damien Le Moal wrote:
> Add the fua configfs attribute and module parameter to allow
> configuring if the device supports FUA or not. Using this attribute
> has an effect on the null_blk device only if memory backing is enabled
> together with a write cache (cache_size option).
> 
> This new attribute allows configuring a null_blk device with a write
> cache but without FUA support. This is convenient to test the block
> layer flush machinery.
> 
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck




