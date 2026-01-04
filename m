Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F56C2A062
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WiuH7z3C63tPC0gnFEJWFXpMhZ
	da0m3n0Hdtb6kS1yL8SVNyE/AjvoJ/3fdlj+pPuPPMS/0XLXP25nuJ8h2K/ldORzbHUe/OEivOKV/
	ynV9jJX3T0lpHM3V0HBWo3Xz2yHWqQafRRVx2bhdaKZ41pZ7IOxxh2hQ3O1cPu2eDRmvo3X0p59dA
	Ai+EYhFNKE0FpMC2G7q3oBSemeQf6D4auWux/pQpToSvIhnHS3h3T0K1bZqsar0VXIeSJA+HyQobA
	7J7BcIJs4HkyjbrSR37JInSB+/zRUtZnDORNNlQ6g187f+3oW0vTEEmAe/gh74ZMHI32cucH4I+r9
	Uzs6hF/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVNS-0000000ASHU-2K7Z;
	Sun, 04 Jan 2026 21:11:06 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVNN-0000000ASGd-0Lej
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:11:02 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso7379905e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767561059; x=1768165859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IEuRfOlOrY5q8kcnIlZv4qDL9vtB3pO2+KvYuc8LGAMJEuGVjRAeexK//facu9BMIb
         sOCYLQGLTujFimGHjaLCqwROIhCpbiobJd2Q7IQ/jz3wCxmjXF7beuBOVdVrBeBvY/cS
         GzUD/cFz3dWbrUb0tFWO5VHFJdnVaKd4wngVeXEcKK8jYs8NPBXdVRSPOzLtS12E6sKJ
         2uDgme7EYKFKkeN0GMeqBsH4shEjx5EyKQ50+V7A3i5ZSUnUD40vKuYA+P/bmiehEoko
         Xrw5HHEfNHRft5m+r2GopbjYbxUtqCNwug38KMsGkwMDBujYMkfn9wNfO4bB5fUkNAyG
         +5Og==
X-Gm-Message-State: AOJu0YyctUeHtlLq3jKogW4gML5LPjKXrGxj2R5meVUXMECRs6pVy0cq
	xB7bM7RFuc48xh7PYEs2T9IIx/RTMQWuzSJKjF2o93ksGXExSk1lmUgv
X-Gm-Gg: AY/fxX7YGGCVfKATwMUJExdwTaSH15qJPvSNY55KU04pefysYzcQFPamQV/Vhwq2E6C
	nOv35xQNNTjzcrIzmULM3cTq1c8vn6HcQ24KV9AVSBIXIHsecBsmB8n6e2dycIl5jBveCqc76GT
	glSBZexwu63oQEyaYo+wFAAYupdhUJByiPrGjLhZKMECLENLl3Fl1IdbRRXnDCgpfbLgSXvk+Ma
	ReMNgPDkgTnZTV1p2DsuuejBv+D7ZANa+y0cIv74gZU8rIx9oCgkqaftTDyZIXUVH8CsE55pJXG
	ybMmnzt91z3RuFS1u7UEjzO1UPC95bjzZfeDyBtEsdXT27oCVCIInUm4ds6U5+kB4cOvIU7Q768
	5nf7bOXCEsvAe0JoWMW/AJKyjJ9ubJb7t3VWVQqnuf1U3rCXM6LXj70pIP0XRFq3gdkcaBqZRzD
	/nfj8l01gLvVlifW+VYolC278Dm06qHfgP3KnKFP7ydIg=
X-Google-Smtp-Source: AGHT+IHOERPsqrLG34P85/K1lPEF7xPRhgEIGVR6cmuO9mYFPvLbPnGC54Dhy8TFGIo91AyPNu8S/w==
X-Received: by 2002:a05:600c:540e:b0:47a:7fd0:9f01 with SMTP id 5b1f17b1804b1-47d195522f7mr639428875e9.16.1767561059009;
        Sun, 04 Jan 2026 13:10:59 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm98807625f8f.27.2026.01.04.13.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:10:58 -0800 (PST)
Message-ID: <266dde0f-c526-4d23-a889-970be1f41aa9@grimberg.me>
Date: Sun, 4 Jan 2026 23:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme/host: add delayed retries upon non-fatal error
 during ns validation
To: Alex Tran <alex.t.tran@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260103-nvme_ns_validation-v3-1-c9ce67393261@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260103-nvme_ns_validation-v3-1-c9ce67393261@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_131101_123197_318DD73B 
X-CRM114-Status: UNSURE (   6.29  )
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

