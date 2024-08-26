Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3F0C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fbpojjNxuDZ1PzqBwTsSUyUXw5
	NmNzXtPewhz9HnTYamcSTiFDWyuP5EKwY/dRa13IG0b9KaddmKjUYMpVuM2n0mip2ToAUGImvkH5b
	7DNc9wlZwba28hSrek6kGv7goaCNX3SVLwUgr3JJPvyMQJgk1bMUk27GhfTb2tmVU5IOhK3g3Hwr3
	moqmxhN3ZA7QoK5sxs9NTlXDOmewH39948rnRCt9BwMh93o3GQM22dz1TsF+1svZ5wqUEDdX4ugxI
	IKx/VQk+qe9Em96iVOlqu0XPzCDaZPBJfwYNX1ekXcjEgOOhAHa02HYR/4Jgo3hpIg8WtO/bphO+c
	u9CDUDZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siX9G-00000006xvo-1YGJ;
	Mon, 26 Aug 2024 10:40:34 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siX9B-00000006xtV-0FEU
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 10:40:32 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso2603684f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 03:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724668819; x=1725273619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cdEfCANA3SIEmUQyCO/BvDqfkWjFdQJ5Q8cX4+/35BHt9S2FyTuaDhQIBrq+5MKUxr
         57mUDVPET/xLxY04kqZ8MwLRnHiG1JR9Wu1ICUStV9okpQE1GTdYdVy6sTBGaPWtMMLC
         nSPIA19cROklPjvcG8w1HPRgq7uosdVo7+EAYcZyibfRV5NPIbGAqxs6+fPxnKmsk+zA
         zJEXtPWSER9BwtEjuEZv7Z1gkPWFftA8Zko2Fl0wPA+iCquUG0Nqu4LFXNK6PA8HMS+R
         vyBiu5bwD/pT4WYjNCrQZOyILmaIH4jLaQGSPzDEAUcoUgotSMudfg62bje3xeNTBgd0
         eGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2dtYsrvvrIwcuHDP/LYY75Zll7WC5/Jh8l1EDceV8ELOaB1cNFTBl+w5RR6G58fidYT58FekkT1cB@lists.infradead.org
X-Gm-Message-State: AOJu0YyU42ENG7Lp2dZ8ft161VVVal+xMJq3ZgHJy1qpVRaIeuN6wAaQ
	Dir1vJKFQsuo5fmHgPGkH5SdHopF/SZXElUhjvIXetsZVAWq98yf
X-Google-Smtp-Source: AGHT+IEoX/xUp/XIu/lunyXVhQWOKxAZ6QKdi4LIcSjH7nJeNPd7ANSuRBJP6dtMdiBUB4Bv+AlJlw==
X-Received: by 2002:a5d:59a4:0:b0:368:30a6:16d8 with SMTP id ffacd0b85a97d-373118fbb5amr6869843f8f.57.1724668818213;
        Mon, 26 Aug 2024 03:40:18 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110336sm10486878f8f.1.2024.08.26.03.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 03:40:17 -0700 (PDT)
Message-ID: <aed78f39-9fc5-4340-8146-1049cc743b14@grimberg.me>
Date: Mon, 26 Aug 2024 13:40:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private
 Data
To: Niklas Cassel <cassel@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: kamaljit.singh1@wdc.com, dlemoal@kernel.org,
 linux-nvme@lists.infradead.org
References: <20240815201131.1439811-2-cassel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240815201131.1439811-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_034029_107086_0864970A 
X-CRM114-Status: UNSURE (   6.15  )
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

