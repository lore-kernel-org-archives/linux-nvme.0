Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA7C5B549
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRit7aOF/CSvEo9I75XCubk6wn8njVnUVU6GD7ByBxA=; b=OtB8reQVgRTz+oStPzZ1bWyUEi
	iAuCP3VUOApaV7FVAPZOSbXBX7a14UcV5AWHTzFUV+ZkYl7YVVDYKDgRy9PweltG5x+tNxI6dz2Zu
	TId4FseDCeEDMlmSURLv+1RO1NZGLUm1aeR7C8mUhn+WkTWKi4skz+VuLZ2dc0BGqo5WprmJVjYWB
	u4XYU3hHdnekPqdM979FSVK4bU0taYS7RcQ5LFC4jrxtwkVcIcTumuga0EO3Z2tO4orYRMlk+xuQ0
	8qpcNQeYRamp/z/+sWY2PZmqJ6t7syAxSLyiUU2Xk73UCYb6y3NVQrkBRnmE8Vt4deLvT2+RCtrwH
	2xM389PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcru-0000000Fo8c-2D7p;
	Thu, 29 May 2025 13:00:22 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcSn-0000000Fk2f-2X9O
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 12:34:26 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a36f26584bso490149f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522063; x=1749126863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRit7aOF/CSvEo9I75XCubk6wn8njVnUVU6GD7ByBxA=;
        b=MH0QxXDNJoT/RKUlYGa3CBwPAlNoSRJUtJTGokLpourCI2pktC3w5StEHrovO3Ecme
         S9NeX9PZpgJl07TOUK0mcusNxn9wMQHUX7AI30mKdbhTj8EvOvt363/wyuAvdMl03J+W
         nPB9RRa4+fA770W+BhuvvSJ3Fr7QAAmmRpu7tJTV3kKgvTs+xhdMiKYIf6HNJeLIeYJ4
         GRhTl/wY99Nd+L8GEuYE3xpbbkBrlfRsQwmGF2tmL8LSK8eWKdV2A9TUNHLKN3X4Szin
         F7HYD1kWdVKs9OQYt2CRhm/TLlTSbCwTc2Ckr6WGZvOVWgKMdZEEjUwhCgqW9EkFP/wp
         Q/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWlx+kTsVKKjdv6W0IU92zBEpJkw6BWhyiDxEjaM5NmvZdUt1rfHUhMfmW6NMN6gOcIK0vNvn2m0Apw@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+3kxFHK7+iOK9XCCpbkUdZWKHElJ9YUQ2+2HltiXoSuK35Inr
	/vjxWUCFg5RHgpcDs20itmt50g/pBNysFuxDCMtoHeqivegvhhAABOh6
X-Gm-Gg: ASbGncuAlNjwHhpc8UomltMfXYp9BTrXwtTC1AKqidwOInc861WzhN7RnYG6aI88suT
	sFVVHahgzV5wArVc9sTW5wTO4Vc5h4vUfL1MML8Z8yI5NECTGG82k1vcYy51Cqq6KTigP7ftQ/D
	jQh3QiH8DD3/cA5M44QSeCKHZBmtQZ6hRPlDke787X5eCUnDLHXkImo8fkxSkJR6mJe+cwOLySQ
	2OwhpRbTb1nDbEJ2kJfjvv9pUuMvOAayjl6aT5heIWia/qdblln0yz0k8yqNHW1uayzkS22d5+z
	sBKBXGRy0mhv2GXNvdrzJhkxX0bauyQP5V+J1bE03njXOEnieVBx5D7ehhmQ4BO2fUPLvB/O72+
	gTjTetpR/
X-Google-Smtp-Source: AGHT+IFoX34rX0TxIdChJds0Q4Hf25V/IKTAOpwOHYA/kLMNCE0/XF1hLlR9a59EutuyHEmINqxPbQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:eef5:ae26 with SMTP id ffacd0b85a97d-3a4eef5b06amr2170208f8f.55.1748522063279;
        Thu, 29 May 2025 05:34:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc17a04sm18829315e9.24.2025.05.29.05.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 05:34:22 -0700 (PDT)
Message-ID: <930454b6-904a-44a5-b6cb-c5014be65cba@grimberg.me>
Date: Thu, 29 May 2025 15:34:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: sanitize request list handling
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kamaljit Singh <kamaljit.singh1@wdc.com>, linux-nvme@lists.infradead.org
References: <20250528064535.135653-1-hare@kernel.org>
 <20250528064535.135653-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528064535.135653-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_053425_653947_4BC84E1E 
X-CRM114-Status: UNSURE (   6.65  )
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

(can you please add these when resending future versions?)

