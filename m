Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10127D3C52B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X7BMDOchh3wJGSkCRQYLwbhivp998pspaWX+TukjpGg=; b=Ig+q/D1Pa1IKy0RFnlbBZo05WX
	bKqK3GF9y+lfDUQLtja70IzokZDhfMrMiTXyKi+hvDsvm2wDm/5NpDOoABjJgSjQZPcdZUdMqmnu/
	xnefwhAUIeuq7q0BefuA7kHhfIELCcV0K0/lUQx1q+cgAuRarxocZvhP1myfBpvkCMQo9ADhkUgXN
	pWF+gzu6WOB2yXXO0nnvbXFYu9MfHX+zdqCLDPDQjTNkCRxWSasVXsJYh922v7M5Vg8Ay5vGaQ78I
	BxYOaR6L+g1ZUueUM2b5Yo8iO1mFoKSODBcZc9Xzkaa96086aKd8XmIryM/MwWi4O7hgs0qxAoWZQ
	97lH5yeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Uv9-0000000Fp6a-0ACS;
	Thu, 17 Oct 2024 18:08:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Uv6-0000000Fp5q-007f
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 18:08:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E28B95C5BF5;
	Thu, 17 Oct 2024 18:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC4AC4CEC3;
	Thu, 17 Oct 2024 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188499;
	bh=Kymg/bTJlENKjTKas2a8NSMhY3dKdr4hdEiZRaLSZJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLtz1HUSOqZYzRlOkV/RXjVGTDX3MyES9oruTIFweZKvTwBrgLVpwW6CvSsHbIJD+
	 WtzYNwk9V8s8L5X6xzY//jyHTPgzNizjU4hRNoc+0t6kt8cyCop9+1t2ylHLTFTNeU
	 PVmnim3VfNePTa1DnO/9HNS6hwrtkh4chnMTyXLg38Rh3f1+xWcHzYdmGx3Ubahb1F
	 +/+GIzqx0LtN4aayBE2ppEoso2WQ2ElcjAHdWTlBdbGyVcMQzkTKSC9mhuADYYSBQd
	 uUuwCRluhnfqeKG6xn8f5//TpUwS2dHyifYbC0jS94fColh+3+SOWt8o9PU6sy4uf7
	 gnvt9NCYo3kzQ==
Date: Thu, 17 Oct 2024 12:08:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 0/3] nvme: system fault while shutting down fabric
 controller
Message-ID: <ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016030339.54029-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016030339.54029-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_110820_111043_CCC224EC 
X-CRM114-Status: GOOD (  10.70  )
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

On Wed, Oct 16, 2024 at 08:33:13AM +0530, Nilay Shroff wrote:
> We observed a kernel task hang up and a kernel crash while shutting down
> NVMe fabric controller. These issues were observed while running blktest
> nvme/037. The first two patches in this series address issues encountered
> while running this test. The third patch in the series is an attempt to
> use helper nvme_ctrl_state for accessing NVMe controller state.
> 
> We intermittently observe the blow kernel task hang while running the
> blktest nvme/037. This test setup NVMeOF passthru controller using loop
> target, connect to it and then immediately terminate/cleanup the
> connection.

Thanks, applied to nvme-6.12.

