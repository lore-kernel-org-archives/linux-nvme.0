Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0111EFF8850
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kks3NZ09ZqsgRG7UDqaoJjlrgLIZqYd6xqDSe0kZQHQ=; b=4fIc8SY4jz+obWKV4ZeJFQQO49
	Xx18azXpe8gfaizERrsXXa593pADFcnJFtPi6tdvlMKtq1tu8kReTJtqJKzz2G6eUaEyf3zK5GShz
	mm1zMfCos0r1w2BpR8z5vgJMc1njICmcEaacNDPa84QtvPtSFTK6ZKxwJQHENKWFhcUKpCwaYUqUV
	m1LVuVx03wQ5HDi9KYFJtFokVPe/FSQaZ7gQaQWYHO3VoBV6+owu2L+G6IXUptb7tRI69nwB9r4QM
	q66q/YyV5ODcUhdzHxnhzYkCWFc5CshRGiRi9XorQkq4H9nRzAM/cLQcWY+l8/WxAYgletcGRvNjV
	K4vaC+OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOo6-0000000Dnws-2oCa;
	Fri, 24 Apr 2026 22:15:30 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOo4-0000000Dnvj-0BUP
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:15:29 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44136f7a169so416849f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068926; x=1777673726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kks3NZ09ZqsgRG7UDqaoJjlrgLIZqYd6xqDSe0kZQHQ=;
        b=ToWtYGJa3+AT6OuQY/cAJ34HuCkWhOq51dDy4o6jDWe4G6WaLiAQ/lvoaYJKDeO7ny
         HAmwsOS2LEf/r8+ExMJT5i4zsgHnPOt+YO+x1HomaSf2cuiS0Iu5gU6qJl8GXpFCZnJy
         6Ydr20rxriSWh5ycXHljNLgQWH13BPEHXj+AUbB3bSABugDr5wqJeYGqKwsI4+hJ80cW
         pf4q3HFYyF7es5wvn5ZJ6jBkE+K7OTd+MEmyRLTMHsZk87osZdn0f5mwlT8g17da6nS9
         tTWA5WWZBBlIXVkrQ2MaVfMIt8QhrbXGvWu0HHg/a8wU6aoUcZkRsMOnSRS1/8J8M7U1
         QM/A==
X-Forwarded-Encrypted: i=1; AFNElJ8MXw9CyEnJD3PxJe4tgZObBbCGKx6jffS8JYPztW1Hx/4nZX7qDFaphY+dnP0aBu4wEqhxTtbjqt5B@lists.infradead.org
X-Gm-Message-State: AOJu0YzJjNAkooM5xTOgOCnRLeyN15til89JMG+qNu9mcTINBhiC+otl
	tymnKJUIHDeM5VbRI57UL4Z54BayaVPfbtYxWlVkcfDK+5uqqtQW2B1b
X-Gm-Gg: AeBDietVA97RiCrF5qyd1zE58l4GUyvhVHXVIamw9yr2wlkcaxuBw4Hgy4muKjJZsrW
	ZyWenJt1d9ymSROVezz8ycTmyOdu3pY80r2zG4VakzZwkNjBbv/OLYZzOvsbWMdTPa6lQekdKpk
	Hyw3AifBqbOb9jsD96TQJSeG5B8Ahg7qUeG40s5+XiKgHawGhLzQ8mQ+NGkGEF3IWnRKOgU6Diz
	uBtzSBccG+TLY8rUyoYSd1MiSdXdVk9+YN/e1MM9pJ6wOe1aNdGqowHOVtqdotU5EruKc7g6OjV
	gKeSzRzZ+DnA6paE14fD391645ojyRTkf7dBqG62fyTxVcgdFPDShRKknXjSC1M8/RABEzmT6+A
	uPeyE9vj6pLaN+LgbZFQsO0ugEECx+MxfzgQmU5IKmd5wCm9GMkylXqvK/LaAl7FmBcT3xxTh4V
	Y8XM+sJCKfV5AKmt97r0QRE5db6fx+nnCGL1R6jhjF+HfiPHkZEkCzC1QXIUI4Pb0LWPan
X-Received: by 2002:a5d:5d83:0:b0:441:1e41:19f with SMTP id ffacd0b85a97d-4411e41035bmr27467338f8f.24.1777068925660;
        Fri, 24 Apr 2026 15:15:25 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm64018499f8f.0.2026.04.24.15.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:15:25 -0700 (PDT)
Message-ID: <443c5fe0-de0a-4bf4-a502-055984102997@grimberg.me>
Date: Sat, 25 Apr 2026 01:15:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] nvme-tcp: add a diagnostic message when NIC
 queues are underutilized
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260420115716.3071293-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_151528_092565_2D55E0F5 
X-CRM114-Status: GOOD (  12.08  )
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



On 20/04/2026 14:49, Nilay Shroff wrote:
> Some systems may configure fewer NIC queues than supported by the
> hardware. When the number of NVMe-TCP I/O queues is limited by the
> number of active NIC queues, this can result in suboptimal performance.
>
> Add a diagnostic message to warn when the configured NIC queue count
> is lower than the maximum supported queue count, as reported by the
> driver. This may help users identify configurations where increasing
> the NIC queue count could improve performance.
>
> This change is informational only and does not modify NIC configuration.

I don't think that we want this at all. I don't think this is nvme-tcp place
to print such a log message at all. Especially not every time it connects
to a controller.

If you think you need to add this, create a userspace nvmf tool that
tests/validates a host.

