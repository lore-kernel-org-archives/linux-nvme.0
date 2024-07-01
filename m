Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A2C3065A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dAeIk83TNdHnlo+Q51mPigF+Uu
	XClCFnKsyL1/7zhFQ9+b0enQnANvgmzIwY/S7/fmxjDReJLxX8apstjfgeN4RszXUyS1xs2lzsoF1
	xNyHfmALOUzRU5PZwXG+1bTeKKPQIsgFfO0A4rRWNZbYDaGp5RTt7lDbFBUPl845crwuo0HEioWfS
	bmIQREk5ykrslSuu405c4Q0jWEs3zyFV6YgbOqvygBHaMNn64GFfsLWp/qP3bN9Jmq7D73MA6RtUG
	7OzdH6YYa4wQD4XXAC/pVLRIVxVYxxqcLlf7djIRZcjKPeaTU5sHt6P06KDygOStaiGw2vHTSrwfX
	P4icnXrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB7V-00000001xmg-0cir;
	Mon, 01 Jul 2024 07:06:37 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB7S-00000001xm4-1aUm
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:06:35 +0000
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7243eb43d1so30463266b.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 00:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817593; x=1720422393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=UMMNhiBWhvWyg/nhM/KY2d9hh0tJ9/k6VXc8+/CjDAVTOOMyNuo55iJrXtN0h8Y9mE
         0o2ZvBWpFmpyoIJed/hy5ocJxIG5R9KwmeeQyyAjIFjTQhPe0tzifMPAc6RMuHhtEcko
         8rq0NLDxFhRLbRoQ0od1vCzHM7zWoumvAa2QpduqXXF5VpKc30r+ogt87w2L3bmwC4lP
         lB/ua3ApEe1DcySGiu0RiraM2V/Bi01Enmen8McUnPuN7/02HllSyTURDNgtfGDg92Br
         Mn9vgtzYUDw0xlBp5yF5bEdj0/c/G28eUcSLFfX4Ai6BE3CInGRTqtUcdaaGkwypXGPf
         KPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzC3IQDewh49UnSBajZ8ikVM7KScja0JBDClJtiGswWueDKwmBblJdyiQ7RxVGPcLvUBe8M2gsR0qLINb2QE1fOcK9EwtbwUE6osW/W2c=
X-Gm-Message-State: AOJu0Yx/mD1nS2P3MV7YF/lDkTkhrKxd5MjEYRb/eDTnN7nJm+hn55/u
	rKgm4AzDjhq0e3HRXNXY6LnUfXWKH+2yzOcjDfI2GG4N+iTxU04R
X-Google-Smtp-Source: AGHT+IHIHA6mHDhYRvCNSEm5bDxSYrJgukN5Ni9KJQucnj8fodd7vWuNJK0zUsN7mXcrAAxNCQQO9Q==
X-Received: by 2002:a17:907:3d8f:b0:a6f:b97c:ba8b with SMTP id a640c23a62f3a-a751442462amr382131866b.0.1719817592547;
        Mon, 01 Jul 2024 00:06:32 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a32asm140395845e9.31.2024.07.01.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:06:32 -0700 (PDT)
Message-ID: <1d65fa66-a486-4e7a-82b6-0135a65c2ba4@grimberg.me>
Date: Mon, 1 Jul 2024 10:06:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: remove a duplicate io_min check in
 blk_validate_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_000634_428297_B289B51C 
X-CRM114-Status: UNSURE (   5.98  )
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

