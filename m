Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A73C5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 12:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FF7Rn43fyNeaqGLr/TaLxcdPEtouKA6mvpPHmZ9xP40=; b=IPR7YNuuqk2A32T5leS5rtnW+/
	sy+EpfwJgYlrSdbFCuX+iXyGgmGsE07GQy6ABlESRcjD9pSqn+veClLLD/R7fg8xPATTe0LU3bf5l
	dq2BG97WD1OOLhNY8NCdti8BbqKCINI4l9anVEVjy6LpurSFd8vwvxyqiB3CV4DN2OZObhnD//4dk
	Rj6MhEAgqKgUhvLY/aAjuHYWWnN/jAOmJJE05A5p5kOL4A4H/2CZKuJAbjPqfc+3clJxLjulrtQY6
	DexkeyG56g6XfI3xLHA7yJVZeFZexbBb7Sha7Kj7Ws4hJ9OQrRGLhrXwda3xuDS4XwLt2ZAswchzD
	uqBupjTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwIlJ-00000007ugB-09Uj;
	Tue, 18 Aug 2026 12:17:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwIlH-00000007ufx-0vRS
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 12:17:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B4A54058B;
	Tue, 18 Aug 2026 12:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB711F000E9;
	Tue, 18 Aug 2026 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055466;
	bh=FF7Rn43fyNeaqGLr/TaLxcdPEtouKA6mvpPHmZ9xP40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cc5EGTXUGomJz/kkJB+J7cXjV8CQNt5a+jJmTeMv2asW/S0UsQrnVMboYcYPHi0Em
	 9AUqsFemNV8q147ZEukOXtgwj3O0HILcy2Jyq+P6uYXBG8FwlUob/rLkbb8hL9aq2P
	 MTc5RCzO79Vg+TC89wCqmMGz1QPdWjxKnwiYGXB5peSvF2tv1eQZ/x7oDNzndczg/n
	 bkS6f3VPUQGNhz+F+51UfHv7WZe5Yfu6rSTUnxdPAPWUsjkXIX5kv3TCWN5IBefxeR
	 Ln7ozHjD/88n+doxPMaA4q9xmfMupobctw+bIEW/k7BVhPnvK8W9e2dEUVs8kPpPuo
	 KNGLaa1iHwyPg==
Date: Tue, 18 Aug 2026 14:17:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	security@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
Message-ID: <aoRNZblm4SZ56ayQ@gmail.com>
References: <2026081423-enlarged-dribble-10bb@gregkh>
 <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
 <20260817065823.GD16255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817065823.GD16255@lst.de>
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


* Christoph Hellwig <hch@lst.de> wrote:

> This was already fixed by Guixin Liu.

For the record, it's this commit currently pending in linux-next:

  79aba4c94034 ("nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()")

Also attached below.

Thanks,

	Ingo

==================>
# AuthorDate: Tue Aug 4 10:18:57 2026 +0800
# CommitDate: Mon Aug 10 12:25:54 2026 -0700

From: Guixin Liu <kanie@linux.alibaba.com>
Date: Tue, 4 Aug 2026 10:18:57 +0800
Subject: [PATCH] nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()

When a host issues an Identify command with CNS 07h (Active Namespace ID
List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
called with match_css set. The command-set filter dereferences req->ns,
but this handler never calls nvmet_req_find_ns(), so req->ns is always
NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
namespace with an NSID greater than the requested value exists,
req->ns->csi dereferences a NULL pointer and oopses.

Besides the crash, the comparison is logically wrong: to filter the list
by command set it must test the command set of the namespace being
iterated, not a single fixed value. Use the loop variable ns->csi.

Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0b24d31f966d..3fde09b4d78a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -960,7 +960,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))

