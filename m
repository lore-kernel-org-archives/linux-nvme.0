Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2789C5321E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=VeVHDFGGm8TZZOrd6hBfKOUP3m
	plC4Qo5VT89dEJwCnhQG/+oIBjYqjHkDpbvNPpdXZnKsY1yRR4f1qo4JGxhATUFuN5zv5FN2SWW4A
	dLc+eGlrAj0GulUzUOd2r6gkUq96sBXtqRTmOCul3W1Gd0BuujwqukUVoOClw4W8P2tBRrN+K99he
	5pqK8LC3K9SxYToqyvf+dzlHqm/ooZbnKmPlJ72SIcnyvXFi1F/n3lbSsW5372kZ58MmtCdroHj1Q
	GlcUVaJo4CbAmnHDW1k7NKteMx1d3uORSsn3TEHT4/R6kMyv1FY6NwYkB61sGQhhY6eC/n8J2QvQx
	o43CugLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si88G-00000003uWT-0RjM;
	Sun, 25 Aug 2024 07:57:52 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si88D-00000003uVA-1Mew
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 07:57:50 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-429e29933aaso26688705e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572668; x=1725177468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jp16odGEStbZNXvhDTxRWK+pebEgwvH8VXsPg8jW2Qq4kHNahSaWPlRB3C+78hcnAw
         aq5QQp6IuXXqocaYE56jd8+KvIXNtHnAn+wvxr0Fbkg54kShHYCENtVSALW+uP7Q2nhu
         U25MY1d2Ggg7wD7187LaOtd5YNLJ/zPVtPss0VbIlPDeIRRGKcPTBraCrMna+/6APfwH
         tKpz/tNeH5tt5D70LptJqF7i5eVar4HHN4dXSBCHKf9abvXfUxj6kFFZMwarzf32PZJL
         sEhoGCgWZtMNfa7H30tsuugj/5X1fAKO7xQqdq803TweKA9DNsjkGQ63t7F1NYgR5mVJ
         Yvvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2byEngrvL2b7ZnEjiZAM9cGpzQq1q2+pdHeG01XgvJVUige1Sa/X9zMYcKP096b0NhgHoZfCSuod8@lists.infradead.org
X-Gm-Message-State: AOJu0YwOCBQ0284zvms4C9o/NYpw1l51UTcYI5o6HJemvuE37Luww11Y
	nmiVJUhah3rKXdlwBCbGTtHKh/HIgBez3xlAwMa+O+SIP7aX4P3s
X-Google-Smtp-Source: AGHT+IFq17EpmluWjsag+gmDhyIK4eSsoiKpB4AM0F31vTSNp10z7/Y7Z6oeTJ2d60ZWn4+Av/9t1A==
X-Received: by 2002:a05:600c:154e:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-42acd540c6cmr47928765e9.4.1724572667141;
        Sun, 25 Aug 2024 00:57:47 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a2f4sm8109941f8f.61.2024.08.25.00.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:57:46 -0700 (PDT)
Message-ID: <46111a0b-eaba-41dc-836c-8a628a4e2ef9@grimberg.me>
Date: Sun, 25 Aug 2024 10:57:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] nvme-pci: Make driver prefer asynchronous shutdown
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-5-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-5-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_005749_368560_E5665282 
X-CRM114-Status: UNSURE (   5.30  )
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

