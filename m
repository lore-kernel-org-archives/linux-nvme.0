Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12AAD49217
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXDWs2smXw7DcBVA3+ZpoBUROl1GhfxQYaN3r5ZYqLc=; b=cHOlZk5qRUAhn8MrjU7m/iqdZz
	VT/vgJiv8DgJXcMdt/nNyZSe/h3Dn+gYSVunVVEOLOlcG+ghtpmAz3ukxJfaK4BIbvsu74pjUJkQY
	lREM42Ol/RzEfnFAqTtZxiaW1HsedgnUiKKQUk1MY/sB9fkmYv3ifAJhLZnnCV3IkRy7bqm4VhmYA
	X8o2Pr91Xvu40CLNQLpMWWNd2GLxTNRar8EX85KdY7wE73dQsIyN30p9E0fwDgTImVcsGGLy4nk1f
	USj02Xfi9VQf8c8LHZNsqnnE2SgoY6l+mk00nfo5cVQx9fWXCeVJ4uua+PC+Jl5/iETmSM/mtTLwu
	oAPe27wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU1pD-00000000UjA-2wC8;
	Fri, 12 Dec 2025 12:00:43 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU1pA-00000000Uih-2yS3
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 12:00:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso8800925e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 04:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765540836; x=1766145636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXDWs2smXw7DcBVA3+ZpoBUROl1GhfxQYaN3r5ZYqLc=;
        b=JMDd0FTeGFIOXurfDBrXrUsZvS6EvTi6I/p1PsvZpVS6mNxciLMDbyjXBONkx65z3W
         W/T97LLZwZx2J4fbYwAo5p1j+Kd2/Bl0sRGfEFwrllzUAMXdzctSrCf12S8F4/WZeL4Z
         a/Uzem6xcrISzTGIf5E24jUB3JcXuCLMabg7cbl+icx64XIEEU5uhCMbYmc2UnY8z8Ze
         xSOy5C3s+yapB0FhL1EmH4fplOTwo8SCvurzArTUuiadBeXCSTbvE3MstcSHPnrzm/OG
         KdtlyDC2zLOoHZ7+UYmh1EVKBCBftxzRzOZRkg/FHKMecHXMPkEaBwwaEL4tWPT+NTIS
         P+cg==
X-Forwarded-Encrypted: i=1; AJvYcCXZczT0c4+fTcBwX1DDtSjyLfgVd4q0sPGPBX09YS6gh5us40ZTyRVElM3HGTxQBBxDUiH+djuWe/NJ@lists.infradead.org
X-Gm-Message-State: AOJu0YwsDhla7MvAYb8J8we6GV98Pf+zlj9571QfIlD1cPDuYIygtuuQ
	2qmWtCeufcq2oyFlFE7R6Lz2Lc2UguVby+pkZ+bVMMtKSjsU0rbJjJgV
X-Gm-Gg: AY/fxX4lNIdFGBIU6S941GbH7RNxZ6nspEQGdOx5Gwx9BaHktRguC/E7hnY3q7/sGZE
	69Xx3RJdVXFlsrbsTuhl1CyUsdv8FlBhqSFVPjMBCWAkj/kA0CEq/k4D+i1lRGTIZk648mSnWo+
	Q2ZAtT6XhHsEHNH0kSb6ISdc1j2tN7wxRbehldvYE/Yx7BI9jmUe4TEdKshHaEB2BlXDwG/A+oT
	oRBABB1Oqf7ND2RLXBAIYqamLClF9SuzT9Ao32w7hjVW6AlbdLCCBcZ+jOWpxoVYNX0Hp3istID
	XgZvBRZkgtTVT/DW22D7RnDjM/BrdqXwC3W1RX0kuPNMZGC/j74bMvkKPN1wZcwPszKq55DuyJo
	ReC0ApHuZz87sSXCB7CVAyalN+XSvdXKuj951v2tOKqRHHfbjnTHsSVCfSD28ICZL0tE5TUkwhd
	s0oeYlxOSG5HQ77BRzxhAIcuo4ePb1TySBYl8Qs/16wT0Ydg==
X-Google-Smtp-Source: AGHT+IG+iJWdkrREXTwYXPMGOAqHbF0e7LmtcoGIzF8v+Qid2fB3MHtrR+o7RmMw8gRcvFYl7VhlhA==
X-Received: by 2002:a05:600c:4711:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47a8f8c13a4mr15704435e9.14.1765540835365;
        Fri, 12 Dec 2025 04:00:35 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f70509bsm11045625e9.6.2025.12.12.04.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 04:00:34 -0800 (PST)
Message-ID: <586912eb-9ad0-4918-ad03-15a411523e1c@grimberg.me>
Date: Fri, 12 Dec 2025 14:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>
References: <20250818093245.41641-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250818093245.41641-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_040040_753571_1DE9BF21 
X-CRM114-Status: UNSURE (   4.13  )
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

This looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

