Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A38CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2Ai73dz1fmXq3lpDDx7KYIxaEs
	AAEMUx/UfNERpusOGy7hOqvx9QDg3BXalCRy0HYElBPHt7iZyXIGuTFNnPia+NcrgUNlzm1G2pNiy
	Oa48JnGgiFhm5+flP2YhdlC4VaMqEp9vc/8xj015X6ESa5JYEihfJqFhTbspJSL++WB7Xvnh0xKkp
	zSs05K3F240tJgplfDjHD3Nd2K7OtUM7gzzYINSoywHthjpjJ8fKhSF2Atnjjpt/DcpNQ4lxQeCw3
	/1nwfm5mWQdoB4ReCBxEB2ogFcG4eR3VkKN9Dil6przFKFRQ2ooFni4pZTuxZ5cV0X68oLxzQ/PAX
	yDVaqi6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rta0F-0000000DXhh-0J6H;
	Sun, 07 Apr 2024 21:24:39 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rta0B-0000000DXga-1pEx
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:24:37 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416463e82fbso750975e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525073; x=1713129873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Wut5s8UPLAdPp3u7ZY3o8cGJmX0GjQvNrhmbquM5uLBlKUgRzD0alwPVYoDa4+75Y0
         ZKCMcnOAUsPB3vCoCsdYxUeJwkyjY/SnRS3T4FxeLjUoWVuagS/jvej3nDdzTw58PoFw
         honjZ85q5k39fZ3CcxDPWhfAeE7uPpKpYlS+ENm7UMcpOTkEiXWOxcHsxnw8wthNOi2e
         Rc/xl6oZEiU04y3RUltjdXKfV9RB7iA6b7z8d8JIuM1Cy98PBUUiXr+nPswgglPbzmxd
         w57hM9t+grUF1Vy36DWE/75PUfu6OwAt81RKa6tqGcPwozIJCdbMrzhzU5JdrMbua1Sd
         ygjA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtMRFH1PHngvfkBFygDQmgQ4Brlzwt1fCuh1GlFZCEGDVUoQvwEVxDR9y11FIoRcgcWMOlp5TA/ERgmrdg19+a7hUy0deyP68tzMi2qg=
X-Gm-Message-State: AOJu0YwEvbVSO4QU3aexjLp++C/0w6TQsXKpscqglQI6DpP+dn+lW8OE
	rVNKo6thL9v5LOq81Lof1/4Tkoh9NB3BFKc/NpjosfGeqq0LvGus
X-Google-Smtp-Source: AGHT+IEfOJw5AN/T5xYrLBkH4SF44gjrDZnAaIRUn4NhhD9qV1oaDre5Um3y6mcyF767v7dQrpctJg==
X-Received: by 2002:a5d:4b83:0:b0:343:ba7d:8ea8 with SMTP id b3-20020a5d4b83000000b00343ba7d8ea8mr4106937wrt.0.1712525073205;
        Sun, 07 Apr 2024 14:24:33 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b0034403ee44b1sm5132319wrt.14.2024.04.07.14.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:24:32 -0700 (PDT)
Message-ID: <fd9628af-4e8e-44d5-9891-243dd448e5c2@grimberg.me>
Date: Mon, 8 Apr 2024 00:24:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] nvme: add a newline to the 'tls_key' sysfs
 attribute
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-11-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-11-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_142435_583834_302F7098 
X-CRM114-Status: UNSURE (   5.08  )
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

