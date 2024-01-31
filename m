Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA9FC47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0QCPF2QjnSThbRKmc+aRJyiDax
	SGIhX0RwcZdiL4Ly4MeL68GGXKlpwRK7gypKbzYjcq8sSANMBKw+jphRHXfyy8sdC03GfUtflyaqX
	pLKgC/LZJ9XrPMXfy/aaeXKqblqzB5oW4AdcrCtw7IgKP4+DPPy4s8xaStE03Y6T5C6SJEbqFxoVs
	qXAWEK9jGH6s3YX4vGoR8r6iNrA39DdIAhbCuGIsXlziy+kMFBFPzw8gejWl84im+Lcs5Yj62pd7a
	qncDgDK1pF5CZ8Ue3uDKnMYl6rzrnhy2juiOllW0KXckFV56fM0hOuQaBh+YWnwiDGHkkC3f0app1
	D0sw+kTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9w5-00000003PU1-1mse;
	Wed, 31 Jan 2024 12:43:25 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9w2-00000003PSD-1qiA
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:43:23 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b025fbf66so156012f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705000; x=1707309800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mU0gVgynbE/eTVJ4991UzqibNJ9s4qvsZ30bHmLPO+P2aDFr9I2b70fbGOQFgpIB2Z
         fwLjLLIHxqeUXzlmB5s5LjBqauR+Fyyh0Hf1G4yoLobn54H/tJHeyWHAr8KFUem81fjx
         QA6gQSOhRcObW3NO7+YrjzZrbrAqaFjrW5He+ETAttj71qSjHBYUgbq3Tgp4GQyJGTbY
         CJ17LeW72/Uk6UwuF2eFCldwQ+pXpZ1jvhPGaQH/fVDGMafguXtoLDt5Qrg9WqQaGCHs
         vUKOVm3jHkA01nK8Xk6NClPxvfRs0lX0pq79GYdjuUlnCdacCObzG8qRPpwuylpqXJr5
         RE9A==
X-Gm-Message-State: AOJu0YzJlAiAv4f1Y7hdL+omHtswyShMyWu4O34dQKPDC8DKlw5pRlA9
	df2eImcVmEFDd9mwozKhYK0uNRuffE5Q/vZioVtBc0vLzuDz8mx2
X-Google-Smtp-Source: AGHT+IERT8de8o826Yt3G9ZFoQkYkXGGwyH3NsMGVT0BS2KEdl/Wgehan7x7SNxj9TjDdaPdACNPnA==
X-Received: by 2002:adf:ab19:0:b0:337:c4c8:92f with SMTP id q25-20020adfab19000000b00337c4c8092fmr1073422wrc.3.1706705000217;
        Wed, 31 Jan 2024 04:43:20 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:19 -0800 (PST)
Message-ID: <82a3f4e7-85b9-4889-a40b-de5e90f950e9@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: support PI at non-zero offset within metadata
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, Chinmay Gameti <c.gameti@samsung.com>
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03@epcas5p2.samsung.com>
 <20240130171206.4845-3-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_044322_492532_5482DA46 
X-CRM114-Status: UNSURE (   4.59  )
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

