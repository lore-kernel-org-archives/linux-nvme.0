Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE2C433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:15:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D2720738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fne08BO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D2720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6Tplbmg5v/D8LmGpgKb94e4ar7TpzCWrnTaKF6nDFhk=; b=Fne08BO2hRUnziaIUpvCGhJwq
	PrtKtiRdF0nKyjNu/XBQe6KrK9z6b7zTLmGq1xCi2yxTsKqnBToph2E19VQ0fi9eI/+dCOubk8ORD
	psy6sTA7SdfUXdcEG6vai2eGJn+7+ZxF4Q/hqtFmf/JehsM+8hE9OYaVz7d4Qp1s95pq7efnrlv2y
	AEqgmyodvuOf1nnFu36MHEwUrHTZODZ+8dSAhenHgwdWh+A9DZbNNTtoAKuY88PIlbfboyAOL1OpM
	Fv0BeyYJ2TBVPx8Yh6Yuxzbjes/F4BGoi7BKRq+CO/v8+VVQG/yvC4WZjV3BcaD//AmdEiFVLAtk+
	zRip6Ig7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aIq-0005mm-3v; Mon, 17 Aug 2020 08:15:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aHF-0004ra-L5
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 08:13:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F324768CF0; Mon, 17 Aug 2020 10:13:52 +0200 (CEST)
Date: Mon, 17 Aug 2020 10:13:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
Message-ID: <20200817081351.GA16571@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
 <fa05af11-d82a-13a4-e892-6dd8e65bf981@huawei.com>
 <aeb44221-8740-3ff8-1932-e9c2c106ea57@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aeb44221-8740-3ff8-1932-e9c2c106ea57@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_041357_845735_08599ABE 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 01:49:47PM +0800, Chao Leng wrote:
> If without any multipath, will not retry.

Which is the right thing to do.

> This may not be what we expected.
> If we can support both NVMe multipathing and third-party multipathing,
> it would be great. In addition to DM-MULTIPATH, third-party multipathing
> software is provided by storage vendors, such as PowerPath(DELL&EMC),
> SecurePath(hp), Ultrapath(huawei), etc.

For dm-multipath we only guarantee we don't break old behavior.  ANA
was never supported without nvme-multipath so this isn't part of it.

Out of tree junk is completely unsupported per the kernel wide policy,
unrelated to the nvme driver itself.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
