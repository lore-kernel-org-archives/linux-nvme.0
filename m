Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F13C369D5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 21:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wb96VFSSSBwzEEcE9MOPXUzm/V
	6GnwIRg6SlGDWvOsQbSLsbpeyvY1Vhv13J2ASB2leAFOhlkeOTjiF0iQPH++MRFg8Iyf1Cz/ihuyZ
	+CJcN8VFXZsRE4eie+IrA2hcoTenHpB51PdEHCl38RsJUPrimSWdhKH6+OBhtUznOfZUe0Z/d/T27
	rtAYk9aPHOdQ2pJsGKqDc0jJGAMTPYjs5kEy7JcBMIKsb1SUHFhoh7ycTWLZMoC4jiJVtc+upvuef
	LXhOKAdtH0HHML6ktgWKwM+fxGnrCboiq4ouK2Dr6/XrqDZi6xyUzYqdHMd40rnuN2+iw9//y5/Rr
	Ys6k0Oow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qq7-00000000xSS-3CmM;
	Fri, 25 Apr 2025 21:44:07 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qq6-00000000xRy-0rlK
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 21:44:07 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2172864f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 14:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617444; x=1746222244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EwZ+pBETiXmt1JTliJrBVeNOjNp7LmhfSaBdqSAeo053/7RxBPlzLmokfk4HsfymcP
         Q07clSn3/Qaysz78W88gJ51rS48rwE+Tlwm68xh1Hn7RUpKS4h8CqFn+vA59KOa9McfA
         eOllYwEgDAhzWRh2pU/cTR1pR/qQcolusMHfrBkt3DFXr6vD6Ek4073SHAN1dyyKfum0
         p7R5RKrAa4vk0l/Ba49kYU+B8I9veeVV56UAm6aSuHt7IIERc8gWBsIqtGM48GdTpxCt
         L668pHHk37WcTNGzLHf2aBgJUUFkJES6dkiJG8in/kqSUMNjwA6xl6hfvgd44QtaR6kN
         Z6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXEt+HXYRFJ8cyS0OJ0p+mvCK/41ICe1Wx8sHPyKNRF2NejUlFMWLB1gqz5elNAuXGZYeRDwvkWhLNH@lists.infradead.org
X-Gm-Message-State: AOJu0YzU4TmcNYjUiimSa9eo/tOhfszXKY2FY310/8UV3PGY4GfCoO77
	OUNi3PH516OESc/MqlXHpdUGjFLKN2JEQaROYoYMdvuaDMVO7/pyEu8JgA==
X-Gm-Gg: ASbGncv8HDYPu/56ssz6BLppBUM0RngF+6ZT7cmPgTovV0Lbn6Rxc31i0r+RO7lHylh
	85nkX3EkNZay1Bz8tAFS8PxSeSkDiBgkCWOT866IAwcnH4BxoO8WHYp1/1cfwEQc9tUGgkltLvp
	haSG8xnxPg5e+U2cuObBrMJ/AceZZPUZdKI1+/8TbGjNGXVmgX6OTk0r99bl3Pt4KUD1d+QG1Ef
	yvj7BDYf0nF6oKsoKOZEE62INlXYNKLXjZil1vJlTqTjaPYAM0TsK60HbSrhz+M+qytcIwpDq3J
	P4cKDPhb7398Wo3o/inJEk5D+QZM4GvyXF9d21NG
X-Google-Smtp-Source: AGHT+IHNkUTzqCyklk8CwfKfnU0VUbuqBmBVcnaK+gzvvYblitq/tJPzGKIQecXGKo4apnbeSc0a3w==
X-Received: by 2002:a5d:64ee:0:b0:398:fd9b:b935 with SMTP id ffacd0b85a97d-3a074f7ba84mr3132716f8f.53.1745617444011;
        Fri, 25 Apr 2025 14:44:04 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46a49sm3448346f8f.61.2025.04.25.14.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:44:03 -0700 (PDT)
Message-ID: <7c5309ff-3a7a-464d-8088-a58da7b66a1b@grimberg.me>
Date: Sat, 26 Apr 2025 00:44:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dmapool: add NUMA affinity support
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250422220952.2111584-1-csander@purestorage.com>
 <20250422220952.2111584-2-csander@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250422220952.2111584-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_144406_238291_095D83F2 
X-CRM114-Status: UNSURE (   5.91  )
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

