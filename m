Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A20FE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=r+HNbs+qs9hJZjrFjL+Yfkyr3I
	l5FPk8ygNA5YAZzyVN8CngH7uhz5Q7mubT6/SNucb0qQFzB4pd3If9G/VQWrqYlj8kFbV6AHKvlLM
	zd+UemSz3PQeU0Qt+8t+jy9Q3y6nGB51j0PakGuhJwFstooIUpeo43uMrlqCVUeVG2IiawY3NtryM
	uIBS8chbRJlYIuDz7VWt3VkudlfIDOFUjxLmE8mFZNXYqU6sR1I/OpDKWVRBJ8YlgTk2najwJE9oC
	F9cRYRihyvvP/QyzDkidOPq4ozMclhyi9L9mC9ds9XH71JYzauWwclJmTW0m12XOpjPVwTJ4Ua1yJ
	0al0eWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNqE-0000000HBm3-3Fwt;
	Fri, 10 Jan 2025 22:50:58 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNqD-0000000HBlA-04zP
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 22:50:58 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so29425485e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 14:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549456; x=1737154256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bgPI1ml/v/25zWWlj+s0fIucK8cNHeyfP0UHQFVgBpkq6zLm1eVslMnC8INc+G+4Vm
         81aRvme3xldHRA1SD8GNrs/e4EXNB+C7881rYTZktp0WUzzgMfd61rFt1ro14Wo+r78v
         /qhp81zUBaz79UNvYJxsPK0kj0V598t6XAyaipAQVyClk7v9Fm7F4/7ObRmV4ehrwZNd
         pZOdjcnE8FzAFlWPBHWEOTGTEkunDe5ByGqyNy0LCvYaXvqTg8QFUNQwE1eqZmIAMThW
         A2naC4Y5frnc2HneWhZL+16VwTzmQQFPDNLvAA0YqnXByuWWQb4HCC5Lhbx5913k+dM6
         2AGg==
X-Gm-Message-State: AOJu0Yz313bic4QEMtufRhjVj9XRSzvUAL+GuwPj2EqquDQPm6TIQgT0
	XxQtaIjil5ACv75XxvbgHp9/7y+8fMN2LUWJjz3MGZgmyQ7ArrET
X-Gm-Gg: ASbGncvzdeTHxoHgAEtmu78R5gxxCGufJpAKFsniFcw1OZsEX9bgZebtzOcPrZLbnDP
	E3/XLeFIn/INS5ZpEUIj+HPBULfJNfxApRrt0e+1TvElJI5OfaoTyinklwWV12TaVNrQ/I5O8ib
	Zybq5EhGrWzgP5OVRRUUjJn421xTq/mN27wxep7Q2z1uq9HJqq8moez1C6E9EAHlpRMAn065yva
	1w4vYz3ByfNvFAqCDHHNtlWriLu1hnCckJM/RFpW/Te9J/g1HVs/0c0TiSREiH+WmpvG7vlIwPA
	HDVbnINPwZtONwcn
X-Google-Smtp-Source: AGHT+IEYT/SsPf584KdNzDDOEI8S/iCxsqQL26S63aAz/axp+fVLSBMOaAwYNszgbg0PmtkdcCJicw==
X-Received: by 2002:a05:600c:4446:b0:434:f335:849 with SMTP id 5b1f17b1804b1-436e271cce0mr116630045e9.29.1736549455637;
        Fri, 10 Jan 2025 14:50:55 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2df2faesm100266315e9.26.2025.01.10.14.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 14:50:55 -0800 (PST)
Message-ID: <10b43da7-28a7-4f56-9415-14676fc2d7d1@grimberg.me>
Date: Sat, 11 Jan 2025 00:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: use correct size to free the hmb buffer
To: francis.p@samsung.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, anshul@samsung.com,
 jg123.choi@samsung.com, prakash.bv@samsung.com, d.palani@samsung.com,
 sathya.m@samsung.com
References: <CGME20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6@epcas5p1.samsung.com>
 <20250109235137.8995-1-francis.p@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250109235137.8995-1-francis.p@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_145057_049495_360167EC 
X-CRM114-Status: UNSURE (   5.34  )
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

