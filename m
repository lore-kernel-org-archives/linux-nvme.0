Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1606C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 10:29:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99204214DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hRV1NJAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99204214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ro89m8JlzP5tSFzvf0HpWnCvbsoOHdbxeAET9otW2YY=; b=hRV1NJAlkOCo/n
	RPhYsaLiangIeFwGN0F/h/FU0f7bp949/TTFdOAVJPptyEGxL3Sjy86XNWQbiFFW+aN1/0FiDRjjS
	YgZIPSciTq/rHxHXD18NIoaQ+hLo9yYsDeSmawBHT39pFrdhSEzx+J1jd11UntYrim6nCmk0ib5oQ
	Mul/X/SAwK+GkjpGKeC5PAYFUtluh85JW+IzH6zkT8xnI5iQocDLLIHYey2GlgmhwmrA6LgTgyV0Y
	pGqohbOmwd400mbAbV0kCPafgN892zmkdkAz2nDFmxvmil4XC+uf/9dnYEvSOU3uvyVHNpiDEKUNW
	BUaSYJItg6M7nNttiZ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iU6wU-0002uj-Dn; Mon, 11 Nov 2019 10:29:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iU6vd-0002Rw-Nb; Mon, 11 Nov 2019 10:28:13 +0000
Date: Mon, 11 Nov 2019 02:28:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [RFC PATCH v2] Workaround for discard on non-conformant nvme
 devices
Message-ID: <20191111102813.GA6127@infradead.org>
References: <216cfad5-b724-f69d-9a8c-c5ee2ec13212@hasenleithner.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <216cfad5-b724-f69d-9a8c-c5ee2ec13212@hasenleithner.at>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	if (!(ns->ctrl->quirks & NVME_QUIRK_DSM_PAGEALIGN)) {
> +		range = kmalloc_array(segments, sizeof(*range),
> +					GFP_ATOMIC | __GFP_NOWARN);
> +	} else {
> +		/* Device with quirk: use (page aligned) discard_page */
> +		range = NULL;
> +	}

Nitpick: Try to avoid pointless negations in conditionals.  Also I think
that comment needs to be expanded a bit to explain why we use the range.
That fact that we use it is fairly obvious from the code.

Also please add the quirk to the pci id table so that it actually gets
used.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
