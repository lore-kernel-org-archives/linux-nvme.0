Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A5CC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=c6P9zn/5pk27AIu7F5r0n0CnK2
	pFEP8friT4aotux2A6dGRkEzU4H6TL4+AA7wSg4P+4/d8KD4hskRlOD1ePWvBfp+q/O7HXiJ2jdgA
	ZS/C/GGWGULw+J+6jZyNI64hIw9ganKc+VuEnTaCkHSCh7M6dfFAYla+DEi1m9+uLvGgYY5N2Yf1q
	XPjpBGWb3iz0QrUX4YsFXvQ9CXKD4jIHzbk5lq1wFeNFQC14KJ5cD4DDp8s+A2GXKZguSpberNQCc
	WpjUkH7P1DJDtaN0O9CWhUOAhSChwXKLYgCTl0PPnxrEYAkGm5l1B5gzhvhbyUCqGImDzLBBr4fuX
	iV0PIApw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwTR-0000000EwaP-12EY;
	Sun, 23 Aug 2026 00:54:09 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwTO-0000000EwZV-1BYP
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:54:07 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso4056402a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446444; x=1788051244;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=puiuGnex+SXrT/PUE+zV14eQbAWokEdEHA+8Au8hpTH8ldtqGqTYA1oaHsnBPnUEZh
         o7JMF9/FYkKifeucVwPC+d+e0nvQfHp3e2PWROxuNz2imuFN7iKuHVvOOGk6froGPAlH
         MvErm+A3OS0VCHxwm7AeIZsOdYf1PINNP2RC062gEOy5HlbQD62l6x4OaS7JFZS+Fv/3
         w+uvnXpE3/OmLSU1MCFufdOLQeIQtqC1W9jhq0/iDiN8m9KY4w3Ogapp+oWxgCqXjdo+
         sgMxtXIxqvIj6cDX5QnyAd9n0uGwEASmWMajrA3ZV0sh3lPC/jz5Tj0ySosCask6cCZx
         IFgw==
X-Forwarded-Encrypted: i=1; AHgh+RqeVXPINLkdo0nzJiV1QfLtcktftvUyhpgJDOpqNJBTiqNjLvQinsOOI/Q9r/elkmyGa2YSZ6DV5sqW@lists.infradead.org
X-Gm-Message-State: AFuF++lVGCyYeaIVVzO+tbeEKUXQ6U4pt3WTGgao/7j8boFwgUGElRvJ
	vMsrVq93YgQ5JPKvjSbMP75Urknm1r8Y8vNC5pRQp/wiAQYDljnft1A/
X-Gm-Gg: AR+sD12YerrTz0KKVU9G2xE4vE9IcmZb+L/a9jroTS5hAWLZJQuchZVpIbUOt3sLXfE
	meTxWAZIlG9A6RyxkqXBTF1gNplFU5zrqdrPY3SS/HtPUqXHcUFuOglRqAhjsKe88+i2sU1bdKW
	mUmCTJOm7m8iWWZUnvekH+vjgUXqgI7hsBa7yEQZ+T2tOHcmGM2gLJ2qAA5jv/fYb6m4WU1K4fQ
	uUjtjVN7uTYZIY9Kfy7QRLbQUCfVxtnaDa9JRQfcABpAZu0HzOuCiP+8OztvgOi27Jf4b1f6OHh
	PnpwCM5LF5KyIN0JNL+GCuBlQ/PfXKEw9FZRTi5VKQktue02ulpjzGxgibUbihdh/MXg7NzpvCy
	J78Gd+Px+AZKCVZzMEbPgBt++2blwblvlgeV1xiq2DG9bqjK++YfuMSx4A7gQAu/M3BvHUrZXRn
	PK2AaMhve+os6vjqOMiauwd9Ha0wXcVv2RacGlyZwCv5XIWfM3qz/43dpzYro3N7ZTU2Cgb9If9
	ChGnF+UAiiNARh3l2m/m+Qz3X4BY2F0ag==
X-Received: by 2002:a05:6402:5406:b0:6a4:ae0:52d5 with SMTP id 4fb4d7f45d1cf-6a42f0f7629mr16835084a12.2.1787446444545;
        Sat, 22 Aug 2026 17:54:04 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e025609sm547690a12.12.2026.08.22.17.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:54:04 -0700 (PDT)
Message-ID: <0ea8b1e0-16d1-4111-ab04-1a96e97a9766@grimberg.me>
Date: Sun, 23 Aug 2026 03:54:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-6-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-6-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175406_321125_2D3FBA9E 
X-CRM114-Status: UNSURE (   4.83  )
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

