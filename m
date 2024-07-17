Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E965C3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=An4TToFK9dSIUmBZ6RYcprT5VP
	d7qOwZcVbYwoX2lNF2Ub4VaAgeG3hKupcTcsTPMAXQkD0R0s+LOTnVmbB2wbn8iaA7TTh84e6Yo8C
	P9zPL9+j70zchewnJtBM0LkbjJRdmqFeRi4KLolv/1tYayRuYT8K2IzoIixcJgosJ0zQ/i9BdgKQy
	8NSdfVvB7tvnBpRL99Nordk+Lb+WWn3SkPUlWxdiyPvIs2dcwFVJ/nbdFAO3puK+ozYSE49t2mobp
	R4t7bdfo9pL4+2dp5/2aZQMKpcMDhe6bUTqJlzw9XSe2KaSRQ8+Gx9h9vcHsIZVTcLDxfaMd5+Ppq
	JBbS9zdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBHG-0000000EqdL-3GQC;
	Wed, 17 Jul 2024 20:29:30 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBHE-0000000EqcI-09MN
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 20:29:29 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a0645984so1401f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 13:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248166; x=1721852966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GKmaUu/azY0Y8uYsjOPoF+IJF0LFFGJzQeYv7NeiCcgjNEua1/fVX/moqVMpwffWCT
         EmUkRUfpCBFEBWGb/XiZR4kh+az3/m812o+pL24nASnjQfFDOU5uIqZgumeiFSgPjiS6
         6pCWXyZ04QhuZcYzFo5ayAJWBoc5tj47NCfMtYOhoYT+sSFI1Um7Ji+Q8yOyrY0bsTMR
         5h10BfKKpfdI9UG6uCUG4BKL57rc9dYYlM2bSlCqyS0QOPDU3T2j/9oBlbvya7m6S7W/
         4Bn+NZZLWngthzADs8sJtUetj8uYBDKebamHGcjVplvF+uExtP6F3NExFACIvJ8YclcQ
         ritA==
X-Forwarded-Encrypted: i=1; AJvYcCVYhfx0RRRdb4QvN4fYEKVIbaVCvtRVuVVjIWutPViuaTPuK+H6vuPCbNne6ypyvUenPBbGvD2iUTI3JruRGP9vg1YxGCuvS6mAjBtI0FU=
X-Gm-Message-State: AOJu0YzIirkdNzIzWwJruL1R9QBoOuGmicsqrms/n7vIae78IKSIoXnz
	yDcdepkycArXC/hW4KvmOfnI9K5BBTPkeWXRTyk9zQQgM78zCL6w
X-Google-Smtp-Source: AGHT+IEO2DpBp1N6Ll+/zU4xSa4F/70cpRJaQU9KNNcMZak9m5oWaQlfCGfSZXEiPPcmESiRxwki6Q==
X-Received: by 2002:a05:6000:2a8:b0:367:811f:814c with SMTP id ffacd0b85a97d-36831652928mr1167016f8f.4.1721248166028;
        Wed, 17 Jul 2024 13:29:26 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb99fsm12536938f8f.84.2024.07.17.13.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:29:25 -0700 (PDT)
Message-ID: <ce3fb9bc-e746-45c4-a25b-9aed15842bc7@grimberg.me>
Date: Wed, 17 Jul 2024 23:29:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_132928_078157_A09DD9B8 
X-CRM114-Status: UNSURE (   5.58  )
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

