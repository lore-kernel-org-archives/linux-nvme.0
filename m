Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E7C4727D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:17:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F1023600
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o6z7uu6w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m7I/i36o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F1023600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kCKVw9QWo4YNmWD8rwIQuQq7nW7tZvJVBaqB+DVrIwQ=; b=o6z7uu6w5FGVmLeFIbWMbrtkX
	KQ7PoenJPJIaK+0N+fy+s3jOaCjQtogEN/7FuwbDyCI058LhpqoMCu5qXPBnbqZREYkIVu8Dy+rRT
	fkAv46Oskj3oY624+IUERXkptz6Ue+mOUBhkmzYocwZieJSiIxVa5ydzWT2k4TXDqFaz13blgkzHY
	E+d2Kx80kzNaKU9X5B9mADijp7xvWqifHdybo+p84VAlmh7PtXnE/qlQIWZrX3KCKgSmbEKr6BJeG
	/81VpZrtuzkvxI/PgZfi+ZKgHJvjr6iIu+628MlMM/aGQwGuIW4AD6Jch7ip1UvpoenhlwpOsHkOR
	58bLkH3Ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKpfP-0002U0-Nk; Tue, 22 Sep 2020 21:17:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKpfN-0002TD-42
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600809456; x=1632345456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2zN5rnwKgD897h1fI904qF6KREKUe9qPUUAxaoamC8c=;
 b=m7I/i36ogeWKQNcHgCi9R/1ERM0YhAVv+ufpQUhDLN0KQX6na2bBx1f4
 JTStrvuZOE2TxQg5repOvWeqtG2rSLQLQylOSA5QnsHMoSsXxSx7SgP6o
 X0D+hpvt7fNK4SSX6Z8AD3bBkbwqlBGPWhF9sWTnkLQY3WNr0512Uvy8h
 +6FNaPwOIIcU62ktHjvUBnY3yqHhike0en8dbR12nOw/acFI0YvWWpTjM
 SiImdVp4htGxZ3brw33K3RC1hA/hw2cujFuEhcZi6fM9/jz75rV7OMPsi
 nOOu3Tl6kURFL80HZZyshekQb/dBeZ+Sb1twbjJuMNWwBhKt+fu4gVkAZ Q==;
IronPort-SDR: r/ButXPeaofXMR/8Ov+MDaPL0aTPR2BoZDZL0PVGKipdtXFjyCoBR0FD0jM0KEihy5JaglJm0q
 MO333moQhTH9wg1P2xvQ8R+Ng5SHxsVLD93t/RRvEdIZyrvHwqZCuSsTS3LY64IvpM46ArRiMx
 07hWHB9WTHsxbdsifh2jFugGDhc7dcmC/Ukt3GQgJEdP45gZQCOrTK9s9KoOS+1Aj5pvsQQrdc
 Zdx7ZOW1fNoxT+oAOS73KV3peitdN/8Ulvbpl+Ky4IkjOhY5bTHSM4PWlg53DQ1E6w7xv4YF/I
 nSg=
X-IronPort-AV: E=Sophos;i="5.77,292,1596470400"; d="scan'208";a="147948084"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 05:17:35 +0800
IronPort-SDR: 6LimAtEmwHRt1DdW/Tv3omvCElPpT/kFHI2H1xG3z3EWKnoE8x6z610q49DxoVglTWVsKXFwk1
 gYiw9mNozVaA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:04:37 -0700
IronPort-SDR: 5GHxFD4HP1ofHGkZSf5rCptMU8VsuwZ+QBOwyadl6xlM+bclRwb+nejynPUGX0Gnp5lZjyTnSG
 77b1bZngeAgw==
WDCIronportException: Internal
Received: from zns.labspan.wdc.com (HELO zns.sc.wdc.com) ([10.6.137.48])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2020 14:17:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] nvmet: add passthru ZNS support
Date: Tue, 22 Sep 2020 14:17:18 -0700
Message-Id: <20200922211718.6206-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200922211718.6206-1-chaitanya.kulkarni@wdc.com>
References: <20200922211718.6206-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_171737_361242_F96B8887 
X-CRM114-Status: GOOD (  11.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the default passthru implementation NVMeOF target passthru ctrl is
not capable of handling Zoned Namespaces (ZNS).

Update the nvmet_parse_pasthru_admin_cmd() to allow
NVME_ID_CNS_CS_CTRL/NVME_CIS_ZNS and NVME_ID_CNS_CS_NS/NVME_CIS_ZNS.

With this addition NVMeOF Passthru allows Zoned Namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index e3a5f8499a0b..56c571052216 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -456,10 +456,26 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
+		case NVME_ID_CNS_CS_CTRL:
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				req->execute = nvmet_passthru_execute_cmd;
+				req->p.use_workqueue = true;
+				return NVME_SC_SUCCESS;
+			}
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
+		case NVME_ID_CNS_CS_NS:
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				req->execute = nvmet_passthru_execute_cmd;
+				req->p.use_workqueue = true;
+				return NVME_SC_SUCCESS;
+			}
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		default:
 			return nvmet_setup_passthru_command(req);
 		}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
