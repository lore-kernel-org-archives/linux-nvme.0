Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7B1E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=GTqomsl6Gpf0xUOzQHmA2g5vW/
	L7YlaHHC2SG3Cdjl/vYaFgdCQhjmnTZyh6G5Fy7eWRHDoU+mesf5F8whnhElZdpqh4sAvJ2uoOTHm
	DF6k/R0JmzZsKpKH7vEAoWLsOUBRs8dwnP/UZOZrI57yHxGVqOs2ZJMPi588muKvd7oxlntaM6e57
	v1AhpowjqZhSjx1Fex5RHRVocBwpNrlMaivyz4OAZ5pFBJuCFSHpD9KALnd1Lu9JStyUIoLrHQjLp
	bSmmDh0QAhrYwp7zFcwBZyPHslu+xo7FzCPDjkYaLuEIqT4J1+QyU+YZJPx7x/7XzVEimAqrbilLe
	IH43xYfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ37d-0000000Brfo-0hPm;
	Tue, 24 Dec 2024 11:30:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ37Z-0000000Brdy-3wXu
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:30:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso33207635e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039840; x=1735644640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=W2P8HCabBTUJtAvhhaSjByiK3F/gqwYs/Mi9XGHD6yAseph80sVQhSRYdpvx1NKa6K
         8qEwXspMgeNylxjVntNblEPJ6T5tJTFGDfG1U0TNRQVldZ2OEl3OdPIyH/hQuEh6GomF
         25gmC2JtlXleJWYT/bYEjTcNd0sc5njCLGAPY8Ho9C17T1mKn1KI9t+16QjuYUroEpp4
         gSFEmjT9u64bF904PZSpuhzIrk3oZRLIEwPMmhGJUMD8P8EPyOl8paxfo5xVtR5PYfa8
         rHwEfNPPNOI+VtOPwlrbC2SNSIhvd1t8iC8EyzhfV8Sr8nv/S+14q2iFkXxPKy8a3ROj
         ziRw==
X-Gm-Message-State: AOJu0YxfbSppUIWef3AP/oKJGAiAj2yKpGVqsOxdkY1LFUq1rUytjpwN
	QoMCdWjnhdwpB5BumXtkOvI28WcAZLV9+B4ByAEXLOf91n/0kFY9bD9ZHw==
X-Gm-Gg: ASbGnct+qVOc9nC9m53mNjgeOJTlX47NmnT/ERlGYMVoAOI0dxbDnXOkM1YtN1nyUur
	dCJnRUTYMleWZWH9IMF3FwoOy6xahObhSCTDHF8G3rySIHIubJ2OQ11sa3itt9DQ6yc2lBuXiGl
	zITtlcbPnx6sAXXuLDE4tUGmdqFDI/C95G7pv9V7DX/fhzUAa9off9ZfdkoWPG3DoAQ9qu2cyj2
	VP2NVGKng4W6wNqCUUdTeySznPspj5TBwNxT0fymTnn6USwhoSrp8bMax8bzEB/MCIbBwDF/1NC
	K9lItPbO13XSGYgO9GbYc4s=
X-Google-Smtp-Source: AGHT+IGON1cCd1c+ASTRJEXqVt8gbt5oxGjUsA66jeZ7BF2DezeEDJWmUG0pxfdldeg07O1IYUTwOg==
X-Received: by 2002:a05:600c:1987:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-43668643a39mr133733165e9.11.1735039840284;
        Tue, 24 Dec 2024 03:30:40 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436840b35b5sm18160945e9.39.2024.12.24.03.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:30:39 -0800 (PST)
Message-ID: <cd6ad041-3a7e-4c87-8d81-1603e8aab935@grimberg.me>
Date: Tue, 24 Dec 2024 13:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet: handle rw's limited retry flag
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20241209015344.60861-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241209015344.60861-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_033041_977541_3F8F7042 
X-CRM114-Status: UNSURE (   5.48  )
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

