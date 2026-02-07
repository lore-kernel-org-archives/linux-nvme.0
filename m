Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05BFEE0ADC
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fnYeByYjdikXOggD36751KuBCsiFkfSEfvDe57NaGlI=; b=2BifSIhPlw3We/s4IEK+oLYJV5
	G+k850ITrKF5sL+mW7ilkDW+bKu5Osp1M98HrRhs/+KEfpMQUKEpVJowXbsHQ9o3VpIgYMSpMEiio
	vTyx6jm5YWtH0E+Zg3VhNglDZI2RESCVeJrrZP+4ZAqqHjud9/2ph1OKCOjhNcXnhYl6QvqsMG7lU
	u6ILK/OU/h8CkjXhNFLKEW6PQ2UCI4ZFiqD1H72LvNUuvAIqZo/NSqxYcBar6gouMvlA9SNYL6+tM
	mNwQvSkfjOb8JL+3wqYlPXeYc/khR8iAZxGLWWCcA9F0E2ES3b9vlr6mNRqirG8jEqT5bwzA8ap3d
	LSXjtPhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiZ6-0000000CUsy-1cJm;
	Sat, 07 Feb 2026 13:41:36 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiZ3-0000000CUse-3H18
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:41:34 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362c932df8so1005981f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770471691; x=1771076491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnYeByYjdikXOggD36751KuBCsiFkfSEfvDe57NaGlI=;
        b=NxY/LzYwJeXMJYAGE3tQzTCS7j8c5DqmSIg8FrJ9JDaCh5t3UJ6+SnLB/Gh8+emwiA
         VttC4UfvEGmSvPY8wm1XhjeWnFrxCjs7h4BQ1P5apsBJe0BI04ZDg8tbsnZZXET4q8Rs
         DywJupoFzhJUBrNMvojGnzqfR8wqB54ay2m11h9d+jl49jF0frq/YFdPtp64et3nMUeq
         apMW50QzBn+nD2VhZK4ssT+ufnj3bOthM3BA16SduMXE+JvPbiJcvyxGieOs+WqsIz6X
         PTXdazlZ8jF85Lq5SAFQaub+yTrLPUhJu0vFeDAdivspPFtVTeks4HwtOjEFEUWZip2w
         z3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWUqQ+nWAUYn/z0zHj1X1RZSJUchrynhv+qiWXwDrZuNTr1CWUCI2QAjd1UA7lGfIcHmIoIOE/HaqdG@lists.infradead.org
X-Gm-Message-State: AOJu0YyrLopDkhYZJ5hZkrm9ywm/bjhM4UAKrYNf71/mBQzFfpMmRZ5U
	V1ESADOMAb5ik0WGPUILllxxRtKhFDjdGdt8EDTybzMMSdCEamsI23ER
X-Gm-Gg: AZuq6aLkGDehkzKHuAP9JYkcoDRXTR+0+GodNv/Q40JiUzrgs7CaOrGrXzRxs91qOJf
	xMnOIelfZPOTA30q+1GKPUr+ET8JG9dnQqWS5JGQuz1BXlMCXLxLzwRiMvKUL7FL9f4i0U7ZMqD
	ETtadDKNwM8dItewXww78Nbz52x7q5mG9HlbFWtq/ZU9PNTTOjevKHD9lY2qbhchdgTuMlm977J
	CVrIujvWZR85+BCXuSfsPTSpUw0xXl/l7fJujxim10UYANoPmuupHSrg8pLsKgSzYUvAJplAjbG
	vMzrQXSpmXkEYmYVTuJUul0Vn28Z6HhaiSwGzRbpaEh9NrZbNAqqFKrid9Nb2SauQRqNbQnAkbT
	ZHVytUWIPGzUGY+6udYgyPnm00jz73lACapkXlF3csu021N4K5Lj7IO17tOl+GeT+MP8YlPVu8n
	yl3x3aNki+ZWh10sEdSCPT5yp3+JXh6vPvS1YXe3YqJBg=
X-Received: by 2002:a05:600c:46d0:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-48320212c49mr82021675e9.19.1770471691451;
        Sat, 07 Feb 2026 05:41:31 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm12336289f8f.30.2026.02.07.05.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:41:31 -0800 (PST)
Message-ID: <35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me>
Date: Sat, 7 Feb 2026 15:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Hannes Reinecke <hare@suse.de>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-2-mkhalfella@purestorage.com>
 <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
 <20260203181457.GA3729-mkhalfella@purestorage.com>
 <b695a3f5-bfb9-4215-9672-47abf7e35cdf@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b695a3f5-bfb9-4215-9672-47abf7e35cdf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_054133_849670_74071FFC 
X-CRM114-Status: UNSURE (   7.79  )
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


> Precisely my point. If CQT defaults to zero no delay will be inserted,
> but we _still_ have CCR handling. Just proving that both really are
> independent on each other. Hence I would prefer to have two patchsets.

Agreed. I think it would be cleaner to review each separately. the CCR 
can be based
on top of the CQT patchset, for simplicity.


