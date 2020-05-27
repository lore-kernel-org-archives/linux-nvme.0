Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73DC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 05:19:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD31207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 05:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FhiOvoeW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7384c9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD31207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7i37ZBPCpBZ2g8IhkPwXF5XqTr3T6dXonwUWVGfkHY4=; b=FhiOvoeW5f531y
	J5jFRO+6jBnpuVWpZ9/X30p0zeSDTAH6tKs6XMFG43uV8JmVTevxCqDgKOuhBuV4TSmTxOZUiNWCu
	SmPFJ8CJi4sjLSVI69EdfIDMmDTG227WTT8nvB09Soab/PeuobrsDjpSxSZp7hwGsVHiocVCKDHjB
	x4YjPWeDGak6ooWgrXfQrvwgyoUkPoCa15hQLs0wz01w72pRd331yt7HPnImqBb1zes/F62epfYG+
	b7pDqDy+a+bbpHnY6MUTfDONiBVZ/znKvS7LV4203y5cwRvituA4DH+RlGQCoV22whszDp1Vz6TBb
	gJJhmz6kyhXh3eTy/FNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdoT7-0005s0-Jt; Wed, 27 May 2020 05:19:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdoT4-0005rK-Ep
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 05:19:07 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 87BE0207E8;
 Wed, 27 May 2020 05:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590556745;
 bh=+Gu7Ms819qce1QK403qJCBSwes3RbCCCLDAY5Pq8X2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W7384c9qF9IFuyKS/iMi2tBagpNmaWjiDU1TY32lRPvM1CulVTZoqeY7zkRwEHesc
 V44k6+Kvdw252EsRRXIt8MolSdYOGEg1KwjNWHuOQsIX9optA3gYpuMWEfj3p+bB30
 aWKSYEGPAaVIA3MCWu73f6clJVTow1ynWJ9lRVD8=
Date: Wed, 27 May 2020 14:18:56 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527051856.GB24949@redsun51.ssa.fujisawa.hgst.com>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
 <20200527050559.GA16317@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527050559.GA16317@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200526_221906_523207_A8B23FA9 
X-CRM114-Status: UNSURE (   7.32  )
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
Cc: axboe@fb.com, Dongli Zhang <dongli.zhang@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fixes: fa46c6fb5d61 ("nvme/pci: move cqe check after device shutdown")

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
