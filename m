Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFF2CD3427
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZoHFX6hhsVaG0uAXVF+OQiLV20
	CrfoCp/ePxB0C0N9a+A8gmm8laLIE8fpwgwpH2UekTvizwWbsH2b/lT7D3FxwWxk8KDAJvarURfr3
	/vK23jKwFKGgST0CcXWXGn19cBI1JuJViXpnEHsvzdGDDevEEKfj0ZJqme/VUKS74zcCtkq+Toqc6
	0Fy/BvRiAKlzdQbtVvAUBs8gtQ2NrrIJYqlZTToAjMsCQlBD89ITNQ16kNwA/o9Us6babv/Gm3sBG
	BlUBAbBQPvziNGzcvnTHLIxQt8q+6ZueIbcwOKo0WKYSUk8rbs1QB4VlIrQ7t8YZ7X5hV05k8na9p
	mFFNgrTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCMS-0000000BjHO-2yfq;
	Sun, 10 May 2026 22:10:56 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCMP-0000000BjGT-3wKr
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:10:55 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso20750095e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451052; x=1779055852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ssx1WrRQTIgtEPIk6CUyLjWxq9vXrbpXHPrbSM5rMJ2o39TTwpl7Kw37+58yi8eVH7
         sBH9XSGEU7UXkxKWzBTBNWFh4DnR3ASN4DD4nkmRcjjmhtQafs76p3nS1+XEsjYJokLc
         QN8waYRb4JthnDSSpYmcEJM2CT/HJ9z5M6X1kSvlh8c098rM5HvLrSu+fMCwoM3CQluN
         LSz7cfYmGMD8RXbmt2UajsxGrFCjzfnS2iWGQT+2kUrWaKWMoYKzvsJvb9nO60TUSmgG
         /18bEIb66MsILHACniT6H+zdxlE0jasenBVhwnVdRLEQ2emdCAMkM0gfxIP6WvrIhWEV
         qIuA==
X-Forwarded-Encrypted: i=1; AFNElJ+yr+UDDUESPKuerUD/dWOCLV3tjuTbZjT+kzh3EYWyLTXJftazmnJCm8e2F+H2b0dYIwP1oohdFYGe@lists.infradead.org
X-Gm-Message-State: AOJu0YyJmmOglgRkm+yuXCOAgV5wzb2QGMuq63LfYPTL+ofg+hG6spX4
	qOEMusx1C86MSIJll9RXHKYdKzxmfQZ9N/Om0C9kdKMH/78afXp8twwI
X-Gm-Gg: Acq92OGgM9O/RwMR+bBFgOUcCDvyncPpXnMx4UT82rsfidrlev4Z3hzfS7VuJc2MIuo
	0gaEyRnGe3v6SUXveFIK8v7nP59b4tNuExbLX9Gzhte89KqXGsZGWa3a578CXwzJeofU3HD6jTL
	54IicrFbj8LKPEHk8ANVYYQ48YDRcq3QAOCBX3w2YkgDwkDEI7jLjm9KEDf14Tm08D0d5U8oejX
	R8rJPBbqwDv23B2b0olIeUANXYMGuTUJy1Fy8JQ/cxGovDhO2T+aZxJcev8nZh2+Kg/oLdFtZnr
	pfpJoI7hu2fh+kiKFN8VkuYVyC08RTNCtn99F21c59QUb/b/8xnuZr6OExAWaEOrwrkMtrGXayY
	t/O6P5l1yugXUF+0WyAEh+WBMOGBS4YyXcek2UX54pHHxgISmfLGQqiiAURvxtwxgCELS1kR2vn
	29as6gvIyEC46CISekYFY=
X-Received: by 2002:a05:600c:8011:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48e51e1a545mr332938605e9.10.1778451051944;
        Sun, 10 May 2026 15:10:51 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1e1a1sm48459215e9.34.2026.05.10.15.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:10:51 -0700 (PDT)
Message-ID: <84d3b752-a2da-4710-9396-20b6883fdc1c@grimberg.me>
Date: Mon, 11 May 2026 01:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/9] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-5-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-5-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151054_043655_47E43915 
X-CRM114-Status: UNSURE (   3.68  )
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

