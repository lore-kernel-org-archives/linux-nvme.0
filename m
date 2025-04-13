Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30164C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vFuozLWOHk8KRkqQUK0cOH5YoI
	3qwA8x9u80IHB7xiwm1ysrkeUxcZpxA6ACkuasvNrmghbuIrmHUhWgThDzbYFmcZLoPq/GUiLxXqB
	HPM6OeAkQoLvUSpUkgkNbQ2hZaLwAsfywPxuN6zPpQDYoI3vMJD2qD/Tf8apH6s3QzpisEFHV+Yzf
	MK+gp6LcLVH/X4r7HVPBaVXWEoBXNQ6DVrawkhDb3i0Vw/8rx0TLtQuN7OVlgJ3rUBRgvAYmiy10J
	5idfaWfgibiUXPx6ZfwFT8vyxRSVfXj2XFOMU5sJf3zGTEN1Jz8Nov5o+cRgxOjqmhECZ3yLUmXMW
	JCn5Y9cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Y1-00000000EBe-28Lj;
	Sun, 13 Apr 2025 22:11:29 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Xz-00000000EAw-06yS
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:11:28 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c2688619bso2352343f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744582285; x=1745187085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VajNrHFGHgOIFTa51fERClxyNvvqQPVadkgKR33T03Oq7cURfZ8NEvXkUkcrWCXFdG
         Gkj8ik9aPDeM2qbqICwfEXeXOVSatm7NFpXw+UHNomH1TGTVWpY5EhRweiW2w4p5sOUa
         XDN96S1wDaVShsbo8K22jdD8vx8P6O/l5puuVGPbCtB+3pDIpoVRi648Y3nWja0L5Fdb
         vDwgKPNWYozcVMPgClnikl/VUtB/mkkBR5FhZpEbdIabr8dBQndF8nVtACfEm1Y2lAoW
         yfmWTBnZSAGN0u2lEfzWsyXB4Qpjwr1GQRuRRmxdRczkCO9hYRSvpWOppy6YAzZIX5iZ
         uuCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJgqIRPRKZ2AXiQRKXxnOB/H8cNTyN+yMbE9L7ydZg4fIqBD2WFmqtnynoUY4azumxEgNfsc450u2S@lists.infradead.org
X-Gm-Message-State: AOJu0YxLtdULWvpNAdFINx7QjoV6oJ+Gl7LG5PXpGF7Qfrf36Ejf09H3
	jaJDfhuK3/FCWFkcuc0Bm1e6r72QceGyQzo/9aHbpcm9WyMOBZQ/
X-Gm-Gg: ASbGncvbOj5wpSbe+589mEY2nD42K/9Asd+5prn8u2N2+wbxVKFX7povQ2yBH7hXwQN
	bSUjHGtDeYjoq+xaZQSJJIWxhKMeMqIDtXNhTTAvQERmUGPEarqNkBOKODJk7TfpGvCVwhV3S/H
	PvFDffaeA34ZuRh6PlGleHE/zE0z1/2qL7FI6lL5LFHMcGoAGB+7U2DiaQx07xYOjr96BnELRSg
	7XtoqbRk397kLd6C/iVNt8bfv3rZlW/hYo5o5+9/Rj70DSHQIij1wFxA0r51TgVWij0yTXV6GqO
	j1haWX3nFBELRrQQBtP8oimGblhLTaEN76e8QScThIAhiG+mjPkmTVeC7XnNbHpRP/cWos/9
X-Google-Smtp-Source: AGHT+IECY5XYow+opudYnlXLiLIz9SnQYa9O5VZpi/wrmLJlyiliRrur42MGbUbekQ80eLIKm3KZYQ==
X-Received: by 2002:a5d:5f92:0:b0:39c:2688:72a0 with SMTP id ffacd0b85a97d-39ea51eee24mr7544676f8f.6.1744582285112;
        Sun, 13 Apr 2025 15:11:25 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm164696995e9.32.2025.04.13.15.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:11:24 -0700 (PDT)
Message-ID: <a19f8b45-fabc-4596-b20b-cc219ddafc2e@grimberg.me>
Date: Mon, 14 Apr 2025 01:11:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: replace strncpy with strscpy
To: Marcelo Moreira <marcelomoreira1905@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kch@nvidia.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org,
 ~lkcamp/patches@lists.sr.ht
References: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_151127_057092_1983B8F9 
X-CRM114-Status: UNSURE (   4.09  )
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

