Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C657C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA44F6574D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA44F6574D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SRiKNX/pi5nxjdAAX+UWlgKpnjtQa/OlhvsIFFsPLr0=; b=ezmnZesxyp1zdtnNFO0Ogu7ra
	qFc0q6JXCGfckDpVni3kNX1exG8oneY+7AF9cyl4NLRoSjIrvL4aIYGFUG9aQwopMYAFzLfIJlhNO
	t8E/+B4P2znU74oJBEcPP0vQK+z1sQebuq7CrQ4RCmmj83q69YgjagH7MpcBslWg48Va0JP6Uk9zU
	ri03tl1sCvCdJu3QS2DbCjKKhOboQQ94PXfw9iVvGSQ7c9/WD56SbqVv5v8kPzCBU3hOcIY/gsFQg
	rQy7tsB0HJgrBE5/NmCPPMftFcyRJ59AnvoRVOf1HUtKl7EROJFKRg5z4tsaTl9nM6VVDLNBBNAft
	bivl3+Kag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHcoY-007KfX-J0; Thu, 04 Mar 2021 01:30:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHYcR-006WPG-IZ
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:01:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2617AAE42;
 Wed,  3 Mar 2021 21:01:19 +0000 (UTC)
Date: Wed, 3 Mar 2021 22:01:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Message-ID: <20210303210118.b6chxyxrfs63is2x@beryllium.lan>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303125304.1200789-3-hch@lst.de>
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

On Wed, Mar 03, 2021 at 01:53:03PM +0100, Christoph Hellwig wrote:
> Merge nvme_keep_alive into its only caller to prepare for additional
> changes to this code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
