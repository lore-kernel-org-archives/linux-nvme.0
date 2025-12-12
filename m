Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA719D49228
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/HNa0XiGih1F2Xb1xaqIU4pH9PxJCsouVifuVNq3qQ=; b=AZW+sVEwcMjQB4v1dtdyTse7Jt
	MgOQnxYTUcP3vos7HaoLyeu419B27IL8euSPzIZlfoOgDBa7qOKEdcBAOiHtyVWl6quKFdKOeOWo/
	Nmf5MDUhuQZiWoeRAghxT+9+c7nov7F81Er1dvjfRXmckSyYZvi/jEJctzP0dAa73FywqQIrhatSg
	0SPWqwM23FHh8aVg3S+Ls6AUE9PyqBpy7H2m13n+vlthKA61j4ykqybgU63fJEZG11doHg2OUaR3z
	ISAI27GgjEO3DZFXgv86WgDq42oMu98Yw8y5nzT4+MkhaSG/9nbcOdT+/9R2RObZc0eUb0MysZyPz
	u++erF3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Rt-00000000Zhr-0mhI;
	Fri, 12 Dec 2025 13:44:45 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Rq-00000000ZhH-2Dpo
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:44:43 +0000
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a3d86b773so10958741fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547080; x=1766151880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/HNa0XiGih1F2Xb1xaqIU4pH9PxJCsouVifuVNq3qQ=;
        b=EOCn8XAbbgJAwGjc0919JuTvc+UqlhyP1Bb0ukouSY797ySEelE3O3Z+hiAwK3KT81
         y2g6Dzi0O/yTsERTmwTo6vUQPM5mUmz7SmUcaK1xvfr0ARysFc0nNDOeQ0eIEQI/QOVu
         wrBPaFXvJs7LtJrpOXmx9aVR8ScCnXb2a7A90LCtBwDi659i6MqotM44lEXyyhHIqHIw
         Cip8PN3Oi9t25K6Tf+Dbr398k/KgrSsB32hPO3Sfu7FudgAQdxQ6bebTa03L+qtLPPqW
         GJeXNwqKjo9g9OvfTn5nV2+/JSYwz0qwt86A6OZNFueUm1XzJeHPWDYDIZ0aNQkyLgjN
         ds6g==
X-Forwarded-Encrypted: i=1; AJvYcCUx8oPqEyrELkYzVkMOb0kPeivzsgqjf5EsMZ/0W98d0usbcydi/ao8gOOdrJ/9ixgAgPPPqt1XylSv@lists.infradead.org
X-Gm-Message-State: AOJu0YzaJ1kPm96nngmz3QSmCae6onO38uU0MYpKv2ds1jiCVboTmqrw
	w6nNLROaokF4eo8IwnmFCRq/bA/auSrQtZVavf0n6oFqUC8R511wPpty
X-Gm-Gg: AY/fxX6sLsYuWiSLY5YCkrLmnuRoTWIOpQmRMu29lrAhqLEgXMJekeK5GrnZxH2OLMO
	lF4rzpuNSJP9un2oWR5zxlWNsw3kC43g3iH8YCe737Wks2joEdnQKSiX18o6pv30MpTdL0jEiUf
	buroVl7RzsHmc7gACHN/GVmGG5XETQUGVTBaxJDADSfcAZEOJrUESwTyEDj+La0TDBYJJi3i++W
	TWxqF52haGFVGT70YKOTUigLjPoMQkZqljTfdRtq5tRibzcMvCiS3jkvfEQWMbLRjkEv6EAmJ+u
	w1zx/1ByS/JBrKvU9PAbFksN4uXRZWJaXceQTZM3BfCtEakdD5Ve0+84DUijVVG3k1uWAvaxhpi
	Vbz9xNJA1Y8sZOrtqDsouBTlNBCo0nizFjPnrMKx223rdalID0IxrHz3Us4xPZ48V8lrWvbB8pe
	CVCW9NDctuzudEleURsoW5DKV5c+PPuAyv5e63NSQW+Xd+Gg==
X-Google-Smtp-Source: AGHT+IGkXGLFS7RbXjSToyQ3nbrewAbKLhXcqiRHT9+XZLrXuhAW8a8Zwyi/R/DCuKWjdIPw9OSCOg==
X-Received: by 2002:a05:651c:546:b0:37a:2dca:cfaf with SMTP id 38308e7fff4ca-37fd087a598mr6861911fa.20.1765547080065;
        Fri, 12 Dec 2025 05:44:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37fd29e927bsm5190831fa.16.2025.12.12.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:44:39 -0800 (PST)
Message-ID: <9c40ceb5-2175-4d19-90c5-4c4f92c3f02f@grimberg.me>
Date: Fri, 12 Dec 2025 15:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: lift blocksize restriction to 64k
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Abdulla Nasirli <nasirabd@fit.cvut.cz>
References: <20251203113000.67212-1-hare@kernel.org>
 <20251204092738.GA19941@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251204092738.GA19941@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_054442_572674_6D3C7F66 
X-CRM114-Status: UNSURE (   7.54  )
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



On 04/12/2025 11:27, Christoph Hellwig wrote:
> On Wed, Dec 03, 2025 at 12:30:00PM +0100, Hannes Reinecke wrote:
>> -			file_inode(ns->file)->i_blkbits, 12);
>> +			file_inode(ns->file)->i_blkbits, 16);
> Make that ilog(SZ_64K) instead of the magic number shift?
>
> Otherwise looks good.
>
  lgtm with hch suggestio

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

