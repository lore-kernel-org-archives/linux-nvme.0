Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFADECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ac08d5CU+GgkGQo98CrY0WvFGA
	L+9vXXufRZ9PQTgUQtgmacNVSfE5IeNmpZxshMTjj7+MYyHquMm6wvuY4hU/aqX7lY0XP28/RX8xL
	IJnRQ2sZ5CLBSTFsuyo603P+moovWRX6LPxULBqvyLI3UWhk9jdtFsYGHjbk5RCUco1+HSfpYAO4J
	vBffG2xu9HQRwo96akuQ7tEUy6eYexvdyZDqu/NUhFfiZj2JdCgMPGvEvAhC2AgrDyqHCCTS2Gfdn
	ikCuiwtnAmA1PZDYVlGS1cgTdvPlEhfzE+aUHtCpc1vLSwQ5t1s/J88YzHn2E6NDnoL+5xCi9UhbJ
	tRO2ssAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxHU-00AxPM-5i; Wed, 21 Sep 2022 10:48:40 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw7x-00ARiY-C1
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:34:47 +0000
Received: by mail-wr1-f41.google.com with SMTP id n15so1947031wrq.5
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=6sgOhTtp5Vr9AFjRO4BzxSs+jCwwjqVIUYNlvlqpPbA4ICdCo4pyThFVR7v4WBvXMl
         vbt/FCi+FdkCoLOul7PWLvt1yoMS1bqt604dYQw11wkw8Fipk78P8mqDu3XU0LIE1ERr
         0ndDeqC5YibvIe5PYdqv1hmgFLHqoaulJwcy7b7fjTlGjU9b+6/0tzmQmcZn5uVKp43/
         yGKO1jjeGTvxdWVN6WztKkmMO04KYq+vdFHt98QNvwCWEHEeeJ4QAoZMyWpKMr1BFKZL
         c5IOjfQq8wo7nzbe7D0/IvH5DMg7MJxCCTZU0S288RdPjGoTBUTj50dYm05zLfHGbryu
         wRpA==
X-Gm-Message-State: ACrzQf13/sPWuO180J7vYIrDX2xASovCBum8KJthOcKzE+BmCzwc23uI
	fAqf//i0GSAnO1yrkK7sMCpxS11/ZA8=
X-Google-Smtp-Source: AMsMyM6OR0PBtfLaLw6baz1pTIFmwq9mUovHDyxnYrqXnCWCA712PuRLg0LIiO/hJCmeAEeYW1uT/Q==
X-Received: by 2002:a5d:588c:0:b0:22b:24d4:d896 with SMTP id n12-20020a5d588c000000b0022b24d4d896mr1158959wrf.611.1663752883671;
        Wed, 21 Sep 2022 02:34:43 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c059400b003b4a33a7d08sm2360427wmd.9.2022.09.21.02.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:34:42 -0700 (PDT)
Message-ID: <6b3c6880-78f9-6841-d903-50baccae6b79@grimberg.me>
Date: Wed, 21 Sep 2022 12:34:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/13] nvme: remove nvme_ctrl_init_connect_q
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-14-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023445_427584_BFC76352 
X-CRM114-Status: UNSURE (   7.30  )
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

