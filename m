Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F1C54FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 18:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89365206D5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 18:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DI8HIrBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89365206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4maPj31ih8/0MbhKtcBPt+MXJAgMq9dm7jJ9muqEQdo=; b=DI8HIrBL9O7D0c
	xE2Ra8ApDnshKfv1iwXceDHzzTWdXnDtKR1fdT+2pPXwYJKnpdfhpZTL0sPRIxBpOcC3bxdpdCv67
	Ph26TrCAusF9IuTGmgbVnkq5oHDaDMz7m52BYbUAUNBaCmQSRVFIJx6LFZRAsMGV2tuqwg4LPlIaR
	qucgFwvt0Q7AjXavXuMpaOiA3YmAycfdvnrJQeTY4yXk2OAV8tbymbS9JubmQccnYpZPc8CH84cjF
	steAy9TuD5J2aGH6Tla/7pN0EwqBLjRW/5waPu1KLHYXK0aouomhlYxnH0DISIhs3GyG0FaOm1ydk
	hrdoEfNd5LUycz7IxzOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQxM9-0006hU-CN; Tue, 21 Apr 2020 18:10:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jQxM7-0006hF-62; Tue, 21 Apr 2020 18:10:47 +0000
Date: Tue, 21 Apr 2020 11:10:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [RFC 4/6] nvme: Add t_flags and pi_blkszs ctrl and ops attributes
Message-ID: <20200421181047.GD31265@infradead.org>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
 <20200224184859.20995-5-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224184859.20995-5-jsmart2021@gmail.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

So I like moving the flags to the controller, but I'd just name the field
features.  Can we split any logic changes in the PI setup into a separate
patch or multiple patches (the pi_blksz is probably another one, and we
should only add that with an actual user).  Also please follow the normal
comment style.

> +	NVME_F_FABRICS			= 1 << 0,
> +	NVME_F_PCI_P2PDMA		= 1 << 1,
> +
> +	/* Metadata requires use of a separate blk_integrity_rq buffer */
> +	NVME_F_METADATA_SUPPORTED	= 1 << 8,
> +
> +	/*
> +	 * The PI types supported by the host transport, if it participates
> +	 * in PI checking or can insert/strip PI on behalf of the OS.
> +	 */
> +	NVME_F_PI_TYPE_MASK		= 0x7 << 9,
> +	NVME_F_PI_TYPE1_PROTECTION	= 1 << 9,
> +	NVME_F_PI_TYPE2_PROTECTION	= 1 << 10,
> +	NVME_F_PI_TYPE3_PROTECTION	= 1 << 11,
> +
> +	/* Indicates that the host transport can insert/strip PI for
> +	 * presentation to the controller. I.E. OS does not have metadata/PI.
> +	 * Transport will insert PI/meta on TX and strip PI/meta on RX.
> +	 * Similar to PRACT=1.
> +	 */
> +	NVME_F_PI_TXINSERT_RXSTRIP	= 1 << 12,

None of the NVME_F_PI_* flags are actually used in this patch, so I
don't think they should be added here.

> +	unsigned int flags;		/* see enum nvme_transport_flags */

And I think we should just initialize them in the controller, and avoid
duplicating them in the flags.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
