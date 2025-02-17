Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9537DC021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Clu+EoHjBxJcfD5TrqVXOdheuiqp8sDEMUuqcD2+M2w=; b=TN0DUCgsA0wPS6GJ4hMwoJYk/M
	g16P62Lr/SF/OdlKmU7WDIwM/OAELA43e1ZGuoDfJ96KMIqThOgKb5fKATnaBkVaclhYdD4GilnVR
	wZdYFPVXIH9kIY9YhH93RpO7RJG+fxQRkhrZkEdEIruVgY5CacqmWbHsikehJq9ydhjorA3BtXC5L
	N3XaTCREW2aSJT0tILwCajWRrkKj68HQ7YU9kzVp3nfTCICdhWIQsOUWidw690IvaCbblbFE7EBVo
	ucKVQh2I2fuxiWh4FCY4+GIIcnGNVhOi1Tu6iJjfLS5TpEjHgs9qMH5bazo4h8TREtknc2YFQCOzt
	B0JcyvXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjw6l-00000003gqC-0UMW;
	Mon, 17 Feb 2025 08:04:03 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjw6j-00000003gpP-3HYf
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 08:04:02 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso25579945e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 00:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779440; x=1740384240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Clu+EoHjBxJcfD5TrqVXOdheuiqp8sDEMUuqcD2+M2w=;
        b=t7l9xQ5nAZrRy6cPhXwA6nSfQqrz6prtHVFHJlc107gs7t+To0s0g29x4eekTx67mj
         Bg10w2bZkI/Rn0lOn80Mc4mIoMhRUUkMe+UxNEn1X/LsG3wnL/CP0yXVQRfLc9y+l2dC
         IXbu0QCdHa3X7XqVeEkRjfxAvS+hXz+BxzTsrV6VmMWWjtzEJ0wxiewRU4gOxX1rUFKZ
         rzVM8dBebv8VIbtRtZvMICjNUjXW0JehJ889Ctywp8IeFPb+mHXi4gp3q1IgyNTU4Ylw
         K4LsKuVQdG+BQr6tA7dUBmwoP0zKk0duf20RCndRMzIPHVYcwb5YIp3c1XBR4dyEX5kI
         uxVw==
X-Forwarded-Encrypted: i=1; AJvYcCWnqhgKmHa2VAssbL6AQOp+s9pa53uiXID/5E56YesrkJDozerqvZHwnFpaycT7c44jsp7Ty2nBjOi6@lists.infradead.org
X-Gm-Message-State: AOJu0YxEt5C/+fUdY85irSyv52n9jxa+8xftrDHbdMIpLwK/JRt6VrpK
	aZtCK48298+yH/S05YJsd6n6/21So+BZnYDvUOa112TniS4CfITw3RpVLg==
X-Gm-Gg: ASbGncuaB3cQsJ2HyOJFHHxNjmf1o39etzDbHrlvudl+x5li2tJwpaQCVV1bVzGRtDf
	+/JHxDI6P5Sx/zFxtHtVKW56EwVeeEl80nKD99+DZMoZH0XVGrd6okFULschmGNf15oSrCP/Hl8
	5bjVUjnYq4sgjNCvQ3fvPdhDxsisNkMFix9CGio8vOlflOivJHo9TmywvaMO4ZDSJqIX4QzGvDW
	aRAP7k5SH4UcanMKw6Pe0LT1A0RHYBwv2M9hRfPlDtf6TjslRd9ASHKBR/0x/ds42uMWHby1hHc
	AeVp4p5iDP5dSa7rCVT4SaiHVs12esf0Rakxs9o3/YbZFrXEovwX3YVOmw==
X-Google-Smtp-Source: AGHT+IE5YB/Re/orvAviO9HvBA8jvAQBntA0x2KnemPCZKZ2Ivr8k8pctu8ZGtACwxpj9nK5N0026w==
X-Received: by 2002:a05:600c:3ba5:b0:439:3e90:c535 with SMTP id 5b1f17b1804b1-4396e5bbc42mr89837375e9.0.1739779440232;
        Mon, 17 Feb 2025 00:04:00 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396713feccsm89454285e9.39.2025.02.17.00.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:03:59 -0800 (PST)
Message-ID: <17b366b4-afce-4f65-acc2-235ef9bc52bb@grimberg.me>
Date: Mon, 17 Feb 2025 10:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet: Fix crash when a namespace is disabled
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250207124134.114622-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250207124134.114622-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_000401_822336_89A8C780 
X-CRM114-Status: UNSURE (   5.47  )
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

Looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


