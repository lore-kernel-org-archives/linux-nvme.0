Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D15C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:59:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF58F2080C
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1QH9sgtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF58F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQ8rX/BoGzSaOrw/Pz8r+iPSbZH7XfRcjd1AlHME/0o=; b=1QH9sgtwWGlwxiAzb4mOsW6GN
	akRXMsd3FGYo0hJq8fAx/mMhZ1S1OxAjXsS1mXWGGAZqOtFcnV64W1+WWMOHyJO9PHPrPlinzUihs
	jwgQsGHaEA46e4VRmjNhGCmYPPRVOO5Y2zxt8N14RvyHbcAtuSEuWMvfV7gq0IsPlB/z1Qb+K+IKW
	mTbmMjMLccSjHsKs2Sehw3A6g93D1G5QiAvuokjiaH3tDyrdZTOQN0lTlUnz0JJLYHt0KtdKiKFOS
	qIMMX7ypeoCHUiPGtpEDVAA1hR67mH2xVrUgq0C7JxfPcpr/XIjVyy3CZvTvwQcw8K5O8WHO5qCKR
	7KyraxPew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI3zn-0004bf-EH; Tue, 15 Sep 2020 05:59:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI3zl-0004bJ-6Q
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 05:59:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A9776736F; Tue, 15 Sep 2020 07:59:10 +0200 (CEST)
Date: Tue, 15 Sep 2020 07:59:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] nvme-pci: disable write zeros command for Intel 600P/P3100
Message-ID: <20200915055910.GA18496@lst.de>
References: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_015913_409956_DAE9A4D3 
X-CRM114-Status: UNSURE (   6.94  )
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
Cc: kbusch@kernel.org, david.fugate@linux.intel.com, hch@lst.de,
 linux-nvme@lists.infradead.org, esandeen@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
