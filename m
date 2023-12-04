Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED02C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=; b=cZ7VLrNj/w3NAAZMR5jEoJN/sk
	NCFYbAHc4DRD7O3xtr2RChBAWPcHok5broNcOZRt2WdoDGigzEDLGMa8wM52xosowfAsBfzwUXUv8
	svjBo4H/G6/6zzJpouS32HCthU8tBcvnktES0sc9MYoc7j+k4KivnVexF/4RsW0YaIMlbn1t0nnz4
	+E6+g4HyxFU4fEUTTpS2Rxpl99Sf8eIzgZiTB9gu/z2TX0E21shpulXX1/gvU8tp70kRP2ZtK5WBN
	1lalacGT+r3lR47MsXrf9wq6cs/Dd++KetQ7fJTKAlGZMO32I3Kno4esP3ZACbwa9CE4WxCKQgM5r
	e6N4lOHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rABzp-0057BF-17;
	Mon, 04 Dec 2023 16:40:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rABzm-0057AT-0f
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 16:40:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8330ECE11E0;
	Mon,  4 Dec 2023 16:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC3C433C7;
	Mon,  4 Dec 2023 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701708031;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRWCD6tyZWQkZlOkjPYf2OLC4OsVSumZVNl+gcarMVxaTsSX/dhSrXp4Sz2+sxlSm
	 +DMci+AzPkMg5T4Vslc1rNhfnT89F5AldCT7AxyHWPxF6yBiYI2EX8vpIzAmPY4u21
	 csSW359pPkWisqLONYnFpSdkfWeOCIAKnuv8G0dOwo0Md62uWDKoqy3qA8GlyFOeW2
	 x1sy/PNITiBBUbzRoFbtlan7qOPJlHRYQAjftoNX/S5+5MXkbPEIBvNEfbawQscy+N
	 AaN1gI+UjOxbdG29DzqZOJPqplZMLAw6edYBRiDPmKFKm2C3V4zsuhITM6CdegdE/C
	 sMVDJgmcaBvGg==
Date: Mon, 4 Dec 2023 09:40:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config
 descriptions
Message-ID: <ZW4A_W1jCw9m0K9s@kbusch-mbp>
References: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_084034_427724_BD4B049C 
X-CRM114-Status: UNSURE (   5.06  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-6.7.

