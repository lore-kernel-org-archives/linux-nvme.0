Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17FC43457
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 08:03:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C799522249
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vnSGstis";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mMRHnNZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C799522249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aDI5vgfxwnyODxwxC1O9rDVnUl0eTPvlygaHVI5xJ+s=; b=vnSGstisSbsnakXDA6AgGvUgi
	e+1q1V6OKvnHs295tPJpwx5F+v0uIp84OCKpy1z7HMti5VZihS5qExLhCGacZ8QoXQnQkKTIMLehr
	G6wrLig/QZwcu4bd5ILtyNBqCdSO+u7Q3rDDKVHr1lBcj51+5/l+luBVi777tQzr9h6Z6w4gCro9t
	lEUusD2B4feYHrVUYNNEjBe5NAbRXRnyF/tqIaMvsEMbPNXjkw1VJpy63XmKTBtnEGURDC6snMuxg
	5UhUtksXTD3RRoLVtPxdGO2KrnShA1j6qS4Z3F8Iymyr4ubSMwK3aOPJiucDxBa6NqMzw2f0iT4+M
	2FgR206hA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSyDy-0003e2-Ob; Thu, 15 Oct 2020 08:02:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSyDw-0003cy-RO
 for linux-nvme@merlin.infradead.org; Thu, 15 Oct 2020 08:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=a2qZql200AZN5N8nLwRfRT3TJyI5WyTogEl+yUVcMaU=; b=mMRHnNZTH9o/HtpUjP8YHNIQyp
 AsR7PsYskBsLyou/+zQT+n+HEg36cIqGJo4jK+hwKhZ6+up4QpErlS2U5uPhGAMXxmA3H11U0UNYb
 1zJkNa5i6EcfKih1iPRHJfuNEg9ub8J7V9cICfb3i3ze+7ssw6/V0nKuUGS7SOkzZef6WPMlrDx0p
 EDKti4gagCtiMFFd/3tPfO5iHN33GZmMVpj3tNBlQsID/rHbQeP7zzyp01dFUB3WMnNCXwxYlJDvg
 1PEKzLUSzj2WDjb+BWXqgZcS2of6pFNVLrq8IjyCFbSd7zYsuYq42W2SvUMAlTxq5kC6pxaKJDwDs
 1j6BdwiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kSyDu-0008AD-QZ; Thu, 15 Oct 2020 08:02:54 +0000
Date: Thu, 15 Oct 2020 09:02:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nabeel M Mohamed <nmeeramohide@micron.com>
Subject: Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Message-ID: <20201015080254.GA31136@infradead.org>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
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
Cc: smoyer@micron.com, plabat@micron.com, linux-nvdimm@lists.01.org,
 jgroves@micron.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, gbecker@micron.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I don't think this belongs into the kernel.  It is a classic case for
infrastructure that should be built in userspace.  If anything is
missing to implement it in userspace with equivalent performance we
need to improve out interfaces, although io_uring should cover pretty
much everything you need.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
