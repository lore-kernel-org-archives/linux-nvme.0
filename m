Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB400C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlhAxxKGTKO2DQRZEOO6IEDNmZp4zZtvTCX0KgBh0GQ=; b=utrm/GIontj6IHdNaOKy9Bo25C
	gh2fa5pDA7E4BylxxAMJuxZcGVTK77Y6KIHyE2pR2rFqwpCLOIyjrGfMt+48N5YXfLbnqwsZTfuwr
	AeTGhEvNCQOUW4PfE/cMCXVW+WG463o8PRTZO8Kt5NMc/fr/QpsagrMxn5/sIBVKtMQzlI+VTPlV9
	Sj7BM9l6og509AcI0dO0wga7uK/PhrvHOzvIyfETLI+dsWTc9lpVlh9p4tFC5yuMcldxaYoMDdZrv
	XkvnUfFGZolqWfBl1FP0VV/Lkv0jyLtG93qn7XX1Knb8E8flj+bP7O4Ow9fRcxsRPPL3DwnJyOpqb
	KabnkaGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqezi-009SXU-Ej; Mon, 16 May 2022 17:58:58 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nqezh-009SXF-MX; Mon, 16 May 2022 17:58:57 +0000
Date: Mon, 16 May 2022 10:58:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Marcos Scriven <marcos@scriven.org>, linux-nvme@lists.infradead.org
Subject: Re: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Message-ID: <YoKQ4YHKEZxd8C2N@infradead.org>
References: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
 <YoFYIJ3/yEK1RGTK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoFYIJ3/yEK1RGTK@kbusch-mbp>
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, May 15, 2022 at 01:44:32PM -0600, Keith Busch wrote:
> Some of the behavior you're describing has been isolated to specific
> drive+platform combinations in the past, but let's hear your results from the
> follow up experiements before considering if we need to introduce a dmi
> type quirk.

Also, are we even sure this is related to power states?

>  
> > Anyway, with all that background, I'm happy to try NVME_QUIRK_NO_DEEPEST_PS for 15b7:5011 locally, and submit here if it works.
> 
> I think that's worth trying. Alternatively, you could just mess with the
> module's param 'nvme_core.default_ps_max_latency_us' value and see if only the
> deepest states or if any low power state is problematic.

Maybe even just nvme_core.default_ps_max_latency_us=0 to verify it
really is power state related as a start.

