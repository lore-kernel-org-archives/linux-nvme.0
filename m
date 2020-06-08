Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:40:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDFB20812
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ER3U1B6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDFB20812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8TW79XAzs6dryuqZCMaC0JWVOFaFoQUZsENi+A8MM+Q=; b=ER3U1B6oLLdmtpKdFfa97h1Ne
	gCLrMOh2Ob9XRIw4n4GQQ23AIzfbjsq71kLeZQjM1ypUsyjuWohDCaUCLlsVSqmqVVpp3D9Iz3uvx
	s8SAoSOkUBe4PYVOtAekKZEOSsNvppOJM/kHsVSikfuCOOWNoCda7rUtYdiXDDHp8DyTWaKFG/v0D
	tj8SmwEBcCKzeIAZ6RUShhdHaLKiqd9JUfgRpmxUYQL8E3WuVypgc+A1gLMFffkimcv9pJrnQs6lY
	JvfbnPRWVjiO8HQVKGApC8O5ZEHlFjmLYS7bOLWsryvjZqTMyfTyt+qDUfIjI8K1XhH8Vvrurqb9D
	URIX+CAdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ji9aG-0003TB-4H; Mon, 08 Jun 2020 04:40:28 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ji9aD-0003Rc-6C
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 04:40:26 +0000
Received: by mail-pf1-f196.google.com with SMTP id 23so7087518pfw.10
 for <linux-nvme@lists.infradead.org>; Sun, 07 Jun 2020 21:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nSBjhKlSsaNdBD0UX48K8C6ckrCMaXtFMyDdwA7NozM=;
 b=W1ZociMYBawIBcsCJ6zZtISulai6TmfhRwlI2kKM2xYBSsmXcsqhbuSsZabVAZv4ao
 KYZb347f8Qf8zZsSpgwNEg+UmRkeO8Yus8BYChTgR1QMVT6NedI44LYycfoKFNSQpfTM
 nwiaDhB0om+I/VtziDT6APpNUkrkwUUnnZoRBxPVM5eE98OUzFtI8dbxQFsvawh/FfHo
 bTWUT6yyNzaKxSzjZ39HdSfOfWqSl7xn008GlT7ac7i7StQSn7LzTDK3EQEVdPVhhZoY
 +PlIzBigGNVJr7HtoQyauxF75mA7W8QFFPVwB7CVNIfhAZgMZ6dzjTxouB+3UxzTjKEP
 3HvA==
X-Gm-Message-State: AOAM532ZtMNHUHRsSvx0Mn25sjyUb/nGjpZjhv89UQHiedfLHFYDqmc8
 JSkf9zdvw2EuVj61MGM9d/c=
X-Google-Smtp-Source: ABdhPJy7WgxywSALA6p7WVaf8OfvaiP4gi56c/bIv/Ak+n9RDZBfZOYAwHnVMzaw0x8oidl0q2/2Jw==
X-Received: by 2002:aa7:97bd:: with SMTP id d29mr18688277pfq.262.1591591222554; 
 Sun, 07 Jun 2020 21:40:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16?
 ([2601:647:4802:9070:5183:321c:38f8:ee16])
 by smtp.gmail.com with ESMTPSA id i5sm14304876pjd.23.2020.06.07.21.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 21:40:21 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: replace transport name with trtype enum for ops
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-4-maxg@mellanox.com>
 <95ef47bc-bd1b-1935-fd03-9470e033f265@grimberg.me>
 <0ecc4a81-e682-d5ad-96e0-559560c4efc9@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <70ed2841-9856-9602-78dd-3c9db192f16e@grimberg.me>
Date: Sun, 7 Jun 2020 21:40:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0ecc4a81-e682-d5ad-96e0-559560c4efc9@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_214025_234784_7BFDB41C 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Use common code to map transport type to transport name instead of
>>> duplicating logic.
>>
>> I'd prefer to keep the driver ops name and not rely on the trtype,
>> userspace passes a name so I'd rather keep the transport registered with
>> a name.
> 
> Userspace can continue passing names, but why not using common code ? as 
> we do in the target side..

We can still use common code, but I'd like to keep the driver name in
the ops instead of trtype enumeration.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
