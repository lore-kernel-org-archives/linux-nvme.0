Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF38C83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xGoi4r9NKJs+rl11znJ79jmIWSjCjlQ97Hi9PxhBxVc=; b=KxjxlShW5ilTySQKstnujyWxA8
	u6+FUT9xvDrLR8KFdNVefvvWBMLHNVtJYHd+3xUwsuuzQPWa4vLqntGrw41OYb6UxRHlhrvbcrxi8
	qAmXC+/gyd1cyzbQhNximhcRqXojEnxNhgcygyCsWV8Y9jKqW2oGwjlREdk2wkGwLHFATLDVibAWk
	tgK9tIrANuYypGwBXkb9Fr2A9jn3tonAurEW1RIvxkQi1DU2GXmp6a4cbE7DE/LVRvcv1Nb7uwnv6
	wKTNTFdJ6YFcDeg+H5jPEI7/uzBsctQkYSEWrKZsOUGJh/N1jUt3Ucypc2TIdiy62RkVto5DZRkk7
	wfA6LQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaEBi-0000000Exd5-3NRC;
	Fri, 11 Jul 2025 13:53:18 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaE4o-0000000EwRa-38ZR
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 13:46:15 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so7154725ab.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Jul 2025 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752241569; x=1752846369; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGoi4r9NKJs+rl11znJ79jmIWSjCjlQ97Hi9PxhBxVc=;
        b=z6EudfqJ3W+SQhF7jaD9GAjlBlIlTCvjfcywIysYm/lP2UxdBaVR7oJb85PqDFC/k6
         2AMZuC0Rn603Wa+zakxq/MCL8qs/SYEqaS+iI7RKqD+aLueEix52hFpvDOxeTllZFqtj
         gNddB266B/7vGk/IOM+MGOSMuH7l8zG9/DN8ZoMxcEdYa6eQHgDNySo84xZwTr+jeFA4
         sLIF9hczuqOam/K9KeHj3UzspGXee5FO9pcNZVuGS9N0Bx3S5KQeC+K9yh3Jy8Whc7pJ
         dforr3m1yP1Xh1JYntQsS+PPVR2jG/LzfJ1Ex2aAv5Z9JwWi1x+KrLEjfiN9YEObP/Ip
         iGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241569; x=1752846369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGoi4r9NKJs+rl11znJ79jmIWSjCjlQ97Hi9PxhBxVc=;
        b=uoeSm4qR6dfV2tebZms3qOrCTwpVxWzN4MZWKH8BQJafsjeyd67RBUDETQbur57KB+
         HLVsqR5DKoPg+CRGc3fL7Dg9nrKHRXHDHOddk3/GwIma7AQ3QHNnkRlrXTiH7xxRpiUS
         HlA4hu2M7a1lW4iJQiCb4ar9cINrYwF756A94YBaGIph16tZ+Aqt21nB5Q8nd5G1rjiO
         P5QKsWbV1QK3pFm6StSCK/ZaNyG8FJ61VWlUiXY6UGbajW3065P3ocImkd85OMkIBNNo
         6742tLrS5gkfKVBlZNmKZoYmzEPqaxGNlVOoTTs/mrUgnqj6I4HJN81oU0MDZNYFxCkQ
         D3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhEW1EwNa0UVn+sMR+mPT+wv9G7Q4NAClrxll+s3KH8C5NmHKbVHlmgfRvbnF13R8OrVEYRqeRKZgW@lists.infradead.org
X-Gm-Message-State: AOJu0Yyc161MDJBKEKO8IlVckeJkA1GHc8+DAAEmqNFhDVbI6dbyXIo5
	4sqfbMrJwS+L8XqRIgRWFQk3/rwvPLdw7xDyL+6sbpEkMgvqlZEjT7/i4teAw71YDbI=
X-Gm-Gg: ASbGnctl7Dxv5dfQLlSAO9vYVqOn+Xp4i9a+cu0H/RbfBL1RHxShlkFvGyjvT5jaleS
	JtVqRkbUwJGExyABaCTnTP/AnzW6rz7zdW/yfYEW72r5Z7G9N+AO3os+At+uEi3BQezUKnXdtaa
	gLvH8bqiktdsWM8CJRlImsbv3hpdtL/5q/d2p6FKvFSlIGpC17tWNXYMUDzf3hV9Hhb+3NQT8a1
	1z+HYzzkk3dsHNLCckxwehqNV13dR8ZvgVX7638U5TnNNVXK6T3r7EbiNJ9DIFQIBqEw2JIY6WW
	TKC/h7KQtSY7tUoaT0rMh9HYzMg/yY2tM5bP0Yn6yzv+fh5HdCqDyabcqpRRKbRkhQWqS/QH1i2
	nqyTU7rBs/ZFAW2gC3u0=
X-Google-Smtp-Source: AGHT+IEyicA1J20nDNiTVC2pjs5quNqkKDeOeKrXMpB1/yVxblKgbnjmlVmI6B21RyzWKcGzAV1WfA==
X-Received: by 2002:a05:6e02:198b:b0:3dd:d33a:741a with SMTP id e9e14a558f8ab-3e253325ffbmr37975045ab.18.1752241569426;
        Fri, 11 Jul 2025 06:46:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055653244fsm853838173.21.2025.07.11.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:46:08 -0700 (PDT)
Message-ID: <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
Date: Fri, 11 Jul 2025 07:46:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
References: <20250711112250.633269-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250711112250.633269-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_064611_036059_63A7AAAF 
X-CRM114-Status: UNSURE (   8.63  )
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

On 7/11/25 5:22 AM, Christoph Hellwig wrote:
> Not only do IOVA mappings no need the separate dma_vec tracking, it
> also won't free it and thus leak the allocations.
> 
> Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
         ^^^^^^^^^^^^

b8b7570a7ec872f2a27b775c4f8710ca8a357adf

-- 
Jens Axboe


