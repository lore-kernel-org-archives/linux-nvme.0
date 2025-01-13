Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB462C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2P+QWxXeHpWiomEDKftm06txfS
	/VazwzNRgYP0lwJSH3jFvk/ydv9KqsXFiiDv8Q9dT2qbuzL/1YgDuPSLnf6qsBsrR/9bZnzSycgDM
	f0CNd+Uj4WhdpXfqzjaP8qWcJZU2b/opqGJWwYhQslE/Vz27Q6EgLgFqfwYCoXU+uobuIiwJ0XOXq
	JU/5V69sQ93OXJ8z3ciR+FBzCYXKB0xroKsngn3SODQOKkDtTvOqmTOiI09690gM9f0ec4uHoW2uK
	ZnXbp536ULf2sy5dXIIfH+rvTlpcaVKA6RSY2MmwOTd4vkrNao4+kVnD+bfzbGcYOLZqqLcJstIrA
	Nm2hgqGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXQoI-00000006Wjx-3h3e;
	Mon, 13 Jan 2025 20:13:18 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXQec-00000006V2p-3OhI
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 20:03:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4363ae65100so49632535e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2025 12:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736798596; x=1737403396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=n+1V0HSelIP/HXp0xPGCBMmFV2U+XfQeA5oagMKultOjfsWKZ/xLbA2opzyHfQAK2S
         cWiCd6v4UbLB5296GMiM5IqErSkRz2pLWVhpHXZZmtW32btDIJn9pUeFkAqOW0FdnCTr
         45/vYO5m7YsiyKPGSBbDGE4V9VUAUW1YmHv1Dl8rnVyvD0oyycSmXWPYKhYhBbW2QKyl
         Km5l+MYzq1y1OiSKDjg354WJyFTqtCoVPe/5C4D3H61kMhM8Jb4FEdRzUKEvTOPmGOfm
         r5HcPOmfmlcyeeLTBoC7uNlyQMNuReejmGfg7Aum/pXFofnnGYc5exCW1/zbzXgid8re
         jKqw==
X-Forwarded-Encrypted: i=1; AJvYcCWp5CiPWIPveu/SGaYnGWU/YPk/yWvd2NTGAPjl4YrNVsu79SHwsBS8hzhXH0Wd2K+YoPlVNdoyqgW2@lists.infradead.org
X-Gm-Message-State: AOJu0YwA11l4lmWHTN9wj8MJGfpOPzPu9RIVlqrlVsRmhYctdP3PqfxG
	qUSDWeKWEaZNxX4/g89tB1UAJSgc8MbcnZ/0Z5K8iaoBH9QGTIGu
X-Gm-Gg: ASbGncseHV3yGs6TBPo1hzrPmC8S+6U7tTtx1xJc++q3jUoQy4ymYABIjiHYfFKhk7A
	eFBMAwTuGg7YoV/ADzOEuPCTMwsyKwJAuJ0LlMHLhvHuontzSkdjxFf2PGva/WHwa3JrzV4HbsD
	xbE2yCcQbQnc0F7HBlYm55IX7m4vHvgpgKwXHVNQ2hG2eeZoVKS5jgcQMbp9t6r3f4hKDFU+N3o
	8lVE1HtDhVpqekXEmXfqlUJwYe9EYATNUg+MGPFK23q5YhlI55tbDB3n28FlBrqg2RH4S1MLKqZ
	e+fyFvxbEs5DpQLS
X-Google-Smtp-Source: AGHT+IE1uMggbB7PvRPJ5io5DgWNYZ7PYHpeqiVC7q7DGRcKENAzZDmCi1xPao/iMbzGNsGNON5qBw==
X-Received: by 2002:a05:6000:188e:b0:388:c61d:43e4 with SMTP id ffacd0b85a97d-38a8733e1d1mr23400854f8f.45.1736798596309;
        Mon, 13 Jan 2025 12:03:16 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3840bfsm13223677f8f.39.2025.01.13.12.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 12:03:15 -0800 (PST)
Message-ID: <1015cdf7-b844-4084-a641-f4ff46c7e8d6@grimberg.me>
Date: Mon, 13 Jan 2025 22:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
To: Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 keisuke.nishimura@inria.fr
References: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_120318_843935_FED4E83F 
X-CRM114-Status: UNSURE (   5.35  )
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

