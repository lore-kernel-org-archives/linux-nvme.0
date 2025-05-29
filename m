Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43DBC5B552
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gAG8TEsJOvrpdGG5O3WipMgoG0
	dfp/ZSaOUJsfw2BuXRamptblgCth/DQZRWozYDV/VIVz5n+gdRx2fYbnh7PWCf+yTDBbQOFcewFKT
	BcjSyJNVfrUJJV/S0q2D+HP7fP3RIogAInDYXIr+Ut/R8e6MhbQM73eaPrCJYXjclLnRMXaxQWBtS
	0fEyScZ6bofevu1pY3WOSmgVPjIsB9euyEiV1knU4qwv5bTWJbhSWnLQfL1SOVGg/Wf6qA7D0WvTD
	rvM5/Pje1ouEWJDAHCXC9BsirtdlqGsZgK3gz1pXuw3iHhatZyGpMQJrIzZ3LTggVAiBbbYVaPMIj
	zicKavcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcrv-0000000FoA2-0igJ;
	Thu, 29 May 2025 13:00:23 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcT7-0000000Fk4m-0Hen
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 12:34:46 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a3798794d3so742554f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 05:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522083; x=1749126883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nqKH4pZ704inLv/eBEbrhi7T+CmlnsUiXVF1X9+ffjB2M6AHNxVC1YvRcVu+PyVsll
         YKZ4Fz+sINiFM2/vovI8zPl9nYLWQFQqZ/KX+FOhGYz38OpZe7O5DWxeIWq0phKJ7Fae
         Kud3yMpW6WQCOT7AEP585vaLCld0hB/RZRT9mciflqUtpAi7n9WwO5Ibc46GN/NYwsie
         gLCiIY4VLEAtEbzA8DhblixmMHUBgYmuozwLChkXwXWMfMgVs2A1kJpScEX+4LsLWxbJ
         f83rCJqxyOiUJIAFR5Pc4sTma6UvUqsesgGy3cXTb+34kY8Rh+lHWrBdkE4O4eYo6W9G
         SCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWupc7963BJynr4BGxLBX6tbo79ACRHNBokJ+NVy5b1Jy0tJu/yB8Z3AG+vnoc6cCJywF243yDh7r6b@lists.infradead.org
X-Gm-Message-State: AOJu0YwG9fhOFA+NIY0/+Y+4NMYue+t8uxxZghu3Pjy8zRPvOYDWd9L8
	PUS9pYj1wCTv3B5Egud1qIJKhtBn9jUhezDyGrUbDTtygpqLKqu+pJkI
X-Gm-Gg: ASbGnctGTc4vQp53WY/Xh5M0G2W4ZmKRD8yTKfZBhxK6MisrJAqyxZyv6kkHKbvX6ym
	SeddpFpzM3ROwjySfTqeyzMrs2a1+mez+CaAb/8s3V5fGRAOGJ4QgLu0ZJne0fCJbNUO9alY6Va
	rQI9cGuW+gNKwWo9l8MzlWPRAhI9a54APu3Y33QmF4RliDEsjsBAR2XdsQZbRXelicSR+LX0CNU
	iUArvSaT1N9UDnFlHx2WRXsF/ESCDoyMHfe+9h2SMSJDHF9VS8ZaDBC/pVHAeePWzRX9fqD2TuQ
	dL4SDlS3y0rVi2TjCR3hsdD0SX0icrx+6Hetro6RzN2aV8N06KOelWsnFD6tfvxOGiknlpuNsPn
	jLQaGCm2p
X-Google-Smtp-Source: AGHT+IHX5u8o1kT0gw4De+eB8ThBfPuzjpvftHYvRLFPh6fYvAqEv8OffHb9H6e/RhvePRnx6zB4Iw==
X-Received: by 2002:a5d:5846:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a4f6558fe2mr819719f8f.27.1748522083306;
        Thu, 29 May 2025 05:34:43 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc34ca1sm18740045e9.38.2025.05.29.05.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 05:34:42 -0700 (PDT)
Message-ID: <edc5c415-4db4-49cd-9725-c218fe06e5ab@grimberg.me>
Date: Thu, 29 May 2025 15:34:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kamaljit Singh <kamaljit.singh1@wdc.com>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250528064535.135653-1-hare@kernel.org>
 <20250528064535.135653-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528064535.135653-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_053445_109048_3F16D610 
X-CRM114-Status: UNSURE (   5.97  )
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

