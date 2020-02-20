Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41808C11D0F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196E324683
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIs3wScy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196E324683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AfnLGjVOLdO/GMUrpewm2TPPf+X4NpR6XdiLpNsbotc=; b=PIs3wScyXB1X9JEVADPv3lcbs
	PTkhfnk0x2l4VWmM5wKz/C1K8nYMwIWtU+I2MupbP3uF1Zzhj7bNTq6wercVBvNegqGHjKCh+xAny
	dGowBiNEABcoMTcCQ2UTx0rVPiDCeNORNat8Lo0KQrFf05q8XLKqtHL/itgapHKEFxhz9MkSojoXL
	dWix1LL/SRMP7AFgFUPvSGKrT3hjNn5TxZT5qq+iua8OgQtHmci9yXh9EaEbUsTUnWC4yRRpSOqRT
	30hJUvQXoSb0UHwi9aDvIACdQNJ7YqjsgYZ5LGmqUnIp072TdSjLIHQ4jUr6C8tdoFp5HirZPv2S8
	IXkgwYA+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4ojw-0000ZV-58; Thu, 20 Feb 2020 16:31:52 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4ohz-0005x1-Lw
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 16:29:53 +0000
Received: by mail-pf1-f178.google.com with SMTP id 84so2163577pfy.6
 for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2020 08:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A+FFCdSwCwfAjX8hJep9Qe5g+8mfrxo7zw+WqsE5pA4=;
 b=QosC0AGDrnmw3nPj8My0Qxl6/8W+qaK4DWwPUPbNmT0bJfF4HPSMruSEpSsY876CNE
 Mlfo33T2QgI/tMoaEEjX87mvqRO3cxiWKXgH69693c67WkTiLiRqPQs4wLfsUraCouGl
 RhEeGnJSCOuhBIePHqO2clcfYIMh/N5v1cvoLyUN/o7v7BCozC76yiNdhIidf4jxyICs
 y+Biji52jKjlqrtBN7FyCDPyyTapPJRSKG6hPS0CPMavwO7AE+2iM6u5TdQjQ+rDGXRr
 ltSOlgeMh8CMus0VmPRizfhJa/tBz1R1geJrR4fFBFZh1SmNMRNuvfjxzJNmft5MoMok
 Wrzg==
X-Gm-Message-State: APjAAAXdie2ivMOfzavc374TpaB6jITpx+ZxV9JKhjZZhZNYH9jw1gGz
 gSid14tSUINY2qoZRidmcgrM8XP3
X-Google-Smtp-Source: APXvYqyX5Bm951j3KxNWjY7rdoEYoQLA5mUY07iI8vDt7C/OdbO9JY2UT2lXBBhfv4QgEPGMBv4ppA==
X-Received: by 2002:aa7:99c6:: with SMTP id v6mr9365694pfi.187.1582216189451; 
 Thu, 20 Feb 2020 08:29:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3910:5e55:b19d:2395?
 ([2601:647:4802:9070:3910:5e55:b19d:2395])
 by smtp.gmail.com with ESMTPSA id e17sm110443pfm.12.2020.02.20.08.29.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Feb 2020 08:29:48 -0800 (PST)
Subject: Re: NVMe/IB support
To: Christoph Hellwig <hch@infradead.org>, Max Gurtovoy <maxg@mellanox.com>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
 <20200219152053.GA13942@infradead.org>
 <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
 <20200220142517.GA20993@infradead.org>
 <cd2f6306-1c4e-848c-9075-f89ce5f3a9ac@mellanox.com>
 <20200220153309.GA14266@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d9eaf6c-aa4f-b020-710e-45378e5f2507@grimberg.me>
Date: Thu, 20 Feb 2020 08:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220153309.GA14266@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_082951_768732_F8E34E2D 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: Talker Alex <alextalker@yandex.ru>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Are you saying that if one would like to use ADRFAM == AF_IB, he must have
>> RDMA/CM stack that support IB addressing ?
> 
> Yes.

Correct, its referenced in the transport binding.

>> seems little bit weird requirement...
> 
> NVMeoF/RDMA is specified to use RDMA/CM for connection management.
> There is no reason we could not also specify it on raw IB, but someone
> would have to do the work and specify a binding for it.

The simplicity is useful actually, so targets/hosts don't need to
support both.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
