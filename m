Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2436AFF8855
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yhwm8cScN06LG6WovVuyBu2HIWzOtL5RgJ3/1ttLxBU=; b=hBOzoJQHBvEAO6u6gSoeRzF2/Z
	v4rgLStYAeEJ9W7QA+I4AeRtBaz0vHWDJn7nYTprGaiknZCJ69pQKydBveT9lctYmgMHQrB5gy7YE
	HPBoU7HgnnZm3eZmaCAoWG5SyqpSlf9FiKaduuvAU7IXECIBg7qiqP0nEdqd0LmxC8R1ffZjC2y7r
	bzLAAWIw+LD5FWlp4PXmSm2Jfeq4ovXIjNJ14iBhD5iL4GomHvINnQrUP2t7CgcsYvG+/Lb9Gnpal
	8JreQzxKH0vigphHEyRB2kKcmUshCmONHKG/vp/r3MJenU3Z2PnokKUKAite2v+yfQ/26tgKuQ89R
	d3btmeZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOva-0000000DoLc-2tdL;
	Fri, 24 Apr 2026 22:23:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOvY-0000000DoLE-1XtJ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:23:13 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so8364740f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069390; x=1777674190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhwm8cScN06LG6WovVuyBu2HIWzOtL5RgJ3/1ttLxBU=;
        b=QOvzhH8LBt4+XVgc9OzbuUjoDdPYE1mImz1tnKKBPbSqFYE+17f6NjgjbUq2/LGJAg
         sdr/jsfx0aL5RYkK5DbkNDIeLL2L6NHUM7Y9f36qoADJv/J32QShd+br9XCruUbmVUZV
         1OO9LMuElX0UC+ZGThVs1zUqpN08mSAKV/Q3NC8t7pi/KeVn7QYhVVRb5dbpT1l0dP7l
         x9A5r1D4wBLymE62R8XyahKsyoVdLYwyleg/DUqliCxL4UBi7iInCckfFyqgzwS29P5n
         eISLukhYwQaWiTGgrnZKfmqARcMmEyEFhyjktibNDsGD55/xrsjKntjnHzLPu0OCx+Zo
         mlmw==
X-Forwarded-Encrypted: i=1; AFNElJ8XusUyqJBM7bCPf4DdBjtzauhKffoebvWuBSc2L3Na5QDNrxnArauZSMjbtBm1uc9a5w6gWUOgMetE@lists.infradead.org
X-Gm-Message-State: AOJu0YyvTmpftPwZ9jpEquMtsHXcE39NGA/7IWMYYvd6EaEuZph0uKXD
	DuMoQ3Y5IIh21eaeIddGueX/dhDVOx7Dzt+HcSrCxnXxnH1dombpCxj7
X-Gm-Gg: AeBDiesDN/ZjXIxEYPmvpRi5EOsDroKHI2c8nd1b5pKiIOjtrwQ33/UZmQsKonCI6ER
	4TxrjlbUzy8fopVi5TrPDnDVrOXKQkSY0itWCvpvbOiefpS/UP2rYGkG3wyXLqVHc73j1WrTHz7
	JQlWpWwZoXIfX3jDJanKtGkEyUWg0PbvNPf90P8dniRepTYkgdsbXRQyEDOGBoZneHCwq5F7h2p
	aQSpZELG7e9cH4kMFLr0LFQASf6/dF0eZfopkBh7E6KJ7pGienw+4tmEKuxvukR/v+H+undwA6P
	l3TUEkoumBlBeMhkFOhJ+YV+VjCg8sKyoTJLztP1KPLpGY/YI7Ya0G+fYuXBoZxZpLrb/jJwU0b
	2+k4QNiZ/PVwKpx4uG/TDfPls/p8AOqzcAFGiaIj6AJB7gyRahRgmsSAcTMa34XZECn13nzuSwO
	tKSdzCHD+utjLC5Gi7X04NWBCZ9crWWXsoRcN5NqPCorqZ94aZALH+AtLQDbR30RmRHPfdm9uH1
	WD2Giw=
X-Received: by 2002:a5d:5f88:0:b0:43f:debd:feb1 with SMTP id ffacd0b85a97d-43fe3e14f4bmr55260683f8f.39.1777069390207;
        Fri, 24 Apr 2026 15:23:10 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm65558362f8f.17.2026.04.24.15.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:23:09 -0700 (PDT)
Message-ID: <63b9aa3e-978c-4448-828f-9119f8e210ef@grimberg.me>
Date: Sat, 25 Apr 2026 01:23:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] nvme: expose queue information via debugfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260420115716.3071293-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_152312_565307_661C8ADA 
X-CRM114-Status: UNSURE (   7.71  )
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



On 20/04/2026 14:49, Nilay Shroff wrote:
> Add a new debugfs attribute "io_queue_info" to expose per-queue
> information for NVMe controllers. For NVMe-TCP, this includes the
> CPU handling each I/O queue and the associated TCP flow (source and
> destination address/port).
>
> This information can be useful for understanding and tuning the
> interaction between NVMe-TCP I/O queues and network stack components,
> such as IRQ affinity, RPS/RFS, XPS, or NIC flow steering (ntuple).
>
> The data is exported using seq_file interfaces to allow iteration
> over all controller queues.

Don't really mind having this. Not sure who will actually go through
the process of mangling RFS/RPS/XPS for based on this 5-tuple, but ok...

