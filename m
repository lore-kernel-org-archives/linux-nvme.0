Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28991C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:06:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6A520B1F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbTjXRKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6A520B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iOzhuvQ55hjIbtp7QJ/eiTUpraUetSsWCsvcy/iisYY=; b=HbTjXRKHbVspxL3yeAvSV8Pck
	L/DxBa0diNixcPKN32MxhCOL8H4ktKAP51KZBp7/vWA6OiGHX4mrMJaBO5QFZYa0XnWl42q0YXO5P
	/FtOemxU1MKbLD9nJHn8O5LnX9ie3btYrWN/s+QsJWmfLtVR2lFS+CCFZP7eO+9ufXYmGCbvBSs16
	byVHNHwjsItkvO5Ka5j1fK8+kigYtpGkEpArguVR5YkWNSlJoesO7wTVe4lnrfHYzeUfu98Yi5Od1
	Ks11YNpnrMARrUd+3pjGtMeooBb/HTdJzuAgUfrQQKon2HOMHskJeoMTHUpaMhaOXzROzxwLkFD6+
	ADPu1TWPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxWQg-0007ip-HI; Mon, 20 Jul 2020 14:06:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxWQe-0007i1-7B
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 14:06:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AA26068BFE; Mon, 20 Jul 2020 16:06:01 +0200 (CEST)
Date: Mon, 20 Jul 2020 16:06:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v15 3/9] nvme: Move nvme_passthru_[start|end]() calls
 to common helper
Message-ID: <20200720140601.GC4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_100604_399888_DB8F2F35 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 02:33:13PM -0600, Logan Gunthorpe wrote:
> Introduce a new nvme_execute_passthru_rq() helper which calls
> nvme_passthru_[start|end]() around blk_execute_rq(). This ensures
> all passthru calls (including nvme_submit_io()) will be wrapped
> appropriately.
> 
> nvme_execute_passthru_rq() will also be useful for the nvmet passthru
> code.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

although maybe you could have moved the code you changed in the
last patch up already to not just move it after changing it in the
last one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
