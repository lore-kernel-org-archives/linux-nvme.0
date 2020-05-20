Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A080C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:26:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AFD2075F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PGSqEHtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AFD2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JIFiUs4A7BNRXE6USL6mM0elWBawmrkFaLznMFJX6ms=; b=PGSqEHtMAYE5rPSfuXNMOyCyE
	dUkHChejOMiXgEyKwNEEHbPwjG+heF+c9K9a1+riNtxSHOCOzSw5+JNO3jFq/0po/41Hnlxuul2af
	leNUx5ASVBWgvM8q81L3tBZWULIzATFaXEDK/LMl3mW37ATfeISAAG/FHkyCJlM4hye8LSqVcSEtg
	XFdrrE6iUf7xHsde1hhIL1owUEAmwNL+GNzmdQtgHZl063n2AR//mZVevUggnKFBOspF975oDF1Qp
	bXcW+fBJaHm8KmRsLiwEFD+OhO+4lwFs06ubu5ZolzwTkSB7ZsSe2wfhUZV2bkIpRxmAgcwnHY1DH
	fFu2xzbvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSTn-0004P5-Pa; Wed, 20 May 2020 17:26:07 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSTl-0004OR-46
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:26:06 +0000
Received: by mail-wr1-f66.google.com with SMTP id l17so3995768wrr.4
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=46NABAt416Vkk64SX+8xcZGJHPV0hEEENt5wcRsihNQ=;
 b=H/qTdMoBFqkCzVHWVTDjZBK84v8weqN+LQm/ED/4Fv9VNV/Vnkrr8JB6TUnmJY0ECU
 dYJcg9Yyt9cV4yZ2Nhs9Xrj7gwSjb/KLb1equ7+N8LRvre8k7dCzJSBr1vbdIRRRrIgl
 a8x7nd7GBuWsUY+PJkQw9h4F4l3BDTb2vBYX1Bop8FVh+XBXkBL4GeDXlTYLsfB8OZXn
 i3sNXyhfTAzY9AbWA/Rab+4YzpIeorO/gm8R1NWZTWH4dDRYsmQc6ZVThkKvoePXPy2m
 rCrigwbw5IdZymJxQGih+yPJ8RreANwkm1Zt8ZUfLJKX1LRQtbC8enp8HqP0g25gEs6Z
 GtpA==
X-Gm-Message-State: AOAM5308qtsVtzTOf9sDdzorN7sXMFMULsBjvWobUapaqYD9LBsnnmEP
 gYqH++pcRzFmf57P+f0nDbA=
X-Google-Smtp-Source: ABdhPJxwbWSvVCUvCfRhB0wX7MmgsOeFP0hzFT4YDe3cOFs/Y32dQszMPY/XYHDuHbuQZgefcpvL5w==
X-Received: by 2002:a5d:5503:: with SMTP id b3mr4963125wrv.272.1589995561065; 
 Wed, 20 May 2020 10:26:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d?
 ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
 by smtp.gmail.com with ESMTPSA id z12sm3327800wrq.7.2020.05.20.10.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 10:26:00 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet-tcp: move send/recv error handling in the
 send/recv methods instead of call-sites
To: Christoph Hellwig <hch@lst.de>
References: <20200518174748.63691-1-sagi@grimberg.me>
 <20200520171232.GB9677@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47b3b3bd-8b67-e298-3d1b-5de7c5b49ca5@grimberg.me>
Date: Wed, 20 May 2020 10:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520171232.GB9677@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_102605_162685_98B66D58 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Thanks,
> 
> applied to nvme-5.8.

Thanks,

btw nvme-5.8 branch fails compilation missing
ae979182ebb322ddd159f998ddeed6efa4547073

Seems Jens for-5.8/drivers needs an update...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
