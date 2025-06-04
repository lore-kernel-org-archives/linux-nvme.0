Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20BC5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FQYoBPF7L5jbKxTdEIFUVgTNpS
	4h2hkac5kW2JFXPHhPozGYe6FBp9ziUDXvCMVmm9tl3cZAJalrGc3Cstdi40l5N7GOPiqTsieNgqL
	7/LEjZq28T6vpesaKIz31bqTj2iUvshw/9KHaQoCGHiUZDALy8xU5NvuEDzp+M8PQGINVeNVZEif4
	n75+26hKR7VEs+z9I1Wr5WIoXD3wxh+QRPfkiZ/V263HgPRlsLhCuiYO0DC3hNe3zYlGoiwjXOMnm
	lLK9fo8zCQ888alsYrDNKE4cAIJ0fkZb+TIWtJMN3Zjk1OF4Wz/nmOs51BaWGq6ceD2GG3KvCjO9l
	ceAx1Jkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhxN-0000000Chhk-2DfC;
	Wed, 04 Jun 2025 06:50:37 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhxK-0000000Chgu-28Cl
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 06:50:35 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so2770500f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jun 2025 23:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749019833; x=1749624633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rmfLjYD5aTXtVyWij56S4dvzMMcSMGIi8wWGdpIrHkzok3s9neIvpHI3wtQEQqkjWw
         sTEarAMvurvaxFLHvxSReAXYwApIvESVE5piXpbmcnj5GdDtMmhd8KzjnUXUA667HHsQ
         NzNW/OR2V/JkzLMvT1/WDQjJVNYO/N/5Yr44+fUFJqBK3NBON/qRpgr2ohYoe5IUYy5D
         tYC/YEa0QGRCpRNTQuN2pB+yxdKt7pvqLBjwt0HBKSDwsjf7Nm9+Wqg0AANKxfDWQIPX
         bqyZ46PV28NlcAjrfCC6lDCYngP7Ghyg4Xs5aCaL7jne+YevClWx6hwXw0x7hM8aZ6wY
         0Lpw==
X-Forwarded-Encrypted: i=1; AJvYcCXnQXBwGfB3HbdM4bvNYZM4Zo7EsK3PduzM3ki23HfPPvE/2pibT9mvjgw1ufSGLs5RzRkL469R9TQl@lists.infradead.org
X-Gm-Message-State: AOJu0YwCbCyYhbDsDMatm6YuCS5YJUBN96Zo8+ltqh4YATei2g1WwDot
	lRD8xCR61dgPErLYIxa7gMnC919J5bkjbJj/ZNm935OKTp7yanc0Ph0n
X-Gm-Gg: ASbGncvbyXZWDd68KPDu+heMjSIpQGEgyd198InLsyti2aR7fDUEf6fY7vH4/Asvd9E
	h1CU3b+WtVC2n08X4yv5cg+yPDtBtXfeZcAnT+ZQU4k1vl3ie7AwhLj14aQpf8xAVKXyzciLFUd
	4a+iRviEIkcvSt0Ys461/dI8Q6ZAFykWX8ys+SrQP+Ip6NDxcC4unNAj67Lh92FeoyXYX/9ILjF
	7y2I9eBpAMqEn0XioCdF89VYdpl4SKjqKlnMl7Dx38FLr4/rrsAf6q8IaresRLNnMaBSCuNOG/r
	zfjwxhCTWgEhKfCihvd4ki8NwJkFKEwB1Rat2wIlPoKDVwn1OvdaGaEecEsspsyxqTPVvFALTQh
	BAcBgSYS7wv4R0qIPvHHosXdm/fU6
X-Google-Smtp-Source: AGHT+IHfD/G+QQO8ne4bq8n5uBqD2enofhrmAoMSD+2nK03PTyPu80G6yaxVwK/KuK8V9d3Dk7AzvQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:dfa5:325e with SMTP id ffacd0b85a97d-3a51d8ef828mr1123199f8f.10.1749019832468;
        Tue, 03 Jun 2025 23:50:32 -0700 (PDT)
Received: from [10.50.4.239] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e5496282sm33479705e9.1.2025.06.03.23.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 23:50:32 -0700 (PDT)
Message-ID: <68a732d3-f546-4405-80ef-0dd5ac58fa12@grimberg.me>
Date: Wed, 4 Jun 2025 09:50:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue
 config fails
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_235034_555560_066D2327 
X-CRM114-Status: UNSURE (   6.27  )
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

