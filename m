Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A433C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:35:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9CA64E17
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9CA64E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hVGx1ww/ZH4HHqLIP9TrwlitEx5pDdlpOrGS7rut9Xo=; b=h7qAM1UUVaHp5spKL2QRSf9qV
	UCld+goQKb0DVKSkDYJ/VqLKzerpgXGWySAT9FhwE/uP48EkEFgnCHPy89jABU+Ksm0WqyTyR5jOV
	l1yz71HkfgAcBVXE21IJj8hmLMfdRYLlkO7tNx08Cwoi5DYCvOPbGuIa3JuNx12ZMWP+bDPkS0a+5
	keWu/SyI53mHVZim/09pLwGOJ6nLi4CLUU0m9qILwkHbx9bdLIvKoOgYWJuK9n24MxhRohaDf/T6b
	1lD2GuCwCyxLmVW+uIMZtroLBzXdSmKBoHOKCQKAG56tqutmo5I6Z7u7p3ACQkUDe5hq+IaVIZXNH
	iRIHbKDXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5BCA-0005FM-M7; Thu, 28 Jan 2021 17:35:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5BC8-0005EX-Dy
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 17:35:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CA964D9A;
 Thu, 28 Jan 2021 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611855297;
 bh=TkMt06C39KAtu27x1DMMhjzHHmvklcYVEo9Dtplc7bE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QXEDB2oB667WqtQ3FaoY5JbM3br+ouLPdfGippereJ3bazR3YvSFM3/yMYFpa5s9m
 I3SLgnoW2gL6Jbrl0kvEocY30o4L6ccfLwVjicpke430MgCinys1z1Y8ZjlkpNLhpE
 g1awn+IWlMu9bBOvr2kGhOYvZPJdtnAxTl/ElWA1Kkxp2dBivL/yinx1thffOp56BA
 c09mNreubOtXTYEMkNE4RDILxeC7fCCmKi/l/KLiP9RLTZJYJtMrr+UWxsfX8dlkoE
 8oS+ZuDaIDSNTtp+vAovpleEwM5FNHZlLbeagoI4a8EUOCNol4DfH7U9m4l+ZR9e07
 FxoB6QhkZCDiw==
Date: Fri, 29 Jan 2021 02:34:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
Message-ID: <20210128173451.GA31631@redsun51.ssa.fujisawa.hgst.com>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-3-jxgao@google.com>
 <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_123500_531051_CD9C70EE 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me, saravanak@google.com,
 marcorr@google.com, gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-nvme@lists.infradead.org, erdemaktas@google.com,
 dan.j.williams@intel.com, Jianxiong Gao <jxgao@google.com>,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 12:15:28PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:
> > For devices that need to preserve address offset on mapping through
> > swiotlb, this patch adds offset preserving based on page_offset_mask
> > and keeps the offset if the mask is non zero. This is needed for
> > device drivers like NVMe.
> 
> <scratches his head>
> 
> Didn't you send this patch like a month ago and someone pointed
> out that the right fix would be in the NVMe driver?
> 
> Is there an issue with fixing the NVMe driver?

You got it backwards. The initial "fix" used a flag specific to the nvme
driver, and it was pointed out that it should just be the generic
behaviour.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
