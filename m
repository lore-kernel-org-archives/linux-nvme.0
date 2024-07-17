Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC18C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+S2qO9xRjNqpsjWxX3IBS0d7Xqog/+YSUnaW+2uA7SE=; b=DS8V5pcAdXzCYJ3z9LgZ+fwdLX
	c5JksjTYWTHIdagIJrF/gzVp4mVj5wjLIYgSSSh7AKn9w5BZFLSbfdS9AaGhM5TjqAWdm1EI4MB+7
	nEazBPylUmzg6bRDAomfvVN3CD9HtdeX+Oen9jNs5HjVQBlGxwNDf0nM9849iPvsh74JKY5Lhbix1
	PuvSgmwADNfjCZRHFrcb/+H5cuYkDcjZLNZeQHX2In9kukR0Bjv8R+24nVgMollOpv//L/jazfDEm
	0aNSZw2EaAuvjtcJNez+ChbQl+uBQFBn7s2tFRc//LB/lJbYYHBVmqUFY9sIYqQLSR38xcKubfNbs
	HuzRq43g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDDA-0000000F83W-20xx;
	Wed, 17 Jul 2024 22:33:24 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDD7-0000000F82l-3i6a
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:33:23 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4279dadb7b1so255325e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255600; x=1721860400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S2qO9xRjNqpsjWxX3IBS0d7Xqog/+YSUnaW+2uA7SE=;
        b=ROA+GfTA3lddlGs4mEwTmK1Y64aNmwpzy7UNvfX+xkiVYzHXF6x4cshIN0A7NGu/1j
         /2EibdxQX2kcC3974BW3UhYjSBjG9jOp3dnJgC6dMXSO1/NoB8mMGXqWGCEAzyucDAnz
         zVTzgKJN0PbtOBDMceLiXHL3vt6J/Snxjnqz4tlVPDAiKY4R4V+p+b6VU740tseHPX37
         TGnOmsQ8IBtZVN7zzk8VzNpGikr+xHJVqzYfIpO1RQxOIA9mZI32ckUhCHw1Kjlg4bjC
         ytrYfpyEJXN5RUbkfaGqD5cKtNAoe7wmuGnokOKaNwKqyceA+3sru0pe9jOdw8GdbxaT
         YHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpdMzu9pMfuu6FsjA40QqK4ifGA7h6bARf3GWkvsxr8h3SffxKzl4dv/zb7NKRFatf80oj5TU2u1YXUrwtPGSZl/w9GwautVZ4rFCDjD4=
X-Gm-Message-State: AOJu0YyW5OEilyScWQBMlA1h2Ho0FGZGwD0M8xHXHqMXVdOyVK7PxM/q
	U9PRlXcLsHpmDegJO+sF116UiN7St7gh8OW8uTwTkldRBwU+q5m2XS1e/Q==
X-Google-Smtp-Source: AGHT+IGT93xf1SMHTQyZ2Q3kR6wa5m+h13hESIWxGV9f4ldRmJ+2P8eiGAet8RrSZ0nrdR3EJwv8VQ==
X-Received: by 2002:a05:6000:1847:b0:367:9495:9016 with SMTP id ffacd0b85a97d-368316fb6camr1412273f8f.6.1721255600422;
        Wed, 17 Jul 2024 15:33:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbec3sm12800827f8f.85.2024.07.17.15.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:33:19 -0700 (PDT)
Message-ID: <85810e4a-5b34-4c6d-bd90-6c0187577b9c@grimberg.me>
Date: Thu, 18 Jul 2024 01:33:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] nvme-target: do not check authentication status for
 admin commands twice
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-16-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-16-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_153321_952131_1689BE18 
X-CRM114-Status: UNSURE (   5.92  )
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

Lets split this to a standalone fix.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

