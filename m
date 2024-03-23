Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBA8C54E58
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ne1Lw8GJ9bZIndfurv4dKOh9Ev
	icc/EiPj1MHM8aBEGbQiW3rkh13OgFr3x8OC59/Fk8fQLtA5ZkE1wQtcXTwNuPHH+OfEG56labsRB
	UFnc4qUd8L3oUWP5Z8z9+yF8geirSbFMTKSw9FF1LMYo0WE8s90ueMRlspL9T9oJjl5QFKtKiQQgd
	mkXf+9l4ou9DlvGcr8R0UQgIsDNlEz3AhIjEE+qzqM3UmCUqwxzP5nPYpXgj+T05Ue7nT+6x6zm6Y
	JJPMDqMMMGNrT6BOmsUs5JWQuNFPh6q0T6daT42+gRHqtbLCmxwrpg4NAOMs+OTi5Z+oTDVBaB5em
	xdL/eGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7xp-0000000B6rV-3WUr;
	Sat, 23 Mar 2024 20:27:37 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7xn-0000000B6qC-3Pq5
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:27:37 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso582324f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225653; x=1711830453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wGJsWY69c8SjcAR2JY/n55od29IA38tkSss0h6QAZrfvPWsh1VbrzU+MJ8qSUa9W5o
         XotQCqBo7qIdbonInAAXtHUh0w6Yc+lshAn5PUWeXMgJO8Tnood+ZcxziwAT9D9MEBeT
         Zthrd0m8e7TqCTqVf7/aRxPFRElrNsbfafbzKFNny+E4f4F9t9M+aEoguJCMmpMx7WkE
         scucI0RIgVvyIjjvsYAuumCeBiNXzmhP8A0HWK+1sjWdZgNyIjRTgK/1PPm8pRnNOjdT
         Y6vz0EdBDiFDGcasym5dApj4ZU77AWLl9xQv4x59faani/EQi3j/+KgrKcXNBYMQzeO3
         WB8g==
X-Forwarded-Encrypted: i=1; AJvYcCX3WabiTxCM1FY9lc5Bs2eMJ+ESC9sECJkXl3Kw5D2PCfxhYTeke8G2jPKjhhEpT/YaF0i3PdgM8NG9uKOmzirnyGGFWHIPMyUGQMt5JS0=
X-Gm-Message-State: AOJu0YxgR07vKzEV4xr0NyIXgymJEAm7yvitZ7RWo8YCRdZloU5PLjFl
	Sl2ElQOsQPmMDAFZam1/Gl4PUhYH51f/HJapvUSo1vrEXDRcT6Lo
X-Google-Smtp-Source: AGHT+IHIUP87gwzD76danM3N3iky9rGrgCUfKjDHRKKSCySuQdefO9Ek0yYV4Auwn+rhgmFuzAUCZg==
X-Received: by 2002:a05:600c:1c8d:b0:414:66cc:574f with SMTP id k13-20020a05600c1c8d00b0041466cc574fmr1991686wms.3.1711225652778;
        Sat, 23 Mar 2024 13:27:32 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05600c1e2200b0041480c36bc6sm2714888wmb.27.2024.03.23.13.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:27:32 -0700 (PDT)
Message-ID: <8c2aee1c-0d37-4d42-b1f9-4962b5322850@grimberg.me>
Date: Sat, 23 Mar 2024 22:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nvmet: add 'host_traddr' callback for debugfs
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-3-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070333.3820-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_132735_873252_4991445B 
X-CRM114-Status: UNSURE (   5.42  )
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

