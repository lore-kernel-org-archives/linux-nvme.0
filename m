Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74EE7718D
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=IfEdYiz9N/BkcMvhwf2pLX59Xr
	bpvo4o1iSlB3ZmS/tfwTU78s+EyTY4gEQJM7bU9Ae6hrYBFjY1t26O2YXCNkkaotF1TIvRChpsHAZ
	SJzzICfL0EjcQg5Nx9YL7hYZ8zUNGNmsHpFUai5JImZeDxLVzhgR6esa/StDkY9t54OrsL2D8HKdk
	PQkxmKl736Ab5svAAb4bAYVQQAS36CLE830Z6DIPBoelaXqiN6IzEN8DRud6N3TQuB2MHr4W6Tb7J
	DCVKl2DsMjk0BoRJaV30ZGiqKspU26OnUQZRX7M+OV5aDcxOMDpL7nZ3AJv2u2rTsyVxqkSOtiw/a
	DUS2aWMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2QG-0000000BnP3-2BGj;
	Tue, 24 Dec 2024 10:45:56 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2Ni-0000000Bmvy-1YHa
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:43:19 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385de59c1a0so2997488f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036996; x=1735641796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XFGonuxwfvSWVzrYFhYMDS40ZRtByCz4XQr1WhVqPp2L6apOOlr0TEG0Jso0GHQlFr
         XP53TKmCwhIIK4wWPXZ774YcSDsH5r1SPLpukUYDjaEgJ8pFICjVDyJ6SPZCVUiHePc0
         NFkDVwht/W2fvdDs17U3LqnTNqtnhdrTYR1vLJR9yTYioVaXKI0SCLCFSiV9XSR+Dhyl
         GMOEfhMZdGB/H820K+AdlownwC/J6zCzQFhUQW9MZwwV8uDEe+noIVGB2JbcMifypCc+
         /kIIva0lTj/DcpYmXarbmQ6hCWqTjYyhuk3peaSXLDQKnndvoYWBmH3dtSha56qGpowQ
         AuIA==
X-Gm-Message-State: AOJu0YzMODkUd2xr7IflLx44pnemYUemthmftUA8IWxArHAIsq5PlugN
	LhQ8kVf5X8kHcsKVw8i+ObTwy73nZ1uxdBrT6Tg0xjFLuA1ZpiXwCqzocA==
X-Gm-Gg: ASbGncvQMvbWxWEzwA3ZRS8luV8lY+kwT2Y/WJNGrWVaZI8nxdL+p0nvMB+hn6VoF3v
	EGo29+nqpMBRRRRdoIQGBw+8Cta6Q0f6b3OS54btCZu0oMkc9Xj7gV+YEHrWWryZvyrbRas00Rc
	UUjflM3p9fEFfS8lT+05bjVeMD23KVene3t12NsJxNbs8GmwWIapuYVm845zpMGiJVTGELk021F
	cEklXfWx/fUnTtDms8Yi/x3mpWS51oQad4Goiu7ufaae03FPmDJw34PLk1GR4gENM5zeOIiNTNu
	6ghGnyoPD5FhrhZPGKH6X2s=
X-Google-Smtp-Source: AGHT+IGyD5nlfSTY5DVLa7WtjBsAFG4kIpVcCbi91Qu18hbrJlYv8tEDp2ASbDcwOPkpjoVlhNKtNw==
X-Received: by 2002:a05:6000:704:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-38a2213d33emr15517648f8f.0.1735036996605;
        Tue, 24 Dec 2024 02:43:16 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661200abesm163155975e9.18.2024.12.24.02.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:43:16 -0800 (PST)
Message-ID: <bb7caa2a-b178-46f1-9628-c33d839b6695@grimberg.me>
Date: Tue, 24 Dec 2024 12:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: propagate npwg topology
To: Luis Chamberlain <mcgrof@kernel.org>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <20241218023325.3671826-1-mcgrof@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241218023325.3671826-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_024318_401431_0BF79861 
X-CRM114-Status: UNSURE (   4.27  )
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

