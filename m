Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FE5C71136
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ykrdepu0zmzYdqkzbEQhJbdD76KeN+yonGi940NHfMg=; b=4ZZPUq7d3TuraodUGuUiqmQN4X
	o5AlqefnHxTpLap2iu+cNMbxVokLYzJScSBV8JXBJwl3Oc57KdW96wx+Vbo85vuuXyt3Eib4eMBLc
	Okw+z8fYW3bdUQ5qF2/JWdvN8vx8L0DjC31LW7fr+DJIJLE0ZvsZA+jFijoKzTp28c9TpzJPuGi2l
	+Fp5s8Hgh1dydUUm0uhnxaOXvjwkEmlBgIG50bigx0rYNtPlpFcPIWN5aLBdevXXIjMe516IJPlYk
	gVVE1qIFxD/tSKlTRyU5LoQXd842PZ5mOr48C8Wz3gbnF61HsZIp/KhAdOlhqPsQ1CezZ2XactcyH
	ztHdydlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ75V-0000000H1kc-28kU;
	Fri, 13 Jun 2025 16:17:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ5nf-0000000GmeA-1u6J
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 14:54:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 36FA45C067F;
	Fri, 13 Jun 2025 14:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A72CC4CEE3;
	Fri, 13 Jun 2025 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826474;
	bh=+637aPsLSU1UEPvOQGQyJUY4IglUTgPupGHZwaGPQ9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0Pct+Gi1hoDM0LZBCspzjOIqDTyyl/V2GwGBXdSGFwBLlkILUhpHpVlgfCrMUpLJ
	 ft/YOmBjSQkitEQeADRDy2IJMuk2s5qeBmYAfOLlPe0KfidAf0uWqoe3GG3Quh0jbo
	 vp59Zhbn5w3KL5AqV7PvQSSpyi9eG2fk5e6Zy6Qs1qFJrouqOACDQ4QVEPy68nKiWv
	 m3H7my7AX4igycSxvPU6isS/XSrmG3VhiMT6KxJXgvyR2tEjCKY7d1g5iorVm6fZVk
	 0LaMA8e65dqZijj1V1l+R6N9sVXHtRmMSZOPejxKl/4h0RJMRbDrFlJsHL7+g8myjt
	 N3zheeKbLKx8w==
Date: Fri, 13 Jun 2025 07:54:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250613145433.GF6134@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
 <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
 <20250613055630.GA9119@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613055630.GA9119@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_075435_537616_2C1F7ED7 
X-CRM114-Status: GOOD (  15.71  )
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

On Fri, Jun 13, 2025 at 07:56:30AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
> > Yeah, this solution looks good to me. However, we currently have only
> > two selections (none and unmap). What if we keep it as is and simply
> > hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
> > it visible only when the device supports this feature? Something like
> > below:
> 
> I really hate having all kinds of different interfaces for configurations.

I really hate the open-coded string parsing nonsense that is sysfs. ;)

> Maybe we should redo this similar to the other hardware/software interfaces
> and have a hw_ limit that is exposed by the driver and re-only in
> sysfs, and then the user configurable one without _hw.  Setting it to
> zero disables the feature.

Yeah, that fits the /sys/block/foo/queue model better.

--D

