Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6502C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F57iFZnGCaOwfJVZUmIWMchkgcrdCa3FFQORo7tFGCM=; b=woXm0Jkeb1n/B4wC0gYvSo7Tyw
	yfAm0835G/DIAtV/VusjaMDlINn19IwAXz9NEF1G75FgESfaWicRdGA7Ls8u6D4h+miPv/8/tVQnW
	Any8/zAbJvlEIxA32MVyhbXvAubedCeBevCU48XT2GhjZ2w3untH9I+0Sdv+4pr3LlcKQZ3FGgNlq
	Bxg+6IhBtV6yn1j6T9aIkqlp5izdYYpSkVcrUg1XaluZOcG5xiqQwqBixoPka+nr27PKsAsNuztQ8
	G9Pe5ti5L5xTCgcRcpkdFWmPZQMlq0gMxIY0yqFiOSHtG7eq3oJ9GwXIYnFOGfLbPIoi/FkoPMbC+
	cn0zcpKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVPf-0073nF-J3; Wed, 12 Oct 2022 06:40:19 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVPd-0073lo-1x
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 06:40:18 +0000
Received: by mail-wr1-f42.google.com with SMTP id u10so24776512wrq.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 23:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F57iFZnGCaOwfJVZUmIWMchkgcrdCa3FFQORo7tFGCM=;
        b=cu7by9pqAptqjVYNpBngwbfXiFI2OS03dvoPre/+nnoB4fSGteiXZC0i6/SqMGMnoQ
         KidTCnZ0KQTfY7qBzzef20NjaupXHQCLxnLDSJ7wB0jBnapupZp5Ligw4GwJsSh2fdqr
         ZsdwLLWg1xCuWXe3m+9bvgF5XbuBHi0frJvcBH8BBHqH4Qg99XNiX5mxVNYsIWdHdH0J
         rfUMsdC0212i51iijXH/DucX1bFh/H7cUXenXpuqpywfhcjjbauBOx6kABfLwM91jrOI
         WJs/koQ1py8FNGa79Pr36h6R3N1+qGL5YckyMp2p3ziL3I1R/fScmQHKNcLt6m37g0zC
         lBPQ==
X-Gm-Message-State: ACrzQf3HKDGdYkz042IGRsgM2PPQyKIsu6Uxs7cuGc2hjmkxqV467OXv
	gPZ6MkHnt+DqbVAKZn+LwVA=
X-Google-Smtp-Source: AMsMyM7wuBKZ+JhK+0cTAv71Jomdt3pC35QcN6WC/W+6Dob21usw99lLcyNEmNRE/HpkPbpA4UYpLQ==
X-Received: by 2002:adf:f646:0:b0:22f:3cf8:7915 with SMTP id x6-20020adff646000000b0022f3cf87915mr12547982wrp.543.1665556813610;
        Tue, 11 Oct 2022 23:40:13 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0022f864164edsm9467490wrt.6.2022.10.11.23.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:40:13 -0700 (PDT)
Message-ID: <bd982b71-ec85-ab60-e916-1a58046ce4f0@grimberg.me>
Date: Wed, 12 Oct 2022 09:40:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet: fix workqueue MEM_RECLAIM flushing dependency
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20220928063910.46862-1-sagi@grimberg.me>
 <Y0PXLA3yTnX7n5SA@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y0PXLA3yTnX7n5SA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_234017_127487_A51B283A 
X-CRM114-Status: UNSURE (   9.32  )
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


>> The keep alive timer needs to stay on nvmet_wq, and not
>> modified to reschedule on the system_wq.
> 
> Does it?  The keep alive timeout is required for making progress
> under heavy memory pressure.

nvmet_wq has WQ_MEM_RECLAIM. Also, note that keep_alive is initially
scheduled in nvmet_wq but mod_delayed_work incorrectly moved it to
the system_wq...

