Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFAACEF175
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qRTokM3nYWAoerMO1TwNyg7SO+XosKIFo67YOO6VTZE=; b=O6XPNyiA9CvZLYcLpp/eI0ZDit
	3Y9j6QRLmShlwbyGxTbAHcY+TJx7tzMbdshIUbL9ylGwgl4gAZPRICWSevx6CKK8hPScuEq761DUJ
	i7+iJjSavGR5uKfrsJMK+560XrmNZ1XIMZx1/abapSM8WvlQa7OYzF3wrnMz8jyRspRet1ByCigU2
	o2tRfjDEdluKPe0jTyl5k5e0BVEO2vzIn8O6BUpxqkYP17P0z0QottYARFf48muxlfh7eXnh+lrIS
	szMpyy9xniJzkB680QGog3W3Hb7jpXlrvTaCvrJ4lAqIRGxM92FrIzpF0QJM8/QfGjp/nnTQWJ+OB
	62FOR/xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syASX-0000000623J-45DE;
	Tue, 08 Oct 2024 13:41:05 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syAJX-00000005zyC-3683
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 13:31:48 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-834d3363a10so211097639f.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Oct 2024 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728394306; x=1728999106; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRTokM3nYWAoerMO1TwNyg7SO+XosKIFo67YOO6VTZE=;
        b=v3g3REtdbyaWzvWGCpJe0pQWLhZItjbl/8pcU82sYSBKIHrzxYUwWyb9oCMhCARGNl
         sAJyGaVuCUgju2Qq3nlkEG+QHFMbRJ/fqrG3qhtmOh7Jl0imkDbcETUbfS4VXLjz6gsl
         KF4K8I7o/Wy2b9iMxJCvuENdLNGrKPB8gei3tVqHi5m/2xqc09yDari3Oj6RgTtqjuAz
         pby0jw3b/p6Hlp/U4url4vOEOV3BALtswmxRtHsSsu8oX1Kr4iyNcVe01PlMASy2BiWR
         mXC3lxGCL6qhzL3kABJlx0+jfdkhvuH7BfWR6CoLgesy3CPCnnZgL6OI7KDs4dSPPzPE
         e4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394306; x=1728999106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRTokM3nYWAoerMO1TwNyg7SO+XosKIFo67YOO6VTZE=;
        b=lP4QVfmruD4Ka1wSapnUDnAGj+iE73nwqpYzt7UtXe2wOBRbFDofneidq8A4tln9rc
         hH9Mo8W7yV7eg7E0DANLiARrJ7rk0rGud92mK9JyhwUTKtBgZCAQ3OHdJVmX2/nw+gz3
         IU8tvpRKva1maXODPFOjvq438/20CDw9WPK6rtrktkTVQyOdDmKChe5MisbC++NUQp0P
         KEl7imJlTygkgy+g2FXxfo3ecS6d3zQR4fPfrmvvqpNnO7wKKUf+0XyV1w14NgUtdnr7
         Fu6WQF7hfWldQWZKxWLEY1wqZQVzxgLClM10eC7i1t5+QSCurxWRx0jvpOT/zygFEW6U
         MEQw==
X-Gm-Message-State: AOJu0Yw91DFidBPoD6x+QgDHYGql4dQCkjPWH1kF4g6MQqlfr1SEqeSR
	x7XQfyH5kTUNsDWiQPVEwhi76WyptdG6H06k6192A5ziyrSGQg4vNZtcmoaa/tE=
X-Google-Smtp-Source: AGHT+IHAfJ0jxOtuKn1vypxia+LF169XpnfSi35lI6RoN59oXX5OXLkPNeFLXl1hgvWOtBnsSXRtUA==
X-Received: by 2002:a05:6602:2c0a:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-834f7c73cb6mr1770506139f.3.1728394306115;
        Tue, 08 Oct 2024 06:31:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b305easm172781239f.47.2024.10.08.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:31:45 -0700 (PDT)
Message-ID: <7ba769cd-6707-44cb-afe6-eebb5e75f445@kernel.dk>
Date: Tue, 8 Oct 2024 07:31:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-rdma: use sbitmap to replace rsp free list
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241008093708.107392-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241008093708.107392-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_063147_813427_C7D6ED0D 
X-CRM114-Status: UNSURE (   9.79  )
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

On 10/8/24 3:37 AM, Guixin Liu wrote:
> We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
> free lists and spinlock, and we can use an additional tag to
> determine whether the nvmet_rdma_rsp is extra allocated.
> 
> In addition, performance has improved:
> 1. testing environment is local rxe rdma devie and mem-based
> backstore device.
> 2. fio command, test the average 5 times:
> fio -filename=/dev/nvme0n1 --ioengine=libaio -direct=1
> -size=1G -name=1 -thread -runtime=60 -time_based -rw=read -numjobs=16
> -iodepth=128 -bs=4k -group_reporting
> 3. Before: 241k IOPS, After: 256k IOPS, an increase of about 5%.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


