Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFBC432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3360520721
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPz4T1tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3360520721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SHPkmNe4mOlvW1ULn+Fe6ivsR0Sbo+1o0tdoi973pNk=; b=bPz4T1tBkWKJJ7
	6FpdMT8e+uJjrLsisWzH/n/xa9zNpYbyBM5UirXTmgtccJwkGbE6W5+KqFeYsTLIrf/138YUhE6kW
	Zei/6i+L4aQ4lpO7cJ+e7182NoHGuGRnmj+IzUuIVcbE5c6xXxBXyRzBFv31prmkHq8lqj/RutME8
	2WZ9Vau09QJnHVC7Dbnwe9nix9ghkXdYlwX+ZvmKo21hLEB/e/GrUZRQoUIZ4Td3paO4rV7duwrt5
	PSDzRQ/zwYI2O1/1Etf4SbL6D5cBG4qFiKKTtZAMUwhEoBL/ibcVGmYVsQsQCtgL3kQ50G6ZVkBBa
	mKRxoiPJSiiBtynBGF9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXV4V-0003wp-2M; Wed, 20 Nov 2019 18:51:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iXV4T-0003wa-Jn; Wed, 20 Nov 2019 18:51:21 +0000
Date: Wed, 20 Nov 2019 10:51:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
Message-ID: <20191120185121.GA697@infradead.org>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
 <b79e612f-4b49-a80f-bc34-e672ae98c1af@mellanox.com>
 <B500B4ED-DF25-41F3-83F8-6E239718564A@onestopsystems.com>
 <c8472575-1041-c44e-e26a-1201161c22c6@broadcom.com>
 <802cb171-34de-65cc-75c5-83ef7c200dc4@grimberg.me>
 <3D590371-4C4F-4355-B36E-7795FB218FC6@onestopsystems.com>
 <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
 <BYAPR04MB5749590C4171F548680DEB7686760@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749590C4171F548680DEB7686760@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>,
 Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The min/max approach looks sensible to me, at least with some good
documentation on how to use multiple Linux systems to implement
a single subsystem.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
