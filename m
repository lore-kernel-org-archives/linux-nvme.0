Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A079D13589
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SpGgvbPfsZKAslaM+g3PrHWVW2
	xRJZ9Y3iVjZjFomsVq23BuRCWup2aokEhJsrzbpNp0PNKVU3icPGTDmP07VEUqTFB6pgg+tiWkfHf
	1Q/Vip0bTApkgfp+tKwCH7JCI5yddJWaCF/WuAvJfA955Lz2CEsBIaqOUN6afLhzzC02JbTU+r7rI
	UdPi2o6CF3SHy9RwJ45RDJ5vVbeANVKbWmjdWfhVYpzzDszM9hAUktlTMkf/mHcDs0LugvxnQV0Py
	wTujCeU3NcNL4WqroyhMFY6gebfL9of/CxPVD4qWjfucgDB/7jKitXQu8MCcgNVRP6SbHhSFIMCQX
	lvOR6AbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BOd-00000008z79-2YK7;
	Sun, 27 Oct 2024 22:06:03 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BOa-00000008z6i-1b2z
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 22:06:01 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so262978166b.3
        for <linux-nvme@lists.infradead.org>; Sun, 27 Oct 2024 15:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730066759; x=1730671559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jC2TmHSEi6tMntTVVlM4ZXUbInEhxedqeQRRimvC+XhrryI+nBWgkak6hKS/KVDFm3
         JukcVJPdc4NUXEJ0IWUiRixvBuUjaEtJBev0hu0gjVrnGcvXVaybvLgI3xbfMywhSd/j
         RZvTsKlwm4Iro4Uvs0/4/oQQ4vtw9SoDZdBFyvYtcZhtViHRtN8xB9QKIQFAPDzZQQrU
         EBvYP/n56TZNvYNHHw815xI048kmzlv6YpoGD0KvwDCxxOgJx77Nkv9BFvrnm47ZU7fp
         +9rejBp5jt448wspsAcToprdwQhebDClXBPthXRVC/NWfr9UuKgtYNT/1pSsG49eeI+b
         vxrA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Rx6/bsjYyiB63KWT479ZxFjH+UUP1LXoh4Wkjl0F4XxXE1CybpmnJDrtYvSDDnRhQ7QZ0XPXMn9H@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9B7v614m6/c18JtC1q6WQE1Veg7ZZwE+FU+dxxK/rkxJ3SQR2
	waiU49VtO8Or5iGCMzBeJq9+Nj09odR/rmMrKEYOXczWpekCJpjeGsQ+dA==
X-Google-Smtp-Source: AGHT+IF3tJdo6p4b9eL9UfN5PhD9f2oTOzckmlKuzrrQlyqFPq0JxsR6MaiqVcNx3QzpgAxh157OTQ==
X-Received: by 2002:a05:6402:13d4:b0:5c9:4631:c47e with SMTP id 4fb4d7f45d1cf-5cbbf8bcbd8mr5516679a12.13.1730066758368;
        Sun, 27 Oct 2024 15:05:58 -0700 (PDT)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63475casm2662929a12.88.2024.10.27.15.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 15:05:57 -0700 (PDT)
Message-ID: <e9556edb-8bf9-4bf0-8246-554ddfb66f91@grimberg.me>
Date: Mon, 28 Oct 2024 00:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fabrics: fix kernel crash while shutting down
 controller
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241027170209.440776-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_150600_500086_1F9CCEF8 
X-CRM114-Status: UNSURE (   4.16  )
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

