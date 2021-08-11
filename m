Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D42C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38108600CD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38108600CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dabxd3s5PQ/tI7UhnOFfz03yIxALS/yl4fxc+Gjr0/8=; b=gg98jU84cuZlqdHKpy7GmLyb3z
	hcegdEr/7hRczdLJUQQiu/iAkrGy1mVFPM0qJd1UTFZObVpzhoUv9Kuprv7TwxPe9i0GDa1U+IxRr
	XB8NFrVYX89LhiTDONdPEnmUgQ5UQ+5HXBifEh65xvEpOA3PrMJEqotAKNp080b1v3+l1eXJbGAYE
	/B+NFCG2hu84rXAuBA79/Jgb08y5EUOSu3WA1u7Hg1j9EFG/JALOY/yKuc8tRDRXCrUmhEYtp7Xle
	FUF7N6AEvA0SV0HLds+263e2aWwFVLVeNyEmVf4hmCb443dm4JhE4961NRKUYs9kMfvZ9lxiONpix
	1e6TjV7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDd4T-005Afa-M5; Wed, 11 Aug 2021 01:30:17 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDd4Q-005AfD-VU
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:30:16 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 s22-20020a17090a1c16b0290177caeba067so7177855pjs.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S6GvUCTp/Wl83xUFkMwBO+B2bQF31aKnoJ0ARaTnLfg=;
 b=VnjEjDwkGA4mvOL4oUqjx04pwnz+dEgKhPQLd0rmj4zGS2aaMdgrZIQYxPBgh+xdTA
 xss4DOQZua938xrwnpAgeMBNRmIlVM8DkTGDX9DJelVPmdCIkT41fetij4LDNWMrbIcS
 J910vZX+qbj7Bu7yQJEQj8zYztLXHe5w24sQV8ozy3aV70LjJQVNs4VJX320lch/PAAy
 eQ736zFH3txaFMUBU1ydSKrxIDv+pA+py6oU7H6/RfvGCfD7R4XZ3nY10V74aE1C84G0
 Wf9rWjXgWYS3QIhkC+M1yCr9gW5jc6NIK+AOoB8En9knLuErePh2luOnLmTzAATQBX/J
 kHNg==
X-Gm-Message-State: AOAM53144CAU67wN0/AsHaPrITw/hp29MyND0yf5VXJ1qOqNHgC3a+r+
 DgB/SyKpCcNtezriKJrw9jEzWZqR8UE=
X-Google-Smtp-Source: ABdhPJzNKG5mfZ9VufF8CmWEshqDTlKJsVtvNFySWt9scdY8Ff9j76b5lD+kxqmrOycgr1lvEZSCqw==
X-Received: by 2002:a63:4e4d:: with SMTP id o13mr486473pgl.300.1628645413924; 
 Tue, 10 Aug 2021 18:30:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id x13sm23824701pjh.30.2021.08.10.18.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:30:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-rdma: always try to configure io queue when user
 wants it
To: Ruozhu Li <liruozhu@huawei.com>, linux-nvme@lists.infradead.org
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-2-liruozhu@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <26de6354-640f-688d-5d01-33ea81ce68be@grimberg.me>
Date: Tue, 10 Aug 2021 18:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803090630.14425-2-liruozhu@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_183015_069034_0A45C26C 
X-CRM114-Status: GOOD (  11.49  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> During reconnection, if set queue count feature failed, we will
> set ctrl->queue_count to 1, and schedule another reconnection.But when
> ctrl->queue_count is 1, we won't try to configure io queue again.
> 
> We should always try to configure io queues if user wants it.

I'm assuming this is not relevant anymore?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
