Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12278C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ft6t6u3F6Lwq0ZQDVNTx1viPZX
	wfAFkqbRW9iyTjBx1NwPpOjJ9GaNsF+Nm9J41CrAO763FOQxblRqme2vl6rK0TeZdRwv2TqITWQRL
	1pXc1XwRSqeMLSgy61fR2tSJUGOx9CdRcl3WTdYLP8mTFKPn20ZLx/jLDgD2ILz6WQASzd5lLJZAy
	q4JxtneipynE2i7d+j2He8qTDUnPJGBUlCqof/yRq+Bq0yWIUyRF8o0mBpZdP7GtdJyInAYrLYB57
	ij8CaDs5Onwrh8fQbO3M8NWBJJd4zqPo+MlHME2KVm+LEhiqizkn9fwOrE+UAhnbs+fTYRmJGn/GN
	SRSVY6fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PFS-00AW3g-BE; Sun, 25 Dec 2022 11:32:58 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9P2x-00APpF-6k
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 11:20:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso6204256wmp.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 03:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IqCGYikNU9chRDeGnxaG1GqTlteD0ylo/38V/lYqHxHpl4avb8kSDbYlEqhTNVM3tK
         cPk6M0mYAv2u3fnAPLEs8cUYq6CnRjDafuoZGOdX5s788R6tGucxbqdm2LTBFs1g3bYw
         4u4g9k5OI17jbEdasK5IYpebdKiXfhovWhfpMt5sZJxw22U0MeRhbuQD7mIjHzhKYapR
         IYxpjw5RPEhlXtTTVZ9F2jMAIfdHEq6uFMxFnRjN5iq0Q2rGlXHicCkaju5ceIM1BYNX
         S6jRrZQbJFL/fA070OWWkePY7EXZgAjYBMInjscnk4qQZW2SK5z7MfuB2RrAoRqrzSGf
         X5ag==
X-Gm-Message-State: AFqh2krBNW42AAYia9+7vRS0hINEQQwPyyC4F+eo/5x/PQjcG+V1nwPG
	y6nSwPNgcnxa/2kNGVDUhQc=
X-Google-Smtp-Source: AMrXdXt74QwiUJ1xfSMZi0QmJ4suyG+9k2NASBzkaVaYU1vIdrK6wrOsDedc1AGeQFlutxhT0ulc/w==
X-Received: by 2002:a05:600c:2207:b0:3d2:24d2:d02b with SMTP id z7-20020a05600c220700b003d224d2d02bmr11220764wml.29.1671967199638;
        Sun, 25 Dec 2022 03:19:59 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k31-20020a05600c1c9f00b003d22528decesm16543686wms.43.2022.12.25.03.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:19:59 -0800 (PST)
Message-ID: <b0e36fe1-5b44-d4a5-3112-73f7c4cdf0fb@grimberg.me>
Date: Sun, 25 Dec 2022 13:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] nvme-pci: remove the dev->q_depth field
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221225103234.226794-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_032003_469183_9B68BBBF 
X-CRM114-Status: UNSURE (   6.14  )
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

