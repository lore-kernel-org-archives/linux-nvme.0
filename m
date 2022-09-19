Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C6ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mjop2Ge0xW1RcpqEMqkH5YcqNeWQ8UkZxkBVMw0vPMk=; b=tc8L09HB51uZkKPwOpUOaYIJMp
	YF7J2GgRHQsYAqZJ7cWvmIGFDZTVzSAvseyBVlmoJ+Q42Z9pJwLr0pBLDR6GNoysbsnHV2xdJKtGc
	gN/08dIkDg6iP5YqgnYnpqXRnsPyFQYJsEYvGmCQlgbXnzw2DywkWia+R36oTWUp+16iHZIWKvl/C
	tTeRXP2AjeqXZzydC0SMGT8WG5zwrJSe7m/vr1Q6qwuFSXc1lXhIyFkJM6oKGvkaC3NTlgRj9FBD5
	MEcMir06M39jeeOr0PPJLKmOKWBjCTGKadTFrQKZvinQ/QHEsly8+r2mymQvA9o+1IvXTMgNzYqTN
	Wc2TGsvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaMiO-00Ekss-Uj; Mon, 19 Sep 2022 19:46:00 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaMiL-00Eknq-UZ
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 19:45:59 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28JIDZT7011016
	for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 12:45:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Mjop2Ge0xW1RcpqEMqkH5YcqNeWQ8UkZxkBVMw0vPMk=;
 b=Fwrpm4fzBdRl3WsRr74OryruAVR8wshEhVnZe3VIfKhkASyYoURcBkw/fj294IAsKjI9
 u78PqdQXplomV5tuRWCO/7R2/HAgrSvdRRVxvbAYzj/h0x9vwS8CQ3dO13trR0ga0rqM
 +0Tgjx4Hz1o4FuQp8hROrT11phgJtQNxnhw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3jpm35cx3n-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 12:45:56 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 12:45:52 -0700
Received: from twshared14494.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 12:45:14 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 808DE8CCBA0B; Mon, 19 Sep 2022 12:45:11 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Jeff Lien <jeff.lien@wdc.com>
Subject: [PATCH] nvme: copy firmware_rev on each init
Date: Mon, 19 Sep 2022 12:45:08 -0700
Message-ID: <20220919194508.1704346-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x1WC-i7hAGYgPBDa8p9zWc-iD42W4fDv
X-Proofpoint-GUID: x1WC-i7hAGYgPBDa8p9zWc-iD42W4fDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_124558_124996_310509BC 
X-CRM114-Status: GOOD (  15.74  )
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

The firmware revision can change on after a reset so copy the most
recent info each time instead of just the first time, otherwise the
sysfs firmware_rev entry may contain stale data.

Reported-by: Jeff Lien <jeff.lien@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea6694fd550f..e56ecc7fda2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2893,7 +2893,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
-	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id =3D le16_to_cpu(id->vid);
 	subsys->cmic =3D id->cmic;
=20
@@ -3112,6 +3111,8 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
 				ctrl->quirks |=3D core_quirks[i].quirks;
 		}
 	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
=20
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
 		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme=
_core.force_apst -- use at your own risk\n");
--=20
2.30.2


