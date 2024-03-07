Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2C4C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NuF+qPJABFgOg7vA4V2O7cmy7VCmpDEn/7jbFfX/J2Y=; b=rE6zWlQtnGi076yJtRU8kmc7hB
	ehkyZgw1h+2KT56QIbSzEh2AncVAe3lXW95GJws8DQ2z5mw5NV8wHX/1ORojuNvkDbHOPsGPSAqHV
	5RFKOrxdYitS+9BDHJcdMA3pXrDA1T6pujG2cb0XIsWyY1IrSC33+CP2Nfn2crEKc9eUW+Jpcp2Za
	XJ6kCTTMtOFDmYkcqtzMFNRb4tgJ6Lxw5dclr4fpqlU7ZFBF4XDXvzytHcw6PexcLVNUFvkjl1JyD
	wInF/dl1lmG4yD4oRxzrcxNXcKWP76WMXkNIkvoBQCQ3M7/2lvGwjrjLcD52ay3xmWZZLQG2GwIDE
	7tPeBayw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Hg-00000003fr8-0gO8;
	Thu, 07 Mar 2024 08:39:24 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Hd-00000003fqZ-21ae
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:39:22 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5135a270cadso252949e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800759; x=1710405559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuF+qPJABFgOg7vA4V2O7cmy7VCmpDEn/7jbFfX/J2Y=;
        b=qijrobz6FSR5E/C6AoUO+oi4GZ3/oBYvcdetKdGN5XQ0TQCjBZRewapj+A/S7ah2ky
         RzO24lgG4lJ4J3DZmKdFheNDvdtzw49F1Tm8K/obBzYmIebE4T8RPK5YJ93fUqTH0nwo
         Xwi8qqT3mRiKi3xpDR4Ihwj+mzy+3hiKqDaO0k3/Nt8vfQy49WZjVPoA78Xp733Ez1xO
         n7nEVTcNoXHSBPFLQ+oW149M2cLtK6thZj20JrH+4o5CHWOZ7cVu8GkrxievBkmXUIFE
         8mlWqHczBNINsD1FxJlKpyC57Fjd6E85YNHDJcIIi7PSL2aiZlJZOAlWzm/BdExXV5Ni
         MYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbKC/nv/zqYKpvTX6pRaa/8euwnMiXsUN6LC0A4qQZTgB2EKjM1VeUbldE+DXR6HNu3/rDMAr3Ln0M8BNfosFRBVjUN5BXjntHwgGMxdM=
X-Gm-Message-State: AOJu0YzzPvn8dyk7abcN/SKtOKltoEr6KW02mujZj5wfJPTTO9WTj6YR
	w4iuv8WjKSnZx3CdFVUfefWvQQzy3izqNxyH/2BA19e5LwrmnYTf
X-Google-Smtp-Source: AGHT+IEl+WlZVJiVq8IZf5wSRagWHVG0u/tE7mCQhtsneylApmt2R47hLVqxcBZNSr8Aph9hLCoG5A==
X-Received: by 2002:a05:651c:104b:b0:2d2:4532:e6e9 with SMTP id x11-20020a05651c104b00b002d24532e6e9mr709243ljm.3.1709800759017;
        Thu, 07 Mar 2024 00:39:19 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fm11-20020a05600c0c0b00b00412de55135dsm1912930wmb.41.2024.03.07.00.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:39:18 -0800 (PST)
Message-ID: <ab89b6a6-7015-430c-90de-6709c342ed90@grimberg.me>
Date: Thu, 7 Mar 2024 10:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: convert nvme to atomic queue limits updates v2
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240304140500.78583-1-hch@lst.de>
 <ZeX2eSKE5OSAgbGh@kbusch-mbp.mynextlight.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZeX2eSKE5OSAgbGh@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_003921_556743_BD1EB535 
X-CRM114-Status: UNSURE (   6.28  )
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


On 04/03/2024 18:27, Keith Busch wrote:
> Thanks, applied to nvme-6.9.

FWIW,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

