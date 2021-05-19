Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F3C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:36:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19EE610E9
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19EE610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=07u8jzoInrhq1KQCsevWmS3RuvSnh9SOyNd7hxCGiHM=; b=n80oiGjSOInjp0rRA6XhHYMuX
	8SUxfkJz8dZ+xeHxl2NFGyHg/vsE/uVvfg2C/BM8Qasg3fJJmloRkXz6IWaBSrauE6JX1t9gC0HAT
	x+fK263+Cpd5GDiYEcUvgtREdcRxPf2DZmK1FTpT+Bw27IhtN9FYL8AWIw8IUFAKDv8aDC/wOEB+S
	csHw3Ad6h3ug97tgUVG6/OwXZwkB54YOtD5shoVPsB62WC/RUUAGn+bvPLjUCsVUDDKEvrDLyK2MK
	s9IlKU2mxJPjo64xOJR0XXYqx5BC/1D0/RwwibToc7rw/JaT9Xgk3xI0ol0DW+aJsS2fGIef91/h3
	lCr2OLpKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljFo9-0030Sy-Do; Wed, 19 May 2021 06:35:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFnu-0030QR-RX
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 06:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5+UQIRoYcUWlO31/m41QlF9o8ppkJRLZPv3rRTX8FvI=; b=4XuNHklzcVWlVzMB91Ac6gfKzJ
 U//g/TZzSV7oXTYrBI2hw5L6kujrv1/63fY8EkPbJ5HgqWjxFXURPTJxq2vMGP5d5+m3RHJNt9hAd
 Ctxl+9cv1TuA7sxWq8zBl3Xms4/joW///WUEKCR3iNpE02grZB+QE9anMX5LrTyRrRSUq5WdFcjd/
 IXxtreAcYQm62uhQ4k6O9w34BnkXVSHP9/B9o/ZQL7ghu2wFpSwPT2yWLdVBKayn1sSJYsulvyWAS
 AUFWpX/DLFz3pfxlfT82rFVdRJFE/M90bSJB73Xab6MsHrLrHrNeLLgs+83Nj9Q91ARtieR2XQ6Of
 c7jnWhVQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFns-00FBQC-Eh
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 06:35:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1FAF767373; Wed, 19 May 2021 08:35:34 +0200 (CEST)
Date: Wed, 19 May 2021 08:35:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wu Bo <wubo40@huawei.com>
Cc: hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 kbusch@kernel.org, amit.engel@dell.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linfeilong@huawei.com
Subject: Re: [PATCH 0/2] nvmet: Fix memory leak when create ctrl fails
Message-ID: <20210519063533.GC30513@lst.de>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_233536_657893_DD8C7E11 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.13 with slight tweaks to the commit messages and
fixes tags.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
