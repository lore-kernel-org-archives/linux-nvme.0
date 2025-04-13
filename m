Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F2C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Dkz9ATnsisBmf0Y4K2DPaxyTnG
	NDbJIroKyNbE/NOvbpDnSUT68jsb08LiGlaig/SZz45/5AvFPtTuQffxwBCENWtljm/tgjStYurTZ
	7s3UsehF8D7gFSjQgj4nEaluHHfqhmZWoRPZrDVXau0S4nRgCrxBHgqBhJNPjAw749amL1GthCooW
	o05/ahCwLW1rHI5xHhtgLesKZeE+pi0l1RTJzzdalWmpWqA1EBBacm3vDoriHszWBMvHW6DkR/gy5
	Q2UI1hF+7354YuKxNJ5qJ4EfEAa6d4HrzCuEWst7zHj16YFEPjcUrexeoDIOwJLaJlA6CzLUcW6yN
	JRZ13sfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u44oS-00000000AsV-21Ff;
	Sun, 13 Apr 2025 21:24:24 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u44bX-000000009B8-331j
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 21:11:08 +0000
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso576516566b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 14:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744578661; x=1745183461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=N94K6klrF29s5LPauqRroP66FaNxIzZvPv6k3Nr+w6UxqPrcGLwsLn2Z8If+bEoiCW
         RWLmdFww+Xz5jwS0GFeJX+nNeKEF5/1M8rkhrxVSjG8le6LNssBpZvcs53wR5O04+ljO
         +P+bNmZj1ZTRMUeXoOb84g9o6q+eh/QezW6R3rWpi/iZLfjPzTaJJhBxJWCJvGZ3Jclz
         hk59hNjHwiXQEUUfoj10YvhuQ7Hod0UozyJyT0xFM/VVRvymqJkgcS48ezxRCFGFvXuO
         Y6OZtTRrCX/Ny4xm0kljV1fp6+GmWCdJ47Iifdam2iJ827bGFl9iWJU5cJQvmd9HIj8f
         fXFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJNMs2JzV7LiKpajPN4z1OSC5XS/0E2xH6OubrIuqYSTaw4FtzTmq7C7zmkM8jwpKcGJxI0nLvbQKg@lists.infradead.org
X-Gm-Message-State: AOJu0YxSQyID5ai6enrSlNEo0jq578TaMqIC1KYKfQmWuNvMh+i6BNQY
	a2veORj9qCeTdBjkEe+vSWu1HnHXvocUlPknqPIb5ZetklANQ+B1
X-Gm-Gg: ASbGncsJb+K4cRH+yE+Zw7/wgI/xTmzRJoBAarY5q+io9lMr8M8Blj2mNS51ZvDbp1p
	D/UQ/4XgCfiJRaPGBUtrUoN9ovGpGztppaJcqTiMKu9RMRzHdjO1oMQC2bLf/AwJVk0cS53L/id
	Nm4EGzBcMmCuTzwFwAkIkeMA50HAiWMzc9kk1/vI/WnKYcDcZSx5DqWanPBHgVCWzFZ0saYm160
	7+zEFeDY3mx0W7k0hNtOUahYy+KEcySdMx6+Ya+veuXRDbIiFYDysjJm+wGOpdkVQpwONwtxqnM
	jRjrUK3sTH7UkD5etRgOSWs8duK9gH2lfTw/e2nhpROyiHysJX7/zH5T21p6oH364CFemkhP
X-Google-Smtp-Source: AGHT+IEPEbZo/uM/DzEN6nGYyDwkIgeU/H/AdYVcZmNLDB48xiU11a77/FJK3EyZk6PQMwzWCAGLmw==
X-Received: by 2002:a17:906:db06:b0:ac6:ecd8:a235 with SMTP id a640c23a62f3a-acad34c1a5bmr1018294066b.28.1744578661237;
        Sun, 13 Apr 2025 14:11:01 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc0desm780141166b.124.2025.04.13.14.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 14:11:00 -0700 (PDT)
Message-ID: <73574db1-7326-43ca-b011-c3c2c562975b@grimberg.me>
Date: Mon, 14 Apr 2025 00:10:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: auth: Avoid sparse warning in nvmet_auth_sq_free()
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@kernel.org>
References: <20250411010015.1017829-1-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250411010015.1017829-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_141103_789182_3022614B 
X-CRM114-Status: UNSURE (   4.65  )
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

