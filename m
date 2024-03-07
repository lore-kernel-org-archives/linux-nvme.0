Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA21C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7YwX+UqClNBV2Vt63eIMOa4U5+Z1jcGPp1xk8wz1Wo=; b=v4kIgohtkBcsuEHHbkHy3lrquG
	OQipgYle//urbTCjWqM++Xtj+IRV7cwbj5yrDu9FP39Jxx1dxlBIp8EocM5DntmztWF65XXnVV6cq
	ewcigG48WYTU0R3p9bJyzTgUiyounmq5SjZeO1R38QaRmBvkW682vD6vQP55SL3zJOk+jJ3u7zgCh
	3N8EAEAUlEbzLY6Bf0SE0U9wn2J51uXbC5ZeUoD3dU0CvFwBb7qIcNbTRIHB+PTfTptH7KoK0UwYh
	Xg/GKwxXO+JxWpMx+It7swMFzTfqXI3WLuiYxM5nfIN9EfTKy3604gAeNL2MdPlVD/Lcs7hcUhVe7
	ayG68qQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBLV-00000004AJC-3Qmj;
	Thu, 07 Mar 2024 10:51:29 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBLS-00000004AIa-3FpQ
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:51:27 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513056fe2b0so248419e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808685; x=1710413485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7YwX+UqClNBV2Vt63eIMOa4U5+Z1jcGPp1xk8wz1Wo=;
        b=hxI6UgRgkmddOsP36PyUMA/lu0lG8QudXYdu7N0UpAszmPiT4rdKtGf/UH5rDD+Qti
         SLakpDz5ZSJ8vPHDRnip7iwocaYkDE7+oVTOlY+fYoDn8hvZ/xmohtXDtyl0OqKJ9kNX
         yfzYs+u9gIMUZg9F79Ngaez2/tAVNtLlwIEN5dzG8furysSehX8AGG2G/Ztj9mF2dx29
         7wPfNxTA9PkPL2JeZRrjWlQISJlqyQ5HguGmNBsM9FvadrrzslcbDbbLDBMw9OzsvBpk
         KGGfetQacHwVXfoHh80YXfgsZGqWD6NdE50vS7A01jK6rCzPeqQtFHbOn7ipxiMpHcN0
         0v9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQMQjXNqKLFSJUs7Dmc3XwKdIDMtb9clqAkPNP+j3rOKZFJB7sEGkdUjr/eQL0Yw9QtC6AO/LLIteWv9B0lJufOTDaa+YaxXw0kqGei2M=
X-Gm-Message-State: AOJu0YwuKk+kDOLplsaMCoEUa6V3gMgFMK6MSootiEtW+cULt1QDp5Df
	9E9//B2R9IQYtkUsElp0XulB3LMNi55+wKXI+Lug3YS+Wkts7i10
X-Google-Smtp-Source: AGHT+IGjUfjuejcgS5AfWwoEpvMw5x3MdFJnxMlmh8dnVmCm1EvC7tRpjXbhCdeJYVAr/IPPc6D+EQ==
X-Received: by 2002:ac2:5967:0:b0:513:49de:7e45 with SMTP id h7-20020ac25967000000b0051349de7e45mr3285279lfp.6.1709808684486;
        Thu, 07 Mar 2024 02:51:24 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b004130c1dc29csm2246778wmb.22.2024.03.07.02.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:51:24 -0800 (PST)
Message-ID: <ada5f304-e617-42d2-9cc5-0a2904bccf53@grimberg.me>
Date: Thu, 7 Mar 2024 12:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] nvme-tcp: check for invalidated or revoked key
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-8-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_025126_845427_01176038 
X-CRM114-Status: UNSURE (   8.94  )
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



On 27/01/2024 11:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> key_lookup() will always return a key, even if that key is revoked
> or invalidated. So check for invalid keys before continuing.

Is this a bug fix? it should go probably either as a standalone patch
or as the first in this set (if it is only relevant with this patchset).

