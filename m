Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA167C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=htrqPFRpzRnl0KOS41IYrQLR1c
	Fk/UPcNDXF6qnH9MkctpSF1MyG6agfUam0HP9IEUUX/81S2DTONOUIHnF1TLbF7j5NIB7RiFoQGcJ
	tI9SO+PrcLj1A62oiO60pCCMiM3Alr88bEqGtc9Yyp8ccZIHstvAlkTTR6Yt90qreoZuUHmXmoTEw
	0RAMPweRiKwM+TJGq+rLbyEa3KHxOHHevw6hedSFxIyDvJsLkNsj3ukajBtqZvoOoVMoySe4r+sDl
	nAfqL/vsCDohB/ivZicS4pYy+67DxzZ/LcQHxsYVIvrc6Psu3j/Z/Y95L5TUVOcYHFs5Ityc1as+N
	agh6Hkbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jNC-0000000Fv4Y-2JiG;
	Fri, 18 Apr 2025 10:55:06 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jNA-0000000Fv49-38Ph
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:55:06 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1637582f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973703; x=1745578503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YaSQd9mSe2sXn/OA65jDJTd5DZJLpSLsK957HRWNyYCOCbUcWoFUfHWvEE6rtDi7wk
         ZD6RsBRRBT/8VOM480Gzkftut2YoUiCpGT/YeNGUevXW/ocGiTInT4OyHxkM8cXIfsLu
         QmUyMn2YBxyy9hw9PzXELchVz0GzIm08UMXo2R/sruE23+Da/zn/lkITiz5mEz68v/Vc
         4ytYEHRUKlQkKe0mHWSKExVBXELuTBKyvZR840WvrELGrFt9hqbOSzeM1BC6vnYwhJ4Z
         5LEtfIU27LKuR7I+jgzC6fhqeolKIZYsmDTCclxmjPGB2BN9df+ffq/RQV2e/gJoYaUb
         DhIg==
X-Gm-Message-State: AOJu0Yw3L9c035aXSmOa3YUVaaRT+wzO4xBxyKlOIfZxRSkIubD3ycNR
	66uSaAQcZDbRtJlvxPNjtQ6g9Ld8q/B0cVAq9Fo67KWElj1phKk8
X-Gm-Gg: ASbGncvS0dvgWB98QniCpfvbdNTHMIGhzis5DugThy51YZSHaCugJob5R8Yh0oWYGz5
	jWBcA0QX5bANuJc7WbRygcA3dkCrm2wbrf7lDQMyXCdrKzUY32QEnCpD1m7ej2+gyMv9OZGB3M3
	qRotjw6kQbFq8K4dTsB6qB538yRm02uF+BC8HyzSmX1tU++dzPQEOX3go1m4QCEkVHogdu1djk3
	cwI95r5gYrTc2io8DXhnGhH2NoUGpOeGbcROTbZEsAZxYxTTnEqmur2lxRgXLJWQHh18Cx4JvC3
	HS0Q66XVjVfTYSdMMZ6hAxPG6EIDW0H+5fAEcRb3
X-Google-Smtp-Source: AGHT+IFTMnm9+bfwTjn7vrtWKhFTRku5ftbLqGSkkbWOuXv0EEKFnV3+WhSXuKtWzRUp57rrY8EEUA==
X-Received: by 2002:a05:6000:2489:b0:39c:f0d:9146 with SMTP id ffacd0b85a97d-39efbace605mr1682750f8f.45.1744973702792;
        Fri, 18 Apr 2025 03:55:02 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acce9sm17980005e9.13.2025.04.18.03.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 03:54:58 -0700 (PDT)
Message-ID: <07238ec6-ef31-453a-a57f-d22117e9b76b@grimberg.me>
Date: Fri, 18 Apr 2025 13:54:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, dlemoal@kernel.org, kbusch@kernel.org,
 kch@nvidia.com, hch@lst.de, upstream+nvme@sigma-star.at
References: <20250418080250.2736590-1-richard@nod.at>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250418080250.2736590-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_035504_819144_F158CDD9 
X-CRM114-Status: UNSURE (   5.02  )
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

