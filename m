Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6145C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZRqWYY5AiFUMYSm7QeW6j5HpEJQR0SimlTiE901FIQ=; b=cgEVKeCuWeoxOu2uITeL2IMDyT
	FvjFiFwPv6yzUpfpnV79HH/8gZtqp61PyoeaykiWofAsle2ioLt+ymGAtk0SNvrMotmTdvCiuV9n2
	GvjCJlM/ZsjlbY8K+CfgxqC+z90C2pop0WDlOHIh1WCN4DNSUoQR/QEPDvc9t/jIPVXxC1WxS59Nr
	qgcDqr2ciNadjJvgJ/JJZLsHfsFd3t5Be02HO2MoE0FWF0G1E/S1lFTK+ZmhjDrMGj0NBfeAPPdIa
	1hBw3az6aSW5sHXfQk3RMNjaBwOIYA/CLHMzKUZbBDt6Xj+WVS9sXmsxrpjcIfrDQrEs3r6cKsOYF
	BxpeIJZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUClu-0000000F4P6-1nv6;
	Wed, 17 Jul 2024 22:05:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCl8-0000000F41f-1jS6
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 22:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YZRqWYY5AiFUMYSm7QeW6j5HpEJQR0SimlTiE901FIQ=; b=UwzIzQIEm8PVZrc59Mh5eK0zYH
	uxhuq7VvAHIg9AdU01NvW2L7YpeFa59qAcvvSRrxeoV5hRu2Fnb52UDuWTKSDXmRx+NZUYtfGD50o
	v938meGshdlUDYapQHzPdIN0RKngz1LKivqRpKUUsFdjUyKzOUC4ovloxIxhniQqltdGnAL/Kn9fB
	T7G1m3QOu4gWvQYlznC2uQA0AG4Que2WmgRs6Z9HF/Utl93fmUGsZ7O2+GZekwAodm0H8Zpy+1CDp
	1Pzn5KcRz0sAtQwWRZIHu5Era0/lKWRMJb7wui9YLWSBPDBpzSwfaS8Xx0PkKiNU7DDQz4Y/oLxGc
	YHUHY9CA==;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCl5-00000002QGX-0J4E
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:04:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427beea4ebaso128365e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253861; x=1721858661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZRqWYY5AiFUMYSm7QeW6j5HpEJQR0SimlTiE901FIQ=;
        b=Ug5JD5TVYD5IUSTQy9tlbp27w4eQJ4zZCmg2vKisjRxj+Kr3IYkgHshApkxTjTe/fz
         7d9KE9TeiVJOBpe8fZgSVEJGmT2s+iQbo5HcJJyNfu53nbDjEnrq63AXyYUGxgcfTZxQ
         TkA1tHSaFq3vogf+nsr4sUeU/DCasvFKw7zTXbjXF008v+otrxZGYN9eQHUMfFxmzmf0
         fzrVWg3Y6I9oYJBmvhs449DcP/NUF9bw5NXVyCwnSY7DIspQ7z+TelC5hbJhC9zbsAF6
         sNRrbr9Nhvnpw7TQxCzYBzTC1TBQbAgur8qQlmkaamklIf/0CX+bHno11CfLocP0nWG+
         3Z9w==
X-Forwarded-Encrypted: i=1; AJvYcCVHIzuD0Z9KfiyeeLi8V4DT0xKo5+1JvOqJ1II7xTn0CFkB3LpwuWkqHqa//YscfzkPtK1jUyiUfaxlx/TUCxVJ7z5sqBTTAPkMxDHbPEI=
X-Gm-Message-State: AOJu0YxkTQIK8fOUfe/zTrmat6tGwlojYoyZJXQv6N3nqVdBXvf/Jg1h
	tkoE6MKH5GhHqYUdr4iMeEMF0xhhLa1Dewr3tmYz/1KbmOoLEvawhrRyFA==
X-Google-Smtp-Source: AGHT+IEIw6yKb+qUjlXm4kqsja9FdZntB947f+x/+0z5rRnpeuAo/mksD0Evm+LfO8HkuCko1lH1tw==
X-Received: by 2002:a5d:47ad:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-3683168f1ddmr1526859f8f.5.1721253860716;
        Wed, 17 Jul 2024 15:04:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm12697262f8f.24.2024.07.17.15.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:04:20 -0700 (PDT)
Message-ID: <12b77408-cfc0-4ca9-b59a-68e529408fa0@grimberg.me>
Date: Thu, 18 Jul 2024 01:04:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] nvme-keyring: add nvme_tls_psk_refresh()
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-12-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-12-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_230423_446626_E97F22ED 
X-CRM114-Status: UNSURE (   5.80  )
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

A bit unclear without its call-site. But on the surface looks fine to me:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>



