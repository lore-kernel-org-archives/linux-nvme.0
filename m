Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB256C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sZE23Rxgle50TnMjPSbwcnfakn
	HPDAcru+czvXwzHjJZPs/RW2QGOZTKCWfPLkwEE8afFnBFDgYBMpuRDkJR8YYAGGTUaUvwFV8C0Zk
	j7EoJ/RxGkECgGsqs+I+E7AWiTDdhlFsYeVkC6+3CgQoWuJT2J60jFASlc+6H92UQU8zzCQrDe1s/
	q+dtpFVScGCn4JFe6Xrdpy+d2MpNIZfDCRCfKAqTcnEsVIQ62QdggXQ++bNfkfHpS8Fb5YZzUBOjt
	zmW1ApvcBNRVaU7GUf2wmg36hG27rfb4KCKp/VopNR3OZ+9dFFyZVmeLsc0PUSvKSjNa6k3qDqfDi
	VbB2yy5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHdw-00000005PWr-1row;
	Wed, 31 Jan 2024 20:57:12 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHdu-00000005PW8-3d9b
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 20:57:11 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40f037636cfso82185e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 12:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734627; x=1707339427;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iUjemFeAxD970C5AxDw7PxHzm/v+3P5rJGxiW5f7I63ykGe5+Jr/34kBpT7hyOmxtC
         09WVto7183jjv+tC9PTGSF5p160gSeh7zvtSLKGXF1+W5IFrUysbfgpGfpQ+t1sCKc1L
         OCS4vAlkd9MLBln9jlD4BLOfxetEUo8FBN7BwoQwJsvqXfW6MvBpApAM0q72boC1vQKy
         E0TjyZV3B4IgB+oJJp37DXem0mBiPMV1qoWTgm/m5OvIuYx2HC76NacQtKn/tgJSF/M7
         bNpZQn8eFUFlR6UW+PJ6xOmM6uK0jppIKBT6VqWs2CrlVoAv6NYUtSpxaFbsx590QudC
         TMSw==
X-Gm-Message-State: AOJu0YzZgOJc23sDRDQCaWcNYe0/roUfIhasL8kQc5+8mFKlgTHIpsm+
	9NHipvuwFat6tAMpElejITiDnSNZn5pFI+Y7xzwp+o/roWqp/2oDC4ElB4Jq
X-Google-Smtp-Source: AGHT+IEvopKceuXxZnrKrl0sBdkOnm2JwWdljARSFQ68FFsFG52+58O/vw3PwRWm3lrGXSYYPAjvNg==
X-Received: by 2002:a05:600c:cca:b0:40f:afd3:3535 with SMTP id fk10-20020a05600c0cca00b0040fafd33535mr536199wmb.2.1706734627075;
        Wed, 31 Jan 2024 12:57:07 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm11746897wrp.20.2024.01.31.12.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 12:57:06 -0800 (PST)
Message-ID: <8eebb13e-7dc2-4ee9-a70d-6db7d0eeb91b@grimberg.me>
Date: Wed, 31 Jan 2024 22:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme-fc: log human-readable opcode on timeout
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20240131164315.160042-1-csander@purestorage.com>
 <20240131164315.160042-5-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131164315.160042-5-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125710_908886_6D4475EC 
X-CRM114-Status: UNSURE (   6.08  )
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

