Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9AE7719A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1KeMzqXQ8O+S+jBXoQBm0btwgs
	FRa0m9bw1NUWVPbgvc+vf+SU9f7WdGFmLUl2ZX5bpP6v5BmVULdiZhm8q3ZhxSnOjbIAxfdeYizS7
	oFI3RodgIFofhZDWsvKSHGQTJDQ+wZeuD/QNowmEuBH/vkVvf5ozFphTa6HvEQrP+JcstDByRSbqW
	rXzUAJTvZTgw3NWsn/ZNEKMmgyik7P7g+iw+s5/oRF+HsnMSSyNM3j5afuncUez7a8CEQah8g6fGG
	8y1++u5mLeFIsz9Fhz11RvvIdNgaqCJYcyGs9l7pG2s6ABGW0KTzDX8iloE479ELnbJAh5DrLZvCj
	V8gY9ftQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTlW-0000000869T-11Fc;
	Wed, 08 Jan 2025 10:58:22 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTYy-000000082im-24vA
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:45:25 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso172300985e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 02:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333123; x=1736937923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DXCoN2FNgGbaOzEede4DJPhvEgaeA1/bw+RIrx3yaR+ePMelHVK9CzrjR6uxUzIyvk
         rD/FkMAUifqJVHHIun8wuUTUW8MSWIgK4JnQV943vf1hFHYxyRfFBco8DNGsQmNzGP46
         O2XIZUmPPhvGcowShNHWPOy/mPyP2sect2Mx3FB8D7rYRuY7lvRb121+CnAO7Be60fhr
         gJzHM09+0dG1l5+3kUemEIHvkWoGa67NnIphRgd+QFRf0l6Dqx19m+mgKqx1LMbGpt7w
         O6iLXftiGbHoLJCy1POzVfjUim26YAttxQNXmb2rUkHCPubSf8JFQhw5ebIibh7Rj1ny
         LuAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/sOug6fXAe+z84Qb2w8wzsLqdVNXZgV7wj8cDzQZVV/+84dJyfduQ8Rxzs0Q/6Y29J5MmAEDv/8zP@lists.infradead.org
X-Gm-Message-State: AOJu0YwyQaB1+Dg0+JlhsgdFUPneZjHnKde4zu6mGz4Rm+GrZe9m6cyl
	oTG+k0HJEgbFcbB+XCEmxHlxWWGurV/XPG7OaXEao+6KphG9PAJN
X-Gm-Gg: ASbGncuoR0aId7E+GtLwTGR7INgM0M3Nuvh0Sv/lZxQ1LnuVRVLTv+vQbgI1ioLrxaa
	RixI68LhtekKqyiEUPj1AKHV20OAxKybLLlLxGz8QXUEwI8StsCAUsmId4E65BEeqaX/8mBQfFZ
	VhBYFygydauF1Ne1Tx7pjQfxe7TcNnDcmO0NMgIcUjD/7jD0yMuBIZgUC7tbM8a9E1nKErw7lTC
	48OPXdOaW5z3HQbBmPNbTimBgU6PW2/qr0Gq9QtVMILOZeqBcC6yc8cRnsJwMDv1bB38UWWFfzq
	Bq6QZnoONZyugqVhE0m5rgQ=
X-Google-Smtp-Source: AGHT+IFC05RsVnDri7hBcipNAiDvv4v04NJxqSjuWjXxYJoiqM5dsFQFv2kFA/if7IL+ERn48ptdsQ==
X-Received: by 2002:adf:a295:0:b0:38a:873f:e31f with SMTP id ffacd0b85a97d-38a873fe683mr1341948f8f.1.1736333122668;
        Wed, 08 Jan 2025 02:45:22 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm16446155e9.35.2025.01.08.02.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:45:22 -0800 (PST)
Message-ID: <7bf04770-4932-4c46-9b15-1326c05cea23@grimberg.me>
Date: Wed, 8 Jan 2025 12:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: fix length calculation in
 nvmet_auth_challenge()
To: Dan Carpenter <dan.carpenter@linaro.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2abae353-5e30-4dc5-a2cd-26dab4db93d0@stanley.mountain>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2abae353-5e30-4dc5-a2cd-26dab4db93d0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024524_532279_19041AFA 
X-CRM114-Status: UNSURE (   5.55  )
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

