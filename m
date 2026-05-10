Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B83DCD3427
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZjE13JSaCZ+hCjd2ZiJ2UaZiOE
	oxoHxAKjc0/q1MhgZ5ifq0hT05stoq8X42PR6otDlsCvDSuWnf0ymiXm73rvIYQxe/ldQeh/9BbNm
	ex4s3FYuihQaVVzt+Aa782HX9UYY/5pvsfr7u99Tff/tRhTqEn3SNOBswDmPjXHGkc77MEdHh5Ezi
	qg+JUk2/PFxkjMTXwMDJxT1vuM1i88+d52ckrX/d0ONcLvE9kp+x4iQWpXurPJXra48cWnfX7zMHh
	iPIb27m4Ag55+pglcXzJY5aXOvfFTZ7uA/nHIrN06gq13dQdyKHQZ1sZ+CAn7opn3ZWDosBxGb/lO
	2IbZCEJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBWX-0000000BdMP-2ytg;
	Sun, 10 May 2026 21:17:17 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMBWU-0000000BdLU-2fsG
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 21:17:15 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso39874975e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 14:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778447833; x=1779052633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=sHxcqgtUykpG0r/qcCC/9PqARItEI+t5dsf6z23lYKKF0G82EKLAl+wFr4mXDOWHdJ
         xn0jSaLf1L8P6G6VgLQ8Rj+kFx0vwwrPWEwPPDLflOYHF1ExfUFj9t63CP5vA+dxR/1f
         7LzXOyoi23YD5qBtte5HpAD/pw2gYfEXQ8loz0CunhHsWr9rwgTNvlukHdBDZUMw4yzm
         GthRsfuG5xcKmw+eFJzqwaCqHhpooyX9AfjwTBqkUHc3BaJ0/VYfboOy8z1sPhFtGebA
         HFIxuBeOPN8sSgTsblZVupqo3/lhpoHIPp7Vx25YZr2tQ4eZyEPXyAsgjPr8S9WXLnCi
         z3yw==
X-Forwarded-Encrypted: i=1; AFNElJ8AtqqV45flrQJmbsO1JIGHe5Je5c6XaApq9TAJ54mgjLW5OJlbFfYSv0FA02L2E98++D9Z61m85SDn@lists.infradead.org
X-Gm-Message-State: AOJu0YyMcDME9rPwCe07RqgrtRyYeW6zXZ5M+7894FWWes74WJcVmW+Z
	IsqspScHev/eMI0XqBEMfyPNpGYrgHSNWBH4jVhbv4Lp9F/MXcHhNQvmlHVZCA==
X-Gm-Gg: Acq92OFLEPYzXmreyfSxEQGb3Fwdp5VMJ1qleisENv7r/U1e32ouk7UQslDueyt1tuH
	JxD6ZTNpbnXHn54SNT0VuACPBBjtS9zJiGn9u/tNEXPL/z/CEpCe4pICtElBu6a2Zu5aDodK/uc
	4yc6eO1NaYh2Ckhmnx/PZg71FEOMUBTY3lflabue6HVpWFfYE4wUGh976hj64CWW/QLpx7zvH/7
	iLhM2NIgTpTQBD954efR7TxYwP7U9xZE3Vsrc3Dbie4g/SdxluzQlR9u3n5p2+pZeWWZisao92V
	CmeUtcOf0VFAjXy7mavLGpvybQPybBtKDLLR5KJhWSO6rfHSWHXyZrIEeoFy5Rz5jufdNZ9KxB1
	XNlMmlIw5Itqp26vXZx3JxarFTW4X0nOBMy1yQ3zDOeOZEfOGZ9fEn3J6UkBmbMox0joyNcX621
	JfHZlbRmwmxxbXa6H2o0o=
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48e51f40ecemr379892335e9.27.1778447832625;
        Sun, 10 May 2026 14:17:12 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0c70sm152074305e9.6.2026.05.10.14.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 14:17:12 -0700 (PDT)
Message-ID: <e3d32d96-dbcd-4915-955c-3c63c891b5bb@grimberg.me>
Date: Mon, 11 May 2026 00:17:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] nvme-multipath: enable PCI P2PDMA for multipath
 devices
To: Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de
Cc: linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 kmodukuri@nvidia.com
References: <20260416212633.72650-1-kch@nvidia.com>
 <20260416212633.72650-4-kch@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260416212633.72650-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_141714_675418_E094000C 
X-CRM114-Status: UNSURE (   3.80  )
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

