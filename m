Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bSNrqO7/WGg8hIQSfI/CGjqrlG+4hqnru7W7uClStc=; b=SVoQi1XWc3m9TLdBHDaxSh+lEi
	k5qN8jxgVdoGEskYm0NgHnKk4jQCMDgLL6JyOTPbl0rTAc2h/U9u/kYC7XLOCHv+dFwuSF/36t502
	kE00UFkxjUuf1YAFkVdLgaZp0gDLu7BOMl37m7O2TyxHyrX+BIctJz0XNMurE0abzIFKuSyWNzGEN
	7uHlAv772a805xfZHNuIpYNvGnAC6T25/67aiwC6ocrajSE4gKVUub84RBrE+u0/rUd3OHgVOnJhv
	BO1oYDASoipibtNnJsLmteLySnWlSJhZShau+gycGWBOlzaG/TiW429OEUVKZ5zXSd3o4yHctrWcV
	Vf5hZdkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK3Tv-004JdI-Gv; Tue, 15 Feb 2022 19:27:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK3Tt-004JcY-5A
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 19:27:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A7B0261799;
 Tue, 15 Feb 2022 19:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A744AC340EB;
 Tue, 15 Feb 2022 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644953240;
 bh=3ek3jEFahVX0usozZBlxXhcQ4Z1DNdCwUuF+jaDSRLM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nIcdfeQQCt0Y4773txzUtGqi3VvYoVCVgFWAjStAtfYu4jtDXOtHJrF3DQJ4OUn90
 S1YDGmvBYvRX0o1DgwnzEE+RN6idVe+KspjeAI2Rjrzo8AXPZAwtYfp2zeSZoW9Skd
 oBR5005VIVSN/HJmQi8sBI4XzLJ4msUsbkxysb+Q+JU2OsMBr2jJgej6dk3doRQfkL
 +rYHOksMXn2+oznaP0VXIcKJylBMI9gsXl9LAYvflGPnqpUOP3G8/krcykUQ7GUz2C
 fwRM0zWsl/2LUM2VH5CchH3O11qCGxZIBEOoYxws+aCGi6h0D+bljU+7C9eDiSQbcL
 QB3fVhv05DoKw==
Date: Tue, 15 Feb 2022 11:27:17 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Message-ID: <20220215192717.GC1934598@dhcp-10-100-145-180.wdc.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
 <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
 <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
 <705ce6ee-3c1a-c4a0-1662-2f0794b1a6fe@grimberg.me>
 <20220215184221.GA24543@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215184221.GA24543@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_112721_259396_34767D0D 
X-CRM114-Status: GOOD (  15.89  )
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

On Tue, Feb 15, 2022 at 07:42:21PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 12:59:49PM +0200, Sagi Grimberg wrote:
> >> I did cc you, here is the link, somehow it takes a while to appear
> >> on the mailing list than it appears in my mail box :-
> >
> > Yea, got it, just a tad late...
> 
> So which of the two versions should we go with?  Either one will need
> reviews :)

With the exception of 1/7 that sneaked in Sagi's set, the patches are
identical (including the file ordering despite no dependency!), and both
look fine to me. Sagi's was posted first by a slim margin, so I guess
use that one unless you prefer Chaitanya's changelogs.

Reviewed-by: Keith Busch <kbusch@kernel.org>

