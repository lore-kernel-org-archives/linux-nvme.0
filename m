Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930AAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 07:44:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EC364E74
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 07:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EC364E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hQv1pBsPLOSh9J+dyfG56plqHXxpJNaLRdygswl8Lq8=; b=dA4TXiQYE9Y9EZUwPBiuK591V
	yeE8Gn+9zBade/FJC4xl9ON35EYB3lu2TL957gTt7GAjhhut3kwCLEMzipM5pCPUgxwDVV2D7uJFO
	SU1LDCNNpjMvHWkm76nYCt4fgkAOqsvmMCUMbal4nYV2f8mR5Vjw4rLSWZJoP2qjDfw5F7OpURkqH
	ZvHlJrrufTwUC6GV4KFiujqMiLz7QjqsMBeSg8Hf0cDDFYj43LjSXLtjzhweO1ALm2f+zd9N3QDSL
	uaM3s4+9WtSpuGZIgOOniwBLm+HJw+q7H2G98KyA38fmkkPmIUXGErke6ObSri1mFXBTgwhUXmjrh
	5qiN+/7mQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI58F-00Dmo3-L4; Fri, 05 Mar 2021 07:44:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI58C-00Dmn4-Af
 for linux-nvme@desiato.infradead.org; Fri, 05 Mar 2021 07:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hEnrd6DGzUXEu07bm1MwK0cTYB1LbxfzZqZ9lxXQQAY=; b=ejvslXttX+Ie0N6JrLp+EZJlbT
 zsQ6DuWXOrLyZbigprIWLPmC2ZSZOZxx8aGWn+AQLrQutTcP122u2x49Gk9JFfvhtGU/xfo3QWaDq
 sV0PyUYuQ6i6a+xPYeMDAmEn77nWyG/b+qssYhDz167GD5sqzCzLfa9rk6d8E/xwMCm4rfpES4Lbq
 BKIMcCtlS802S2oqqvMcdL2blaprRPT92H9DJmMCNqxfhtw3DRnwvgagpN5pw3zvrsmwt4GWbzTro
 sVxleVztOrDEigTMT3GiKRGC/qgH+GHxr4C119mcIgnrecew7WoYBEh6OkUYjrf3IenI5vVzXm2Cg
 hQ8VlyJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lI57w-00AgNo-SX; Fri, 05 Mar 2021 07:44:06 +0000
Date: Fri, 5 Mar 2021 07:44:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: jeinwag-nvme@marcapo.com
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: mark Seagate Nytro XM1440 as
 QUIRK_NO_NS_DESC_LIST.
Message-ID: <20210305074400.GA2546079@infradead.org>
References: <20210216122543.21509-1-jeinwag-nvme@marcapo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216122543.21509-1-jeinwag-nvme@marcapo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Julian,

we'll need your signoff to include this patch, can you send it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
