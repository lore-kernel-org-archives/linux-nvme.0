Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E303BC54754
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gkpn3xaIBbZi1bxxpLiN+y0w6dCFyLFgmm6rxbmcas=; b=aAkHiXsXO3TU/5UXQkEQA+DjJq
	4IoyMl3+l3Ey1UAmjavWQqOz4wtIlqetp84UbUJTbJC2Sw9VYLGV91qlVI+VGf5EYJ6l1VZABSF1g
	A9fOpi6mGxc+dtf6BATWzbI434l2Za+ZxoXQxxaGutlDNqGPl/bMmZciQvw/weREP64tyBgx3PNV2
	FkgcoR4O6Kb0m4ScVJFyZCFdaJTX/hXd7VEYUgJFwNpRsGvlgbg9LKddTc6Zik3IBDa8VTf0wmtjp
	+hYuJGsSqu3fPTydmxY7ycYxVChcqhkXBxPahet2yQ1SnYzQ5rbm/g8bO/1cfZVLyvtWDc4AGdcRr
	KgFxzZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGOD5-00000006GEb-2xyB;
	Sat, 17 May 2025 20:32:43 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGOD2-00000006GDs-2ySU
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 20:32:41 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso2203942f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747513959; x=1748118759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gkpn3xaIBbZi1bxxpLiN+y0w6dCFyLFgmm6rxbmcas=;
        b=aTP4NmT0XR81gDoUAQ9RAReJ5SWUIqjWSTvsy2uvv5Uyx37thlgZ32FINdWquG6fFe
         ucmqlhSKCeLvtmhM6X7vc+JdmLVrhzePxkQ3JTZlvQD+YwjikE6eTJFEpIRmpzF31Kza
         wY4tgO/bUQ2VnJg4x3bCWjZ7ImG3RSJO55Lm6oNdDCUcDJpzBKWPwoh27GeVVb3wXSvY
         3IfGh+YgOh3hc0UFf82muJZY2alfyPHR1aLkpJaQfCO4ox6a7t+PritUa+LpZSshmP1L
         DSBFgl0H0AKzd5vjp4cpFWfIJKoYtE74KdRvaD+7ElSEZrx4dV3uqcurjdEsiK4pirZ3
         U6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzZbahci/Y6aqvuk/XLOh5lhPFbrjZKqkG+8vlyJ9TEk8qI1pU9sYM7c79LPWYqVVb4tBVN5hQKHwd@lists.infradead.org
X-Gm-Message-State: AOJu0YywPIjADbYzj4X8y7ypuxEw0zfUjc4EAMl0RlzDHAPybAfRDlnU
	8iyBwi1UzFErjKe1lk4Xw32fwRMGhtWybV/ROhuaukkvc7fULY2jO6C6
X-Gm-Gg: ASbGncsbR7cbXx+pDMy/873BzysqlvT9kGH+Qv7/cLf08PAEfiFq7aOSXqMlQ5N22yq
	IOxsUEaO1N8o0k4TVQMxepPShna2aKf/Fnl5Z+nvcsTGQoN7vUQzojof0WVpJoPxBPCYd6Eozji
	INXX9mO0aT7fcnGYtd8XioCoin5aH2mwRidCViY1JDQ99KgI8NqyeH1752EYJUmxjHewU4q3OSg
	bCDulgZoGkU6Qf83B4guk1guX+9XInIsV1BzAqdbaPDWDmDZbgv1vO3LxjyLSENCe9XS4zJVHAJ
	Rbhr3z6Rz1lzfGnY/3dvav3u2hGuqd+BNr9w4gnLyODxCWXYpyrbyo6tj/3irDUu2Cf1q5VWSyi
	jBKJvoBgF
X-Google-Smtp-Source: AGHT+IF4nmgt7DDatNcx/D0XJAtOOMwNnYCOY/5VUcm/4MWcQgU0UcD5GNCZqqVa1d3GOfAzhn0v3w==
X-Received: by 2002:a05:6000:4010:b0:3a3:6b07:bdcc with SMTP id ffacd0b85a97d-3a36b07beebmr351310f8f.15.1747513958838;
        Sat, 17 May 2025 13:32:38 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd515bb5sm79959715e9.23.2025.05.17.13.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 13:32:38 -0700 (PDT)
Message-ID: <ca77a49b-e531-4ebe-abfd-c2f962910943@grimberg.me>
Date: Sat, 17 May 2025 23:32:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org> <20250516053100.GA10488@sol>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250516053100.GA10488@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_133240_748708_CA6AF2A2 
X-CRM114-Status: UNSURE (   5.73  )
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


>   	if (queue->hdr_digest && !req->offset)
> -		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> +		*(__le32 *)(pdu + 1) = nvme_tcp_hdgst(pdu, sizeof(*pdu));

I'd move this assignment to a helper nvme_tcp_set_hdgst(), especially as it
has two call-sites.

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me


