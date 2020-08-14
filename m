Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EEC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:09:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73B72074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OJ21yGMu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFKU9ZzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73B72074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8Y2OjUy59oRQ+mbsYMV2xm/heGTnhmftOawAfg9m1xk=; b=OJ21yGMuUjjJs9ClNfOoaGOX3
	WXIEBZa+y2intTxj2qDTRzRYti16WEyJpzdi7GX2FcUZu65s/b3toHwEchd8TmQuRvgk+HV6DBJZH
	k31EOHK1Xb3nX52J4uWazR11Fhz4zvkiYwnBLL80lS+rBz8kTh3CTkR4vUGefGB4eUmBEg+Zm0vyr
	HXW59Ni5+KlgsjOT71anfa4zMYxj1bXYcAvpWZc1pEdpa5lLiLeHjeeCQltVvw+qaQy8NskfkY2ET
	VDAcYs34zsyw76A0jyBzYu73QHYDDVSzOxgSHyyJcvSCciy4OvWtk3pDieh8udd/pmOw0eJDBF7ua
	D8NzTlfWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6WeC-0000tN-QV; Fri, 14 Aug 2020 10:09:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6WeA-0000tB-DQ
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 10:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=C7BilqlIVW2TMUg+aIJ2U2+ac9vCqZLJawdRsWE2Fzo=; b=SFKU9ZzH8lv8W9EE+CxdaDBNmm
 bFWHaXGCLM0UJt+L/4uyyAoGaWJABEypRMMzGp9rAwcz+7Wqcfd/Bru3a5lCj7ieEe774TFEqe2G/
 ifcSq5E9z8W046m53dHiyJaoThkI93FFpKpQrXedtUCpzyte9T9lALAUMnmAW9OT/8LTetICMFXlc
 r5XB0P+USUuyNy+5U2CBGjeYWs49Muu+ohNbOYfQ39gQXmh22ni0uw2RW62CgbDP41/rRGuukN7vk
 mNI5e8rLPD2OQ/7b/5w39CbITr6EzPSp3A0nY+hOOGX+V598vDwK2UF4y5XujvnSbj2od/PDhhK7y
 y2N4yc0A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6We7-0002ho-ND; Fri, 14 Aug 2020 10:09:11 +0000
Date: Fri, 14 Aug 2020 11:09:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200814100911.GA9975@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814082015.GB18371@infradead.org>
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "Engel, Amit" <Amit.Engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Anner,
 Ran" <Ran.Anner@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Amit,

can you try the branch below?  Pretty much hot off the press, but I
think this should address your problem:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
