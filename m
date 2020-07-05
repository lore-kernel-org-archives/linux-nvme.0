Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A811C433DF
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF3B20786
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rp62Fmaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF3B20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Rp62FmaaZq6Uj3hiQMUlRid73
	6L51h9WRowEsy6cheBuvZbaq85t9w/IJegNt6Xc4ONhaEJxkR1eOA03P5wKg3t/HoynP/dfcp++iw
	XSXOwdkV8u2TIwAXCyX7cjSYXg8eIZ0lrI34XwaaDIetXJgCQhknJjW5aqGJL0NnqgXZ5e8Z8LpFU
	JvGbN504tr8chZxps9kUm08L7T7DFfiCbQjz8w5m5lHa/ITKghcpFKCYFIRGXtSRYS/IQsesCNbgp
	XpuKTETo5BMKQkzX95u6RN8e9qBBumtLV7ErDMKdCfRf4BA3yct3fWSkQ6du9v02FsXLLQaOLeDFo
	j1PxiiOGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jryd1-0002LJ-7B; Sun, 05 Jul 2020 06:59:55 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrycz-0002KR-Fy
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 06:59:54 +0000
Received: by mail-pf1-f194.google.com with SMTP id u185so13635432pfu.1
 for <linux-nvme@lists.infradead.org>; Sat, 04 Jul 2020 23:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=NN3W0Y8XCYtAWN08lr3pwRDt4spdjsrMWbIrS6YSDAYncxtFb6T9lanyff1ARG+d4v
 /gylwq4ZVLPg53SLrR/6iWRi/gOZloeP9zygBEbE8XhMO853tVG/xplwscaQoC5FAvM1
 F9T3xZ4jnbWH0RYcw1fCV/4hTaM2JVLpkS4uxvtAGCOyzFRP1UR/eoj8NJVOsqspz7LY
 6cl3SPqpWCInULpJARDJWjSUC9zn6Llre/OpEp49q7zfaiZq2q6LLh2smOiLUio2kvkR
 vRfFpouay4Ss+ejy/XihgeAIeOAxRWKvunNnOUPJSpcE+7xfimkxEfTaF9LZnL4yBVX3
 8rMQ==
X-Gm-Message-State: AOAM530hHDe2xnFO8XviMu8mJ2jfhKGgYX/t6sfViF2kWDuqJdeY7Z6e
 Wrl7giIoLbhsnFoHMKr1oqQ=
X-Google-Smtp-Source: ABdhPJxerZHDIQpxkJPD4FNIhC3VUSKnjSLgmPdtqKF28AyDdyJ0p81t54OkjGPoWQoQo3UbR5srGA==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr28506198pgm.348.1593932392462; 
 Sat, 04 Jul 2020 23:59:52 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id b21sm6421045pfb.45.2020.07.04.23.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 23:59:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvme-pci: Use the consistent return type of
 nvme_pci_iod_alloc_size()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c97e7fec-8602-ef3d-b841-f6e90baf7251@grimberg.me>
Date: Sat, 4 Jul 2020 23:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_025953_537491_E9C252C8 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
