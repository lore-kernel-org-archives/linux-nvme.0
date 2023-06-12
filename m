Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E02C7EE25
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=CkDEGHNzwiRx1c403hvExFvc55
	oU3B0Xn9jdnPq7oOzLita+zMn3vLfmGGgp5b99Ffmc7SevCTPFz15zByGJtQ9K4cn3UpfI8pyYXC6
	OMG/DKGP/TonI+JVwWucHmYVlOyELSdg8hEmuc2utvVLNgtQNP8IRe5YMTvHlZRbXYsmPCuYWmIHj
	ZH9jg2JL9N2CeayBbVxph+InAi8vaeSQBrwjnXZpq+PRGaD15mYFzAbs75tRm7NQySkxgDZoftaOS
	HmeiyDKB1zTtD4eF4liiWTWzT5+Evd4Ng+Lug6vrZnb6u3nxFruoAItXNshJJ58PrfsR/np5QflKn
	mZfhEVnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cYy-003297-0E;
	Mon, 12 Jun 2023 08:06:08 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cYv-00328G-37
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 08:06:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30faf6de08eso462213f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 01:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557163; x=1689149163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gp8ltP3kDo2KBP9iXVLqRKYIvRrbyKvdRTBDuYCBAlIR12t46CB9wo8ON2BqQzYdTD
         sM/kJ5a29a1BEk9mb8SM0LaVD80SJIVC1Rkx6K/58S6ABF549GybJMpv3Y4YADr4rvo0
         mZofHTRQuFO0qrC4qZUvZWiCPvbC8lbYMWWAZGxisL/9IO8XcD3BxLxVF5h8rsSnHHsT
         Ew0uebPcc6EhkZwoyQq/Oq9qmJK0MPAfNyKzGKMHZfHpODulgFiS+vYwkFH8YuvSP26m
         t8E6YX3WXz+I9fAmRYsVgChOYacguCRujTpNZSpQquJwkTRjV6Ygt355xoM/ujCtM3rv
         MfAA==
X-Gm-Message-State: AC+VfDyGqUxN0nKP4sOSnZVBjVynKCrJR4klqJaiT0yqgnf1/WmwuHTH
	8Tn8hTkklVOp0DL1WI4sQW78aEOTx88=
X-Google-Smtp-Source: ACHHUZ74PIgz0bU1yqdToQao+KusVSR3+j6EbSCEZgu/y9NAPONrArrpM7dUqHeUVUK9s35XAFAmWQ==
X-Received: by 2002:a05:6000:503:b0:2f8:15d8:e627 with SMTP id a3-20020a056000050300b002f815d8e627mr5706986wrf.7.1686557163235;
        Mon, 12 Jun 2023 01:06:03 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d6385000000b0030fba9ef241sm4329668wru.30.2023.06.12.01.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:06:03 -0700 (PDT)
Message-ID: <c4a00e2b-d391-f1c5-323f-28dba1440b24@grimberg.me>
Date: Mon, 12 Jun 2023 11:06:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] selftests/net/tls: add test for MSG_EOR
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230609125153.3919-1-hare@suse.de>
 <20230609125153.3919-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230609125153.3919-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_010606_001381_127649A7 
X-CRM114-Status: UNSURE (   6.83  )
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

