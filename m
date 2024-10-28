Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E79AD13588
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=srtuIN4UDIeP1iygrB3xWagRqJm7i5ojzFZmABiEEaY=; b=F/ed1+uDzy+/zrNybyuNBotVbJ
	lJOEeMmmB+BWqN+LaVGTNmPkeuJLzTfyrkB9xkg62/UCsanpf49nnPgqG08JD9t+uOI/Fdzkk8HVM
	RBDki8v1qY/6JjAumB6b5emzVvppAj/PN2zDC5OZ44Z+JcJI/LDp5hjezng6+U2P0P6yz+MQTC5pz
	BmblBIORCYFCSZN5aDZ6vxMviil1v2s0hDtmYrcvUeleX0SE4hPjvD1QYuzyJO0BhEVhltaN0ftiP
	yZnwf+fqOkElV+rj1rtKkYXwDMQgK933UWlHrbCim5jRuMtH9GiceR8wurczW1RdVduA84Hl0oTVR
	bEtZePCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Lrv-0000000ACU7-0ifm;
	Mon, 28 Oct 2024 09:16:59 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5LpM-0000000ACAv-0sdG
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 09:14:21 +0000
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so3234625b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730106859; x=1730711659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srtuIN4UDIeP1iygrB3xWagRqJm7i5ojzFZmABiEEaY=;
        b=wQHQOup3k4+Afdfn5UdWtWfnolJuVYwkJcNi25DLAiAbgtWTdbhNooMGyu3hD+00Z8
         nNIeDdDtMvcu3RjoRBi13TCUjdwaAMbldZjGGdxL6bV8wKtmRMmAvx74WH+TpVaVEH7m
         vWXMFVGoPb661g8kJPHrPg6mQbkNNfLJV6y+tmfdK3RHnjnuZJopYKHAQfHbij2hdsT2
         x0vUTxQVp1wJCWdbG4hdocS5VRpdsB3709mMBsvf2JDL40vJg2mydqWWWg1oV2YEPgQ6
         K9B7av90EPPOLrKG/hJ4wJP6J75ieZNx6a2UR1/SKthCMdTVu1vndX14JYh3MmoKh2KI
         K0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqSKgkk1hgRczUh6rDCvkqUXTEWyA6jiATKQT0FgqQl2xdWb+3lP+NlZknUcmaoQdptdpReAq6fzYu@lists.infradead.org
X-Gm-Message-State: AOJu0YxXW91rQ2RhIs3VPofDADkYm21vU5PyRvAaDF1GIgkhoh8WllsQ
	4xegyDi5tmfEpnAq9ZkGjsKp2VpTXR96rYKEAdFxnDP7+usmxJnw
X-Google-Smtp-Source: AGHT+IFOcVoAiReNFsgJm7hIlhvSGHplTbU8aitfUuo0JTbtalw5Mn0rBOj06HtVjHNR3vdcjtAsLA==
X-Received: by 2002:a05:6a21:1690:b0:1d9:3456:b794 with SMTP id adf61e73a8af0-1d9a84bcdd6mr12174889637.38.1730106859191;
        Mon, 28 Oct 2024 02:14:19 -0700 (PDT)
Received: from ?IPV6:2a01:73c0:66e:d542:e044:419e:4cfe:6873? ([2a01:73c0:66e:d542:e044:419e:4cfe:6873])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4c89a5sm8739446a91.20.2024.10.28.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:14:18 -0700 (PDT)
Message-ID: <3489ffea-05cc-40af-ad61-63750ecc7923@grimberg.me>
Date: Mon, 28 Oct 2024 11:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/2] Implement the NVMe reservation feature
To: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241028015844.111210-1-kanie@linux.alibaba.com>
 <20241028085543.GB27771@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241028085543.GB27771@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_021420_279943_D824A462 
X-CRM114-Status: UNSURE (   6.37  )
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





> FYI, the series still looks good to me.

Looks good to me as well,

Did you try to use it with your recent pnfs-nvme support?

