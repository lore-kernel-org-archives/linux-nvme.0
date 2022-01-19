Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB66C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=OaxQp76bUHCgaV+nKoUdQuMd0D
	YFzonipYXnlBoQePZLo29oWjHo98pKnzLVdaKUBofv9a9E5nBNiOm8IaNCR79vskgxyTdkFtxhYp3
	b1QRCP7OwCAqk3LXjuJUyxGjPGSzRihii5zU2HyD3P2MNqGioO8dHhM8wlCnTRANIAyO3KYREkNEU
	g2AjAUVOKnIvN7wvZkHlh1vsABhC55HYdBrRO6AhNTVLsDEQ2tNn3S7nkuXfTWpjOAzTXfKEbehBY
	nvkTwy7MM4aXIVMm5Y09TxFocaH1V8CJnzL+c6cpAuE8wymHsN193NNxqEJCmddPwUu8om5lNegVG
	dhkSHAEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA95L-0058oI-6c; Wed, 19 Jan 2022 11:25:03 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA95J-0058nQ-2Z
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 11:25:02 +0000
Received: by mail-wm1-f48.google.com with SMTP id p18so4741943wmg.4
 for <linux-nvme@lists.infradead.org>; Wed, 19 Jan 2022 03:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=mx7HrMY3hVleglNizsNJDXuzgmrXM0gkhQMDEPKDIsyH6qpd4UU1mB7/R+u8T5+/MV
 bpwNMdwANL4fflG6MSr0+nUHXRuj4o/hRRvYAL9IvtK9DimrFlX2qspSkm1u/vH/T9PX
 jFJD2IpM+HqQ/qbzNqmxQEf/mSj1eHeOirnjnYKlJ3Ee5YRv2WRDwW1qoL82NUnSfiwa
 XUpq1ccdTSV3OH8tiBW3gduZ5zOJ2Dq8DR5+doUmIN854yeLJsR6In5Mks4LPYeM41ne
 d+XvsMvOApGP3ooUMXMCaot5IlM7K2UG+fwUoy0RR/2mTDRJK9MTDu8OYwo8uekkEcvp
 MVqA==
X-Gm-Message-State: AOAM533dMpzPMZbQKFiVdgzd0TpWEv6tKN1ULkkBTLmp6ixg5BiK09CT
 qZvv2w6zG5uUTyHdRlsUQR4=
X-Google-Smtp-Source: ABdhPJynm7QkJ30sLP5M6lJOVZAnhE22i6lc3GEf0/aBM/TC2CNV0NMhn5e0hnNQnDJ5ePls1ULd+A==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr3071256wmh.22.1642591499127;
 Wed, 19 Jan 2022 03:24:59 -0800 (PST)
Received: from [10.100.102.14] (46-117-118-170.bb.netvision.net.il.
 [46.117.118.170])
 by smtp.gmail.com with ESMTPSA id z6sm6620450wmp.9.2022.01.19.03.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jan 2022 03:24:58 -0800 (PST)
Subject: Re: [PATCH] nvme-core: remove unnecessary semicolon
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220119074954.13531-1-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ffe0365a-9516-051f-acd0-b0d1b87c9546@grimberg.me>
Date: Wed, 19 Jan 2022 13:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119074954.13531-1-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220119_032501_147709_2C39B781 
X-CRM114-Status: UNSURE (   8.70  )
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

