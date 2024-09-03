Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6735CD342A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OVro8sue4I6P7XANtcaz6HGYNXziH7j7oJEr3RrtQno=; b=b97J2EvuZKZiVPFnaeWu0lYi7E
	7/FFMqguRxnrZ6DBgoxJ1w/tfW7j3siex54hnOM12RksCLyh1ANyXHWggfb1pZG8a8V+LxLBNZd50
	Rb32UosPwc8OAe/Jd29NXMHukx84b6KLg7FR1UcOZOQhAq23KhWfoBaSL7sy2RiHCqyV75mK+FUlA
	uFNC1bRJed6WPTYGw+XiHU+s2BHbnNwA/m9WeobukrzzGN8wKXP+JzID/3R4/3YOyjx8HvA52wdby
	4bzpvYJQOi4hWoJNUp6WnHxjuAPnvs1gfF/qz4l+BCmH7mOqRg8ARWyLLl/f4P3rnaTUFSEJrqIwF
	M9qZDQiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slVEo-00000000m1p-16Z9;
	Tue, 03 Sep 2024 15:14:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slVEk-00000000m0J-433z
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 15:14:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BE962A417B3;
	Tue,  3 Sep 2024 15:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C43C4CEC4;
	Tue,  3 Sep 2024 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376469;
	bh=OVro8sue4I6P7XANtcaz6HGYNXziH7j7oJEr3RrtQno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIhJsGhkxBkdWSO2zLi2CW+RVoB7ZeJtxjoRwi2sVMU1XopuDhu1t1vbiN52kOR4r
	 aYUpjjgEK8PBE3YvhWwByfzbXkWvBT5/qXxXSusAs5/DNCjrgvzcaIgm88cfWjzGP2
	 PPEz65LLNu1j9fBsUlu4LYVFJlgreitu9FG9dKZFMuooQIhc2h9Um3IKQJeS46Hf9T
	 MRvfg5gEvdedpqxo+vAjsjuHWulge/MUweBiqCnyiDj+5Cq+S9EBvhxmwulsOT/z1w
	 1+MA3iDiW9nEfAi+6XonINywMwGeUjzue8rZw4opl4+Ib1XtXBxzBhzFFo4ZV01S8+
	 Oi1MofaI1NCvw==
Date: Tue, 3 Sep 2024 09:14:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: check for valid request when polling for
 completions
Message-ID: <Ztcn04fAPHM5BeAy@kbusch-mbp>
References: <20240902130728.1999-1-hare@kernel.org>
 <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
 <93dbb39f-3c5f-4631-aabf-1f4222781b06@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93dbb39f-3c5f-4631-aabf-1f4222781b06@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_081431_121687_490B87E9 
X-CRM114-Status: GOOD (  13.29  )
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

On Tue, Sep 03, 2024 at 08:25:08AM +0200, Hannes Reinecke wrote:
> On 9/2/24 19:04, Sagi Grimberg wrote:
> > On 02/09/2024 16:07, Hannes Reinecke wrote:
> > > When polling for completions from the timeout handler we traverse
> > > over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
> > > Unfortunately that function will always return a request, even if
> > > that request is already completed.
> > > So we need to check if the command is still in flight before
> > > attempting to complete it.

So the very same command was completed in some other context? We've
disabled the queue's interrupt here, there should be no other context
that can concurrently complete it. The timeout poll check is supposed to
check only unseen cqes, not "all" of them. Is disable_irq() not a
sufficient barrier for accessing the cq head or something?

