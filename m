Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E69C001DF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrKLmIm8rSN6fQb3wTpyM7s13FV47whzXvai8eweME4=; b=SxjWZmhP+3pTz+Exg+GoLnekOM
	yvjet1dWxjWUv2MwJjwzZ/osZkR26tsKjY8q1TCNdPu7ajoknu95v0Ae0nRKXaUDaKJmtQvM8sk/b
	O/K/4P2HAxwf+bjzCL4KqfYfe09dmD5zgAxSBTUINY0ZL07CstRwi/bne0pmrw4Xp7C7owd0lNB9K
	oOfEn58EYNBWG31jjOaR61uquH4XJGahRLBtWrRjbncJwBUgaZ8Jx9sGm1HNJWjiYG7yl7dm1saOC
	Tggsp7HR04eD5sg4vo1W/272h/+a/A4bw09xPUg2003PZD8ybYNLyLJQ4OF/VuTafCfqb/aPxEcxi
	JdfQXaxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnUA-0025Sb-0O;
	Tue, 01 Aug 2023 11:24:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnU6-0025Qe-2D
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 11:24:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B64B76732D; Tue,  1 Aug 2023 13:24:03 +0200 (CEST)
Date: Tue, 1 Aug 2023 13:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>,
	August Wikerfors <git@augustwikerfors.se>,
	Keith Busch <kbusch@kernel.org>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilskruse97@gmail.com, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230801112403.GA3972@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp> <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se> <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com> <20230731201047.GA14034@lst.de> <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_042414_865013_4BE0B262 
X-CRM114-Status: GOOD (  18.00  )
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

On Mon, Jul 31, 2023 at 03:14:54PM -0500, Limonciello, Mario wrote:
>> No.  There are tons of NVMe devices that only support creating and
>> deleting namespace out of band, especially in virtualized and cloud
>> setups.
>
> Even if it's only the error handling path only that it's checked?

Do you mean nvme_validate_ns with the error code?  I wouldn't really call
that an error case, that's the function called to check namespaces are
still the same after we did a rescan (either manually or triggered by the
AEN).

> If you don't want more changes or heuristics on the error handling path for 
> this case, I think the best solution is probably to pick up
>
> https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
>
> instead then and hopefully we don't end up with more disks like this.

That's probably the better idea.  I know at least one of the early
quirked devices also IDs that changed for subsequent identify calls.

