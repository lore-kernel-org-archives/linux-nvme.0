Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B7C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgU/fsk2o90nv2441UyMkRJGp9lC98Vp+Y0k2mz7HXg=; b=o1q74FGNAM2mvo8oC7ef8AsbsR
	zfLFNKIRFTyvNqHsOJ0ZzC0fgMbxA8gX2l3Io3vNKgICklOCOo8M/Q4Ra4NTabF+/ptv4qiXAhb8F
	ecJgwIIq28akLqYdkOUUZTrrXiVPqQgUW55oqyG6JUgzxPr4fQxoQdFZ0Kb339pPrxu/K9HLdbCYA
	1cdnvb8s8tSkQH+quIVJaFjWkga3nwgAwUN3lDEbV25K9jrOmOYYFG/SJuo0/Yy7U3b9Z54nEye5I
	5VYB8Hp67TQUnpodDR37s7KVYNQZUHVK47TNK0bVogwEnIFIZzhSa4LS0Uq8ol9FJZoZoY+6d2Axt
	WXQFA+SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNwm-00000005uEg-1I3U;
	Wed, 26 Jun 2024 08:24:08 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNwj-00000005uDd-0Tmj
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:24:06 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42111cf2706so8114645e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 01:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390243; x=1719995043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgU/fsk2o90nv2441UyMkRJGp9lC98Vp+Y0k2mz7HXg=;
        b=aPg8BK/BwzytRF72O27noglL37tvBykmUMQKERTcxBRXzHfvEfdITFZYYf51Q16XtO
         jpDROcumf1e5CNIBXTShmohEvUg5DcPFYdsOAExQ9efpbzdeVgrhtjxDF6bl5atPgkwl
         zGaRe/JF04mNq8F5y4jtrzai4zxlXTHawQSNcDMCIwxXb4St5B4GCr8VlRQcQB0mT4V5
         /r/5uHbMJ7IW6a4LX8hoHDnF+YdPIJH/vfecoQt2WgvX3rocmsBXQElDNufu7/tNCmV4
         nFnuykBaHJrYKguWqCnLaJlbjjN1ElR9GkYwNzIX272b1tQRCU7MCAqJIRfcrBribsbC
         p1HA==
X-Gm-Message-State: AOJu0YzxoM2l4cPmmOrx5fHjlDT2vcbs0agCBs16LslR0u1YJVAj0Ycl
	FGsCdqaXYT81Q8sTxYg7kIxvrFSWUFvOSlkHpuEau3a6zes4nia6
X-Google-Smtp-Source: AGHT+IHSjUTw3mKKQn9qr6UJDVsF1Ae3yrP/yTdwhV5Mh877uHFja9Cti1FH/pyoM/Toge3XiCDKMw==
X-Received: by 2002:a05:600c:3b8d:b0:421:de31:76 with SMTP id 5b1f17b1804b1-424891aa2a7mr80554065e9.3.1719390242938;
        Wed, 26 Jun 2024 01:24:02 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6753sm15130117f8f.74.2024.06.26.01.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:24:02 -0700 (PDT)
Message-ID: <55079f60-1b3e-4929-b7a9-c5e0d36a03de@grimberg.me>
Date: Wed, 26 Jun 2024 11:24:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth" iopolicy
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
 chaitanyak@nvidia.com, hare@kernel.org
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-2-jmeneghi@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240625122605.857462-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012405_249908_F7603042 
X-CRM114-Status: UNSURE (   4.28  )
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

other than the comment from hch,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

