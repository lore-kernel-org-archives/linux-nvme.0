Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A670C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 23:23:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D112339D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 23:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D112339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kbyy9dRKU+tI1tLH4Yqbf42Lv4hLnWBNik23+OUUTH0=; b=NwAdA8CEwN2XrkwrnYP8DBc6b
	VeNPSrUhtDxsX33pGjxMeBZ8SnCpmU2FwoNRSIM0m5BxiJpUhGmtZs/AowRiszt7Z/zfI+aioFgQy
	+w8mMKLvaNTqK/t24aGQEJWrx43tQWWu+4U0402sZWm3qFD36w24k1W3x5TgWArtpMtOn1Rf0SIpv
	utATwfD5NE69ihdu+rID5/mvpA89u7bRf+VJfKE9JywsNeJHqBAxUt6hQ9NWY+AU3mYha3PmhWONV
	LVjZS7q+klSNXfR3a6Tz42XsC7No2wEKfM/3hg0yX2XDa18DhCIgbg6UWpFrJedXgwowt9J+UyidP
	pY5Rj2tdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzpTd-0000ca-TM; Wed, 13 Jan 2021 23:22:57 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzpTb-0000bu-Lw
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 23:22:56 +0000
Received: by mail-wm1-f42.google.com with SMTP id y187so3123068wmd.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 15:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EAD1NNiUKRbW2AuIhdlRBYCSNPU8MCggmuQy96n9Jb0=;
 b=paSNQrREzGwcvGFa2kAAJg5DKbTu6jGkZHyeTmhQYcvnA5bOa8YLZRXsalgnZvMkxL
 PgvenS9XEQ7ZVvCueOsS1yyDZqCMmZO2oXGtbIA3sIClZ0zKazCptxHTQi9TazOeiKl9
 qeK3jDFE51aIZvyWIehszPpHLagMuMelRisbxYUsD8YID1ItGPYnJyKh/bUOmrUA+uKe
 oft2+av10Jn6Pa1YTYv6M8+IAM0+wvZfGPXo5ObySGA6X0gSLKERMB2r+4WeI3yDWU2P
 EpKAl57Z4rbHOYk0x/k5UWY49UiFXFqjrRBmhJbogMI3NxHzwauqnR5CJIlsU0fkcDJP
 36Lw==
X-Gm-Message-State: AOAM531EEQeumL5E+MPQN/mgLn96Jwef9RhlYcOZHEF2e6ZkzuH4snmi
 pm1+DcNVsZU4ax+kgE2MMtU=
X-Google-Smtp-Source: ABdhPJy2ZWqaykKvD0m1cPrWYZRxWviYEwthitCWx6Agdbk9GelLGMqESJOvz/aHmDP9Jl+LeduhAA==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1242466wmj.117.1610580174471; 
 Wed, 13 Jan 2021 15:22:54 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id q6sm4939299wmj.32.2021.01.13.15.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 15:22:54 -0800 (PST)
Subject: Re: [PATCH] nvme: Constify static attribute_group structs
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d516ec7-6a3a-71d0-4781-9fd2fcc95fa6@grimberg.me>
Date: Wed, 13 Jan 2021 15:22:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_182255_736653_E36FE98B 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

FWIW,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
