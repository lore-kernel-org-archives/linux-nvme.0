Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B6AC11D0B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 15:33:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD22207FD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MelAZFSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD22207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XqKBbvtb/UfOgeBddLYei2aUt7EJtBqkIyqNUguSCk0=; b=MelAZFSbG9RB5b
	OlzGecLMsw5uGAvyqfErSC+6wg4eiB0GYJqq2cRkCd934j+mPCiz22YEKn+O/LL8dVdjOWlhQRVCg
	nQ9BXgdiYvKp+r2xryfQ2UDWuBblcDERPunOqlCGHsdmxaG9kwoTKnAHPHUXx3nNaCCvDfTPz10lA
	4uBgkI9pIshn/MDHHMlB38P+msLt1rUZiY+nLx+PodNeEc9G3Lk8aYol82ugCz/zNtLVVrO2OeKq3
	T0mLJKn9Tux3+w7Tvu2rGA4pHef+YjhyWZSp8hSGv3kqx6nEk6YmRw3GYYdgsIJvvwVarZDFTML46
	UxoB2Wf2gjCr+gRnz12w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4np8-0007aJ-8a; Thu, 20 Feb 2020 15:33:10 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4np7-0007Zz-7y; Thu, 20 Feb 2020 15:33:09 +0000
Date: Thu, 20 Feb 2020 07:33:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: NVMe/IB support
Message-ID: <20200220153309.GA14266@infradead.org>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
 <20200219152053.GA13942@infradead.org>
 <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
 <20200220142517.GA20993@infradead.org>
 <cd2f6306-1c4e-848c-9075-f89ce5f3a9ac@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd2f6306-1c4e-848c-9075-f89ce5f3a9ac@mellanox.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, Talker Alex <alextalker@yandex.ru>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 05:16:35PM +0200, Max Gurtovoy wrote:
> Are you saying that if one would like to use ADRFAM == AF_IB, he must have
> RDMA/CM stack that support IB addressing ?

Yes.

> seems little bit weird requirement...

NVMeoF/RDMA is specified to use RDMA/CM for connection management.
There is no reason we could not also specify it on raw IB, but someone
would have to do the work and specify a binding for it.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
