Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC42C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVYxhIeGzGtwcaVkPYxrMKBf2hNFVBqzK0Y3ukYJEsg=; b=OSoXOrhNy3zLv2XlCYFO4BLqov
	G0r2FwMcVHU8EkXmiTJuS/Qn7CdS53fbcoU5jwH88yazVRoAJjJTcAFb3/uhqdI6oy082TrHKOmFb
	xgtj/RjigL8lXxgwvsCYSgBa4eYFl++SceFuTYe9lsKwxqQrpCxRek1RdasOJzM0HlPtP8lrm7sfO
	rMfrC4i6UC95bRUI2NSHoieqEjhlZtJF4r6IrF25U5ecNx35NqeLf8B5PSb72hIRYgMXxVKlJJFN1
	x68oLjWp8OA9X7d3RvhKcKPzaTBkTFdKSLJPRi4rEFHpBTPnghQJGAveHcpuDwNJWOaWPOlSwdJCG
	pv+4a0ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4mf-00Ftfs-NM; Thu, 27 Jan 2022 13:25:53 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4mc-00FtfO-At
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:25:51 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 r2-20020a1c2b02000000b0034f7b261169so1866265wmr.2
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jVYxhIeGzGtwcaVkPYxrMKBf2hNFVBqzK0Y3ukYJEsg=;
 b=ziEJgV9sF56nIF6zAt8tHm7UQnvLAPBLRIkny6VKMGOwg4rsccXlsrDDtz0PC7Lojc
 tEE5MDx/NDaYDFcbb/nQadoisYYLKAX1guxujglKEUGvRiYY/i9NdDLW/kdtVHJK3g1E
 ZEQSkIvornVrAguuKKkHeRBWioIsHne+8QqogeLoJqY4vrpmom8PdOFOxC2v/T8M86HX
 s3CSqtH12D0wzL75Vp5AJ0oSSgMAczXLkK83TAh8kopaypYnhesIsYwo8/ryVw13sEk/
 JV6JNkK8iwfp7st6hPgEWjulT8cnnd21xxV/hlqeK3nEW9GpcHX8KmtKm9Qp6PrylwGL
 b2Gw==
X-Gm-Message-State: AOAM5310G4lz+wCEimwbE9uU/LSZRcPCMO7Ihf2b/sJ9lDB803bD8Rxu
 2GlY4QUS+HWT4HrjtEAFghu1x0+WIyw=
X-Google-Smtp-Source: ABdhPJxAp12oTvfagnNPh2lQrWRd6TpaGFK1XsaqUBKZyZUVbQbBDr9cvMooi8fghDZexYATTp7exA==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr9947594wme.98.1643289948771; 
 Thu, 27 Jan 2022 05:25:48 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 44sm2131668wrm.103.2022.01.27.05.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 05:25:48 -0800 (PST)
Message-ID: <798d9b8e-e813-2c6c-e3fc-4835a13d676c@grimberg.me>
Date: Thu, 27 Jan 2022 15:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] nvme-fabrics: add support for TP8010
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB4291A64C165DCB6AC710A1989C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB4291A64C165DCB6AC710A1989C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_052550_409498_0B9DB7B9 
X-CRM114-Status: GOOD (  16.37  )
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


> From: Martin Belanger <martin.belanger@dell.com>

Hey Martin,

> TP8010 defines the Central Discovery Controller (CDC). To tell a CDC
> apart from a DDC (Direct Discovery Controller), the Identify response
> now carries a Discovery Controller Type (dctype) attribute.
> 
> TP8010 also defines a new Discovery Information Management (DIM) PDU
> which is used to perform explicit registration with CDCs and DDCs.
> This new PDU carries extra information such as the Entity Name (ENAME),
> the Entity Version (EVER), the Symbolic Name, etc.
> 
> This set of patches adds support for TP8010 by exposing the dctype
> through the sysfs. It also adds the following two new configuration
> parameters:
> 
> 1) "register" - This is used to tell the kernel that the user
> wants to perform explicit registration using the DIM PDU. Without
> this, the driver will operate as it did before.
> 
> 2) "hostsymname" - This is used to specify an optional Symbolic Name.

I think that both Hannes and I share the stand that all of this needs
to live outside the kernel. Is there a fundamental reason to why you
chose to place this functionality in the kernel and expose a "register"
verb instead of simply doing this in nvme-cli (or a different utility)
to assemble the register command and issue it on an established
discovery controller?

