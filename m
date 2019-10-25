Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB0CA9EAF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275F521929
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ayfuluNg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+qdYz4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275F521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z4k0b8ZSkO19ApXMSoZw1Ycqs24WkeHIdn//HZ5O4Lc=; b=ayfuluNgPHmp01
	zqOcDDwDur+SNDUpc3sq2oXhf1QdzIEZbkcumwyjl3ZXaYcbkNwjT5SVYAgAqtltTm0CvOTOVqx7w
	b8kbIQj0uUfk0GSjwMvj2pDairzEqmaREJqNL8oF02VKVlPyM4xHwRFngURfjKaUrgl6EaVQGhFgP
	bHtT5mwrEcLCX4SvGtdOHQtvLfODUAY68reLlGpjC8ec0ykZfyx4+R4OgvReKl9MdaKP8kwBORwZ8
	/piXk4wz3n6f6+fsVqMqPKCeOF4LZRleH9G1dXDDx3agEeAv3Fpj0pvQ3iSQ6AP5kxXs/PNdNgOQ/
	Qpl5E6f1vrYBfM8O2SZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNnKV-0006Zb-Bu; Fri, 25 Oct 2019 00:19:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNnKT-0006YO-CB
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 00:19:46 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06BB421929;
 Fri, 25 Oct 2019 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571962783;
 bh=qeb+RACViZjfla1NOoCoKbMc/synwBpBMGikLRyGhe8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O+qdYz4m2eXzDmke+fcya7AMtL+kYEqJ67POsjO166w1gMwnumAs2fyFdnPBe2Hnv
 1bIOC2Y37sGz5g9YqX+JmfHmBInXQu9sBFduC1jjwyQV1GtJ+sQBHv9IZxVY+iM1fq
 XK5/e8PDMtn4kD4d5vNK75HAi7R5Xj0AZPORRres=
Date: Fri, 25 Oct 2019 09:19:38 +0900
From: Keith Busch <kbusch@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH trivial] nvme-pci: Spelling s/resdicovered/rediscovered/
Message-ID: <20191025001938.GA28602@redsun51.ssa.fujisawa.hgst.com>
References: <20191024152400.30082-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024152400.30082-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_171945_438741_8AB69E5F 
X-CRM114-Status: UNSURE (   6.74  )
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
Cc: Jiri Kosina <trivial@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.5

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
