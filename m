Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F4C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 06:40:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA77207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 06:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6Tf8zc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA77207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4YVXOY/KFB5BIUpTbDTFbByKQFyrZuuF8vvHph3rY2w=; b=V6Tf8zc8ESG7qu+i5mAwk1dR4
	DZ/adWWERcN3eDGgONpjUl9qGvSFzFjxeFDhBfaAtn1xxNHCyQaUOlzaMCQtXhX4dQmxnDiblhTxO
	dHsKKL0Xd4Ho+qZw1hGZOgH10zuOE5FZzP42nDoqeW6fI48lzQih3FZuc1KFWdXXZ4WWBT3LwrkNS
	4yffLgMYnfMqLRTeQtyYStM+pglIRvYw0nnN2NHdJXLQHIMTR5b2ri8CjUGzcIKfIoYXTWBS1/4Ne
	xlhuvQG+0lgbzqX55lxhsFDS2G7Vi6RisPm83ZBIdQWhtz9KVHfpl25ZsfmV5VXx9B9Mmyeaj8Nnn
	NCXERJBwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBBaG-00080L-G5; Thu, 27 Aug 2020 06:40:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBBaB-0007zx-LI
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 06:40:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69E7968C4E; Thu, 27 Aug 2020 08:40:21 +0200 (CEST)
Date: Thu, 27 Aug 2020 08:40:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix controller instance leak
Message-ID: <20200827064021.GA4757@lst.de>
References: <20200826175304.2151626-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826175304.2151626-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_024023_813348_5E25372F 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 26, 2020 at 10:53:04AM -0700, Keith Busch wrote:
> If the driver has to unbind from the controller for an early failure
> before the subsystem has been set up, there won't be a subsystem holding
> the controller's instance, so the controller needs to free its own
> instance in this case.
> 
> Fixes: 733e4b69d508d ("nvme: Assign subsys instance from first ctrl")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
