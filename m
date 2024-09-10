Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C58BECE582
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=la2z/wjfMXM2WYkkigYM27fYHEw+QKZ7VYl07D5xlhg=; b=OUmyB4o7PjbPXEYF5gQvd9fb6R
	s97IsN+K1m5mZrZaW4JGHFGqw/4OHdXNVRz0i6FwxmN1DlH2lK7RQ3bd6SZLGO94g6BAhs/UqxtxK
	l+UVI32sVRgHfeI6lKQkF3WuT/tHErUQx6nK2bESw4WzNsYqapeShyGeYNi6h94OiuQUx9GDnhOVp
	NbdZtY3tfASamWqxO3IF4XRrmSY/uPq3IMmqDwgARyrv2FAC39ezfyZHW9giDpushq6k1XY1fZjdK
	rzGDAbqtSvTWPNul3lmQFyvJxVA3RYo87uaKMTCG8h55Jz3PX/AikFqTq/LQ+tyTkJeOq772x+H+c
	vK4e0QPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvjx-00000004h6p-1kxV;
	Tue, 10 Sep 2024 07:56:45 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvjL-00000004gy9-2Tgq
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 07:56:09 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so3826975e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Sep 2024 00:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954965; x=1726559765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la2z/wjfMXM2WYkkigYM27fYHEw+QKZ7VYl07D5xlhg=;
        b=Q+eO3f+qrj74rL1E68hvUbNZg9hbIbz1hSrZ9hlWjSpglMCtjeQoT9LaJLUeoDET1L
         PEyqL9fyTq/H5HTWXRT2tx2vRZDsRnqBQmsINZmN3tk66c5AVkkBK0kt0kc9yiEhk/WG
         d/Xfgfj6pqUL0R/t4Av74JKfj0sP8Nm7FvNVn327GghEMxGsr0svc+OzAiHWEf1PWKlu
         qq9r86hTZltGHZZHC+TNPA/8bLypCDPLVFhTKQ46UA7K41sVqE142/jxm9q+9vqP6g3f
         aov0p92B9/UXk+8AnotIqHUd3ungxZwfgYGyivOTGfx94h46DOPk4ZWY9bWNAmn4EqpW
         Dz7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGYWXJcGTm+Z+PrGSUv5xROezxSGLldWRhE0Abtja47uPOzkJjd53N20FllvFvMIYU9YN+f8klIVHP@lists.infradead.org
X-Gm-Message-State: AOJu0YyC8yUY8gRKlO9mQnqB2vzyQYXDOqGm/A5LGmqRXwi7PbSHXHDO
	XQNugeu2b7BKtdQ1UbXnBgT+VAP9Ee/T1rSZUegp1gYLH3WLijc4B6u07g==
X-Google-Smtp-Source: AGHT+IHbEmNZzv0aLRT0PXSHoj9J6ezBLXmNy4Jtz1i5tAWzTzynS4g1nhl6g4KPQ96hnqe0DHGL0A==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42cb3098ee0mr51445405e9.19.1725954964324;
        Tue, 10 Sep 2024 00:56:04 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32678sm101881705e9.16.2024.09.10.00.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:56:03 -0700 (PDT)
Message-ID: <ca3ec565-4967-4e1e-929b-db4219e3e98c@grimberg.me>
Date: Tue, 10 Sep 2024 10:56:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix link failure for TCP auth
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240909202118.811697-1-arnd@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240909202118.811697-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_005607_683629_408E591C 
X-CRM114-Status: UNSURE (   6.32  )
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

Looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

