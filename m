Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C5C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 02:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC0920637
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 02:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHhLn7pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC0920637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sUMkyHGTQEwdV6zTR3jDPRr+Hm3idPDFUAQZ/i7QWac=; b=bHhLn7pabAXcxcMa19J/hhazP
	kMIoUup2NRH2cWScb2QtDLusF4TXjrnmbAct4BhsCM0O1wB+C0824YwiWbNww9GEhbqINSygOrjrb
	O0BjhIm0uZzOnBj8+teabymqnLCzhhpxdW+f3mQcTWK0tGNenDSaXV6AsCNR8ECf7xz2XT4UVcfhC
	8eFu8eV638gojLpvJ8Ju8b9ro+ns4SGtM9o+1QYNI9eK/AJIyj68zOGwipFmBakcSijJyyEzIBHtD
	lyCzmk7Iv7RRqle807lHwFZWMOLon8G0PlB8bmJIyoNAGq2dE4cDNvl//iaTYudlaCHN5yiutjsE8
	eBJbR2ueg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia9pf-0003IX-Nm; Thu, 28 Nov 2019 02:47:03 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia9pd-0003I7-EK
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 02:47:02 +0000
Received: by mail-wr1-f66.google.com with SMTP id c14so4580092wrn.7
 for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2019 18:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DRsh4dCM7wI8G7Q+IJNIDPNzcfOlSYwwFFMyl28hc+0=;
 b=TTp1mLjRP/q90G58RUsBsh+IiE/MvL1DMmQoNykHg+zWpJPJsOcN5vXRgVa4w2KBOr
 5yL2iw1LVFnmV5QRztxSuBjwicHtbFvAOzKCePCquQ1QHEJ5OruAP3f7JkxJS2y0+fCy
 UfjEYqOR/zJUduwc7LYlBCO+qODCFQ490fvn9eN0yHEJzew6cI+31lSFuofLvyeP9nL0
 Os/fnirsmAyTudAXyOz0r1fKux/K3Zek0D3HfuVuSRoE/Jc3s8nLAmph59sWcfdurLwV
 EHkmwvU2jiXWSTMQTyw4vTflojL24jgs1vuKk87yFvCmpN0RkjUrrur4CUD1Eg1wnxD1
 jFgQ==
X-Gm-Message-State: APjAAAX8XLuRwssQIP9KOUz1CKbnGu0RdoI2N3n95jQR6KG5AERGLagJ
 4iAc6fWg96Fp+yTyGlaMWEs=
X-Google-Smtp-Source: APXvYqzIV5UUdONg7LNLuLWanfWJUU/6JRIviKBUlMGbBPNaQ11DkHgv4f4yc/fswuUoWuUhpvbIFg==
X-Received: by 2002:adf:e312:: with SMTP id b18mr48066225wrj.203.1574909219882; 
 Wed, 27 Nov 2019 18:46:59 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t187sm8705750wma.16.2019.11.27.18.46.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Nov 2019 18:46:59 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11325d8e-e9f8-408e-18c3-182c69e90eab@grimberg.me>
Date: Wed, 27 Nov 2019 18:46:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127175824.1929-5-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_184701_483067_DDA5DC52 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: bigeasy@linutronix.de, helgaas@kernel.org, ming.lei@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> For deeply queued workloads, the nvme controller may be posting
> new completions while the threaded interrupt handles previous
> completions. Since the interrupts are masked, we can spin for these
> completions for as long as new completions are being posted.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/pci.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 571b33b69c5f..9ec0933eb120 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
>   	return ret;
>   }
>   
> +static void nvme_irq_spin(int irq, void *data)
> +{
> +	while (nvme_irq(irq, data) != IRQ_NONE)
> +		cond_resched();

So the cond_resched should be fair to multiple devices mapped to the
same cpu core I assume.. did you happen to test it?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
