Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAAFC3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FGxw9VJM84EOmTZms5r1Sumz9L
	RRdPAuXH2Nr1YBiZx/YLLbUd7dUYIhBh25IDk7ipCT9skn9xQRcisjPE0cgEKaTF6kJke1Xo1eT+1
	PRXCjZJGB8JLJWHf1NKwFL3dNsprH9OQnajSuvjsVL40L418LCFwLq81kMLl7DWZHKhmGCeA07VD7
	ztCrke754Imjev4nng31zj0+FkNPtnOiCn71kxariq0LoucHzZed1KZni2efjXbjJg9l9n7oz9nBu
	TnPUIe4Bop9NEJKZUU1w1MO0OfmITLipsRSRwz7Ayg58W65b3V9zhOk1q/092IeeZ5NiHByJ/j93y
	ggfQjCyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDCf-0000000F7xJ-4BHg;
	Wed, 17 Jul 2024 22:32:53 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDCc-0000000F7wT-3RhD
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:32:51 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427b9fca517so236165e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255569; x=1721860369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nddXJJLGopDNESvZnzxr/F4CFXXSAMON13k3/69j8ZoSUTwe3t2NMLXr/1h/ypxY6n
         sg8T3wT+NzXVptsJGA2OmcQXLU0ggk/jLp8dfy1OCi/1emP1ge1MJVs0XuyhjX3nfC3T
         ulkvIQikNhbDAIsbHpGTiPBOw6uXyOfICV8UgnF6itdvksqHMa3JkAwBUZLRtsbAWsjK
         3mJHIuNtQcBNgTVr4u2UgGS8uVh0djRPJplVFiyBpS0EycRQDZhBF3CpmQ0pKHKHWSEy
         wT3wHPhNFTIWhje87Y/H9o2Lr+hHZzsR8/7I6/SH1+6AQfZzENUWefD7GEFH2d0fFGHM
         aB7g==
X-Forwarded-Encrypted: i=1; AJvYcCWltNtmflvE4kW8bLPEY9ijhnlfaGH8+vZK+unsw+tJVTx7UwiX1jXISAD9DDw/DMvUmxiR8XM5P0/h6nm5nO3JnHhETAiC6QGpldKBXrs=
X-Gm-Message-State: AOJu0YzRa/5K3jl0NKTHHN3olg3oXuxlfRnou4O/QTjfAqP9L/0vAM8R
	1KoVTci+WqJx0uhqhGK5MC2K2dGdwVi4+9K5tFtknMYmHMUVoxyzAuyr9Q==
X-Google-Smtp-Source: AGHT+IFVhmv9xuMGZ2PLFFIEaPFd981L7zRfYvyTDLBj3CJ8Rs4fX6cb2+PlImzGK7D8hFwPlPoZOA==
X-Received: by 2002:a05:600c:3b26:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-427c2d2e1admr14268725e9.3.1721255569381;
        Wed, 17 Jul 2024 15:32:49 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7815503sm12076375e9.44.2024.07.17.15.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:32:49 -0700 (PDT)
Message-ID: <3ac11c52-e788-465f-af51-1289bbcbee04@grimberg.me>
Date: Thu, 18 Jul 2024 01:32:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] nvmet-auth: allow to clear DH-HMAC-CHAP keys
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-15-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-15-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_153250_864342_4F02825B 
X-CRM114-Status: UNSURE (   5.41  )
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

