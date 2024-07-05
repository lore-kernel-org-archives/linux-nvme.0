Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E746CC3814E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rEEbbrC8aRXr90rm2dfj6wtkquFsmVeWR3hUqqr0is8=; b=BVdDIPSaA1FAJF/UvWKZdtnMef
	kMTjsnd9MNIFYUgLjA+RUvgaCcD+6PRo+ZE3djJ3eL/5T2Eo78N3Y25h/CKFO7ayyXwjvyTy+8/Vj
	nUrZNxJJD/TtLikUUOB0Dr9ly+txF3KST/JgFlVDS37rFz2VktU1RX/G3BM3kjWltAkEuksRoi9S1
	qv6Wl5pzCmJgTEXICpkwljmMAItQBSoGonFX9yXXQuVOqJ5JNKpJusYGs/mwpAXQRRY4vl/zAHijS
	quWeRuKttbTR8RhP4/Ejioe2Ku3/EsTLQMx+YnmmDUTkAE4bovstVV2KoFjKgZbj6s29OEtS//kdn
	7RxOJltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPmnI-0000000GYDx-3n88;
	Fri, 05 Jul 2024 17:32:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPmnF-0000000GYDJ-2vzH
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 17:32:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83F4268BFE; Fri,  5 Jul 2024 19:32:16 +0200 (CEST)
Date: Fri, 5 Jul 2024 19:32:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nvme: implement ->get_unique_id
Message-ID: <20240705173216.GA2279@lst.de>
References: <20240705164640.2247869-1-hch@lst.de> <ZogqNFka2384O0pT@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZogqNFka2384O0pT@tissot.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_103221_899870_9EE1F619 
X-CRM114-Status: GOOD (  14.17  )
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

On Fri, Jul 05, 2024 at 01:15:32PM -0400, Chuck Lever wrote:
> I will connect with you offline to advise me on setting up a test
> harness similar to what I have with iSCSI.

Unfortunately there is nothing that works out of the box right now.

What I've done is that I've taken this patch:

https://lore.kernel.org/linux-nvme/20240229031241.8692-1-kanie@linux.alibaba.com/

which still needs to address a few issues before we can merge it,
and then hacke the nvmet code to not autogenerate a UUID.

I'm looking into a patch to disable uuid autogeneration, and hopefully
we can upstream the persistent reservation support for 6.12.  After
that it should be very similar to the iSCSI test setup.


