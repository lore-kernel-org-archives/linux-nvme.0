Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4F4C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fC+bYquCfzgZicgee25PY59lTqSA7XoHV3EqBusFLEo=; b=aR0el5VlHFuk54eSf3mpIh/Ygp
	7F/21q6ZaEoDUkqvWDGdGBjeYEFTA7c/dmuKicxambXkr+NuK8YKfT+z8/S8/9MrzSIi3GIcpvQaA
	JQctDhzcF/LICdb5sro/v7h/shebVZA6YgRlCtN36cLoHtgv8MuhZDe7ruPZQGdY524vNyUH1LQZX
	d/+5ou0XTucjBxglkgIgNy6eH2FjUgUukrJiriznxfSJzWTQ8rluv4KjrCx9ZcViN5BxcAVd7bkNg
	vujknKlWr60nVHrO0NJGGmAbCEYxYRNb2QhQPc90YMgv3yu2Z1ofG/A/0fOewc2WCDAMBaDaVJjcf
	S5MqCrgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3QW-00000005g9U-2yH0;
	Tue, 24 Jun 2025 13:11:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3QT-00000005g90-3hfZ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 13:11:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1DB268AFE; Tue, 24 Jun 2025 15:10:56 +0200 (CEST)
Date: Tue, 24 Jun 2025 15:10:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250624131056.GA20362@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com> <20250616053627.GF1148@lst.de> <790a0419-4087-4181-b290-15db01ac1d34@oracle.com> <20250618053213.GA28614@lst.de> <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com> <20250618171750.GA29321@lst.de> <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com> <20250623133309.GA27241@lst.de> <1802de7c-1f2b-4c84-9f99-a38625c3715f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1802de7c-1f2b-4c84-9f99-a38625c3715f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_061102_061298_D9EADB07 
X-CRM114-Status: GOOD (  10.68  )
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

Arrg, the patch did not actually print NAWUPF, and made me scramble
really hard how the output could be possible.  New one below:


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3da5ac71a9b0..90473d4770f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2033,6 +2033,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+		dev_info(ns->ctrl->device, "nsid %u: NAWUPF: %u, atomic_bs: %u\n",
+			ns->head->ns_id, le16_to_cpu(id->nawupf), atomic_bs);
 	} else {
 		/*
 		 * Use the controller wide atomic write unit.  This sucks
@@ -2042,6 +2044,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		 * values for different controllers in the subsystem.
 		 */
 		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+		dev_info(ns->ctrl->device, "nsid: %u: AWUPF: %u, atomic_bs: %u\n",
+			ns->head->ns_id, ns->ctrl->subsys->awupf, atomic_bs);
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;


