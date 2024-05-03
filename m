Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBAAC4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 07:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ean6watWpOT1po2D0lCcyeVnY5
	E8PPF4chU3hyANJ8ypjz85mVWkcYum1hroTAncogMC/csrWvjVP8zn0ArTITvRBJhgKT9e9vdV+vc
	k1UrbnZ0pMJq/kjLcrxhPU5xedXwSecN+ChejXebd3U8n7vz9OpLOh/1SiuOO+2plL35N8s12J2wJ
	B6V53VKf+YRZL8QE4PDBbnrgOCDEw4FBTy2d2iebWySoQP4cHwrm3UGbsLyQ7zI6EHfUWZShjgKMb
	l5X3V27m1kcuVbo4xcEI0Et9Q3gXOr+xZJEVspyKTND5PdFgLC2xoxUWmrIzSq9i13BdMtkgnzEOk
	ue/Tu6EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nTb-0000000FUkw-0iG4;
	Fri, 03 May 2024 07:37:03 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nTX-0000000FUiV-3QFX
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 07:37:01 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4190c2ec557so6089145e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 00:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721817; x=1715326617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NuZAFXRhlZ0Zm4XlySSCDGR7qqrl9fWWMvrwxBgDexPxRuOxhOXx9VarX/nwrkV+W/
         x4/pKYRsmmN4YSpESDbXfFDMB2O+hYuCsdMGxtKH435Jc1Mjt/iD2HI9JQXYesyr0fjz
         njVR3A0daV+Eg/CbyrdtUbSD5seGnlhPE6HiF+68AAc6lde/lHLsAEKzOeRA5aBzBZdL
         ImNAi3129vwo0Fb/xFp1zBMcJq2g2M86qHR46LTCkY6Y7ya4sWza0eA4M8fL0z3T8KyJ
         5WlwoeT1lct1YFO1EWqF3ouBOJJkwJLokae2JueYQe+3w1Z4vmJYkzN9hRAwfnlngW5C
         pMKg==
X-Gm-Message-State: AOJu0YyE0ucDLcZ2ToKykFdGgtGJnx0f+Mo6PvhtRIfdF/RiWVuXbWNi
	4IJHr7/XdA57J73qQmnlKmORZ2fTKOj0R2pH5obQR32bfHDvt4fJ
X-Google-Smtp-Source: AGHT+IHtI7PXsGTvS0PejopXDV3j0cpzokIHm1OsHxbL5QXjegcU+s4LRXuiJNcNW0/A/Wf3XcRtOQ==
X-Received: by 2002:a05:600c:1d25:b0:418:ef65:4b11 with SMTP id l37-20020a05600c1d2500b00418ef654b11mr1388283wms.2.1714721816799;
        Fri, 03 May 2024 00:36:56 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00419f572671dsm4638575wmo.20.2024.05.03.00.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:36:56 -0700 (PDT)
Message-ID: <504a0e06-477e-4f1d-8ada-a43227a885af@grimberg.me>
Date: Fri, 3 May 2024 10:36:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: remove sgs and sws
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240502063438.422046-1-joshi.k@samsung.com>
 <CGME20240502064150epcas5p3b6461ca0466650cd0296089d257ff861@epcas5p3.samsung.com>
 <20240502063438.422046-2-joshi.k@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240502063438.422046-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_003700_182636_575286F7 
X-CRM114-Status: UNSURE (   4.86  )
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

