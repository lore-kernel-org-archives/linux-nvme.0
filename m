Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DDC43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 08:33:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0789421823
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIo63H/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0789421823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDbXbq5rUhmwSY0jkv6pIUW7/CIuaxreZraOyD+dkDE=; b=jIo63H/wk87l0p
	5jPZ1hYEeZaizCAu914stxdIRGCmTRWtB5hUQudAygfsuNe0Ix1z8ENV92HYCAMnk/jxyZscIv6t7
	8JaA58VZME8LMsqQQjdDVC5ieQMrlaNAGS2o9+Anhdd41ziCLLIhXce0Fcx5R4sbt3pKj912cPl/n
	KBfhw/65ByaFhTYKYlkKFNxSItNyrtXDkdqaxzvgq10Vi5UYIR8H3OcS6BQVlAD9gfVPXFb5OqdgD
	FCNfx5ZyT5tkWX5fRWVgNRCM1OxvO/dQg6QSWGFn9Ah7McgSyLCciJQcMh7Qrfcl/H6566zh2o2N9
	gyd0O24HsBdhkx8sqq6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icmZk-0000f6-2D; Thu, 05 Dec 2019 08:33:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1icmZh-0000ev-3i; Thu, 05 Dec 2019 08:33:25 +0000
Date: Thu, 5 Dec 2019 00:33:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amit <Amit.Engel@dell.com>
Subject: Re: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Message-ID: <20191205083325.GA855@infradead.org>
References: <20191205081541.55962-1-amit.engel@emc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191205081541.55962-1-amit.engel@emc.com>
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

->data_len is gone in latest mainline, instead
nvmet_execute_get_features check the transfer_len.  But your
general scheme should apply there.  I think a little
nvmet_feature_data_len helper to calculate the required length
would be nice, similar to what we do for read/write commands or
log pages.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
