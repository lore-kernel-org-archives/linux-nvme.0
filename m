Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82763CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jpAd53E3fGnuKMKuIVd3Kbqb4q
	+G6RZQ/USy+nktyWHG7rXmueb9VWoeOTNIybswBQg0TIpnzgx5d2AN6KiuTciGZIKGIlLu9NIk8k0
	XxdUWLh9xAnGl20XkBiT9t0xE8wDJjFlDO5DxsKmDiEOE1WMMnZ0YzJkFx23c7T0w9/RfdeCtl7HX
	rv0dxAJFH/rlGH9TIevajfbkXDlTZTFBL5sK0zg9Xb7wZDY24kCHtBEPv3sH/bs2SuwfylWLZO3fg
	8msb6fmu0CFMmWMJS9HPR1TyEeok4r1TuKj82OsuBjnl1WIVnoR4Eo8lc2kR7P2I78GssRRT1mfj5
	ZiyrVu8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtagQ-0000000Dc0W-0kxY;
	Sun, 07 Apr 2024 22:08:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtagN-0000000Dbzw-0kp4
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 22:08:12 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34584c783acso299292f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 15:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712527689; x=1713132489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kvaWFg5z40zKlxy5jimdtuS98PLtErHfpAjsupPnF4NRGLIVpUKnmpGdjf2WN02xkm
         DjWm/yEX2tprOv5+cyv/d2NTOJcA4Luf8MxMradDfZY8CXGzJw3/5J02uRc/0evpY/tI
         9UDB9sJN5EkiktNE51nnBTYx2Uor7qFeSfnrk2l+3kK7GwYE3ERDL4ztFH33IwVdjoBw
         qbIPqOX7+N8fByAalwMNajP4OzSPtj74gizPm7PYRtXaQfC3Kj9lrkpXJBNVAAEi7Jjk
         vhO21JHCC2xpU1sm3+pTszwenyPv37R4aoh4nwgLe8xAUSWS4Q1F5ztQhwLY7Eugxhfe
         /g8g==
X-Forwarded-Encrypted: i=1; AJvYcCXjqbAZHNSVY7155VUOpZoS9vhcvtPc8s+zSSFr8yIqH+jYmzSlOe+apk9PRDK2OMUeLcQZVOD9IIkSgM0b5Z+mHh1GL3ajINqZKEMwqLk=
X-Gm-Message-State: AOJu0YxJoZMcbbiDk7cuMixD5bXnHgdQv2mcFR4uJ9gY0kHobhDFIc9Z
	ApRxMhB+e9sIL4tD4TOJUGs+PeYMypi+nY1N39oL8jt82bSBZxY7
X-Google-Smtp-Source: AGHT+IF5fHR/wnDvTesC1rRC9R2Fs/WTb/mayNQgsQq/Jxr/Ikd1TAk3vWtPwTMqvxVlnh5jV3749Q==
X-Received: by 2002:a05:600c:4f95:b0:414:f154:e652 with SMTP id n21-20020a05600c4f9500b00414f154e652mr5622582wmq.3.1712527689345;
        Sun, 07 Apr 2024 15:08:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b004155387c08esm6467144wmq.27.2024.04.07.15.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:08:09 -0700 (PDT)
Message-ID: <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
Date: Mon, 8 Apr 2024 01:08:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-6-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_150811_237102_87390879 
X-CRM114-Status: UNSURE (   4.31  )
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


