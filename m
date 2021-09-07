Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B235C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 14:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868BB610FE
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 14:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 868BB610FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=D7WCZ3T44daZLjaSgKIx5UlDb5JVICDpRYFXfIIrTE4=; b=yezGkIbvWUtpW7twKmwZ6e1vwP
	JK88chHZxX1IpkqONNJkHA9j1h1H5C7m84AzAGgpOLPFZg4JVtARzerSxHbPMZ6FxQnyBpy0wi5Fe
	FXXObfP41DOvCYw2V6GZdvbDFJ0g2xP1w/eWZmJPyfLOy8Y/06HbCmb3mNso6u/NAumPb7eE2zNzN
	k5QeG+QIrBZmnu6cUdg95uovIh+pZVXvEDk4AjdClARr7nus9j9cXC8H107y+OHHWriyy2II8JeWf
	767YVOglsg9He59ElnzqkUZ5RQbx7fwNtwKZYlGCqCW8Qql6yLa1l2hQ2tsnCZ5oNZgg3qX24AnWT
	fA2j+r8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNcET-003tZQ-RX; Tue, 07 Sep 2021 14:37:53 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNcEP-003tYP-EF
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 14:37:50 +0000
Received: by mail-il1-x12c.google.com with SMTP id j15so10284777ila.1
 for <linux-nvme@lists.infradead.org>; Tue, 07 Sep 2021 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k7UIabWHD6NhE//8e0Wk3ieOxe6NDASRxwbZqmCHGys=;
 b=l9YV0fG70+xwUx5Lg/F8zIIYSomUp4yUqgA7tawlD0GR2rFagHPu4vFzf5EuUTqrRy
 E495IdM2X8eSprMng75VVogV4+BFFf/0C9/i6CYE1Z9ksXbIfBc7MGX+rFWlrZpdx9DQ
 0NQ63qtx1wSK47s64nvDPjR4AWU3oYGd4yBuPWhefGctgLvfb9UeMvwXZJWrPvk27cz2
 3RYOdRxwmPZNiGZ57N2nebAYLLxslFtWc3feW6se+QAx+VwoMqh1tWISfNvNeefgID2d
 DiudYcWp+QueQAiOd1n3Z0aG6S4NGSZ4BTNFZdK+Oi6wAHMNZAxdqyBDb8hi3WhaNq0H
 t8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k7UIabWHD6NhE//8e0Wk3ieOxe6NDASRxwbZqmCHGys=;
 b=Rq3bPBTRNYBLOlC/U9zmMuQqztHIJt3C0FuKT4zRaGgP0DOrqMMw/25MQOQGdnIQTE
 FMTOhCi/b8qK1lrohEwEkFxsAtCQNYUd1B5QWKEZPGkP3LD9rBdbNurxSEdnPNlTHhee
 MdD+G97xeX+ZA+1/BQkzWzQroqo+7/1zvbdm0ZDMCGqUgLuP+ccRNyQNlBlJC4ga+Ddp
 s4B4AXYTny+8A4isyIlu7GEbXdgQ6dnuBXdJdsSbGcLQPRM0TVuHeU1a3NjYhpLDrSGd
 4thMgcGt76gmtwcA3QQOaXep3GHsi1Gs58x0+3klFdnZ7b80/eu4V0XrkFOz+7rXG+Ex
 W+lA==
X-Gm-Message-State: AOAM532UmDESHZRScA9FEN4ckrwFmTNVDlpJH7u7IzSbYEGfo8aMhWz/
 +y03KHAh7Xuhl2fAxdMA/v7TG59NG9mH0Q==
X-Google-Smtp-Source: ABdhPJz4LjPNz2+qX9UkOekJK+Wo+oqlhj8waX5ArBaUO802fVOIkwukcyCKxfkE/aGBDktZuR/XDw==
X-Received: by 2002:a05:6e02:1564:: with SMTP id
 k4mr12373217ilu.146.1631025467210; 
 Tue, 07 Sep 2021 07:37:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x15sm6369990ilp.23.2021.09.07.07.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 07:37:46 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YTdyu/Y/d9woHINJ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <406a8f15-16ff-e2e2-d17c-a804f8710cba@kernel.dk>
Date: Tue, 7 Sep 2021 08:37:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTdyu/Y/d9woHINJ@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_073749_533452_078D1292 
X-CRM114-Status: GOOD (  12.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/7/21 8:10 AM, Christoph Hellwig wrote:
> The following changes since commit 1c500ad706383f1a6609e63d0b5d1723fd84dab9:
> 
>   loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-07

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
