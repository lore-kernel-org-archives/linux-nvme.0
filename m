Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA85BC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATzZnYu1/wJpZqtvzKFnlu8Sq3WzD+ls0rupUup1kHo=; b=rbERah5YYj2hdPS7ehmm8zgLJG
	RfU81/k5mUkpHwH/oCALkc0UDBoc81K0dJAZSliZn81ytgBkTHn1S3aECcc6i7kQdnSf1Mw450byu
	EYlE0cWctmwCWOItC4qvbUegFn+zzDoQJc+2f/q1qfjdBh+Ck2zJvqvojpP4lGSNMypLWWTBrLGJl
	IElgrOvDEfnCWkyEJQs1ULEHHHtL5NB/4rz5Ut6cobQLSbvuqVMxRm5eSE2pQc3WCgK08+dOjPkWR
	VYZWcuwP1ASIDv0CofOyPrQFsxiUN+cK7Kd96VXy5FCG6F8f4bo77wqP7psT4D3Qzm8vo+D40XtM5
	rmU5tPfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p64O2-00DCdN-D4; Fri, 16 Dec 2022 06:40:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p64Nz-00DCbi-3T
	for linux-nvme@lists.infradead.org; Fri, 16 Dec 2022 06:40:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4696C68AA6; Fri, 16 Dec 2022 07:39:53 +0100 (CET)
Date: Fri, 16 Dec 2022 07:39:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: "J. Hart" <jfhart085@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <20221216063953.GA24390@lst.de>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com> <20221215082344.GB3816@lst.de> <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com> <20221215090941.GA5062@lst.de> <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com> <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com> <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_223959_311565_16DF088D 
X-CRM114-Status: GOOD (  16.79  )
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

On Fri, Dec 16, 2022 at 07:30:55AM +0900, J. Hart wrote:
> I've tried the obvious ones and that didn't help either.  I guess I'll have 
> to give up on it and return it as defective.  I'll go back to normal 
> operation and to try and find a controller/device combination that works 
> with the linux driver if there are any.

So on the hand I agree with Keith that the device seems really broken.
On the other hand the fact that source file system on another device
sees corruption even with the iommu enabled is something that looks
scrary.  Even if ultimatively caused by the device somehow, that seems
like the kernel is part of the corruption.  And I have absolutely no
idea how.  A KASAN run on the device might be helpful, but I'm also
reluctant to ask a reported to run more reproducers and something that
corrupts his data.

