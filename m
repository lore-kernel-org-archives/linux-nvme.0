Return-Path: <SRS0=aIMh=YK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B2ECE58E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 14:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00ECA205F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bZkFYLX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ECA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=bZkFYLX1hJ5ufC
	nA1Xm4abua+lVSr7R0ITLHy6yQwopTOBrPYngkNDgcBDblntOzhkbBBhyN86nmxI2e2MbySZjFHU5
	Ba9HZkMa0p2IY722RU63Upl8juV8lbixvvrM62AG8bmkrWJI9Dv9vqNIu/2EZb4kLPMVUpiX+K4qP
	GxE9w292Eg/00EUntDmbpvOzkaEvRzZjwTNPmDDkxOAra1D1njY2DWfbhRsx2zfsXeOaDvi49HDgY
	ibFvwnELRGVZsYJo4D6SrV5WgQvTSgQcll9bYtcJvLhuoLND9YniYOpBS29/jj6Y+RXeDSdEAez+U
	WfAx1XPsMhIiCja4NLjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iL7C4-00046L-KX; Thu, 17 Oct 2019 14:56:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL7C2-00045p-5l
 for linux-nvme@lists.infradead.org; Thu, 17 Oct 2019 14:55:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB61E68BFE; Thu, 17 Oct 2019 16:55:54 +0200 (CEST)
Date: Thu, 17 Oct 2019 16:55:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] nvme-pci: Set the prp2 correctly when using more than
 4k page
Message-ID: <20191017145554.GA8676@lst.de>
References: <20191017073428.46155-1-haokexin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017073428.46155-1-haokexin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_075558_366330_C9627A5D 
X-CRM114-Status: UNSURE (   5.41  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
