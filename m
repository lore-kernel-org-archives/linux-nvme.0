Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33933C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cgUexX0hGQR4vlETZh5gD3Duc5vkMcUXejHLk5g/mpc=; b=DFm2KUaLVwCQXOpwBhOEi0B6kO
	/6swXCVs4V2Hmw07Fn57hr3Busq6vTBTXVDb012+5ad4xCQuplZBwug/C1r/hPLwVi5Lo9pPmTl+W
	luWhiQKnUYjVpMdW5Ty3C5943Nlcj1i5MCPbIKvrdVYeZ58gpNy8lDfcsB9Xqk+uLSP7mHkOJqLxp
	yIBm/gR1koNCy9yqimfVg8ZhXF0tUaPDfGy4om3Nj/yo1KbF5G72V5uz3qHt5F90GJ8f7Yp55Yuba
	D2DCZzV4YLTnLSy1rc1G68t9wvqxplEjnavS8PvppwIwrKsZTXM2kzwngUL+w+dQXX6jEKUKNmpfU
	xUdJfEFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMDp2-004efx-W5; Thu, 11 Aug 2022 19:26:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMDoz-004eeA-TN
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 19:26:23 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BGGdZM001942
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 12:26:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=cgUexX0hGQR4vlETZh5gD3Duc5vkMcUXejHLk5g/mpc=;
 b=N4XwKkzks4hCSM+okxqnHohpQ5BT8ajPKhqlMnBtV3GKnF+UqApSq5Rjc1OjOwDNhqa9
 Q+4sc28ypeIUtk6axKiBGpngqXY5Ap/FYLo8y9bNJmdE1KJxdRwTmcThPHrvnHIQN5g7
 KsiN3xaw5aDEPn22Hs1rxnDEFZHiSB1KT/A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6mqtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 12:26:19 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 12:26:18 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 12B1573F8ECC; Thu, 11 Aug 2022 12:26:09 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: do not update kato from a dsm io command
Date: Thu, 11 Aug 2022 12:26:08 -0700
Message-ID: <20220811192608.3387239-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SOVtC2GJ18EseiYX4pa7PW6MFjbsytRF
X-Proofpoint-GUID: SOVtC2GJ18EseiYX4pa7PW6MFjbsytRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_13,2022-08-11_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_122621_975218_CE3F6AFB 
X-CRM114-Status: GOOD (  16.42  )
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

From: Keith Busch <kbusch@kernel.org>

The Set Features Admin command shares the same opcode as the DSM IO
command (0x9). If the DSM's 'nr' field happens to match the KATO feature
ID (0xf), the driver will use a bogus keep-alive frequency.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..7d49ca115cc5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1111,7 +1111,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ct=
rl, struct nvme_ns *ns,
 	return effects;
 }
=20
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects, bool =
admin,
 			      struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1128,6 +1128,9 @@ static void nvme_passthru_end(struct nvme_ctrl *ctr=
l, u32 effects,
 		flush_work(&ctrl->scan_work);
 	}
=20
+	if (!admin)
+		return;
+
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
 		switch (le32_to_cpu(cmd->common.cdw10) & 0xFF) {
@@ -1160,7 +1163,7 @@ int nvme_execute_passthru_rq(struct request *rq)
 	effects =3D nvme_passthru_start(ctrl, ns, cmd->common.opcode);
 	ret =3D nvme_execute_rq(rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, effects, ns =3D=3D NULL, cmd, ret);
=20
 	return ret;
 }
--=20
2.30.2


