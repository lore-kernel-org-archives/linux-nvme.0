Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787D2E8FDD5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6xaMKyvxeJEVAuuyNEypUS33VARveNT/q4/8bMFZAI=; b=FZAHLXlzcEWnI5dgKMtce2d9FT
	tcbDSjM1cCCPv0xkJp8Z7kZ2iiuLGke5oqLCD/xkSka9aGZN+obg3+rHXWl0f3/OqDeh33iRiQNZ2
	ogwIjovxcNjm12mtcV7LDct57HUsDYlLX2xw+QHtb55s4n/TI6ObJJKxJWyDWSLxFzovREjropwEE
	o1WZvHcXMcOqd9XMesqA8feB2bvsdVNsrjBPtvqaax1n8xGlucf2UlqHuqsbDAJ7wCjLPS6Z/UD6t
	0VlbdesVmREbwrliPQOBcjYHB08orWxWt7rd8SuXccjLff3u+7MzjdMUeknplvNMcxwPAHSxsmlUa
	jpT011JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRTD-00000001rMu-455X;
	Sat, 27 Dec 2025 10:24:24 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRTB-00000001rMb-0bpG
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 10:24:22 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso41981045e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 02:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766831059; x=1767435859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6xaMKyvxeJEVAuuyNEypUS33VARveNT/q4/8bMFZAI=;
        b=dPbYNmUlIWbTfas1m4O75ev7Yv5f7fBJdvHYdzr6F8uHmNZsOdHC3HlEEJKU3y30MI
         kb3HmljtMOxztnRUverLQGPaAAHvI4fPEL3R19eP0qAehMAJLjgKTAITBBh6PQn8PyDT
         LXIqfqlhqhnAkDJysGNUc9XvChy0LdylEmLuCzeNrysUSfzgX8Th17zFumUHitw2V6if
         10HPv9TukXeHRQsvCnXa2QKkS/3+NaIGu+W66pJMrHbrujMbzW20RLrLxlZA8WTjVeZe
         lacM/nsXR7089wZsY7msPnNUVW53LFoHgYc/Cal+Nc46hG1G4dfFsW7bdkDXO8Rji312
         QFLw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzaLa/Y2LbeP1UQZu0IqwLI+QDv/R4fx0RmocUObVr3bL88sog3LB36JB34uh6LZ7HMx/0oTe+eSN@lists.infradead.org
X-Gm-Message-State: AOJu0YzNuvSd7huFkHSZ0PDM2oT0a7zjkrdHaSsalFymPl3Gr2crL3On
	OW8U5ATPueHkIMKRDkCJH4Tya4QdUxPqsTyC1YkyImYBauDdW+QQ92Yr
X-Gm-Gg: AY/fxX7fOXGot1oBpGKf4MK3Eypbw0H7p1axjiPlbepmlstuCnfqFxJzhwvFzjdiIqg
	Z6IdRzEPEMCFZDXDEtm6K8b1dTSfD9+srqnJfreKpDXE44MJCJV22yyzBJXoEoJhuA0FloD1KfQ
	pUYLGd/QNVaBOEf4d6M06huZhezILJlcpzgl5UjfPa/8MXDSZNnhD71Dd3gShp1E3KaADlPrUNv
	R2ubxP3iO+8fuapqLrb3t6IuGLRaYfctxjFCq53m/AAqkBqu53JUnXGbisPkwwmipqIgGpDWYar
	wgnKTUSY8p03I7OBWdZa87MIw3z0pBlN5MP4Z6GslQyDgxEmUFP8uqiXsEOmzIBckXP4TYm5xvQ
	d7y1QlobtwE/PkH5uFGQ4i40K8+vHBwYN9yNNz9uLGsZiTHjxhPjYlFRmflwGwJLkn0rsUMywn9
	ZYESH6NGp1+QYoSgQqrwqtSRW2x8+HExzQcoc3vKp71ho=
X-Google-Smtp-Source: AGHT+IGETYYnb3JisHsdSO+up5xdIlUXy2P+LpnE7NDZYVZecpLAxIbaFBTVQygvvtjBT/G2nBqX8w==
X-Received: by 2002:a05:6000:4010:b0:430:f3bd:71f8 with SMTP id ffacd0b85a97d-432448bf502mr30831038f8f.25.1766831059139;
        Sat, 27 Dec 2025 02:24:19 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm50027862f8f.5.2025.12.27.02.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 02:24:18 -0800 (PST)
Message-ID: <9ac9b7c8-139f-48f9-bfd2-bfd03506abf0@grimberg.me>
Date: Sat, 27 Dec 2025 12:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-10-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_022421_195382_7858F025 
X-CRM114-Status: UNSURE (   8.81  )
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


> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +
> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> +			   0x00, log, sizeof(*log), 0);
> +	if (ret)
> +		goto out;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> +		entry = &log->entries[i];
> +		if (entry->ccrs == 0)	/* skip in progress entries */
> +			continue;

What does ccrs stand for?

