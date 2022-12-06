Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25280C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=PkHIgy527vy08ZOWwP9qFvmYgk
	OO3v4NdMpa7FcRd0SnPfiyidolOT2/U5HamNrdjSfXHuVjmQMD2UABBR25ZjyJ6b/tkeYgHj6c+2f
	jeOfzuefoBYAVzSgptFcQKJCuTw+/a6tXXw+TtH3TgezMNDroeH0SgFFt3Q9tiJKZVhRnuuD88o+q
	Nfc6b2fxKSRYXIOcyAGY4tI1zQ6EJ1eklcHwaHnYpYzzf2FcdsAmjzEBmKmH7dG3orMFjIwbapLoH
	xcO1hJROmYJ2TqSBawBSZjYy6ba43OnCfckD1v4JNA9hl8w4vVPCBPUmsFkaLSlQiXo8Y02zvKj6Q
	ihY/UDNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wum-0091c1-Rf; Tue, 06 Dec 2022 12:19:12 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wui-0091Y5-Ve
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:19:11 +0000
Received: by mail-wr1-f46.google.com with SMTP id h7so17181520wrs.6
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RyOXucoG2fGqd69O5rLR9XnJFu6suoRxiC2jeJ7bK7UU2ZD9SXAbQWkCeGBHS+XlwP
         tTZKHst3e7OKmAvgBmSnEfmEWGQIkAliuUiThmwr2Cr66+Cn6nZK8Ku3n/a7wmrB7lfT
         Z4bwzn+NjJY0xP1OLK77o/7CtKY0wLDfq+KL+9W75vd2II8+ztTNo4VY/AzrT0iPvkgu
         f+wTv1+Du579i0PiLmxdg/Hiq07w3iPWJIlvJ0E/mFPF785/FqnPwZR0kjhdLU/kguB0
         k2DTH8H9FSTQujm5nbeHcZuwVs4BMo+x/WgkzlKl0KOP4+JvtDml46OSG8loSujoM30Z
         BXpw==
X-Gm-Message-State: ANoB5pnKMRO6Qv+NOMyt47YtNjVhITQ0XPcXJU8fvEMtrCS19p6TcQET
	8vSbKV4c1qPHzXr41I7YJbg=
X-Google-Smtp-Source: AA0mqf5/hl54vbFT6Zl2CG+Nfe03WGhQudppSorZmXqGBUYlUiNUArWbN3xilUmURzwcxYVZm602xA==
X-Received: by 2002:adf:eb81:0:b0:236:4ba1:fb2d with SMTP id t1-20020adfeb81000000b002364ba1fb2dmr54575444wrn.570.1670329144456;
        Tue, 06 Dec 2022 04:19:04 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003d1da8c7854sm5401422wmq.45.2022.12.06.04.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:19:03 -0800 (PST)
Message-ID: <92cc81ce-ccca-c6e2-9c3e-669319cdf8b1@grimberg.me>
Date: Tue, 6 Dec 2022 14:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] nvme-pci: remove nvme_disable_admin_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_041909_024145_367F4659 
X-CRM114-Status: UNSURE (   6.99  )
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

