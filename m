Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D7FF8867
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE/q0qDqFAFU+/fEBBlWGfYcWY13Vt5Xw13manENopA=; b=XXCvaIv44BBrMpqKAZq9vdT9Us
	4fO+j+Vyw+P7taYOyUZ1iaYiRGIwWmw3GTOCGbEcl4qR5EqEVX+ZFw1cbyMYuz9RoL2EKxZXhFoxz
	Lb57D/HsZjER+N01h6zMa0IpfBuZe+AbXH/M3qB2EDgevh/tJUuqxsJ/E7ifm25gcND4olqLVa9BA
	RxfU86NE3Lmdjdfat4rqwcdW0+QluqC0YkU8Gr6hLYUF0rs2d4mCd9hsaNqqZU4pLsGUxoqB9IIhC
	k2MPih0LVZOvqbhMA8lUsvnaAkIRZU2Xb3LjXL6EbFsZaYnkk/MO752MNWjw4czb0qfKOrYpYRy8g
	9Q7B8DVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTpI-00000000CS3-0Mb7;
	Mon, 27 Apr 2026 21:49:12 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTpF-00000000CRk-1ds8
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 21:49:11 +0000
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-466ec4c6846so3511556b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2026 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777326548; x=1777931348; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IE/q0qDqFAFU+/fEBBlWGfYcWY13Vt5Xw13manENopA=;
        b=QMnd8ikzxm0lkkeuV555ZDIDd3V3alWDnaV9R7YIA8oTbOllPrgwlAJSlxS21nX+Jq
         LV6Ml98/msyA9NAGMSqdy/tHG2DyY4To/ECspNtRQKQ16BU+L3+RlS2DfMdR7NXH30KT
         K0H9/tTEjmWz5CpfcbZnhq+GZImoCSDxhPEJOfhVLqX6AImNid9FBFzOh8XMctzkjq5E
         tqyX+984nDFkfgwbH5s7AkXQ/9erRxzkc8uPbYRFIk1XXJpsz3i+9cTkb8hVszT3kSf4
         6iqr4se2Nlq80MwgayzGczQXiIw24q21trFSi0axqJgmNlWa4LWmB0kIJ3OxSCGitDDE
         30MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326548; x=1777931348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE/q0qDqFAFU+/fEBBlWGfYcWY13Vt5Xw13manENopA=;
        b=HxHte2vWOnPpC42UB80lHyxJ093l+ibET3qs/EKD0uZX/QUsL5nSaJD+DzKBEJP/Ez
         lqSa+9UVhHzKnTgCQ9DIU3vbtCkSTN8DhSakaoNCsVOvP8oyVJQKP7rTigxEhQFvzNT6
         gDLmhSDTTy2pmaf+i7XmjMJoxMSqE50e8TIjvYBCzvS8d/BzBJmOLwHRBi5/b6mU5ms/
         0poVpbGsFtIi7zNn3NVkYQTJ5KxqvilB9sllewntyvlHfCC/TmUlr/RkF30/exherwqH
         JKciNKq1PVrkOTuaR0zWSZke/ieQuScxxI7XrgO07k+2slfU8iXEw3pYcK4LGZ+ry/h1
         ux5Q==
X-Gm-Message-State: AOJu0YwdrW/nvNG1ONbmg0yxgYQ/RyTYMUAW4yTcCzQR8KSWUJ6F9Usu
	cK4RFKqBbKPYLdKA69aYQPqQf5fDFvOSRtJm7SKPoR9E4BQvlNSG1AoPI9Yr4fOGa/WGx4pv6fI
	Xv71eNnc=
X-Gm-Gg: AeBDieujw68S93OMEMwea8OZnnq876d1VBUiHAe/fjKOeiTLTz9uzssn1ANGhB0hDoA
	ci+otgDevFnh4Az/6pmY4uCA1WhfgsoNncKnC8by8v7fIXvbVOlttWhpwS8U6SFpx4B4jrotMg/
	ABdXzhEMVeEqnEjW+npIQx9+56tjIM68jhnMn6DUJWLq2BjDKYAygyf4fg03KTqOyi0wxLl6WL1
	X3JE3GE0nSBQ+KjvYKaWCglezAx8VdXBtDqIOeikzKnC7zoPvJ8FpiaWOscYx7X09KtiAcn27Ey
	8CdEr+Nh1TxiA0WyvNqwPh/iIqgqkkSrjznJtDmhLdsMGO3ZiT1mzAP6e8qEbNsU5CmCHmAN/Bx
	7E3d/U92DUEV8vC//VeRuAIRPX2fcM/nGJWlrcUaOqxLKU0gUZf+dJj03anobBuLwduqpOzmAF9
	8xmCa91kmhr48jKjKM3BgdWVq0jnsBAGWrngE5CxeeqJMsc+8hTNLW6VyXfBoucUvg2NKuZwwZ7
	UTN5BqnGAz8VU20s/fk
X-Received: by 2002:a05:6820:200e:b0:688:3372:3a0e with SMTP id 006d021491bc7-6965cbbd862mr182953eaf.50.1777326547939;
        Mon, 27 Apr 2026 14:49:07 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6965ba3686bsm358150eaf.9.2026.04.27.14.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:49:07 -0700 (PDT)
Message-ID: <cebf60eb-bf31-4f24-a6d3-d3fb525d56e6@kernel.dk>
Date: Mon, 27 Apr 2026 15:49:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.1
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <aeutKVHQDxuEfEVn@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aeutKVHQDxuEfEVn@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_144909_687354_14473FBF 
X-CRM114-Status: UNSURE (   9.24  )
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

On 4/24/26 11:49 AM, Keith Busch wrote:
> I realize I missed the pull for this week, but sending this now just to
> get into your queue in case other distractions get my way again.
> 
> The following changes since commit e9b004ff83067cdf96774b45aea4b239ace99a2f:
> 
>   blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default() (2026-04-06 12:54:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.1-2026-04-24

Now pulled, thanks.

-- 
Jens Axboe


