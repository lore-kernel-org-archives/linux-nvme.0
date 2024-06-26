Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E287C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+taibDOFXuS5M+UtWpyxfKE0pCrSkGL4ScPe+lBSS6A=; b=teUxhMVa2Jez11EuLpS1FNoLNe
	41vPef9nBLJAKek3mrq2neEP6j0PrfFWszYNMM42/iuLyZw56I2jCMSjbI3Ej9eBhEZXd6D9hadAZ
	XdSu2OTzFwdH58MUSkvXvnfB2FiKS1EmOUFZTdSuP6/urf73/DI1EG2jQ9BRkko5b18DyjnPmD1NJ
	MP+ZeKoxSXF4DaZYRmzKh/CCTOm9gO2/7OVEcXQYTeypGROPPc70P938bHCzVemujjovlH6dxCWt0
	0qQiZfmw8JmDkOsoINimEVtIc7Tkw6XA9rQHCxRgyqft/KKE+LSneL8nDbd/1QJcupgXvHm7tSojp
	TyiIO1WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSxr-000000071x5-3Xwf;
	Wed, 26 Jun 2024 13:45:35 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSxo-000000071wA-2nPX
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:45:34 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424a4bc95f3so1864585e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409531; x=1720014331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+taibDOFXuS5M+UtWpyxfKE0pCrSkGL4ScPe+lBSS6A=;
        b=HKP5D+4v15RVbbOu+3JYRmfIDRh0p0rYWIjK7gD0wK/JX9L4pA1yl9iFQzHc4qhaEA
         GjMCobXMERWF1U7hJqKYThWll1NQV0ob7sfvdQC/uMa2eTvjYHSjNOOePJaLuL7rfA7d
         Yd5Fl4Yavhf2n1VkvszAQaKvQWD3MSGCySrdnvBc2cLiTsoqQ+kDLwDaA/kSLsvCrnVA
         glCL9AJAGqp7Pi92WKYW3BWjzRjMOtrI/COGM/Rknb9y8yT65zL1K0nKR0Gc/84Q+btW
         CPR77KJZGeR6sc+pS46KmeNiTMK7MHy+WwmVRR+hjau8CPCkJ/YPOsl+3wK+D5LL3oQG
         nfHw==
X-Forwarded-Encrypted: i=1; AJvYcCU68F8mKz3NtGeLmZjHJUHZYe6eY1KSCijOTAU7+jG2T37Mzz/v070sbR45E6TOV98JI1xTNtwXKo9wqAoYf9MkGNlQBddo6bwsDxpeXxQ=
X-Gm-Message-State: AOJu0YzW1R5Mus+CzeSGMiLlt4Gs3aLIaz8ySG9s67cIUEEhbg3FlkFr
	L+joQFwyw1y53m0vjgM6w7CRwkUMJa29hK3OOISCY4BP2enT45RExJWNuA==
X-Google-Smtp-Source: AGHT+IHJzqVgnkwXki6Gsp9gfaIMp4QmZ7mJaWar5Po5RsGPRiMwNbgt6XutrN5yP1S4cMnnF96u+A==
X-Received: by 2002:a05:6000:1542:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-366e28afaf6mr8561391f8f.0.1719409530605;
        Wed, 26 Jun 2024 06:45:30 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9b8a8sm15800881f8f.50.2024.06.26.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:45:30 -0700 (PDT)
Message-ID: <0e11d80e-dec8-4be2-925f-489d14282b29@grimberg.me>
Date: Wed, 26 Jun 2024 16:45:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] nvme-tcp: SOCK_NOSPACE handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <20240626121347.1116-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_064532_858944_C1766D76 
X-CRM114-Status: UNSURE (   9.09  )
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



On 26/06/2024 15:13, Hannes Reinecke wrote:
> When there is no write space on the socket we shouldn't try to
> push more data onto it; it'll stall anyway and leads to higher CPU
> utilisation. So check for sock_wspace() before queueing new
> requests and let the sock write_space() handler restart the
> submission.

What is the gain you get from this patch?

All I see is bit atomics added to the data path.

