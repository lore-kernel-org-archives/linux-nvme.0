Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E514C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g41bNfVEIy5ryRS7rX4HLAPR3mbK+n1gxYRdnvKWEMQ=; b=H69hPEOYwjdHbwAR0ycih0W0Fq
	FUE0gRnI+ctb8r8Wb/zD0+s9O1Oy8+QYawQhpbMFoidCtKccZwqqzdYNoXSD1UYaSuxTOeE9uTNFm
	ybXKcqW4JEbb3P9lTrReP+3fa6bFXmrlfy02USQdRAE16q18gN7EPUwHT841hyYIoyNZzv9fD8qKi
	pUU840LcXDFKcnVttG0YGEEyjIvQuFaGHrwgog4Qh7LtmuF4IlOF52eBs8Ia9CgO8GG9Q35yv4IJu
	MVOnpaHyRVwHt5WP/5DM8SAdMqCod2ipwY9JEZHEFoaHIYbZt8hBhlubXtQwdJTy4wVpzfY4WNRmd
	jekg6N2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwou-007HiJ-OO; Wed, 07 Sep 2022 15:18:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwor-007HgB-6m
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 15:18:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A89967373; Wed,  7 Sep 2022 17:18:18 +0200 (CEST)
Date: Wed, 7 Sep 2022 17:18:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leon@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Israel Rukshin <israelr@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <20220907151818.GA26822@lst.de>
References: <20220907113800.22182-1-phaddad@nvidia.com> <20220907113800.22182-5-phaddad@nvidia.com> <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal> <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_081825_416897_45EF82D0 
X-CRM114-Status: GOOD (  14.66  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
>>>
>>> This entire code needs to move to the rdma core instead
>>> of being leaked to ulps.
>>
>> We can move, but you will lose connection between queue number,
>> caller and error itself.
>
> That still doesn't explain why nvme-rdma is special.
>
> In any event, the ulp can log the qpn so the context can be interrogated
> if that is important.

I also don't see why the QP event handler can't be called
from user context to start with.  I see absolutely no reason to
add boilerplate code to drivers for reporting slighly more verbose
errors on one specific piece of hrdware.  I'd say clean up the mess
that is the QP event handler first, and then once error reporting
becomes trivial we can just do it.

