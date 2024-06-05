Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AF9C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=P/z85Mozf4NQZFwxEvKJIImdAi
	OgppyJNU15Wk2R+2Rmxx/3WgX2eCN3LXD7nAkOJAl7P+MbWRVgjRN7GpNHy3W4E/+cgO8pXKWkP6E
	rHPb9Dgoh64bMNarxUdtkYl1B22DFopzFukHLqaBdGP8YfrD1riGe4bDiNQs7hIuHYFMxd0pUF3DN
	wcodNpfJ3qzarX1sb+JvUDoYyMe/+3f4zm+2XmhSX5EGr6GN4tfUOdyaqwflzwsokfbVW744DouGf
	OwsnJorJNk4ohBKeIOEimoOeDcghqTf8r+YmbRWi709wkXQWp1viFKIONHUbpbuxgCALF7qdHGkiq
	gL5setWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmPc-00000005IWM-2EYd;
	Wed, 05 Jun 2024 08:54:28 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmPa-00000005IUy-1Yww
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:54:27 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ba7d9b765so175567e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 01:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577663; x=1718182463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YezkYA0r9zKG1yfFKxS1Q8VfvJONCH/Xw6vNByKpVoc8N+MAp3FgqzcVg/ky/VvaXn
         u/Rny6UYc/YKZ8Lcg2ninX1HOW3is9yKZtOu1MO98ewyro5TCxEaHh3jWhrPPW/h/NoS
         CijO0lgVUW2ihnuOeIpjCBu2waOMeN8tLzPaYZyXCE7Tj3L29L57BvSZzFghmoaIdzeU
         H8nDUTaXPOwhd5drl9BG9vKVK4qxKWe1EgWM+Q3qv4AerROfFXeCEXgvBRZDbO/8ZdrM
         J6l3unkSkOuh/s6jDEUAkQp2OUt7FbRv0aNhlOqAlD+FaubeGxLShlqf2X8c/tOaLxfn
         0xWA==
X-Forwarded-Encrypted: i=1; AJvYcCVxpPzdeOeRbyaJlLbILYghBNVNeXSmJ8IOAOgMhGmlokuV3a0u+FOiB0lxu1RJWEsLUhx4biElNjPsiJxfH29sQLGSHKF/JhTKpbmNMAY=
X-Gm-Message-State: AOJu0Yy0+dod5ksAK00nA416xkTghZg6tO0g9SK7hk7HbXhC22fEGhXL
	F/APK6XdT95pJQKTrqth7u52CC4nTDrrBvWbGSISMC6R9EnFT5up
X-Google-Smtp-Source: AGHT+IGbvFOk6vLNjOLMhDAlT0jyZrOQwzLi5FpUV1QzaKhOdbmxD58StePqW4/rVf8H6cstqLZXSQ==
X-Received: by 2002:a05:6512:3089:b0:52b:74c4:272f with SMTP id 2adb3069b0e04-52bacfcc57cmr896995e87.0.1717577662725;
        Wed, 05 Jun 2024 01:54:22 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813bfdfsm12558405e9.39.2024.06.05.01.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:54:22 -0700 (PDT)
Message-ID: <1a3d8072-42dc-4ee7-971f-edad74070526@grimberg.me>
Date: Wed, 5 Jun 2024 11:54:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nvme: rename nvme_sc_to_pr_err to
 nvme_status_to_pr_err
To: Weiwen Hu <huweiwen@linux.alibaba.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
 <20240603125702.97368-2-huweiwen@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240603125702.97368-2-huweiwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_015426_442873_E4DF842E 
X-CRM114-Status: UNSURE (   5.22  )
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


