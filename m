Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15831C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1FYoH2DFhNhREpfoFxOmeqLidb
	Wu5uguJXNteGs9sJ82xsVhAqW9zYoyX4d39zuQo2FHFBsRBERRR7wozt8kapZGXxPYnphAghIznKX
	iyd8ZTzeYOqxaLShd+66lnYsfRNVazd/H3rPSQEUgIZNG5+buYaQVBRM2dlQ0La96KwlytYob225Y
	Zs279BLdGhIe8f5TzFQFDl9LA4LoRwHRGn67ZinrhXNCCXBA2MhGDorS9SS+JtQhVf410jpNeVTq+
	CxcgPqhgfcvzoNCZnF5AdJklQ6diBCuP9rp36gP5LTFodF0L9lR8annN+MrFer4VEWHMqqgX7pm9b
	0ZUjZitA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuWE-0000000Es85-369y;
	Sat, 22 Aug 2026 22:48:54 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuWC-0000000Es7l-23Po
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:48:53 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2762349a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438930; x=1788043730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OSHqjcrozmJAjlxO+ZMJZZoyNlxGYc/lOHX4Mgs49E5RMvB2SLBeULkAtRldXQku0n
         CPlc7HaV724/QN6cZaINhi18P2z+LQn62rmK7Nric0n3JBBuHftxId19/N93FPDiQCt4
         GDdJZjD9Hu5b1iK3vHtHGf9kmO/Qj0dEcPRGcaPccqe3qHAgysNFvj3cGhOkH3lRtZe5
         O6m02MVxyk1NspUErBXzB+VR8FWIz5+/CpIm60rAjTIyyysVYVK1g/gXnFuWPo7iNlut
         8pTETBh1vdXew+4invpy4AiXggBijfW78InkgAh1hgYaXOqjVF2eQHoX8dtR8X2/j6ZU
         bmHA==
X-Forwarded-Encrypted: i=1; AHgh+RrUTaWH5JtGOtsSoTECTqlTqxlKQgzwflokirs31yNq9rpsrm8TSNc7GVLZYic+l0NuX9QzlunSHqHo@lists.infradead.org
X-Gm-Message-State: AFuF++m0ng7DB8pQCtfU6oYbWCM4lp1QcHKjej72jVDISCp6aneuzxAQ
	Y1G9nAAreTYxptw1B0f3PQxJCdW51SvGJgZlt5414r8jMqtlRdmt4rGo
X-Gm-Gg: AR+sD11RYpFMs7/Gg3rqdpVfbCZQ0PgwlZNLGJ3090rQh+do6s5rWhz5ofsuZpFx3U0
	cLjOD6rJsPp5A8sJ7BI8sVemeytyEcA/fLYM6pioguIJk2BUc5ZvvQiNleMDQS//ARcSw2e2JDy
	cbRb9cr21r7jCilx/IJ0CZzxkzH2sO1FoTxa/OeK7BSxzrhOGP4e+Ss9JzoKEg8aVwY5YQAe7RJ
	qVIVvVRYg64l2h+lSpzyLXHuiW9JZVLTbxu4Yx8763XahTjLnRJSHrnwauftnovQ67IesEOMX13
	h+SI6jXWQs5GEo7OM7iqW8PWIB7IlAf+utU0UG7DWrpeYL2gApMMXAqeR7grV6+6SiRkie4fHi4
	XCuQAAHFlq+kf0/M0BtFwxfwyvT5rg8vk6gxlcFbbtXnCT1IZAsnCGMLSPf1cYH0V0oGSg4SOI7
	aQ8K7v1oHyCg2LK1VLHrArwGd4RNrkPPC3f4KuDuVDlvzulmgG39qBbm1m7PIdPiVgG9Yt1MnTm
	jJrcnrdQwad26aVK2w8BMQ=
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a582af951cmr9902892a12.3.1787438930544;
        Sat, 22 Aug 2026 15:48:50 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e025609sm76519a12.12.2026.08.22.15.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:48:50 -0700 (PDT)
Message-ID: <11176b67-6924-468e-b384-4702959e2c71@grimberg.me>
Date: Sun, 23 Aug 2026 01:48:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
To: Shivam Kumar <kumar.shivam43666@gmail.com>, Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <2026081459-handoff-wildly-eeb5@gregkh>
 <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_154852_526912_A3DB936F 
X-CRM114-Status: UNSURE (   4.39  )
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

