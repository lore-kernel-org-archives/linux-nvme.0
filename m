Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC9CC3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=de9T+rDiow6EMqKop88SCvRX5DI/gKZFYXCxEfAH5IY=; b=MME7daXZdcioqCY+F5SCZSPQ/t
	Jd3LLPjmmQZsPi9rr3+j7kDXF68+PUpV43WHngfqx/EkoIU9tFG+SludA1cbcMM7PWknj77eTvh4U
	DwJI5xoVBdHmhKx4XpGJfBEurouvCQjmTTaE+jvtTqnY9VX0THV94tiv53Uw8ksj1RfKLwmumkOzZ
	fFuUsPOeNF3dH2feX0s3aFntKtL5XKbFis5InJCCDJgG6YKOwDu9xu/ADHJixbJ1tlBsEMJ8XWham
	a6NGOdJFkQELel5Z1F5UIA/s6TcBfBRebbl4bcZLdjlKwfhJ0+EKuANmTMUQAtXAyYJISih1972fP
	y/BTXJKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCNA-0000000F0Nl-2WaO;
	Wed, 17 Jul 2024 21:39:40 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCN8-0000000F0NA-0KUa
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:39:39 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426719e2efeso217365e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252376; x=1721857176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=de9T+rDiow6EMqKop88SCvRX5DI/gKZFYXCxEfAH5IY=;
        b=nTdh2aKRqD85fksEbxdca0WeaXpVLgsrzCsohywuICJOaVxdfya6L/6OBMWoVeu4YJ
         rzqoUPfGeAUpMFV18y+PKAp5k20CXRRer4pTjl2XnVO6Se1PlDcg94AeTZfWaooXb8Oz
         mxin5qV0OqF9OE4jtQklFSJJszuNoP4qGZNeZRMOgCHta7ehir3NNmXBmaOHuPrlFrZl
         3SuunSXhG08kDOFdaStwz3Xf53VnUBO78oKCd+ytTUApCJhz71YQcsMSjq7EQPuLl23Q
         ru5YmN+IfmpCLcd/XA4wFFvLBypc/1cmtscMFOl5rw2jZf2LZvEZyaij2ub5vacj7iLY
         Jugg==
X-Forwarded-Encrypted: i=1; AJvYcCVII6rnaWSt1orgEW+gGcxlJEXHEjBvmS3dl8N0EY8a7FDDMkyBMLNbiurxIQRcoZUbiVT4kc4pvf2oG1dOX/hPaq9eBpQg6Hld2mAd4Js=
X-Gm-Message-State: AOJu0YwXzOHVnLNiAJqKbHdISW8RZHry9YqN0xBKmP3ZVf1gGqFPimgJ
	CwzTAfilNYCFXA2BksEmAmgu4cdpflQgfr0gSXfjJokRKNg0qUvn
X-Google-Smtp-Source: AGHT+IFkWUrdjcv5HUwzqnh0GXVLAHhy0RhVE6yqF80JHrcuvBu4OCv8vMM+w6QLkZiWpn1W60K6Og==
X-Received: by 2002:a05:600c:3ba1:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-427c66cc312mr9090645e9.1.1721252376510;
        Wed, 17 Jul 2024 14:39:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77c2de1sm11552665e9.19.2024.07.17.14.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:39:36 -0700 (PDT)
Message-ID: <99809d3a-d0dc-4544-b246-bcd46d37e243@grimberg.me>
Date: Thu, 18 Jul 2024 00:39:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_143938_147490_89A7A13A 
X-CRM114-Status: UNSURE (   5.16  )
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

This needs to CC the crypto folks...

