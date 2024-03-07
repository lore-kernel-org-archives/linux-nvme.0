Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1091C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oGD/ksgTVdTyq9ht5rUxFvPvPB
	KNyMhncKWNJfbh5kA7xWv9ujkWHuyqq6EUMVN058uOiREjdhmmUuhKTWgwrB5AqJ3S5qzT96gvE6f
	/S/5NuCTmRLOPNfmBjwJA9hK2k4zkZLgNWWcMyMtd/o1at4KbsCviejlrumhi+wjgafR9nlg/yRq1
	YtGWTVRm2HoeVSTt4Lt0/PdZ7qaVt5SkvEVNtOSk/j4WzQlraVrfFUHn07oy7JuQODYX+U2L3/mbD
	J3HgfBWsq1mNL8bfsVhRPUcsWvHWf3omQbz35OS1b4zbLElHW47oiaYf77IjcTWrgUyUL4AxB1Uq+
	1aaBnr1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8jK-00000003XkS-1fL3;
	Thu, 07 Mar 2024 08:03:54 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8jF-00000003XjT-3Xly
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:03:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso189097f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798628; x=1710403428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=E89JFEx8PknfV6hrjGURv67bIoJMX1WHVxAUK2KOGob52rR6UMdxE3oRa2kVbSz9rt
         KPcSqk8RvltI2v2unZZSWyzCt8Z+Pl1/OeVNstZi1VkaicAnzbaI4z2XRYnpzZM+55br
         iWBl6Zk7J1DaOSY6gq6Z/la/fQhfhtnefLFQUDC7F6Gh9/pMG/0q2tin/CgB4nZH/ksb
         lIYl4SHH9E5UustCrj+ZjVYXzP8OImmXp0OLaR3rCjLeVRQowrpehsdIkY/NuWsDEMhu
         teYqDX0d/Mnj/wEehWAp0gkpBUXK4KeziC49ng0HfMiaMrXLDupm0/g2aJc0P3rV+c5r
         ItLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2K5iBbMdRo9gcN8JQWHl0TRw8QafuqK0sUoFnXeLdGCmV6Tcta1AOxizIgG3JNR2u202+j2gGVYBql5TmRCCHyjUi4WJGI+Rdt6W7c4=
X-Gm-Message-State: AOJu0YxDIN/IPSn7AJNA0WBaSGcJwyXo7iUpSshvR0NB4Fm0jpkDTR5a
	JJilXAqkSybot6Rhf58nQApepgeOOO7Kz2S7fptnReYD9myGpnzI
X-Google-Smtp-Source: AGHT+IF9qn02Dx73orOwENpamqRaMQzyNDKnj4TUHzMh4o8T1FeGnBSOKiG/g/ju+EyW+f2eXU46DQ==
X-Received: by 2002:adf:f2ce:0:b0:33e:48f5:fe97 with SMTP id d14-20020adff2ce000000b0033e48f5fe97mr3476062wrp.6.1709798627945;
        Thu, 07 Mar 2024 00:03:47 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm18884841wrq.50.2024.03.07.00.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:03:47 -0800 (PST)
Message-ID: <11c683d3-bf2c-488d-9a9f-47249b39bdec@grimberg.me>
Date: Thu, 7 Mar 2024 10:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20240212042641.227821-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240212042641.227821-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000350_001797_4198AD45 
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


