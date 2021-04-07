Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55029C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 05:28:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66DD613B8
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 05:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66DD613B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uZlmZXy8vkn0xc9wnDwABwMEbQ2lPU7h3dbXQFMuFDk=; b=Xa4rn6CtiIZ/8Nc/8Bj43nNkH
	neUwobRqBCmY8kZoqzP0oxFGq8Zloe0o8DDWQC1YaihuXvt0tJY5k2cdKxnscMk2IxdrUi1pakr5d
	mYFSlW2EAxA45jSmnMRyBSYNNAf6H+y10kO23MEwxcB7NtXNzAwE7W0wmVyOEYkNGhUr3mI4AXBaV
	eyC5e8nPfmsvdeIPlhesJKz9eiAWhNW+1ecNl+WHulbLh5CZeNSxUp1pbZQsHDaWZboPnjPehs+gG
	aUnaK8mVOCjXzGFujD/KtLZClF36Xxzjd5OQrqbOkgUhwb0kFaJnGQauUw2sT0PvEalXUpusIwGoQ
	7tymS18Kw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU0jg-0047t6-Eb; Wed, 07 Apr 2021 05:28:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU0jZ-0047pr-M9
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 05:28:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 666C368B02; Wed,  7 Apr 2021 07:28:06 +0200 (CEST)
Date: Wed, 7 Apr 2021 07:28:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH stable/5.4..5.8] nvme-mpath: replace
 direct_make_request with generic_make_request
Message-ID: <20210407052806.GA18573@lst.de>
References: <20210402200841.347696-1-sagi@grimberg.me>
 <YGgG2TAA9TNqM9S6@kroah.com>
 <00e36c71-9f2c-5b38-96fd-3d471382f6ac@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00e36c71-9f2c-5b38-96fd-3d471382f6ac@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_062809_858718_6A61A6E2 
X-CRM114-Status: GOOD (  15.94  )
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

On Tue, Apr 06, 2021 at 06:04:09PM -0700, Sagi Grimberg wrote:
>
>>> Hence, we need to fix all the kernels that were before submit_bio_noacct was
>>> introduced.
>>
>> Why can we not just add submit_bio_noacct to the 5.4 kernel to correct
>> this?  What commit id is that?
>
> Hey Greg,
>
> submit_bio_noacct was applied as part of a rework by Christoph that I
> didn't feel was suitable as a stable candidate. The commit-id is:
> ed00aabd5eb9fb44d6aff1173234a2e911b9fead

submit_bio_noacct really is just a new name for generic_make_request,
as the old one was horribly misleading.  So this does use
submit_bio_noacct, just with its old name.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
