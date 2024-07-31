Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92108C3DA64
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rBAUe/cI6zY7tyE/XutFtZ1TLf
	ixZh5U6vYEOpkAOhIYIlipi1G8Qy3HL+mNEcwTVpoGMCW376Mj+3Ms2zqFblDzlPGu6ycuvlMAJap
	agSgK30DZPqWEhvoil9HdwaHWuxERWrsPRTbY4Q4ivCLPWSw1MzHf8z8jDqXmi/M8gE/GAvua3xEK
	TXZ3dL5vLKSOKMJyvniYj0qInnOt0uEcj1h27BTPJxVyaAbrbwo2jlhdojLt8X+QrdDSJ2WolBGLt
	lSG1P+XCCcxQlBzdAK+JJl3lkrQmd4Sy6SVJEqYtM/ARGHlF/8YhkcYWuqr7yrvw0QOwSXVKmNirv
	3Ccj3POw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5we-00000000bOH-0iLA;
	Wed, 31 Jul 2024 09:48:32 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5ui-00000000anB-2JMU
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 09:46:33 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef260c4467so10773221fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jul 2024 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419190; x=1723023990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hhmX/ubqSmkD0hHgLPsa5SWLUHM9DcDhIsrXmBcUWoF5NUExfQxQaRsXb9zUI7V5ce
         ayUaUiVqQ6AQwUU2VcsE6Y7PFqK6EJsmDxmCpWQ+63e+2hzxWrS03mH20uteKRHkd/d7
         YNkdBaltWZ7qknj19sAw17y6q8eBnOHMBGDXcV7d3w8f3bBrUiDtZsMCZFPHiWm0SpCn
         NuMRwF2aZ6IhFm6mcJo0tWMYGFI6zt+AVylSn9H98YYojb+2kJQ+1OCjFBIfyuvLaYs0
         VDUd2u/QOTs7Zvxu7HOxFT13hjYRGSr/AvgWGKlyiBrkejeYwOFAx8DDt7XVicq0+Chy
         BgFg==
X-Gm-Message-State: AOJu0Yzzh7+w/TYxTLeXvHUHGvfCjbo6U/vtu85kj4dypSackGfW2ALV
	bkg/74hIi4C49RSZv7OSjDI0yxxmtWusLCst7ppTK8qEO9Xn4TTSVrgYIQ==
X-Google-Smtp-Source: AGHT+IGAfn5aw2D3wOf9SSxhZbSHfr+GKfSIoA2MMwIwMC+b4IL+jbNifHrUKCzuFjhU0+3tCDDNuA==
X-Received: by 2002:a2e:a548:0:b0:2ef:2f59:76e0 with SMTP id 38308e7fff4ca-2f03c7d6e19mr84641851fa.9.1722419189847;
        Wed, 31 Jul 2024 02:46:29 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb226a5sm15132085e9.47.2024.07.31.02.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:46:29 -0700 (PDT)
Message-ID: <44103e84-9531-4308-9955-9c726aed4679@grimberg.me>
Date: Wed, 31 Jul 2024 12:46:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: reorganize nvme_ns_head fields
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240730103138.66714-1-joshi.k@samsung.com>
 <CGME20240730103945epcas5p3d07f1d9d6d6fee323ef1ae95abde00c5@epcas5p3.samsung.com>
 <20240730103138.66714-4-joshi.k@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240730103138.66714-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_024632_595511_0B71EA36 
X-CRM114-Status: UNSURE (   4.70  )
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

