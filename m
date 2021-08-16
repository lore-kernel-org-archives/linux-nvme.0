Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EAC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE56860EFE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE56860EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+HDZkga0UVHWAf6AcsnzOqY8upKsQ4IqexPHH8nNjc=; b=C1nB3kxStx/apc
	FVPKYgkwZmvR4yDTnUcOJOc/5E2EvoR+JxtJ6NlNzfXfqnXumgC8QhKka3Pdw1r4Th+1Yv4erKM/t
	NydRXj4aGw3XBwo6Px523mJR1Ft3QFfm7cyd1NLiqfWtiTIYelf55HlYuYdYT56njtobgKFMketOg
	vehoO6wh6fxbl5DIIzIk0gT5YX0tQpnv4+wEaiyCWfbENasMTOHYM8Va4hHog0UOzPVYIznSk/1Ex
	VjMhahDxRAXjwpma8caCQRLVIknJXpzz7TvyFXZVeUUPvuViyStEwt5TdnqWFYex9KH3Cy0e9ZtNq
	vRBw5qcrgUhO3BDiWvFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFfjC-00HSWq-8R; Mon, 16 Aug 2021 16:44:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFfj9-00HSV8-5B
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 16:44:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B17806736F; Mon, 16 Aug 2021 18:44:38 +0200 (CEST)
Date: Mon, 16 Aug 2021 18:44:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvme: remove nvm_ndev from ns
Message-ID: <20210816164438.GA5581@lst.de>
References: <20210816162452.223334-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816162452.223334-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_094443_372805_149EBF91 
X-CRM114-Status: UNSURE (   9.02  )
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

Thanks, applied to nvme-5.15.

Can you take a quick look at "nvme: remove the unused  NVME_NS_* enum",
which fixes a similar fallout?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
