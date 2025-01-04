Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD6E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=L4EAE5Gqv4MSOQ+TAAISeAQsyH
	L6biSrcp24FqCS1WmdgwfKGERMNeFL2SBlBNlGFqa/6ey2DA3/m2gh6/vQh563mrRyyMHFmARcLyS
	X8tDgPHi9pZEapBJsTTypFizoY1NXmoYsbiFmPZudT9XQUISIwUKcSG8x+MJ9qaobcGqgpzgmqysw
	5+B/x7JtQfbcCLPromk95fPA2pKDu3Rq6vaTc3OGAwSgitrBS1tAYkSvBI2Ywa096auoc1SrUn1gl
	VDf5OvoYZOEy3zk2dnOYc3qq93+n+YL4mWZW+cOK9cereE5qFySQ1yop1yeRCqNHGB2NfArk4XWpV
	FxPUCuQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCNH-0000000FhXX-0Y8D;
	Sat, 04 Jan 2025 22:12:03 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCNE-0000000FhW6-0xZM
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 22:12:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436249df846so91700795e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 04 Jan 2025 14:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736028718; x=1736633518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OPnzYUZBeji7or1KIPk5DvC1+eGOpLo89g1KgZlVb2/bCEim2S1xzbxgtR2sWq8oWx
         N5jVWFL0cRsWRj5f+ke2vNbXv2h8/ugjrewgOdn32qxpwZ9+IO+4O2qbXiOowG9kDk1t
         yFe59QVmN8oWfkEl7k/P+E81I3WKyirPcn/A8BcFWe+ijroqUvrAVomvCy/P66uegu03
         bdDqSeoK/BiHDDDAxUxetIuXMd0VwegONxYF/VsYrympuSD878sBjPZcZuRNmMbiTjBD
         RFqJ+SQ8pbP5UNnbPAcH63VdfYArnktBNQsnL6te34JM9RNXlkerixnJw0ARC6NNSVTr
         7xJA==
X-Forwarded-Encrypted: i=1; AJvYcCXrAvhAPMpMmZDM88JeOdugkbcyfJq6iufgoZe9LlkBRdTfJNaYY38r/1HcaexiYV768PeuLbTRW1OB@lists.infradead.org
X-Gm-Message-State: AOJu0YwSlvxWjp364ymV5zye50QfIJXy+iWkpkFD8d0OjMADTa3pUHDs
	I16zfN86MIe4QIJvCBBdZVRCTwgxGQWrJvuWEVKyfjnkQWn1bbIE
X-Gm-Gg: ASbGnctEek+Vkh+FFxBD+eWS2QXCx1RG38pAm0UZu1NP7KPEsIe0/0JWNhehHN8OE3R
	MU8FymySCQMoKSEexC2tsJn3mW1sTf5p1O1wceILMWnmQEtYAol90F7Kvdd8WUkc4nzoylHs2Jp
	qcpsyp/0/BMxB81A2TTXJBAxZ3DwtQwjkBuuU9HWWENic5FdTkgs1cSewoRf4atdv7AxwmR0U7P
	9h6OXUJqiqmUdkd6uK60OIjWixu+MNetXr2Bi640O+8nAtyX3sU/VzP5kLaM6GMrC9Y7Hrvsz8M
	V2wmVpyb2BLOhPiKwnDYfhE=
X-Google-Smtp-Source: AGHT+IF+/O2w0tlV5xbiNSRXYkEgK4eJ6bNgAlswjUBk8c0kHkeMrsSP7nExVbh6SG1aQluYjVQE6A==
X-Received: by 2002:a05:600c:5488:b0:436:5165:f21f with SMTP id 5b1f17b1804b1-43668b498ddmr417778835e9.26.1736028718410;
        Sat, 04 Jan 2025 14:11:58 -0800 (PST)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b417afsm562520085e9.36.2025.01.04.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 14:11:57 -0800 (PST)
Message-ID: <38bf7ad2-cdc8-4ece-8e8a-03e1c3863c3b@grimberg.me>
Date: Sun, 5 Jan 2025 00:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: remove blk_rq_bio_prep
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20250103073417.459715-1-hch@lst.de>
 <20250103073417.459715-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250103073417.459715-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_141200_294508_9C8343C4 
X-CRM114-Status: UNSURE (   4.92  )
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

