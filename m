Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB68EC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:52:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CCC613F2
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CCC613F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JhVt4CtIkZxCIj8OmGydtbrLvT1U6+Emzk0q3MYcGcs=; b=UNx00eqazmx66Bkxb2Bb+V2Wxz
	FUkOXip4+diSJuD799Du+Ct/OQ5Ph5xa8QFGW6pQhKhoOJx3zH3w/6WeYD1e0TLsatAmBhgHmLZDc
	lt85wkfzU1jtIOajwBhDCu41k5QRvsVIe7ceCX9g6GGszU/XSrx3WwomSpdpoC633Pf6EtvV83dYo
	s206VAt64ZzlXcrX76bsnmekevZMWCbVVWWd8uSp8knk/a83EV7kE48X/nqq5RgsLtERF9juTdsOu
	SGHm5nLWiqTfV3UsjA6MW0JdwI33CSY/gXrhfzjfFphLCheGHUvdit1cusKtVoOxkyjA7V/XjPUdn
	pea9u0Xg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDzu-001ISr-J8; Fri, 21 May 2021 22:52:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDzq-001IRy-Tv
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=yvj3eMK+q0AK283Z+clTzeemzC/RTeZ4w+42UHNs4CI=; b=S4uLQ/lnGEl/znMt/t/nFmDbbj
 khhd3nCP76ZbPKHYcZGJz74IMGfTzvAxjfssYqUMGa5kUxuaiqX1apZvyBL32gOnncXs0YPNU27GW
 xERlMZvHrCglnCUds1Qc/XJQOlWMYjfcJU4W/JaOLWB4KyFkJzYIooKTX6H+vhqUtv9+Mki9Eaj41
 YxAmDc3baf2oCjvIrQ9FmZRkVJ/Tq54kBlYj8NExc7Vgg1+qwrxs4eHO07ohuoBQaQRAEFSjY5m0J
 Ze1wsXAtJQ2NpCtKMd6cfFXXYRx8jhww90CFa8PcR6NrPwC3ws1q1GnDM0XhjWIjlJTfK/3M5zw16
 gk8INTgg==;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDzn-00HTzl-Ng
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:51:56 +0000
Received: by mail-wr1-f43.google.com with SMTP id z17so22432237wrq.7
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yvj3eMK+q0AK283Z+clTzeemzC/RTeZ4w+42UHNs4CI=;
 b=r1L9NMtY7CfjiMqzc0UfLwCIDIfw77Ly62X5Zht7t/n5DOIsSuGs0CHv/V7T859Q4t
 5ckso/tOts2bT4KeJS4+7exSYKcKn72Vm/xidsgryoslhxej7ppfucHBZLIvLq/E4mD4
 V8nNJhL3gRzf3pKXy40DBKvh3BpLMm+67VFrQDv6ND3YKnv1gO3bIlcV/K+KmbahIZjT
 d+xsSAw2ZS600T4/d9UAoUTjOjMb4VScSpI3lQywmp4Xf9Lx3r+/snrNut09qjUmujRv
 hyMcNjCfmx8oXMQRGRqZzSh9pEP0/tB45ZEzps44hYHvM+WkoPEZQu5AkiAxA/70VHU+
 7R4w==
X-Gm-Message-State: AOAM530r712UW97Q2pDWzRtGtjBwU0egYRiPD9sRJd/M1M4MjMRYfkYq
 XJaRnJTrN7ZdHt3TNeWioJg=
X-Google-Smtp-Source: ABdhPJwEbixDJMryHTATmZwjWT5nmeb64WIwTHo06Y4gf4GxbExH2TJom8qu3+3bdWibwW1S6CKCsg==
X-Received: by 2002:adf:b31e:: with SMTP id j30mr11719070wrd.74.1621637514577; 
 Fri, 21 May 2021 15:51:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id g11sm3461416wri.59.2021.05.21.15.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:51:54 -0700 (PDT)
Subject: Re: [RFC PATCH v5 08/27] nvme-tcp-offload: Add Timeout and ASYNC
 Support
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-9-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34e4a50b-4075-2364-d654-4039564f43ff@grimberg.me>
Date: Fri, 21 May 2021 15:51:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-9-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_155155_795432_A6112B65 
X-CRM114-Status: UNSURE (   8.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This should be squashed in the I/O patch

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
