Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC469E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3PFFd8xDxzkrDHO7fVa2Ojlq6gdz3WEsM8gksPp0K3A=; b=bfZ6+0e0LpiHQQsYkHJN5Likdm
	r2NfsNSO0DVpNZUQQceu6OWKtaKAp3t5pabkSiok5dGZyHRRwtrjH+ZJooWx7Hr3NaGddnrCmshj/
	a3bh2FXj9XSAq7LPHtd1B6xM58RLIkNUORKI61qL3UF7pTP/uY73G4x4FZdMMg2QQPKf8DNSuCfD0
	Jrw3ck9CN89zd9bJQtJZ+wjuPKrh8BM13odhY01qHXkE8PA6NMpkX3xrECXFXsuT9aIfY0dZMgy3h
	oST8SFqVXmjcIizStL9V+pDrTX32RS72pu2O9eVIqsmf7hep8J+gIplC2w9/QksLiZtRuL17TtFgw
	CaTgcSQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3XV-0000000BuPE-0rst;
	Tue, 24 Dec 2024 11:57:29 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3XS-0000000BuOu-3oFj
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:57:27 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso52944315e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041445; x=1735646245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PFFd8xDxzkrDHO7fVa2Ojlq6gdz3WEsM8gksPp0K3A=;
        b=tR5ASkMpesXk8hMVeoF5ffluS0872rYE6uO+y3swRw7dt0nMZAnti9TsE4KLSpXj6j
         kHo7o0Ah6QY+hcCrTUYzFJFONykIY8XJzSPl9dGBZ+ORQSbYY09zUBK89joFzh3L7B6n
         qoUIegaENpz0+k/k2eKzYrgMwMa8RhfadHVW+n2KW+rJ0ORBg89I7mCRLy7kKKfqEm/t
         xoNrduBZf701/H12a9HU/CjNFaoQqJYHi4IJFhzqhE6Pq7wd0cj/PEyWLiehXnG+O5XZ
         ktumA9XhXfAysaYX9cNUvThRtIreyl8vsqZO4O6YskA/2MfLnYcYhO3y8Bmoii/WXrqR
         +VwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt63SeNGs3M8RxthpUDOGomXirjXf46USsXujr3HSWTOJocpiAFFxIZLxfoRzMjPVkvSf6NzPJpyyG@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6WB5v8tFlH6qFxlkkxROE/6lJ6UXR4GXOnjgLAtY/BaiBURYb
	crZ6mv+L7p5AuPREoBRz5FyNciQi6NS+zp8cEiI4v8bIMlb28qEEwH6Suw==
X-Gm-Gg: ASbGncsVYfecnUTwn2xn6jgbhTi7L8CtwjwTGuzrQ4zx0EuHH7WxJcGl7tdWAanFtlw
	VVsSv66NK4f2i6C/Ovngugy3zkPYn6Zx98N06nrniunGez830fSKPDHg/L2LIKPfTOG7oKBdo90
	tNocrSypSo3d8R/pbgZBD6QXMz8H4vy7h5yhUTvBgV30d5by+quZzW3p/KR0JgrSq20yLZmXm5y
	oDdR+8ZRi4zN4O00z3i4wGwaOgKciP0JzSbSPJH8aop33G+xnyn8uRSBEqsewl4+nHfu3yuvUPp
	JmChjX8uh7BtuWCDxJzup5I=
X-Google-Smtp-Source: AGHT+IG+o+LvrCRQMeMf/fm7Pz0V5kacMFRR+ucIiAqdQN4mqAC25iG3q3IFsMLjGCwqaxHVdKnYsA==
X-Received: by 2002:a05:600c:1c9f:b0:434:f623:a004 with SMTP id 5b1f17b1804b1-43671244708mr125496435e9.16.1735041444960;
        Tue, 24 Dec 2024 03:57:24 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4b0sm165575965e9.35.2024.12.24.03.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:57:24 -0800 (PST)
Message-ID: <800536d0-25cc-49e4-97b5-6266590f7ad9@grimberg.me>
Date: Tue, 24 Dec 2024 13:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
To: Jonas Konrad <me@yawk.at>, linux-nvme@lists.infradead.org
References: <21f8ea47-6db8-44bb-a723-a34e0b0cdd8c@yawk.at>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <21f8ea47-6db8-44bb-a723-a34e0b0cdd8c@yawk.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_035726_954446_6155FE9F 
X-CRM114-Status: GOOD (  12.27  )
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




On 19/12/2024 16:40, Jonas Konrad wrote:
> Hi Sagi and Hannes,
>
> Can you move this patch forward? (from August, if you have to check 
> the archive)
>
> 5572a55a6f830ee3f3a994b6b962a5c327d28cb3 fixed the kernel crash 
> resulting from the failed allocation, but the allocation still fails 
> regularly in my setup. `echo 3 | sudo tee /proc/sys/vm/drop_caches` 
> works fine as a workaround to free memory to make the allocation work, 
> but it's inconvenient that I have to do this daily.
>
> Thanks,
> - Jonas
>

We need a review for it first (maybe from Hannes).

