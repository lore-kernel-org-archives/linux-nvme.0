Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD19CE7AE0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUeW699pIiwvRoOrUtlMBa5bs+p07zLde3Uj8SrZj/k=; b=dSgOhT2teXu0Jig3jsbZ7LOeDd
	9U9ZhrGlgUOfklmFruXYneQJ0vdl81uOJzHIahZal0hEnfeCplo+/Kd9n6rc4bXaBj0TPc0veuVcC
	KByuHwCiNXKV81P/sG9ynsz6jCloM+CfhLDgvKsRdbv0TOFkf3Sxr/+fSX9E6iuNFiRpF5+wlRz3w
	idXClP1BSqWf5Hdcy5exvw4afgSiy/y/LNDJ7oa3lRstgdkFpxFvOZPeuFBZ/lWUSMA6yvYje+bYH
	rZoGGdZJIg/i35CmPNx+Ej/6zF+ea9Ns91SMvw+2+RaYZKDsV2d5X8WBQbqGr/924mYU9M8Ahgugf
	tp5gBRiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTd5-0000000B8xm-0Yu3;
	Fri, 06 Sep 2024 07:43:39 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTQX-0000000B68r-1cnf
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:30:50 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso9181985e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 00:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607840; x=1726212640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUeW699pIiwvRoOrUtlMBa5bs+p07zLde3Uj8SrZj/k=;
        b=uVHF8frtYnPokHgNzyUMBCkUTC4aRpkT6/yx8Ow469Mw9Tvr6VBePupAlYK19xsZtn
         QpEM2Cy2YrAFZ7e2SCbicv88YNDlobJpRwVZd6OV1mBoKQwFPBPWEMmrKSAm/TV8sZzD
         2EvYwqPvRyy9PQToIqhb1UZEVlN00d07o7HHUTE7VwB6Z356GdvR0d8dMf0xbn0NeFbj
         vS0FoGPPhkc1kKSX/mPce70yDYKo5c/yaBfzA8Pt9kj/LCuF3IOx24Qi21nQfWVbXpj9
         EudcH7bZmfjHDNhY1AYEe/KO1FUJbVUlyX6G0Pf059urxZ7Kqq/I2HxAGc4Ct0wmKoKX
         nT8w==
X-Forwarded-Encrypted: i=1; AJvYcCW/bKmO2YF8338dsnDTHtSiHQCZcySccaRS1wZT9uRVEX4vcW2VqPqDBjkxVEB+NBA7uEXRvJri6sT2@lists.infradead.org
X-Gm-Message-State: AOJu0YzaN64fMTMshvgGZBTnauVRuc9ExK2AlwLINJJ6TBTaMShuhsH4
	n+JwO4nhKRV8I3aK5T7PGLN9ndtTmRfh5JHp/qnKh5dkdq3HR2KCDPJD1A==
X-Google-Smtp-Source: AGHT+IHBGTbcXN+YJbyDwDaNlLr7zAUOsytzBYs8a7H8mV5Oa39GWARvFpMOjWpOJMEe8g0EhY8WlA==
X-Received: by 2002:a05:600c:1d15:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42c95a5f971mr52174395e9.0.1725607839524;
        Fri, 06 Sep 2024 00:30:39 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0600651sm11049195e9.32.2024.09.06.00.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:30:39 -0700 (PDT)
Message-ID: <67da8c6f-4c47-4c6d-84cb-dba79f2fc989@grimberg.me>
Date: Fri, 6 Sep 2024 10:30:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: check for NVME_NSHEAD_DISK_LIVE when
 selecting paths
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906071828.125614-1-hare@kernel.org>
 <20240906071828.125614-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906071828.125614-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_003041_670779_6D44275C 
X-CRM114-Status: UNSURE (   5.75  )
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

Patch title looks wrong, but the patch looks good now.

