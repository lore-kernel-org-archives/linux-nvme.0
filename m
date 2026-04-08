Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634CD10F9969
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b529M1YAXbbXhWTHvT3HJ5kMy8sgsrpua7hjukZyYFY=; b=FxwjgEymZcYUuK7EOAO7m2k5If
	wE0r49mK7yXZYfVtUb2Zn6QNFlIxG/RFm3tWXSRXRy6kDLZfc81hgX9giZcByhivpjP7aEKwtBKaY
	4CMo7MbB2zZmVwwvZhAlzXX89YaA+SGAQzEvJacVa4zlUJhFq9Ti+ZhBmNIzlGDZmZ47fyLL+wnZK
	BtqpN4yn+mJss+0IBidlOy7/oL3lGM+ZvarsVJnLUT6YElimjO7BpHjhBxB8LJnnIv2HI6xA+wLHw
	896wjDSbfdNNlvX5InbBxXJls3lDt+Smryk7opz/AznI1Zto1K2RppSDfC1hGdUt6VYlmGhBCyLdW
	coemcgTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYTn-00000009JJs-3Wpc;
	Wed, 08 Apr 2026 19:22:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYTn-00000009JJl-1Cur
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 19:22:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 16394600CB;
	Wed,  8 Apr 2026 19:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776B5C19421;
	Wed,  8 Apr 2026 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775676141;
	bh=GtoDxUV7jx4Q+glcVA7o4x3DItfhn1Pj/U50pTxFP7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFGXE3AL6wXIi7lveJ8KhF+h44fH/6NFbjQWJrcaPSpI8P+xLb9f8+P+cr6iD/XbL
	 D2LvSO8izzn/UycXDenTf+6zzO5Ma1wLon55R9uVqQDrjeDlbjRMvJA5M6b35nPoBQ
	 cO/0WJSfFe07SSB2RTQz5n4VTkRDuLhbfGQSu/gAJ0Az8go53JPzM8M3G9xpjQsHKX
	 iCtb3y08W34ynT0eehQj9J+2nmEIhOUIyq6aJmLx+OjxxDb00Pa1h82tWwbVojh4EV
	 lGAJTE6Ldd1hJ89oG4gVBEAtNNLNITnVKoI4sBit2NLQKJgDHnKnvuQZFE7HwUddcY
	 lhQEYv7kzQ55g==
Date: Wed, 8 Apr 2026 13:22:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <adaq6xNK0Vy7pWW4@kbusch-mbp>
References: <20260408075131.6221-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408075131.6221-1-kch@nvidia.com>
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

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.
> 
> If an NVMe/TCP host sends an Initialization Connection Request
> (ICReq) and immediately closes the connection, target-side teardown
> may start in softirq context before io_work drains the already
> buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
> sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
> reference under state_lock.
> 
> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.
> 
> The ICResp send failure path has the same problem. If teardown has
> already moved the queue to DISCONNECTING, a send error can still
> overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
> window for a second teardown path to drop the queue reference.
> 
> Fix this by serializing both post-send state transitions with
> state_lock and bailing out if teardown has already started.

This looks okay to me. Will give this a couple days then queue it up if
no issues reported.

