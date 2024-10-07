Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5940CFB44A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpVa/ud99QHp3/znkcwtRES0gVTEds1rre66sQ/jdeA=; b=wjXn7tNdOPyJUNGuMp6CPrdaGl
	9iqJKO9a8siKed9/RuxXLv6D4WlBtFb3F7P6CetJoZxe/Tp9Pe9E7J0fVvcWNr7kQBWngRy71NhSY
	sZj50toLK3ZU5wL1akOgXR2T4kWqB//RN7mqlpfTxeEsJVfFvo5oVwY01FQCULUYPwlI1XVTsiyLh
	JRIyDI/c81scfcYgjvyjV+QtUICC4+g6c/bvatu7tB7WtO1w6EobjV0SYVY/+UejDJ9e52FS1uNCI
	efrBRKYGwhSdbK1yu6mxNjTytUrzPlemE25vRPBVCF1NzIkdCq5hL8zyqL77ponTw+Y2oZrIKZkly
	njnNeujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpwG-000000030qo-1XAT;
	Mon, 07 Oct 2024 15:46:24 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpwC-000000030oh-3ezY
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 15:46:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 46EDEA418B5;
	Mon,  7 Oct 2024 15:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320AAC4CEC7;
	Mon,  7 Oct 2024 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315979;
	bh=BpVa/ud99QHp3/znkcwtRES0gVTEds1rre66sQ/jdeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuIh3qaYodR6ZLQE8XO1RZvFLVS/LuXQdsc0N8kd5W6oAq2NTyaOmZdXH8xGILmC0
	 17Wv240nJPlohcmXltN2YgM87j3QCzDQa1fK2VeV6+aHJL8m07wWuzoXB5jB+b4PGi
	 hJwd0Z8qRq/rwKVJcdJSv2ttTMGQYPQanfyvcyTP6MZ/vy5ZC1JlkOxzRIZXDbrpZv
	 cpc8dDgJxOKc1nM8oymUcItxIWU6Um23DyDqajt/kdGdj3jWgQWcHkxAGYOQWK9StM
	 541ZwWYhnL2BB58qEGCFLEOwAklSDTQv8W+54HHWL28tR7rfdJysQlAhhOFluwO5ot
	 zUqCJLYW+/mDw==
Date: Mon, 7 Oct 2024 09:46:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-multipath: simplify loop in
 nvme_update_ana_state()
Message-ID: <ZwQCSHIuoXgF9su3@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007100134.21104-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_084621_013064_A0E4E694 
X-CRM114-Status: GOOD (  14.67  )
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

On Mon, Oct 07, 2024 at 12:01:32PM +0200, Hannes Reinecke wrote:
> Currently nvme_update_ana_state() iterates over all namespaces
> with the srcu lock held, and calls the 'cb' function if a
> match on the list of namespaces from the ANA log is found.
> This assumes that the iteration itself is relatively quick,
> and the namespace state itself doesn't change during iteration.
> For more complex functions (eg if the 'cb' function triggers
> mpath_set_live() which then kicks off a partition scan) the
> namespace state might change while iterating, and the rcu-protected
> area becomes really long.
> So change the loop to iterated over the entries in the ANA log,
> and call nvme_find_get_ns() on each entry.
> With that the 'cb' function is executed outside of the RCU
> protected area, and normal reference counting rules apply.

This patch looks good to me.

Your commit log is word wrapping a bit short, though. We standardize on
72 characters.

