Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD5C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JGR9rjoNjjh8K8pC43OJ6+NykYZV2SDmP+E3zAx6RAc=; b=yF/NfD4CB8pWcV4AcYR336bbLH
	hBQoLltjBuF7aqX/gh8RMkWbLr2BfwnTy8IEObZPgK7iWtujZWCpV53Uc7b/l9ES830MU75laKAGn
	uRuDDPHfCbg0jutl9CthmLsHGIfMVV6TR0tCqJG159aaOCfekAtXIolkchgYk2LjAW3AC03X0tRpA
	PdS9Vx/Qi0lZhOtYbgFxpdLsJqzKjahyvWzDmImgPboKuRM5HbUqTOIc4NP7rDmDQ1c3ZZlXR8mwg
	AMUHk2OgVuFx9PkFuaplRPKvSIKY/a6vW8LjhzRxkqbQExztYHi12vkDx4SA+HXNdmLd+ySJLC7J7
	MJdfG/Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riUNy-000000085ew-2FMX;
	Fri, 08 Mar 2024 07:11:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riUNv-000000085dh-1S8h
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 07:11:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B7B1DCE1E7A;
	Fri,  8 Mar 2024 07:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578AC433F1;
	Fri,  8 Mar 2024 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709881870;
	bh=Jv/2GTgtoRDF8LDjOFfK4uYDuPdBi8I5Q+EwB62iSE4=;
	h=From:To:Cc:Subject:Date:From;
	b=llq6GJUC3uWyqjagkwioTu1gi2XPP+2rNmYfhr6w+paMV/KNv9JhwQDn+e8grsOVe
	 CSdPGjg3rzEW1BeHyxmuoU36DUvUCIaxPhKRTz+sZvecjsav/205c+lIIQ08cdZvBL
	 +U7UMSnaijnSs/+wPDAke7FvotP0EqKGAhqbxKKTjLKrnokePIxFCDQLAkL2jwQMwU
	 6P1Wf1pl/uZcftTMwqwyu8Fpn5p/kQCwZXkEqpvRStRDNTOeAJq60tWEzUnUcw3ux5
	 zCWiYGModob9H1sWOUYccZqUxl76M0uQcNo8kjbl32bCDYsCQJ8BDbQdHQhO5OZMAI
	 edfLV1TOxZaSA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: do not continue for invalid icreq
Date: Fri,  8 Mar 2024 08:11:05 +0100
Message-Id: <20240308071105.6175-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_231115_864749_A1AC9E74 
X-CRM114-Status: UNSURE (   8.63  )
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

From: Hannes Reinecke <hare@suse.de>

When the length check for an icreq sqe fails we should not
continue processing but rather return immediately as all
other contents of that sqe cannot be relied on.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..3d606ab01506 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -898,6 +898,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
 		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
 	}
 
 	if (icreq->pfv != NVME_TCP_PFV_1_0) {
-- 
2.35.3


