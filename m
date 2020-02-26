Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFDC4BA24
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:06:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E250F24650
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iSy+QL/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E250F24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/0Xg0fQyGqCq35fzlrK7o6mzFbj26AW6mkbyPIFR6nE=; b=iSy+QL/6NkVs24GNnnVINr9n2
	AX/+2/zDMKuwzmIGvC/4wLSYqfgsCT4PEz8vnzLqc1D1LmaPxWohhprd+WLiyzvDm7Oova4/dfGlS
	QYeJ3BgVvEuJZPNQy7oKCnVyoFRuJ+Wj3aYoSZ+421esGfKFz3eRHHgRdGQ6UMysHV+WRp178kg3l
	DG7KZCTKgqW1+bfElwaxOilMC9uY7+N5repIgzIujZ07tBt36c0lW0+9P2fazuJeRjPWHuUj1J9Ee
	MpgdbF+mGKxIV38XmzKUyv4Zhujtrsv80CdFaSVh9KCuUGWuxSOyc6ZlVp6z8DIBiQaNyP1qb12oo
	Lv1LZTiMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j75kx-00060h-LG; Wed, 26 Feb 2020 23:06:19 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j75kj-0005i0-52
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:06:08 +0000
Received: by mail-ot1-f68.google.com with SMTP id g96so1078738otb.13
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rz8owZz048vr1Nb1eXiJd5TZUtHPUckitGOYNGK22uE=;
 b=K7a7xiWPPg+v6+mxZkcIMj0yBhpm6iicWuw2oUq37RUUfWYbWI+3aqer8EnkpI67k9
 Dk8SAFCwPr8NYiBm5bVvbUh1jPh3o3TYw6YJ7kByTDLN/eCZG4sUTBg26OZ/e0c1iGSS
 w6+mTLkmh5f31Cdz4oDNgkIOnfpo2Xm6dxB5dGA4Lza/z/Hs2u3RNxuMapXv3Xy7DEh8
 zgbXLDI2UvboVhHFlGwRqdXNR8LwPQB9ydZslKmxBBalzDVvcoxiECKsXsiHu6FcIXEK
 Jo05rzk3x6GUxhv28hOI1DWS6ODwthahaMyhFuyMO8pd7EdWWRfPwwyVeTUYbFMqUAHw
 /22g==
X-Gm-Message-State: APjAAAUK4fCxKx+BloLjszTy53XmLLuBduyZCNgyJYHmC7EN0WQ6vze0
 By7cTzNndjdkMYiX35VvY4U=
X-Google-Smtp-Source: APXvYqwTl7SOLrFBI6vzf2RPwJP474QUd6yAAHJIHaciF3OeoD/yWAYlxR4HJV/lHgqjIC4XHy9FjA==
X-Received: by 2002:a05:6830:95:: with SMTP id
 a21mr939317oto.171.1582758362095; 
 Wed, 26 Feb 2020 15:06:02 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 5sm1298377otr.13.2020.02.26.15.06.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:06:01 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To: Krishnamraju Eraparaju <krishna2@chelsio.com>,
 linux-nvme@lists.infradead.org, hch@lst.de
References: <20200226141318.28519-1-krishna2@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
Date: Wed, 26 Feb 2020 15:05:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226141318.28519-1-krishna2@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_150605_228365_CF84E04D 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com, nirranjan@chelsio.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Current nvmet-rdma code allocates MR pool budget based on host's SQ
> size, assuming both host and target use the same "max_pages_per_mr"
> count. But if host's max_pages_per_mr is greater than target's, then
> target can run out of MRs while processing larger IO WRITEs.
> 
> That is, say host's SQ size is 100, then the MR pool budget allocated
> currently at target will also be 100 MRs. But 100 IO WRITE Requests
> with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> "max_pages_per_mr" is 128.

The patch doesn't say if this is an actual bug you are seeing or
theoretical.

> The proposed patch enables host to advertise the max_fr_pages(via
> nvme_rdma_cm_req) such that target can allocate that many number of
> RW ctxs(if host's max_fr_pages is higher than target's).

As mentioned by Jason, this s a non-compatible change, if you want to
introduce this you need to go through the standard and update the
cm private_data layout (would mean that the fmt needs to increment as
well to be backward compatible).


As a stop-gap, nvmet needs to limit the controller mdts to how much
it can allocate based on the HCA capabilities
(max_fast_reg_page_list_len).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
