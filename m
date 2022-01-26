Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6BBC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhcrfvpLIRs241UejnUiCqWRKyMdYTy0K0D1XRxqQEs=; b=qr5XKieU7q9oQd8Vo4nqAD1kZ8
	XaVRSXUlwBdCHJlkGOcpizyE84uWaTgVhXvocYEhUc0DStd8QCtFegrPrvAI3/A2o/7Iw5YVLj9oV
	ajByfPoBCSkaguoqR2qX01syBRc057iyK4VBqA7RdqAtZSqDIyuExeoNEiZ4mmYADjPWjvAyR7tG5
	Be2bgZ4XmJ0RNClyLWR9dNNPI1bz54WETxJbJUWS/mhEVN29PwE0/Jnh8C3xJcvVOwRjh35j37BE9
	s0JGCtBQdJ5vBeK8RL+nM40H6lMeW1CzsvQ0XRI4NK6lOWXtGTQG3RBihX8J+kyCem4mcGl09420Q
	mX5s8wQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCmGu-00D4Kv-Ez; Wed, 26 Jan 2022 17:39:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nClzk-00Cxud-SY
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 17:22:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 16D9E61AD7;
 Wed, 26 Jan 2022 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C927C340E3;
 Wed, 26 Jan 2022 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643217726;
 bh=IhcrfvpLIRs241UejnUiCqWRKyMdYTy0K0D1XRxqQEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E3oCmDb+VhE4TqOV27cjjzuBgYZ5S4eDs7ya8SyflaGBc/rjh9BRgpLenIG6u6tCq
 UfS7w41l2nMx/nyoPvgF7KKt71fjEl8rXnv0Gz7B8WvZbT+uYq9vn/bghvFReD/Hez
 PpZ1H4YHmKecrWHWCGkwjK7Jh3XviX9QcWU6yPMf60PLxA+D3+djtSWeoF5Mmyqnvs
 mTUSqA78OFdh3L+O6NNdGi9IUGsPcB3OoFxqtsEtnT5zm/PDu1xr6KmtbCH1EKNc46
 QC4Lja22taQpIyWGqbVLlsLEn2mB3p4S2D48zHFzgGtpdIvFVFLmZpbIxmBweAX7NM
 jbCJwySSImERg==
Date: Wed, 26 Jan 2022 09:22:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Pankaj Raghav <pankydev8@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220126172204.GE1885300@dhcp-10-100-145-180.wdc.com>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126163306.GB31892@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_092209_026069_325AA6DF 
X-CRM114-Status: GOOD (  13.72  )
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

On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
> pci_iomap goes with the ioread/iowrite accessors which we absolutely
> do not want in nvme.

It looks like the action pci_iomap() uses is based on the
pci_resource_flags(), and should call the same "ioremap()" function we
currently use.

The one problem I see with this, though, is that pci_iomap() will
automatically clamp the mapped length to the resource's length, which
may be shorter than the potential doorbell registers that the driver
thinks it's getting.

