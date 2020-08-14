Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715BC433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:17:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A5F206B2
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3JxcgKS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiTlwITG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A5F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=alL1HNymuMOKHD7NMKxIi5+ijuxwMFLrYaTTypwL+KU=; b=o3JxcgKSwsXGi4CpOn5rPwpxn
	eLvXxWn7MJ0SJwYXWDTXEAXsd8xw1kKug9ekyHhxiYsiRMIfwyiniNOKcUzOROKV33ZQj/rpR6EK/
	KLq9T+hch8oULjzkhiv0LDKv0Ox9F/gAdasPxySy1mXSL/QUXJhus+XyClDm4TRkOOKMVXq3yQ4Pt
	S4gbnMjm85+Q+shxRvsB/p0SOO4XECl+21k53UKJp4nLwOwI87FvLw5k/04L/IbetuygV5zBBeV2/
	Kk8B8cE6huj9gykji+CYgb/BsjLScrOy/1OERc/XCzZt2O5A+1cNEfUrunrmSjoL3hFKgNmjzpW7r
	HyC9Sp1Dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Utq-0006HC-Od; Fri, 14 Aug 2020 08:17:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Utq-0006Gf-1L
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 08:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=g8PSEAUA7x2opNJ9a7x6NEXmPCi+/BopzEM5tlmpuYw=; b=YiTlwITG20aDN876I+mE/JX+xS
 AeqYqW0mEmRrrc6vwVasr/wMYwOG3IBnH8h2+s46OQyWKhMp98c3i4/GlMAg/O5QBj+dJ+DNZ3ZuF
 OhN8mNTpmBBvJIHzMJ3YdU0+El1b1sqM9yS1H1bhKaKVSWQbJgaDZDXcAuimgx0Hys8Swl7hyGjKT
 QyjMs8b0FMM/Zobo6kAaxW6s0CHJGIXk1qa+Y9EZuYvflAikGe1fBA2LoMDUAMcCoQBRDlBRz8oZV
 +uq86/ahtS6IhUc9nPLV11BilFUb52dwDczoHFcvjg8k3gvPjmyBkVZd39iZmCDDh3yy4x74tJZDI
 JiRKFEQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6Utl-0004nA-DH; Fri, 14 Aug 2020 08:17:13 +0000
Date: Fri, 14 Aug 2020 09:17:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] nvme-fc: Fix wrong return value in
 __nvme_fc_init_request()
Message-ID: <20200814081713.GA18371@infradead.org>
References: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: sagi@grimberg.me, tianjia.zhang@alibaba.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, axboe@fb.com,
 james_p_freyensee@linux.intel.com, jthumshirn@suse.de, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Aug 02, 2020 at 07:15:45PM +0800, Tianjia Zhang wrote:
> On an error exit path, a negative error code should be returned
> instead of a positive return value.
> 
> Fixes: e399441de9115 ("nvme-fabrics: Add host support for FC transport")
> Cc: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
