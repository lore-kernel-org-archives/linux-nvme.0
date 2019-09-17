Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E235C4CECD
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 16:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD95214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D35WY7CJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yQUKQKjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD95214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f5D4Nul/K+wtILIPY5H9Q/vFSO2wrCi4+csm/6uWOKI=; b=D35WY7CJsYVKNB
	gRtMGciNcCGAgzSNLvNqPtJ4qKk5f5DMntcCqsyA0IMT7SrQuk9ZSJwPYXwSrwJmFPpY7SLi1+c0C
	LBU6AWuhGnTkMUnm/c5BvYszGriTo9qmBJO5yM1SJGomEG2Ut95oD81ZmHhCeab7Q0Qto6VRFEnTd
	YdXhzsuZGbROu0f5te/gdvKa7CKzyYfPiCOF0ss3anBGdf7S6ApN9+VRhlwz0V3l/BKFVlCfU8t69
	3pdjtb1rwGDXNtd9oIXWqMBfGjsbpBzuYrIJ33Y1EZez8RYhxILoiqBCSIZgrE/kEiJdsnnUfR19o
	qSZVBi1iv6O5TUamDiXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAGVW-0002sO-SL; Tue, 17 Sep 2019 16:39:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAGVT-0002s1-Ql
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 16:39:13 +0000
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFFC3206C2;
 Tue, 17 Sep 2019 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568738351;
 bh=CJxuDIir/Q8qXCQsVobRaYKJz6i9TOdPwNr3MjspfMg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yQUKQKjV9hD3GAAYiBCBQC5OaXd06dpPbVwPiNd179rfVNFSA/T+nndAMhG+CmRYz
 PtPN80U8+yBQeRv1/AXBF18O2gbnYnQRNW00W/IwftXCYLr4XfGS3h6NtvJMC1HYNe
 OOGO6MqOIQ0T0OF033dOsYWy0Qk/kZBnLliND/0Y=
Date: Tue, 17 Sep 2019 10:39:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Baldyga, Robert" <robert.baldyga@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_093911_889183_1E725AEC 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>, "Rakowski,
 Michal" <michal.rakowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 16, 2019 at 12:13:24PM +0000, Baldyga, Robert wrote:
> Ok, fair enough. We want to keep things hidden behind certain layers,
> and that's definitely a good thing. But there is a problem with these
> layers - they do not expose all the features. For example AFAIK there
> is no clear way to use 512+8 format via block layer (nor even a way 
> to get know that bdev is formatted to particular lbaf). It's impossible
> to use it without layering violations, which nobody sees as a perfect
> solution, but it is the only one that works.

I think your quickest path to supporting such a format is to consider
each part separately, then bounce and interleave/unmix the data +
metadata at another layer that understands how the data needs to be laid
out in host memory. Something like this RFC here:

  http://lists.infradead.org/pipermail/linux-nvme/2018-February/015844.html

It appears connecting to infradead lists is a bit flaky at the moment,
so not sure if you'll be able to read the above link right now.

Anyway, the RFC would have needed a bit of work to be considered, like
using a mempool for the purpose, but it does generically make such
formats usable through the block stack so maybe try flushing out that
idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
