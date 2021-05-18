Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC95C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:11:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576DA613B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576DA613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=flYPpQiOJhOtAfDnFtr/IaC6/A9w0wRgzJwCNZnTrXY=; b=HhnSQEQ7vX2npQmVQ6g3lvDyX
	FXJq10gk2iFD69LGFnj9Z/GWWANqDMeEKx7BWr1iE7OuUkZdfDWZwORfAyzB/quA39AWbnoH7U/cA
	3Kw2H15GURjvcviQ4MIaECEh0cBNjA6cHauMFlQ3hfUAriBnF+kUGEAc2mbgUxr7UhiYprwqeYkGL
	Zs95+HjKAoW/CCMJf81yBfLIdkGg3B3tfbujpzZotQgeHbmPNdmAPJFlYNef9u1uTMHEqtiwvn2LQ
	+Zu6y/eOtLgyNV9IljDjVnhw9QMWEqXqeSj+wMdXP4UdyMsyx11JpL+EU7zWGtulaEFRlvuLApdsb
	hXUGBeVdQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lioFc-00Gao6-TM; Tue, 18 May 2021 01:10:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFI-00GalP-LH
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 01:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=1eYLby+ika6Gyi94fKDhfoChY7muvtzZ6DWJaF1wfIQ=; b=M6/QPdcXsVhKz/CGPPAeHqu4iy
 tckaL63es2JCC9jPUEHKeloHAaZrFA3J7BumFEsr8Acq5vM738pTXD1s9WSzMx+x8+CW7z+XtrMD/
 wd2/El7n8ubopi5Tob2uuXB6BE4gJHJsNqittcy7hD6m2kSiktbJWRliYiEYN+KJLgxRejANe5q9j
 liTdgvrm8srOqp1FECf7wqGeX3N8+qQycgfSPO/WlyQHyYPfRpmXMRKkrl75IoJGoIVD68O2yXD8/
 XxmuCutLysPer4pgmYQ8deqwHY+Po5+JKyvQlGbdxnV/RRAiqBQOQxvIp+uzF/q7YzUDlIIM1YRb0
 pTbOgVAg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFG-00EFMm-1Y
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 01:10:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BF88613AC;
 Tue, 18 May 2021 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621300201;
 bh=3Tr08Y78fD2cRH+schCpVdrD0QHHKQyBNwEkv7fNgL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G8DoWTOYT+bWi1dkNRexvPEJPTWLfX4CrkWdq0kh/vqh854aMI1gRNw7R2hxNp/6k
 j5vbrWrkcrS+DQ4B3VgjOR/aHu7DgG9/QBHEVoJWrGCjRh658kshnjobTSJsf6rkZ0
 bfBKI3neXbpD2e/8mqUdqUI1DOjLxAw7Fz0vziDqfFalI2IM+8ldUWIXAMGu0Q/AwM
 3evReK8SRve9RTo+kgorgC393G2l9ENHzjJnhGL5wV+4ArN72PYqdzX4++K8lzNrO0
 UOrDjkl4vWxZpMPxWPX2MjF0x+1ZaMb9Px4fPVKlRs4PlW3WwEvSCVnv49FKChCcH9
 +wgoiTkJPvZjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 3/3] nvmet: seset ns->file when open fails
Date: Mon, 17 May 2021 21:09:56 -0400
Message-Id: <20210518010956.1485782-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518010956.1485782-1-sashal@kernel.org>
References: <20210518010956.1485782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_181002_109825_39C0A7C8 
X-CRM114-Status: GOOD (  13.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 85428beac80dbcace5b146b218697c73e367dcf5 ]

Reset the ns->file value to NULL also in the error case in
nvmet_file_ns_enable().

The ns->file variable points either to file object or contains the
error code after the filp_open() call. This can lead to following
problem:

When the user first setups an invalid file backend and tries to enable
the ns, it will fail. Then the user switches over to a bdev backend
and enables successfully the ns. The first received I/O will crash the
system because the IO backend is chosen based on the ns->file value:

static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
{
	[...]

	if (req->ns->file)
		return nvmet_file_parse_io_cmd(req);

	return nvmet_bdev_parse_io_cmd(req);
}

Reported-by: Enzo Matsumiya <ematsumiya@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..b57599724448 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,9 +49,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
-		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = PTR_ERR(ns->file);
+		pr_err("failed to open file %s: (%d)\n",
+			ns->device_path, ret);
+		ns->file = NULL;
+		return ret;
 	}
 
 	ret = nvmet_file_ns_revalidate(ns);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
