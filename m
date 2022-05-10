Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634ABC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXp9GhlDmGMZbJuG60tQjYB7THyLoRZPOHn5Ni+vSuc=; b=v6/u8lh9ex0SzdJo6DQBnkGc1S
	LcyqW+gGvz7g9Gkthm2bhi80UezstxPGF19YYSVd55BYm6cL2puKMcRcX498fWHAf6gkjjXAnWtZR
	YwunuDmlIUR+7W1c/0g3VZsxVDEfIaqIZYRCl4+qytRaTtYl1kXM3MoBYc3JKYN//ljdfDvLZUftg
	CWq/aTUUi39Qklf2mv5+iRktwYpL1ovOU7UxPMnu8UTQesmb3RuyuDsy526myZQkP3LSql4IzH/y9
	u6/LusDWV8luND3fpuRnW56kd1N2LowTD/G5kGPM2uoOOFnwvolojV5VydEz2rGSJGuVNRHcshPv2
	27KWZYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noYY4-004Exu-PP; Tue, 10 May 2022 22:41:44 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noYY1-004ExP-SY
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 22:41:43 +0000
Received: by mail-qt1-f170.google.com with SMTP id o18so342967qtk.7
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 15:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bXp9GhlDmGMZbJuG60tQjYB7THyLoRZPOHn5Ni+vSuc=;
 b=qYkad8ikglNth/OiviTvPc87UYCIUaobWgt4ZUkiGvE1xfMIbXObVJUQ8fHF76gIJ2
 6+DztF1Y72/NsQ2v4w07V+y8xPIYj9i2XokiipDGcJStqOrgvS6U7HZrhir3vMURjnVZ
 w4tcgTJpUS4R0EOY2gRe8sayLq+5J/U3GmO7nRK53TKK2ms6e51T+/HmHSNJdKAT4P/J
 OR5DlxgABiB5DDIEHdipHIS8aU7POaSCjmHESV1U/nMWLmf9GBOLDe+48JAfW1gHeiAu
 44yRvtcCz0xilmhXhYFnOmo1LWbYXb2ekfwnSJx1t25ga7/v2g0xcpuLLn3wO74bV8yh
 kkSQ==
X-Gm-Message-State: AOAM5335OV7cRFx9hekuPVXO7hamniTQnuITTOxO9B/Tu/Q8shKuvMWF
 +iVaQiG2QF5wWKpqY68ofpg=
X-Google-Smtp-Source: ABdhPJwf7TaLYdX+JDqspR6jvGv0UahKgdzKEM5ujcrPU9qxDXCxsqIZit4k+mZN9jf2I0JPETcfMw==
X-Received: by 2002:ac8:5cc3:0:b0:2f3:b220:86eb with SMTP id
 s3-20020ac85cc3000000b002f3b22086ebmr21804223qta.63.1652222497731; 
 Tue, 10 May 2022 15:41:37 -0700 (PDT)
Received: from [10.20.15.217] ([50.226.69.182])
 by smtp.gmail.com with ESMTPSA id
 z17-20020ac87f91000000b002f39b99f6c4sm130184qtj.94.2022.05.10.15.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 15:41:37 -0700 (PDT)
Message-ID: <c0f8f6f7-f345-7064-da5e-9051ca7cdd03@grimberg.me>
Date: Tue, 10 May 2022 15:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 0/4] partial sector read support
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
 linux-block@kernel.vger.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20220504163207.891761-1-kbusch@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220504163207.891761-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_154141_966222_512EC4E2 
X-CRM114-Status: GOOD (  11.40  )
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


> From: Keith Busch <kbusch@kernel.org>
> 
> Don't you just hate that you must read a full sector when you only cared
> about a few bytes? Well, good news! Standardized protocols provide a way
> for the host to describe unwanted read data, allowing partial sector
> access. This lets applications reduce allocated memory that was used to
> hold the unwanted data, while also reducing link traffic.
> 
> This series enables this for the NVMe protocol through direct io. With
> this, a userspace app can read a single contiguous byte range, subject
> to hardware DMA constraints. An in-kernel user could theorectically
> construct a bio to read multiple discontiguous ranges if desired.

So userspace needs to look for both bb queue flag and dma alignment to
infer supported range(s)?

