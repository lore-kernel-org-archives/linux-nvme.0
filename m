Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA1C25B4F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 07:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmLhDLEbQWMnT0//LtWrCQUQbiuEglzaZJL+YZYy2Po=; b=GRw8s7O3a/0mA8L5v+RfUOPINu
	kmgVbJMjUnGOQjxXW4J98TSOueJij6WfttwyKKtEG23Xdy8zhJ08Xs0GV/zp4aAMxg/xUXln2f0Sj
	xBfoip4kFTS/5+ohpRgnE+q+/RjZYYnh6+HQm7o0KpwgZvOJ4NozLe/+oYTJ405mHIBB5czI/ZfEP
	+7nUw4BcvMSAvp+KPMlc5lUIuoA2hRvky8MXPK55GkOwsw55crR1+QeDyKMUOcxSsopYrJ624y7/D
	EyxhT8i9Lg8pJL2Zui5GvzLQTu0apn0zlPnO7qfivMGuMl9YT+c1X7AlMTXmAo272b+MBi+SNPqQl
	hW2p/pCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4c30-0000000ETUf-2P7A;
	Wed, 08 May 2024 07:49:06 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4c2t-0000000ETTQ-1swD
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 07:49:04 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41f83158de0so549565e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 00:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154537; x=1715759337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmLhDLEbQWMnT0//LtWrCQUQbiuEglzaZJL+YZYy2Po=;
        b=SP/J3u+1p/hTAgssihFvbuxOyOr8nALKKElto99dZU9TAtTjcv3I4biomX7cgjLDxb
         CYzvV6lXbu7kMGtBLFbTWDomo+4j5FQeOTwcCuPJcI4eyQIE+cxusAstDwZtJtnUEuXx
         4bk164xacwCGKlnDPJhj9u7jRumXdEpLstJ9e3NO6fPHhXsWaSV3roYQO0ZaR6+ClP6c
         PZRk3HeH5gMGPuot4Lx8zVAiGyxC38U4dLlfOyGh/ABwf0KLVemPE1r+/wLrmL/9T4r+
         wMLe+IpUNwZ5Lqo64zgFST7sL+j0Ka9wATykViHFFiTqvxy3o6ABbhU21TZNzCBRMj3X
         fE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQXxvh4NBgj6Um3+vryrsrfXBUeFpvMhjMUOn7n/ax9Bk+eaGDV+Vrk0eQyyAOoX7vedAwRJG2HMs0BTocM5hV7tH8Ml8CVdl4s97nHqE=
X-Gm-Message-State: AOJu0Yxlt6MJTeESqVR/QUxPyKvsVX3hnC/pkfFuehU3TBsqWyE0b/Vo
	wWHVlbzs6MRFkK1C9SRXRWzZP/Ozz+1h+6YF6q8tf0phMXVIoTyBX2/AXA==
X-Google-Smtp-Source: AGHT+IG4mhZU+iZGlVuQL/dtlaoa362Ho4dw89FrUrZPN55PAl1v3JqBEC3sfZqmhJqrpcwdBukWJA==
X-Received: by 2002:a5d:4a4f:0:b0:34f:4e00:876f with SMTP id ffacd0b85a97d-34fca8104bfmr1476690f8f.1.1715154537202;
        Wed, 08 May 2024 00:48:57 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id q27-20020adfab1b000000b0034e24be18a1sm14783292wrc.15.2024.05.08.00.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:48:56 -0700 (PDT)
Message-ID: <80d7474a-3a94-44a9-8e82-5831f1961ef5@grimberg.me>
Date: Wed, 8 May 2024 10:48:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_004859_628326_50EE021F 
X-CRM114-Status: GOOD (  11.28  )
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



On 08/05/2024 10:43, Dan Carpenter wrote:
> The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
> endian data and we're on an error path and both of those raise red
> flags.  So let's make this safer.
>
> 1) Make the buffer large enough for any u32.
> 2) Remove the unnecessary initialization.
> 3) Use snprintf() instead of sprintf() for even more safety.
> 4) The sprintf() function returns the number of bytes printed, not
>     counting the NUL terminator. It is impossible for the return value to
>     be <= 0 so delete that.
>
> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

