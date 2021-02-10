Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A0AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279D264E3E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279D264E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6geWQig1KpfzERek2YKrwS//fs7g8TlGxD/NShviBj0=; b=qSijKkh5bfNLPhl16IRYxpjnH
	MrHFxN4aC+cg6mGrWQidE36Ayt5To9/4nGzSqszTPNAsv+X6galSwehPn3vXe+EDXGOprjMwfRuTe
	kAo6KQ8k296+zfoOm0/q+PAzqUf3cnoJBe2ExV2JBGyuPvhNOK++999zbvU0TWFyKjnYnQprG9mtf
	XfdVLJrbCP23h16BuCocJIf0hJfBnqbP/mlU1L3B8uXyFEKa3paOwOBHuf+QFMQgLX3O2jBGtgtte
	cxWn8p2RlU02VzoYzSHNonpEGdiHS1jaCNQ5E4hg3WsnF+N9FBfiQ0mRYcgQOVyeJ8NzaOn2P+vny
	Dtg0nJrcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMV-0006oM-Tv; Wed, 10 Feb 2021 05:48:27 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMT-0006nu-Vm
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936105; x=1644472105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ep/XUtHcooNTwHLszhNBjfG4SzN8MNBdWKYID4RjhpE=;
 b=FOjTAnpmAqyc8PXzBA24qIeDxpKtkFtUaT1/DBvxu6My1F+tfClQq7Vp
 3skQbxCLnyL+le1tDfnPVEXSBzrQYoA8kWcP7EQFhwribWMemdRHFKdd/
 9pr5TJAsg6uFHddlvyp16LHeD2CgvD+xcOAuVfY2jhBwc+JxsWQbfcERm
 38Py0+ZCN2ZNm5ZFS5dtLXsyk6Ni/dXMdgSsOBCx2+18kXpHRG0o//fda
 yZBKiERvTiT001GnoMUXSh4Sevogf5InQWHdIuKtlrVu4stpyONploChv
 gIy+hc/TbagVEBGqQfex2ife/0ZIpmn33LyhDdKgs04iGwMHFzkfG8oBA A==;
IronPort-SDR: eo/2c/g2ppinNTssqRywztZ5kfo/WF2SYstPdvf3d4LMPIjTpVgRdNmXkipu1IkJdQpDDLS4mK
 amsaI7kWRV1fHhdGK6nnPnoNhs3wSMMlSIItvWgaXMBiPXiLh0MZ/byxFkPLIi8ERIauDwrhLB
 8AB3Xl9oNezgxOgNNV/yygdVgCOFYprcBaKVwNIRnJGWSki1YqpyvCyi/kL3jULm5hiRycCjDG
 mImjopvxYPSYdVbQuT2rGcF1u70XYpGKwPXjBmtCr+W6XzzGydujvBsQ0/0vZuA+FLy4doq0Gx
 jT0=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="164067731"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:48:24 +0800
IronPort-SDR: iR44ALxyHltcR/lafr5wq8AxLSCa1w3+K4q3fAFPTXvLm/DLFW5bcJ1EyZL+YLxFlzNkd1mkjL
 zMmKSTqX8km69QepYCcjma7KqAJ4C4TUKKWmDdR747cu4scEgAh2Y8S/ciASl2w5Qy5kfiBogN
 HigFyKhrfQiWRrNAngKlrlnX5alOgfgqpU5Bex16DTq7Upe6vrNaz9AEugLbT+aqchdPn10KiL
 BoX+71s/WHxLGCzoUp/N9xQRBj362cvBW4lCb9d6+WBMK6CxhesWNQECQVAKUBElDlsEGLC/n1
 oGTVM+ZQ2XozuzRYbfVa6t7N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:07 -0800
IronPort-SDR: ta4+JnN3NRLTiA2txWj8/wxGcbGKDDYNGbG2X1m3N3bNEaCXLufKhvwdu4iLJhk8QtZ7azbMf2
 WvAW++kQT3HGxxQXgpktSDPWdBWbL9jBs+U1ct7yJYt7OYtQS/n3eRe3+oubIWTgHGO//89CLl
 efJHQCgKFFApwiQWzKYHp8lx6ERG8gblJxFjubZdzMUOx/TOyVdwusoyH//JPvMWBSQTgmkmpJ
 HTb2aKYLkLIhCgwKhPN5vAJeqxDIatEOcCiju9QUjfGWosNex9ltOr4Db0ofp0/fon8Xx6NRfg
 AaY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:24 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 02/11] nvmet: return uniform error for invalid ns
Date: Tue,  9 Feb 2021 21:47:53 -0800
Message-Id: <20210210054802.34269-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004826_197888_746E94B3 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvmet_find_namespace() error case we have inconsistent error code
mapping in the function nvmet_get_smart_log_nsid() and
nvmet_set_feat_write_protect().

There is no point in retrying for the invalid namesapce from the host
side. Set the error code to the NVME_SC_INVALID_NS | NVME_SC_DNR which
matches what we have in nvmet_execute_identify_desclist().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5070ea5cf260..e938064254a5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -82,7 +82,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS;
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	/* we don't have the right data for file backed ns */
@@ -697,7 +697,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return status;
+		return status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	mutex_lock(&subsys->lock);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
