Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8E1C02192
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0F9Ft9duupMKnmMyP5jPMsjU4U
	/VlQz6SlOrMxwuUycbcMA8RVua8rLXn7+v5IDT/58lmfQnMPofTB48THZd6Ms2t07MLPASytQFXFt
	4FPA8z/Q0baawxGyfiZnWP5PZcBbiHpGtjeBQYiJrhojrD1mcBiyQXknIa1aPQWdiJILbTzbapWr5
	6JRfXfCwqy/tbYg4nyAzDdi97JTG0OjLYFwDKq7h2bScejkm3ZD4TSFskFAfgiE3yaSP+AvuOCQTk
	2PRAOcjzKPp9WmPCyKxy4TxDLVSMHd8tLkwWkq6Ao/IIFA4FOwXXWLS1vqzGEnRfmQdYRdKOYSzXb
	wkJw9YJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgcJ-00000004Kg5-3OkP;
	Tue, 28 Jan 2025 08:06:39 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgcH-00000004KfG-3YrM
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:06:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43624b2d453so58016235e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 00:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738051596; x=1738656396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DOKUMUCYbnPZuU5qpQQnENTpFF53cutqzHOK3449x56foQ545MmxroAUH+hREYhxSE
         iWktMS+goSJme1VSi3naoXn6PZyBu3njZBIk/MGpHcKEWeEaqy9nYpyIFVMqlhhCWbSA
         KdUTn+fMGbzonvfwJWFk6O1X2cITO4qQDfV26+qpS7OFejAaktnoVv17LgTZFvJ4X7EU
         bgl9sAVy3/3OkhpU7aRUnbBWuWWqKxM5obgD4dtL0R6eB7NlBnJkD7I/Aip1Tp/2crgS
         rCAK+GtW3O0/WTyR4F5jWLtuYFvF3Azvu5CRp4mDqygdd3C6XtEVAmGGBfeBh4XP/dDq
         /bog==
X-Forwarded-Encrypted: i=1; AJvYcCXGK9n4b5wD6Du2D3b2OFRNQ9VhWyrxfWqIzFq7e8ARxXOsgArkrOZ22/RCr5B34SA9PGnpzs1oNF7P@lists.infradead.org
X-Gm-Message-State: AOJu0YztatqZp78DDt3STb3Ba59kiM/ob+6cO7hoKUvv/DQqtiaWnVBU
	YgNgZenRafIrdQt2LOLMcm29Cu38fFoY3sYbD/lhygeJvMYJMf+Y
X-Gm-Gg: ASbGncuUbVfDU0gXIVxDZ8MTiFRMEvgnAb9b68drOhEqQqQM9zQSgRHJ3WLZj9C1LK4
	1q4qFp/iJEY+qf5T9Sbi3sDeSPsrIjb7iKvsejIHY8eak1CQpw6DytlAcqqPFwY21PsqSGAKmvP
	7Bd5G6MQHVV0OmPsogMPrvvrCTvid3BdcyeHwMTkWhPYFOf43FHxtDxabxdGofxdTiKSXd2pqYb
	Mmj2gWV/bEOjCRhwDl4dRoHXyLntBtCNGPqYawSnNnSLNn4U9luDMMtwhHFy28nEAHkKvW/6NMZ
	bFYZNf9Cwjza2hrE3N7I64K88b/9yupMPII/Go3TzcYTggTUuid1pS4L2w==
X-Google-Smtp-Source: AGHT+IERyiJDeM4osy3nD1vu9GB0SzIZg6c8R/DOVTfluvwjlIA7gUpbJNDFOV14HzAZuWqUHiuWCQ==
X-Received: by 2002:a05:600c:468d:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-4389143b715mr382187575e9.22.1738051595989;
        Tue, 28 Jan 2025 00:06:35 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb02dsm13375336f8f.70.2025.01.28.00.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:06:35 -0800 (PST)
Message-ID: <45f2d295-d459-493c-9d23-34758cfba64c@grimberg.me>
Date: Tue, 28 Jan 2025 10:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: Do not re-authenticate queues with no prior
 authentication
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124114738.115882-1-hare@kernel.org>
 <20250124114738.115882-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250124114738.115882-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_000637_883011_33E8DA14 
X-CRM114-Status: UNSURE (   5.18  )
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

