Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCA6C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=omGUZ0Wf9rJzNsKF6waX658hboqr69lYhUVgSuQoMZE=; b=H2kRklwDsj7kzd9AFHW3dEd/U+
	wY81nFBbBjuYUV/KQiuO2oCkhlcrZ+l0PYsgtrga3KDSG1rVeHDVcrRf5l025MLFq/qDsgUcHtDnx
	Yrf3rLhCHp3aG1adUN7NmPVmegbHbD8QzeNfdk1NLDRbrfj2RTjc7gwgLeJek8okLuPOCbH6B4/nA
	mlEx//X1uPa2q0Auy48yaJE5cX/JF5dW1HXqu7PHO0m/JuMGmbaNidYnTlcx+QVJ2ZdA73oaLbTmd
	/tIvpMZPNk6ccLGYYLltWUUXLxM3/6v0Wvi1NxIJnhZMkUSu/kINkQZIjJPYg/OQpPUl2TnMh4X5P
	p/CUe7YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbK9m-0000000EoOi-3L8k;
	Fri, 24 Jan 2025 13:55:34 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbK4A-0000000Enqa-134N
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 13:49:47 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d161947so1167655f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 05:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737726584; x=1738331384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omGUZ0Wf9rJzNsKF6waX658hboqr69lYhUVgSuQoMZE=;
        b=ubBRqIQwuuw/EvZkVREm6+Nq8mzRdmnsIpaMBw5EhqSVy82p9MZZ/UDWOBT2Iav0h5
         eRw3AtML+e2qCaQpVGn7ZZLqQssx7NAiYi6PWCxgmlXkRbiXvNxM/gHxlXXwAxGSABYp
         N9YSMpeYPHxH7asdBJE5McauOPy0EIJFdnJGRXat7T4Dvj/4vodVea071MWzqs1idFIZ
         5QG2/uV6P1rIGX/3DtXDKw6HKVa5i2UkJToLfSLhnrpiCp+1Rfq0QEkCNL4xfJEFpNma
         BR7AU+B5C0LIWzwDzez+k/m5YccxpuxxaP6aX1kJeqTuRnz425qSJdmsBUv02LWHGnn7
         NWMw==
X-Forwarded-Encrypted: i=1; AJvYcCW4eq5lIsDgLD3/4FexXOIeUsoFxdWo7eN/5WWqaTzIGYvQ90sXFtn5Ys+nj5lQg6OQJ7c5FsaGo0gn@lists.infradead.org
X-Gm-Message-State: AOJu0YyHcx+MxnvMftckB3A4p++mHbcTaKvHlPxuupDj4J7RxGIyon4V
	bov/t/7pnDS3KON9HUmfPG8YwkcZi5BJT0II6f8j9QI+W961puZRDFq9qg==
X-Gm-Gg: ASbGnctuW+BPPGNHNyNtBs6fAOrpJAm8gHy4xREzV0XGblzpNuxL2/2U8wOQ3Lln4+f
	INtFy6XSFnW/mrCqWJ/+eZ7+r5/leM1616TxHskSP7NCq8kui5TPrBlRFU43hIgNBQW5JVN9ERz
	703rEeyzujZhcQSSIn6jFHG/GxKUlIJuL70ceYZ/hNbi0KDAVtqh4t9/dF8coXgg+g3V/CpJjOG
	kbqPQ469LKYvRQLXlVzHeYtg6xX1WNLItIjmYNJRx1aIQwVj7RHJGHooFkyRirsZjpNhU5PyzV2
	+gXm1b5bT2n2jOv05LlnLzTkksvNOeFEJ6SoQ4rn
X-Google-Smtp-Source: AGHT+IGwY3mGinma/K9x3ViNtWzjzza3ovN/0QYnlASBOYfqpakZJXuayXkxGNQzfLcNW9FTsYtYzg==
X-Received: by 2002:a05:6000:1f88:b0:386:459e:e138 with SMTP id ffacd0b85a97d-38bf57a604amr23251824f8f.36.1737726584239;
        Fri, 24 Jan 2025 05:49:44 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d79csm2796302f8f.39.2025.01.24.05.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:49:43 -0800 (PST)
Message-ID: <6d74b77d-df2a-4622-8acb-3e5ac74be4d6@grimberg.me>
Date: Fri, 24 Jan 2025 15:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: Implement 'admin_only' authentication
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124114738.115882-1-hare@kernel.org>
 <20250124114738.115882-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250124114738.115882-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_054946_296178_AE13BFA8 
X-CRM114-Status: UNSURE (   7.77  )
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




On 24/01/2025 13:47, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
>
> The spec allows for authentication to run on admin queues only, and secure
> concatenation even requires it. So add a configfs attribute 'dhchap_admin_only'
> to the target configuration to allow for testing independently of secure
> concatenation.

Why do we want it conditionally? why not always?

