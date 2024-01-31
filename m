Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60481C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fcmmzDc/OB+4ajoaxDbfTs9LjA
	JLuNLvDw/8gQl+UZ+C+6QSRcfOgmaj0XPsJIA6l2Shr01w06wLLpqzSCoBv0jLvUZg88uF95Kwl9K
	JclgWcnMFn6QO36VAw6jkOa7/I7oLbLgBiwJXzwLUPZa3kq2jXqLYsH4z3H71sLspDH1Q2qDfV4j6
	E/pqTzSE6UEPVKPjvmbIOSgHqv3oVc+YxekFrKCS099baINVDxChOUbsQF7wnYDcm5KxsJH64Xn1Q
	+ld1WDXuf6lrqj+5AxSXzXZ8IIGZW72E31Ouv46lL2AsQgArnwCuwcG5SuZeCxJ68gg8pxTUrdhBY
	ROc2SODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHcz-00000005PIm-3qMI;
	Wed, 31 Jan 2024 20:56:13 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHcw-00000005PHU-2URz
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 20:56:12 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so5626f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 12:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734569; x=1707339369;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qo25G/dtyz2nshLfZOZM35GwgpH0KNQLuFZVcJP/OT1WOvAmk2JTjHNvUv7DACQCND
         OEpVN6lndQ7FSZHa0iK2bCvuMyibYuwuXYaPew3TouVTgVW5odQPIIEhs6u7grXlDb0h
         4nZDD024AszI8uJlCLDvZyNthJxcB///O1c6BavOe6TiV4etLqZKIiSfbGwiAgy1t7Ev
         cVaj5RWEPdq1mNJuvVt1VYWkRi5p4g3WPCpOBW+ez7R/esJwwOSD/bySKT5BFwgqYF/n
         Wm2EkYk/rJ0vjVfzs2ndGpuH9FrJnsQOsmxvAYt9r2kvh9JrAuQF7r6xdLFZENURIxPX
         U2AQ==
X-Forwarded-Encrypted: i=0; AJvYcCUTWE/pISnXNql6jLcmwYMIkSEma1MorvVG+4lqPG83tCXJuyw2AQ+jShKrlF/PbUZSkzUkE7WwG1jCtd2l2wZIV/xNBAyl80MGBrFXaaQ=
X-Gm-Message-State: AOJu0YwgqhyGF5H8tLKxedsIkFxGUHL6v8MMGfwuqhCwxjZ5l2z54FuS
	iFpKBvk6RqFq7Q7CKeEKpdPXxQtaV86zYK8YH8aRXJyTIezpgEPF
X-Google-Smtp-Source: AGHT+IHHqbI/hUt645h/3DqWPPWzT//UIOJGJJVWv956CttWoCZ5OKDyQTjYu4J3hNsqHmcFI6e4oQ==
X-Received: by 2002:adf:e941:0:b0:33a:e758:510 with SMTP id m1-20020adfe941000000b0033ae7580510mr437861wrn.3.1706734568534;
        Wed, 31 Jan 2024 12:56:08 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm11746897wrp.20.2024.01.31.12.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 12:56:08 -0800 (PST)
Message-ID: <91735d96-4460-4021-bb69-b141293c1dab@grimberg.me>
Date: Wed, 31 Jan 2024 22:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme: split out fabrics version of nvme_opcode_str()
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20240131164315.160042-1-csander@purestorage.com>
 <20240131164315.160042-4-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131164315.160042-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125610_728057_DCAD9342 
X-CRM114-Status: UNSURE (   6.10  )
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

