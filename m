Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0608AC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UKslhL9vMFuhf/noyneB1kSzBV
	VejeaZQWRh7Wq8XeCBKehuEOWu107mSyywjEuIp4z4TLu9zVfMv05t5KGaMbxMwJvATmMe/mZ6sEx
	ZkDQq4dbUTY6e3sdiUIxjRoPbLEyBe4pY8R2gnQXu/KaMoU0LxqZqRSy/wwJmY74lALd1a3/12Z0T
	UVzBols9Ib76VIAl0YwvPL5H005K+LpCPODPTk+itxeTS3pIjCOkfvmG1RlBaeZR63B5fODjOxI9/
	d5dWk8vXCm3+RYcjWduzioeKWFLXarKPWp/Yh+jRrbh+64r4pbVv+zxcnLkLSDglgNBDdu2GeeUUP
	KBlh7bEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHbW-00000005Oz9-088K;
	Wed, 31 Jan 2024 20:54:42 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHbU-00000005OyX-1F2h
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 20:54:41 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33aeac77bc4so11874f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 12:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734477; x=1707339277;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=s5L2WCk3x7bWSKEAUT9m61UdHw+cGfUpsmBiMv/DEeDTlpggFrtRsM0IFsvvcMAtdl
         eYKcjg9NKm3e80E4K8OHFcT6x3VIF9R0c7Z+LgLUqapyvCelIe7xUSwkJ7kzzdjd8ZfC
         APlFz6UouDpmc6gh1fHhm5sEQ1/QOkieC08XDzcGgkdVtXeRFwicYP/4h10Zdf7yjvQ8
         EiWdsJhhqoqfhtPpEbw159iS+49GAlVXwaISz64jGDVm8cXXt6VtlrE//ZQfRPwD/YLU
         RchqJ71oDprqoZLcTi4clwnb4KjOhUVNT/sp7jw+2y8n8CYQk4Xx4+D3k8pu6b/DKkw1
         5FQQ==
X-Forwarded-Encrypted: i=0; AJvYcCWHBWKM2t18guv1xPBJhOe9ElPMIN4xxU/8tuUr2cdNTTaN0p03Hgenh07VFc8u4jpI39q5x2SWpuJvbCA6J/AUf3Fzj4SfyvdyNK/4tRE=
X-Gm-Message-State: AOJu0YxY3pkCoHRxQ/wPbN598fGJWnfcqcQaVQxk8EHWawZOL99QP+YO
	Reoaou/kO0CTR/2lzq+ejDCzrUV52WjdWtqSCvI1ouA91dXUgH9X
X-Google-Smtp-Source: AGHT+IFfjL2PDldfKXuUFXG3L0vJ5ZwPYJxPTZicCAEsYAdRo/UtJgGj9+x3luwhIbxLCQ9fm5E3Vg==
X-Received: by 2002:a5d:66ca:0:b0:33a:e9d3:5112 with SMTP id k10-20020a5d66ca000000b0033ae9d35112mr303314wrw.6.1706734476696;
        Wed, 31 Jan 2024 12:54:36 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm11746897wrp.20.2024.01.31.12.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 12:54:36 -0800 (PST)
Message-ID: <69a4c1e2-9f9b-4c5a-9544-e3221cb13ffd@grimberg.me>
Date: Wed, 31 Jan 2024 22:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme: return string as char *, not unsigned char *
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20240131164315.160042-1-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125440_342941_17306845 
X-CRM114-Status: UNSURE (   6.52  )
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

