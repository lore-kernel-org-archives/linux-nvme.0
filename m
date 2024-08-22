Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3594C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bT8A8YlP9kIVNl/y77L99HWu2w0TPCtT7cuarB+RDvg=; b=NaCJEQ0osprnsDGTfYszODklXp
	BV93Ly8u0bsXG6UzNqsVuZOtkr14PuYmo3wW/qiO5FEtiB0De8VXyzqWDgAt4EpbE6iHdOAI7X8Aj
	sQb9VZujfQdmO+zAIWwAwQ2TvbdfmP6ebbgOFml5t7eSXw2aVhfmm0vGZwYGGkNjbw92NgS+HunNT
	fLE4ZjaEY91IXdqQ/+JYdMT7RpEs/SApqkXjATl0b+WTDczX24HNfafqOOcEhQ9IQkKs3P0qt5aDV
	D6OlQqozLnr+auIyAGtgo/McVjqO8CDvuyb7tXCFb3t77NPFvVMjyUKIod3RYTwq6rkKnBCP+klBK
	0kyfK5zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shGSM-0000000EUGP-0Q9e;
	Thu, 22 Aug 2024 22:39:02 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shGRz-0000000EUBC-3x5C
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 22:38:54 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-201d5af11a4so12389615ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724366318; x=1724971118; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT8A8YlP9kIVNl/y77L99HWu2w0TPCtT7cuarB+RDvg=;
        b=bpttbyPK33Sgu36X7OcoUPU1abCiIHLipo1ot8lmXb5mHMGb43vt9KddhqHZmRD5bj
         GdhPsqK/K5E1aimvGwKfZ1PETEJC5AavNHzdnwk92dj/UspqaRvvGRbAyekZq0KDTxhU
         MWk0fYO1wTis9iw7PVXfW0pdFw7+7OGQ6Yx+eB12bAuGby357EL9UevjF9cDjycIZwnk
         rRoIqAY5UG8qkOWlG8LRRkx+tY5cxfh6xtWJntHU5rGqTbRth7Ulag3seIQhsjhzgdNZ
         NhBI5SZaTeug02kwV44MzLhkjB6SJkxrJ+J6iccKMZDUcbXqjcu35iW0TbfNlQc8eLDm
         iQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366318; x=1724971118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT8A8YlP9kIVNl/y77L99HWu2w0TPCtT7cuarB+RDvg=;
        b=rtC7NVzQ6wvCUTC/kfhRUU4M5f8w2jnNOaSs8yrhtv7WoOfoSi/xmBrDhcU9A395B+
         uTZ08Td4YU2OKaQvXEcFh521CV/tmM+aNJbPrtZ6q0fMnG80yQFlPWwzejwL6JFTu0GS
         ZC+4AMNaSSUapNVdh1K2l9oZSW8r5ZT2PclgU2idRnQ8tQjK7n0gT1m9WUVdCoZ8WKTJ
         0Ow6phgnOcC6emS/+AhLpOtkLgr562YCGlZKwjo/FRxsZPcu3lnKPSOhtnvVleewZlXT
         pWWQQDjozN3OPTGhCf5KUegpaLw0V8wsJF6p0Pli86S6RWciA0MJEr/b6iKX6k9J5eSP
         uWCA==
X-Gm-Message-State: AOJu0YzOTw4pJ38x0qzNf3/jMwK0nSN4lFbyT4k/JvPcHu+oCd2okrmy
	Z/QVUUYCMNSp5gtzAg/Iez2QgOxP9zdbjWzJ5wCXiuZrClfxGfmVz9gTlxaqX5Ur19cgVuZseyV
	u
X-Google-Smtp-Source: AGHT+IHeLAhTPulZqRf4+0yIkUJLHbz1lSl6fjDSAyP8BZaTO5ik6SHc+wPnPigJMrDvPO8dYvQwEw==
X-Received: by 2002:a17:902:d482:b0:1fb:8aa9:e2a9 with SMTP id d9443c01a7336-2039e470157mr3033965ad.15.1724366318578;
        Thu, 22 Aug 2024 15:38:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbec8sm17353095ad.137.2024.08.22.15.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 15:38:38 -0700 (PDT)
Message-ID: <ecc1d4a7-88fd-4a94-8477-14fb745479f4@kernel.dk>
Date: Thu, 22 Aug 2024 16:38:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.11
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZsehTd8kUzkrmQkp@kbusch-mbp.mynextlight.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZsehTd8kUzkrmQkp@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_153840_020391_2A448A66 
X-CRM114-Status: UNSURE (   9.80  )
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

On 8/22/24 2:36 PM, Keith Busch wrote:
> The following changes since commit 81475beb1b5996505a39cd1d9316ce1e668932a2:
> 
>   block: Drop NULL check in bdev_write_zeroes_sectors() (2024-08-19 09:48:59 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.11-2024-08-22
> 
> for you to fetch changes up to fe01751347359862c65c715d51c0b3f4fa8ee2f0:
> 
>   nvme: Remove unused field (2024-08-22 13:28:40 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.11
> 
>  - Remove unused struct field (Nilay)
>  - Fix fabrics keep-alive teardown order (Ming)

Pulled, thanks.

-- 
Jens Axboe



