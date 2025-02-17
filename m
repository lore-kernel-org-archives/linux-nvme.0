Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAEEC021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=tQo8aad2CAuXxonCoiUrsAkpVc
	HiugqnZp+vQQ7aKYpPuT6Zu3VuBnVS/it9dFBD5Rw43JROBUsBwCapObqYUiCAPx+06H2Uy4d+Xim
	AdSQtw+VrPKW+otTzQsXCNrPWYVxVylZKVHjAw8V1NHOA8BuBb5SRDV5fuO3n45+g6KKPmXlvta6+
	z1So4rsFalQlP9AukF67epdHwUqSyF1WGYHATSYLilLhD9foFYlnD3Q5xE4h0JFXNaPFnzF7khhUp
	AfDRACSWntU5GvVLDpzd9/cJ+5D/FnNt70DxeX3PptxscFeGEvA0zn++XVwCfVWQkwRwSETww23X7
	t5odcGQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvsc-00000003f0a-0mRU;
	Mon, 17 Feb 2025 07:49:26 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvsZ-00000003eyh-1IjT
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:49:25 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f22fe889aso3056109f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778562; x=1740383362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iXT6S5fSXcZ7tPiW29uOf7TkM1ZmzUWE6j5WwOez2HPGLLfmazdQqWgiGOK1JsIARy
         aj9zAnDgQ/xXitJeJSnVMDXjrH384a/m4T2AjmSbW8uto3JrGhErPceBWs1pkhvDdMmf
         haA3ZaO+meDmXuhOI3CRO3bdHHjwugWfh3GzP0hKy9E9a1nUY3w2mugoQntirZ8Wu9fm
         8VbM3/i+fOynuj+zAF3aAV+9WLsVnkXOE/xZ59lLtVPOVXgTuia+ZbeaJ7mlQYYS5Co8
         VNyABzUlvM5BCl/Su75jcTyZSovipRL9lrDKO+cDmwWDM8Itm9t3b2rzf2Bqp0MGW2CD
         F7bg==
X-Forwarded-Encrypted: i=1; AJvYcCXpQuFc+L5sYBb8GQgAdjyzcdfUHVMHP/w9dolJ3mI9naOJF0yi2pblZVn/97qWMWZ1KgkhABgjfZZr@lists.infradead.org
X-Gm-Message-State: AOJu0Ywbi6sbrfXvUtffvd4xaCLQom21NmKpobuf23w0ITobIYAcjV9m
	6pe8qKzotdUFEH0xMWG/LTSZakFQJJ1avq8Bicv2cUTSlFB0KGPUrTy5vg==
X-Gm-Gg: ASbGncv2LrNkn3GGT/f0AgqdQhdox1T7zTckft4NdzI9Rk9gAunS84ZkzyMgh11MfdG
	O+UGDNzlthMyYMSDqR7mUTf1HYRprK5xzuMzCXCxapA+5OhydNms2OLyJw8EOIX/sW6wBv5q7VC
	HiB4FmDfQOz3kpRGADAj7wtuumIiXGGGrup1JUMX8Crfd+8Nb1ZgwRQKp30+AIk3TlcSWc1o3Z6
	UlUBv91GRNoqKEALXks2n/vWM+tfDwVsB58KYvPegd4C16oMA3OR6rPU+mxcJxO1awhoSsx6Wyh
	CspBBu3HH7C/jiolW5UTfqwCNxYH/y1eAVZVaVfG3Fkn9GxX1PBork/bZA==
X-Google-Smtp-Source: AGHT+IEgRIytxQ58+ca/ELque84Bd0/HwKiI7QGI3A0Xr5UX+f4V0Q3nEkuJqq8WHNdt6s/d0bcoJg==
X-Received: by 2002:a05:6000:184f:b0:38f:4cdc:5d21 with SMTP id ffacd0b85a97d-38f4cdc5ea0mr220317f8f.24.1739778561615;
        Sun, 16 Feb 2025 23:49:21 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d1f2sm144064955e9.18.2025.02.16.23.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:49:21 -0800 (PST)
Message-ID: <b99358ad-f012-4f23-a7d8-4e1d947438bb@grimberg.me>
Date: Mon, 17 Feb 2025 09:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvmet: pci-epf: Avoid RCU stalls under heavy
 workload
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250210220657.1762684-1-dlemoal@kernel.org>
 <20250210220657.1762684-4-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250210220657.1762684-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_234923_339248_B6042CFD 
X-CRM114-Status: UNSURE (   4.87  )
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

