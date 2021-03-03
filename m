Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED4C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0DE652CB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0DE652CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ti9/+8RvO70ZTG8G1tKEwwpoD6w6y+vGeHHOv3cEyVo=; b=R7iXbVzKS4i4h9Od8Ds+nF68Y
	FKwozjBr3NyYiAtUTuWbaRCMPlN/lOyF8Kcz0t8AX9QXkmdRW5azpW9WT0W3FJozioi8nEMsePH95
	7ak65Qa4+hmf+/w8gGqtbYx8pzqihWZzVvMsh3NBrM+cqJ18D+iy+ahFutkLRDmTvdcnb8ATW5hwo
	id1SyNKnI+CYSQrC/F1DaArCc1V9oOvn7/EIP5tzkXcoOk38c0AWKuIumUTo7ascxLQctgrIyWmpL
	l5er9rKr0JD+zceBZ738wW0Nf6lMIVIuIoBBmDuqA24kemA9KnbgC+JSBIiVGhPMYwMmxq8gGoEiu
	eChKDiB4A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHcor-007KjM-1m; Thu, 04 Mar 2021 01:30:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHYeh-006WlD-9z
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:03:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 28612AE1F;
 Wed,  3 Mar 2021 21:03:36 +0000 (UTC)
Date: Wed, 3 Mar 2021 22:03:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
Message-ID: <20210303210335.d7sxywknjswp3zez@beryllium.lan>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303125304.1200789-2-hch@lst.de>
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

On Wed, Mar 03, 2021 at 01:53:02PM +0100, Christoph Hellwig wrote:
> Fabrics drivers currently reserve two tags on the admin queue.  But
> given that the connect command is only run on a freshly created queue
> or after all commands have been force aborted we only need to reserve
> a single tag.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
