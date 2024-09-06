Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B2CE7AB8
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFL1s4poDH8CH7Nn27dDb9Exwn2gceKVZUV0anJiHEE=; b=xvRzNKWz2Ohgr41nYu9B7F6WSi
	7oyZbgHu9rDXAy3O0oBnhunjz/e0U53c546dV2ho/+nCloQ5apQzhqs1jr0LEjt//Ydwq21a+4Icy
	W+TvPLwECw+ooos5hWQYGDleyTNR4d2FOJfICqJjLFKZYLkGUFuduuhw9L+pwg92DgLfPZwXlSEKP
	ssptcEiBx/MTHj8FtB6P0ThL4rhiu+b5KLslXO6oyjKrXJxvcV3zgPbsOXR4SNZnQDt2e5Uk2V+Gt
	IdSpls5kElyCeh+n+gNbc+B0hcfibtgO2sC3PEJV+ABZEwQHOXN5/gOTujFEXHjikGTHNI01BWRko
	Um3eIzWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTYp-0000000B85e-4654;
	Fri, 06 Sep 2024 07:39:15 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTPP-0000000B5Oa-3au9
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:29:34 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso12727195e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 00:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607769; x=1726212569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFL1s4poDH8CH7Nn27dDb9Exwn2gceKVZUV0anJiHEE=;
        b=GwhbkR1nMBADid8erU2GHsbXwVa1RRN4gDxNGmzXGdfrmc8GMboap6LuBV5Ggyyv4O
         lckdv52TcEuOOafuU1tI4NBvbaeCRnfo1fyAvF+pguAx86eX29fZt8ItNoglcg+8lb1b
         AvnDDu1jAo5JemOxb8IW4SZV/9HzoOgp3TppPnoh8+SjSjVAcxiChKAt3ZENxstJWvqU
         COOC2R/5tc3iv8FDRYpIH/BP/NKzPXhC9FJ52KK5ZArtI8mCDE+kHySpJ+r/Li9sB9I5
         uvz3Hjp0OvvANb9yF7txjQ+Amytc5/phHf9fHLph6aLLDVDLrmJg+zJMW0ALEg7eoRnF
         o9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVX3ahoiD05rV6mO8Vc6aZWfEiYk2hvdR/+BMPMxgZqI8XHP/X/U/iPb8dLlrkmWF0kmjoQsaN22L0M@lists.infradead.org
X-Gm-Message-State: AOJu0YwDjOue2CnOhPSn8d9/7G41tq7M37nUofnSn0zCRou4QPbh1+7I
	6TAx/5IpDot0PuHS5FZNgns7z8CkK640zGpwa4czHomjamBgSshr
X-Google-Smtp-Source: AGHT+IG/rUmAibtCfPsTwvQKVMfcwiHF2ZfhnzrU7q3cKUgcHNAHggW47eRMHIJ2zKA2EZoWR3CyAg==
X-Received: by 2002:a05:600c:4f8d:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-42c9f98a2cfmr11390005e9.21.1725607768824;
        Fri, 06 Sep 2024 00:29:28 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cf086sm11112515e9.26.2024.09.06.00.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:29:28 -0700 (PDT)
Message-ID: <25d2867a-539b-4510-a17e-790f71ee5f7e@grimberg.me>
Date: Fri, 6 Sep 2024 10:29:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-multipath: fixup typo when clearing DISK_LIVE
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906071828.125614-1-hare@kernel.org>
 <20240906071828.125614-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906071828.125614-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_002932_408570_D0431886 
X-CRM114-Status: UNSURE (   6.62  )
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




On 06/09/2024 10:18, Hannes Reinecke wrote:
> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
> 'struct nvme_ns'.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Christoph also gave a Reviewed-by tag iirc

