Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C760CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XZzSKcULq5hc5Q2RBWTSm8Flo8
	wt87Bg3CDbgnzAgvmNcPQ9A1qhn1Tw2lBJvELz5wIHeNWGxIt04P5JSgsWw6HB+DtuFJMbpfpC/iq
	67THJ9nl1Qt9ORluevBTnHDnS2TM2DbX2pjayx1MSFVSTkqZf6No+NQOzDEL50LG4LHySJYR+BuxH
	lqm7ga7DriPPYcopbrw5ERzkG5uDxf3sXxVW4klSbE5fvRdDtuRjNr2OH3K+yUQ4UjMi1VwAsbJhd
	C6zJ2EVHM+IiLwlVyjKdWsG3d65UUvFYsj0I2goADRIaqG54MRbno5frlJemrEGL+ShQQ0B9dgmko
	BZe0b4pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtagZ-0000000Dc3F-0Sx8;
	Sun, 07 Apr 2024 22:08:23 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtagW-0000000Dc1W-1Iyn
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 22:08:21 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-345606e8ac0so285892f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 15:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712527698; x=1713132498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gjluwXkMMnjNCfnCqmWl2inFthce2hPAr+vvf8QE9EyoMeq2sxfsgUmZ1nX4Il+eH+
         JeCd3rQp7Ioesfgs1HsFfqr3vOMUCJwaO6ne7N8rWhu0U0sI5BWMEFHQD8RtIuZ71weG
         qsuhoeu+OwNRC01K9HvmsX5Irpe1pyc18SmM1sCY/WkMpDKv5NIPvnh1gyezppT+c+Jd
         ZfOY5UGo1dmitrqBnNlCrGN0mBjKbD6flUKDKCs9yY0qxnClvck2W3r5J+UMYXR9baJ0
         x+GVmKHpQHRFnu1vFB/jmfAAFZGyJY/fzAsapr9ensZDxl/HNYwfdI6sJwCRxUz6bt4N
         EkDw==
X-Forwarded-Encrypted: i=1; AJvYcCXZKx4UCJ3gIofh+qjY32ymBqH5z0UnZZ6rUGUMfufFRIm7eC510bstxtu8eWf+3p6fvj3/AqtpMUQZx3q0Ta5eYBX6ItNvkqROPPQW+bU=
X-Gm-Message-State: AOJu0Yxa6hzf22WFozjobddQ9UKlTLastZk6M01L8Ib668gJv1d7EWSI
	m7iJbK0C9GovsqRwzeZHS3U3N0um98yjZAHUZl3Wu5C6wopoEf7O
X-Google-Smtp-Source: AGHT+IGDF8tsJ874mEe6XkoqEKWxA/iRW0vG8/gA+TkxveM1WuRq2ay+27LWLJ/uK5YDN5U7IV0brQ==
X-Received: by 2002:a05:600c:3b08:b0:414:b440:4c66 with SMTP id m8-20020a05600c3b0800b00414b4404c66mr5794243wms.3.1712527698538;
        Sun, 07 Apr 2024 15:08:18 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bd8-20020a05600c1f0800b004162b0b88f4sm13884883wmb.31.2024.04.07.15.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:08:18 -0700 (PDT)
Message-ID: <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
Date: Mon, 8 Apr 2024 01:08:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-7-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_150820_359252_8A9F0D14 
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

