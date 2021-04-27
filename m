Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC048C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 03:11:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D99361164
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 03:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D99361164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BRIQpCF/S0M57rdULMdmrjhSQ0IHMc86X+45utvOAxI=; b=UX6IRftucrUZ6okazZS1ZIs4y
	9H7KqrrCfQk2DxPfF8V2xAdwy6m+/qFAPZB2Q5noA1D9oNoLkPUaVaQc5dLSwPiig8zn96a3dOTt6
	VqUSlBlbaQccx2VNeiRq4IMo2702Hd4MYJS4AXBcqScMPuIrK06mpXI62dbimdqQwKZC6ZgIUQVVc
	+Lic8ZE/0kozuthRLlp4dnXrJfipMi6E6lHhNx9KHXVrLFsZfhk7aH6bNcSowVF4Mk+FBHZnjG/iw
	UbsfPTTCwY83ytaDJ9zvCJ7zATiOLbM2vBfqvHBDE9KTe1w59sRGLlxncp/9mCyD3BSOlNqqn84Ge
	J99SD7Y9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbE7h-000Yhw-0R; Tue, 27 Apr 2021 03:10:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbE7c-000Yhe-0v
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 03:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=eExXUpdug50COuI/y1Ob1JGvWXxZQ7EKQ9PNi67cqVE=; b=YFdTJ6OlwVX0KrDB6snm5hsoZC
 bUAP6qdVEfGm5zz8tW3932sWu9oWb8CKuhnA6OzyVIBbt2KblRsrG+pLUDuSv1UmCbBwyTzM9tIj1
 vMDVHg0R6oHwO0f8w25nib4e8Wmf9FgG6D64Xy0uSCcJkxWJBqm8YLau87xE5wk9ppW8hNgVx+yqg
 sfDM85nA4bsRe/0tgEbKjILdZtUpKz0VFOOOUnG32nhZuxpCe4KFTmeiXTx8QmqXN2tHCaQeMi+mW
 l84512pJiinvdPQZgRxkj4nQuVAqew0AKQFNhgfiJUC+hjAfwaqJ9xhkOZsnRQwKOx7uKDyn0BBW0
 cNXYyAoQ==;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbE7Y-00GOtt-Gy
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 03:10:45 +0000
Received: by mail-wr1-f50.google.com with SMTP id e5so29234429wrg.7
 for <linux-nvme@lists.infradead.org>; Mon, 26 Apr 2021 20:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eExXUpdug50COuI/y1Ob1JGvWXxZQ7EKQ9PNi67cqVE=;
 b=q9P1zDej8bejMNzCR4fv0X98bF0xLzf0pSIp5MBa90ICUgPDBHEewQkNR6C7kSwkcn
 owb//RoH4FnNe9MDPsf0ib2PurNDAaDcKJAm5WRrB86tHXX+WfPgkfJkBY9GwzX66+Ha
 Y6//rebqanBWuyKKzgPGkUc9+yoNWctPy986NXkcKfMvvH0sfNsI4Ler72AoZIZGIBV1
 I1km33N86obxUuhFKniWeP81wsDgb4MIVdHP3wzB+W2xt+X+EcdyPKgEYq/LNwpUYQV2
 mlDGTWT1MziCsopL01i0DUGkm+ZA145Urci7MP86iKq6hxahLybScIWraL1om0OO6Lv4
 M14w==
X-Gm-Message-State: AOAM530N9/7L9TFVs5Nq2cCCEqSBy/Y3IzfyG4iuKdCDjchZH4DLhdmK
 U+XoB5RuKbUFLoldwG+/VWob/FDW2rE=
X-Google-Smtp-Source: ABdhPJznCq7f8woO1gb+AAwgqlB7ZivZUDJC1TpEjb4UiyRsLB4vsiLQ4Zn6zTYH8R2HTIo+zlpS9A==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr25784236wrv.275.1619493042267; 
 Mon, 26 Apr 2021 20:10:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f408:950:96bb:c8b8?
 ([2601:647:4802:9070:f408:950:96bb:c8b8])
 by smtp.gmail.com with ESMTPSA id k188sm1274103wmf.18.2021.04.26.20.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 20:10:41 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
Date: Mon, 26 Apr 2021 20:10:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_201044_594675_31110572 
X-CRM114-Status: GOOD (  12.27  )
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


> This patch is successful for clearing up the observed "no space" issues
> observed during read tests.
> 
> There are still some issues with write tests that look a bit different.
> I'll get more details on that for you today,

sure.

> but it's probably okay if
> you want to make a formal patch for the receive data side.

What should I put on the Reported-by: and Tested-by: tags?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
