Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D37BC8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9aDudv2upYVWH+WWRk466i/6fSRZ2ozBXSB3K0ez+tI=; b=w9psg8TGrGlPnzULQ3CdqSTAuP
	mutyL52APYYY8x41MwVQeoff4+x+vbQEVshPceMtpe6oOMeuBJxanpPGA0OE//8FhdW7D2FQ90I40
	lrK0kVqR5VF7xLEumGIBGE18++Qa4dU6VoC+Ld8RtAR5M6VVBSO0uMSXLRiu4/SHOGvsRIAF6kAwz
	NaiZ0BbUMkD8dzLlbuwwQ5PqTQITASXyC09gOPX3Z8Yzqeuidg7nWe2mg0s1dkbQkHr63uJp7Sioi
	lnE6gbAuQ9hot6c3WHPBJfF52XB2zhR+hK85kyrsiX3tCN7mHXc1EqgUvgXYQ8DYt5+xPvBlJ9bll
	sQ3sbS0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWIgq-000000037b8-3zCu;
	Mon, 30 Jun 2025 17:53:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWHct-00000002yj9-1ml6
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 16:45:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6A169A5345E;
	Mon, 30 Jun 2025 16:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D6FC4CEE3;
	Mon, 30 Jun 2025 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751301902;
	bh=9aDudv2upYVWH+WWRk466i/6fSRZ2ozBXSB3K0ez+tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVW6mvP6A549tIcr56fsHh0sLA5bIsgxFDKVia4LkYuOEv4rA8YdbBYT2unSJY1H6
	 uYcVTqjaK5vy+TyiIxuWdGXjdSNelsnwGb7trCmhu5BIkKGKcayHGdAvA/ePKGRClF
	 8E3Cima3VIk+OGkmqe+AbCbmL/3WqonPgJoorTqp0DfgB1W0Zyz3oGkSRn/Dmsjg+n
	 nlfvSk2pqieKrDsu68WKE8NTP756szm0EBkWPMbLB85SxDNnE8znaYCCRBYUbIX+FU
	 vqwfHhZPxh6DgViFIkIlfQJzMwfnIJ7KxNb7f0oeJZGcS92ToF59FH626q9huyRP1v
	 yXpZulcgbKDoQ==
Date: Mon, 30 Jun 2025 10:44:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: fix suspicious RCU usage warning
Message-ID: <aGK_C3v6aMHgEsPP@kbusch-mbp>
References: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_094503_537596_92E8314D 
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

On Mon, Jun 30, 2025 at 03:48:32PM +0800, Geliang Tang wrote:
> This patch uses sleepable RCU version of helper list_for_each_entry_srcu()
> instead of list_for_each_entry_rcu() to fix it.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

