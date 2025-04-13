Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013C6C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mnTtI1IDHIR5HGdd46jIeTst4UtXj/hWiIOe6p5Y64=; b=FYKn10stE6046hBzt4qSoDBpSy
	L3iiMcFHhziW160pMNo7irIq2ELnofMacKS51hn+1/b5FhWUiSGXJ767U/u6KHn7iC3cx0MHOJ9bZ
	ytBOHbOujXoWxf4udhk4GsWxePU6sFyOX4zmjWWuPnY69mVDSVe9t6+6/wpt62idlPeps8EbWLbyO
	opmth+8+Uh57/79KVo92a8xUkch9iMPtNoiPQbcSuftYGWXN/7rSlytc4TyETdfr+QxcqSolsxAzu
	fSfxgc6pwa3ZjPKJf7eKem5vyBBqTDTwQaN7yYvLjznu3WQb5HhC4P4r8Dc8ZGu2j7ybt2/6Q2m4a
	1Ktn33kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u462T-00000000HUh-1J34;
	Sun, 13 Apr 2025 22:42:57 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u462R-00000000HU9-29Zo
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:42:56 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso28504185e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584174; x=1745188974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mnTtI1IDHIR5HGdd46jIeTst4UtXj/hWiIOe6p5Y64=;
        b=hFNz9DE/1AaItTHYpvBnnJtqGT4OFT7/RYfxVUPA7SFzP0wMtC3K353oydQsJPulys
         CKYQGXDJVjSIIlAwVw1Wja4rCBkP2KK4knpQ7MQUg0rUFDxTjXl3xEuyAxzLioVil2Mr
         XAce+KalGzNna1z6f28kjEOKKkD56xtYp8AMNkEsWuohYx/I59u3PAHInnKhIka1u4zZ
         MKbAkfbacCGPwerZbzezV7UOMten3/KXWK+AmRCLkQrsZ2Ed8QyAesA4aH7fKwhlGkmT
         rF6hA7Maj21T26uUEka/zceievapUs9vnOp+oJqPwmpYVt+j6joaOiZInKX49IyT7eFC
         12QA==
X-Forwarded-Encrypted: i=1; AJvYcCXq06+RHJbkDYC5zcGArArkUsnl1Azul63o78d653tIaoDDEEq5wymIg54dXT0Yf3meq5/GWQfhoJa9@lists.infradead.org
X-Gm-Message-State: AOJu0YxUuxqiJwUQyotjuvm1qes0Tc38sG9HeNxFsYEr9YmZ5xRY3HtI
	8Bfbtd+ajXdQNmxCI4xMO9kziFgnYDPh1AMV/+NDHUe4hdMDPTFi
X-Gm-Gg: ASbGncsca0XSRAy9sCyMZhUOEWcg0oq5KxuU8qHyIy9ylnLVAWzVGofb5F7L6vKy+MW
	jnRKKai63AkhLetVwTlDxWvB+7T1R3J/716PRQkxDBJ1JBtCGlJ2QV183pH/b06yjHPf0vQ26Xj
	422i/DYUZfYZAmcKbdsar4s8yUoHCxxTtmIVHsUgGOLrFZqwhP1CVBcoxLcE1ytdt7gdl6Zb/Sf
	KhsPsw8FxK2Lqxm+g3SkNUAr9NqHOxIZ2uL6xN1SUddnJMGcw93C3t60Ly0g2zyZwNmARG6sRFS
	F1krAyPi6qpD0o/AMkrfjnkkbauHhX9DwTlh1KLTJi1znUIL7NMncHGr2Gg1B+IXR++lts7w
X-Google-Smtp-Source: AGHT+IGdd1dG3cQI9ovr6uV5O9Br8KnVmX0PGy+fa+3nYiZaQ8UFWmTuqk7A54IG9qy8w5z5ThL7IA==
X-Received: by 2002:a05:600c:6c4f:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43f4388e304mr39402475e9.8.1744584173643;
        Sun, 13 Apr 2025 15:42:53 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a0bf4esm80379915e9.1.2025.04.13.15.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:42:53 -0700 (PDT)
Message-ID: <71b136c5-b26b-4a3e-899b-2cd77e2ea991@grimberg.me>
Date: Mon, 14 Apr 2025 01:42:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/2] Fix race conditions in the nvme-tcp driver
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, linux-nvme@lists.infradead.org,
 mlombard@bsdbackstore.eu, zhang.guanghui@cestc.cn, loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250404082801.1614252-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_154255_557515_34DA71BC 
X-CRM114-Status: GOOD (  10.17  )
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



On 04/04/2025 11:27, Maurizio Lombardi wrote:
> Patch 1 fixes a race condition when the sockets get closed
> while the controller is transitioning from CONNECTING to LIVE state.
>
> Patch 2 fixes a command double completion when a send operation
> fails despite the fact that the command has been received by the target.

Maurizio, I think there is a problem in the initial connect. Where there 
is no
expectation of error recovery - but instead propagate the error to the user.

