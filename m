Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3E9CDE024
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/fIn7u+4rHlHRJlM68kvvjQ95OWp5axsLKoemYDM7s=; b=RGkkGWAtHCbMQNUv7X1a3PAmyi
	1FaTwMg8CPM9/pMgfpDrTfHbwSWQXxIeRsQ3BjSl4V/cCnbZH9Qa/BtT7UYRIXPbD86uKlq471G3O
	dNWplXqypFrpndX/Sjcj1x/Ao6KQ6GEBGYL/zTY48EMtFKK0WOVG02MWOKIC6K7he9ADAvLNlX0bk
	ksI9IZnY0tsWeoUwyFE83YWYhVgM2soyp6SQAhc3Ds2hD8H6z1/vjvutaazlSSq5m5LvDTbZkliRW
	EWbGkOd2PaDLG+yvypBW0Q/iXEvT9lSIegNdwNzRn1bWxJBn897vrhM1J5LdGs986H0zSui1wiBw2
	dFIT63jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1strnP-00000008wrL-0tch;
	Thu, 26 Sep 2024 16:56:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1strmX-00000008whw-2oBQ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 16:55:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A970FA41AF4;
	Thu, 26 Sep 2024 16:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21794C4CEC5;
	Thu, 26 Sep 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369756;
	bh=SXSEiQQI9kGrzyiaXlBcGqbkXlxYap13u+JfZINCSZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN5PO9sq3jyuQGdQayOLjh31cxzpOk32q721BBOG4n9PvHkz90mM+bAgn6mCbf2+E
	 lTV0OKsgxtArms4tzUIBx73ciHXG7QwXbQ4nO4xy4IgJulMLehy3+3kEEcHyVnj5YI
	 /8T8BsRdo1MV7ojTHjR6SDLETAoHAvn4hcTV3GCumntOgEXpsoYLnietSk6Fsld2lA
	 R0gbDgGNEwt4bgai2vsr3BQvmhoY/I2RKvUdXvxMBHIe6gAnifTeuD6sNn/a6NKZzS
	 9ZkJo8SU/7ExFF3IpGMxLyjIwSCOFQAGdWZrtvI4nAOv556dDY/CdUS8CZVyDhBQHg
	 xo5UhRG16gQKg==
Date: Thu, 26 Sep 2024 18:55:50 +0200
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_095557_792850_F979A280 
X-CRM114-Status: UNSURE (   8.64  )
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

On Thu, Sep 26, 2024 at 10:08:09PM +0530, Kanchan Joshi wrote:
> But there are kernel knobs too. Hope you are able to get to the same 
> state (as nop profile) by clearing write_generate and read_verify:
> echo 0 > /sys/block/nvme0n1/integrity/read_verify

It's not the kernel's verify causing the failure; it's the end device.
For nvme, it'll return status 0x282, End-to-end Guard Check Error, so
the kernel doesn't have a chance to check the data. We'd need to turn
off the command's NVME_RW_PRINFO_PRCHK_GUARD flag, but there's currently
no knob to toggle that.

