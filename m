Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F278606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=whfhTtt+;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PaztF3yo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tpf0q+pRPTS2uCoNGktUMfCttTaBMrYBmYvxfS86hNs=; b=whfhTtt+EP2jb1
	T7Yru5fHGytny8BbRIVNeMk73Z0MSVtANLjYaHlmvy2O2H8F3aj/XR2rp//KM9Xn8zkA7Ynnw35M7
	WemRV5fpVORCxBHh2z/hx1qrmJh0RpxfuMIIh8VMjK609YyDBGyDNWQBTe6e5D4BG3PkCOWpsIPtx
	tKd9CGGNI3SdBlroeCckq3sXkFTbRr4cDYroFFKThUxAlNIT6J1vl/TNlI1JIrXteownPwB4TVjek
	11FWWKXTte4sTkUrB9qfh7mixSYMXAAlHMZ+sAl0IJy7i2fwxLBCvBEb8LnEOslu7nGf9YHpfgMmC
	jbn1aaJnd5ivq6b4+1gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFx-000000099Nz-3mgu;
	Thu, 29 Oct 2026 12:29:21 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFu-000000099Fi-1VBc
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tpf0q+pRPTS2uCoNGktUMfCttTaBMrYBmYvxfS86hNs=;
	b=PaztF3yo4iEdKRis/8+KSvhlyg4xeQ7rtqqIcfgm4oD5PPbpaTlUE3rKRSwYAGlLadPvagLnXTAZNxpjoPLsBt4horzcAukYTQrnpab1uylyYOKVO6qXUdARacTSfUhaPUFG5nkx8/oDmYVvrK97LMQSbmlEo+bHPJhzQpUycgg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjWnuV_1793276954;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjWnuV_1793276954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:15 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 07/12] nvmet: advertise the FDP capability
Date: Thu, 29 Oct 2026 20:28:28 +0800
Message-ID: <20261029122833.284572-8-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052918_625374_C28F1A14 
X-CRM114-Status: GOOD (  10.04  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the Flexible Data Placement Supported (FDPS) bit in the Identify
Controller ctratt field whenever at least one enabled namespace of
the subsystem bridges FDP.  Hosts use the FDPS bit to decide whether
to query the FDP feature and configuration for each namespace, so
without it the bridge stays invisible.  The FDP log pages are listed
in the Supported Log Pages log page by the patches that serve them.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aad5abdb6ef9..8a8ab2af3882 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -699,6 +699,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
 	if (nvmet_is_pci_ctrl(ctrl))
 		ctratt |= NVME_CTRL_ATTR_RHII;
+	if (ctrl->subsys->nr_ns_fdp_enabled)
+		ctratt |= NVME_CTRL_ATTR_FDPS;
 	id->ctratt = cpu_to_le32(ctratt);
 
 	id->oacs = 0;
-- 
2.43.7


