Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460CE10F9953
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsQyl1ZyVyK9D9CF592JArgWi3cqdGNTKg78GwavARM=; b=DFnM5LAKfeL5WEKF7Pnje1xoyM
	+ce6qXHmQnXdUvv+id1k2iJ+WqbHzQ3T0teUAa+qGJIE8F2sOgwKw6EjFynNMpxp1Q1SaHBBJqXRm
	ItUlI72BPfODQtSJhpjEfnE2lYhknmkNoMiulSAWWw29zAFxrIi0l3bPFUMWQ8Vo+EPsqosX2viNu
	0dYP5x6OZ902NxHWzF66lgz72tl7pnx08MRwtBobg3Dm6Eip9F1gEn6S+r5Kd/O4mlWveN1SNLLjG
	G2p1HChkBQy5egJdcRtZwi120S9m9xKbES+aFbce23rSy2dgrMUD5xeOA/ovykptslVhon6dsH5Au
	8TsaleRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUnB-000000093LD-3MA6;
	Wed, 08 Apr 2026 15:26:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUn8-000000093Kd-18Vy
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:26:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5AEB34002B;
	Wed,  8 Apr 2026 15:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FC0C19421;
	Wed,  8 Apr 2026 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661965;
	bh=KsQyl1ZyVyK9D9CF592JArgWi3cqdGNTKg78GwavARM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+QOerFDDmaD0SRl/5jE1iYESDvgxtv5U297dpdh1N6IATREv8/kpDqPushIedki/
	 9dJyZUJqlA3ElUm3zNPsOrkladtTJfZBqaFOhedKbQjzQAWwrEnAA1Cpyjzl2ax8y3
	 +GWE4VEMhFWLeb1esluazmGuxi+BKyucvwd5kFRo+bnrUwA+pr224EoBY07GiKMp4X
	 rP1RDImHxSrUYaDl9Xk4TJ+NjFx0SX3rqXyBS+ULSxh9fYg6jUWGoEKFqbrb05IG/d
	 96/g5zOtwboFvhAEhJt1STafthSpXOXEYa18QShT9ISZxVV3/hQYy6OG/AR2htP2Ii
	 FrHkGciRtwFUA==
Date: Wed, 8 Apr 2026 09:26:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	henrique.carvalho@suse.com, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v3] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <adZziy_r_5BFMx8U@kbusch-mbp>
References: <20260406092132.1333458-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406092132.1333458-1-shivajikant@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_082606_332028_C586CF68 
X-CRM114-Status: UNSURE (   6.93  )
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

On Mon, Apr 06, 2026 at 09:21:32AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.

Thanks, applied to nvme-7.1.

