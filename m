Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D61C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kX8hmy2z52Y3Krrm+nUOnUVWkD
	1F3bPDB0wMAOiUmR5/sdVRie/t/YaVP13fxHzW8swtbxyZOD5uQ2IWq/A+HIJyGDCoIuGsVpNHCiy
	n64Gn7O+TKMyDv9/gtobe1DRVAsWWVToqQ+UC1WKbr5F8HOHtD4nyleEPodPW/nmjcqrh3WLCfIyL
	56UgJ21Z/it3fp7f+JlKE4q9GcDgtf0RTwenzQ3TQbw4idgGIC8K02bl7zgmIRlz3fA8KGDXemaT7
	0jm5MPjcyB1HmGaKD0AR8l+vzjVzaYrozx5dIfNBne2HWe9X4srQXYr2i1WqjHMy8oH5QHX69JR6l
	wxFHt3qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Tt-00000000DmF-414f;
	Sun, 13 Apr 2025 22:07:13 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45Tr-00000000Dlk-3tW6
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:07:13 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so6283836a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744582030; x=1745186830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Zoog2xDHlQ9fVcZF4q48/RGrjVKCB4X3fr7nRQwlousD6O+PzJKfVvixcQ4D0aU/C0
         8IlitBig8fPDGasTmkg5QLL65eRh35XcemvC/RCU2oFzAl3hs/Q7Gp13SBlt5rjRcDgz
         DYLjYaGWBn4hqsCyjTylnwCFYEWpQGWTWRe1HJIQI/6sTIy6Q8ToWGEN2xkejUnZHHrD
         KxRfBBQ8LzvhR7K6PxPrYiK4VCj3pUurQXENn1iyHt3+F+R+UxPGToHSL/5r0o8cEdgR
         Fso1qfCz8poI5JNxlI9fvA72DqlSAr0CzADK3ciDOFI6CygUYGKdJc1P3rVPjnhBZhAb
         EKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5NmCKVDt6pqKhcV0GlXgU3vvQ9ondbmaadsfGrr6W5aH3eyPX+QIpavVpwGxVpL0BtFBVSnOw1bRo@lists.infradead.org
X-Gm-Message-State: AOJu0YwyDU6aI6Rhm2dxnMt9JkSzdPNv3gYglnQ+YlqGOWxVhYD3h2+H
	86jS1pBjcT52HWKc0NxEJcOtGRe8fuEyYMl6XPXQ9VhUqr3J9ySV
X-Gm-Gg: ASbGncswvuK4hihh6askxTH0V9n3s4IIC9cwMHyhLJNKneMhP1lV3cm4WBXJqhNGSdP
	myPuIsUQi0Cgmbnji3RRwmr1fHIiFlj/MbT3KzHvaIjCGWVDTl+3CuRXtZ5vX/hnyPiYr5wuQK8
	ALuXCZuu6SSy5PDzp9gTZT6EpmAD4/8YYJIQxBkrkkgCwGFb5aNPyWn1PaoYT+Y6wTYbO9iT05v
	epO5A+/VcUzrdZz+CQs4kz2T8JRzi9wgPSCPCyVH+tbFHiR+ecw4Bn/EJonEv3djkGkq2Fk3pA3
	jYunAUiFhN2qSLKTlF8FO0ssTw5M8N3biHgS8jNBFZDZzz7v5eMXYuP4bC4tH3yDoKSIVaaJhAe
	qLF5tOgA=
X-Google-Smtp-Source: AGHT+IHUhYQyA3eVl2YK7PCt91HdPxkOAQ+yTbQpNEEyGPo2xAyyY0VpWowdFgvSMk3AV5WLvhfndg==
X-Received: by 2002:a05:6402:27c6:b0:5de:4b81:d3fd with SMTP id 4fb4d7f45d1cf-5f36f64b2ebmr8685518a12.13.1744582030122;
        Sun, 13 Apr 2025 15:07:10 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f528bcesm4041484a12.72.2025.04.13.15.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:07:09 -0700 (PDT)
Message-ID: <a1bb956d-7f5a-48f8-9ba0-9db161ed4c2c@grimberg.me>
Date: Mon, 14 Apr 2025 01:07:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Fix use-after-free of netns by kernel TCP
 socket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Peijie Shao <shaopeijie@cestc.cn>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250408224105.2344-1-kuniyu@amazon.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250408224105.2344-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_150711_958853_FB16DE42 
X-CRM114-Status: UNSURE (   5.90  )
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

