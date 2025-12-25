Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D4E7AD44
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DJnTyGKj01l6T6aQEODBy58G7D
	Yqy9Oug1gX5XvcXJ1jOqYy4XOwBmow+CQmpNT9frPm8F2kBplXWEJD6omHRrM58bRj1zqcX9BtcWJ
	8qEw5pxFveDDbvezSfU4K9eGKfff+lKwoFFSAQRpEGnPSeHbjUIaYvzXgDFo0cDibvMqin6BuNiga
	KYm/Kx2hmbKtAE38JZau7eCgS1kVxOu/frx4W4X4n7NohZpt5Sn52WEsLUbBxC5ilB9ay5O5qv1zk
	AKsSga8ndjTEUtmOO4XsnGVB5CmpKdd5zCSnD1PMvZC++ug1jrh7xJ8+WfcpGAfDDtGzuELims5tV
	XuY4mAUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkjn-00000000PmY-2oIf;
	Thu, 25 Dec 2025 12:46:39 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkjk-00000000Plz-32iL
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 12:46:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso51719785e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 04:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766666795; x=1767271595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KlBzLniNw9jbL9qiEMKcyEPLU1p8QOv4X3RrU0okwgUUw18uTGARXAd18anfEnP4wV
         81oBUeVcFNXcdYOkm1RnYiIzp9dz6iGaWGQkfIpxqVrIajah9mxlHe8RYsO5E/sQZwC8
         Z/9V+bkfaBg0bfZqG3nPD5FZJgsFT7GmLM+js9lkSPhN2la7QS3nOL7WNJZ6WTrOypuE
         SHhMjvDvWIOj5lcVzKpVaMwDhN5ukxcPUc/Ygt6gYkd8G3W6yn9mkmzgbY6ebl80sXMN
         KeCSPYtRn1OrB5YHDYI+tJE25nz6MgruDVPrSFvBRTsuYduU8HhzCDHFNn5Udg6jSOpt
         aB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIn1p7IMPDxpgQntg4mpzL3iGZGEk6Curo3/0nUj7tE0IBhvyDib7UiucAjWvElPUEU2riDVB+K8vU@lists.infradead.org
X-Gm-Message-State: AOJu0YyfP4e71mO/i/nquRSNOBFRRPiJJyy4Ha9LbhVGHTgVBkVkgUMM
	1oP00Jt8xgGE6tylnMSsCaFfhSX97EmoWTImnE5QG9a+mawattspaJ+Hslt94CUc
X-Gm-Gg: AY/fxX4h7hKtfXBRoVx6ebJ2//ACrymbcZo/awS9sY3q+HvuNCM8EXGw+qfwkRCM+X9
	+zQJ2sfjgL/FFCiz7+dTiPrcldxPSX9lK94aWE8Yp/6jb127xY9de6iItn1kOeDFZ6ndJTSPK/g
	4e1npuNp2FT1yAxjxu6X5DAgwK6kWncDAtDTD/hZq5dgI06x28NaKK7c5ZIiRWiQMAY5kceSaOb
	pp/8LAa/7I8KLaXZeF6wj9NMo3Qn9hpsy7jAEq7m6nlEwH6hj+tVqjU8Kdp6d0Pyvld5rC0vzBh
	kw/x9IaG9QN/ZfqNMJTr6+sWTgylABaoOQ3fm3j1Lk4TBIHLaopa9IDXePUuTbSLsgslm1w16y6
	RXbly9BKyAcDkICr0aS0r3p2LMgqwgkedFn93iujQCllZPkIDtF9tCdH1P5TOSlx3fik/Bk694g
	I5xVjsEichC5Rojo8I+qd7L4NmQQpMFRbMzNZFQmNPQ4UMxQ==
X-Google-Smtp-Source: AGHT+IFMtQ1sqZdBUrgI0SJXLgWsJAarACSScxm7CXp343IWCyeVA4MPu5bOnedvwQOS60f6G3wRGw==
X-Received: by 2002:a05:600c:8b82:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-47d18b99b99mr200246125e9.7.1766666794684;
        Thu, 25 Dec 2025 04:46:34 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm371990775e9.8.2025.12.25.04.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 04:46:34 -0800 (PST)
Message-ID: <fad46b60-f7e9-43d1-9d4e-8007a5b312f1@grimberg.me>
Date: Thu, 25 Dec 2025 14:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Constify struct configfs_item_operations and
 configfs_group_operations
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <82fd284cf70cffd374f5889a5c2a1f3800bafab3.1766495484.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <82fd284cf70cffd374f5889a5c2a1f3800bafab3.1766495484.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_044636_806387_BA3F1429 
X-CRM114-Status: UNSURE (   4.68  )
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

