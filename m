Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB3C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bh0nJjc0Uh8T5OlFvm2wDUJ4ehsRqq5hnIzvy71x1Js=; b=th0gwXwHKq25RiEPkFwLlIm+fZ
	Mdui7lCMYnEEqcbMi6yLOPhuF5JEwHL/ysb4T9kYu7tWyW1zEvBArpBfmEKGCPq538ANYwM/L/48a
	KNzwsTG4rEGAtAWHdiimKP5WSt9YehxSW9reL8YMBleUSSGBvIf8fY+kxtPTJskknzAnZQN87qFYv
	qbF84SUSSmV7m3qe3JQJtbQt0J5mMAUwVId18lOzLu998HCrW7C9IPzxv0c10SDZ9tFePZuBWZDv/
	sTaz4ilYQYONxYxUxt02EYpHvD4xwTmxN1fAmf0UhERtdEM9wPjJf7OjfV5o0gKXE75j1Jhxwsm12
	Y0yjLldg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIv1m-00BVbM-J9; Fri, 20 Jan 2023 17:18:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIv1Z-00BVMi-Ol
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 17:18:04 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KExbjk016078
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 09:17:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=bh0nJjc0Uh8T5OlFvm2wDUJ4ehsRqq5hnIzvy71x1Js=;
 b=UjNmG8/087osg7Z9+54A8mXweQjP2UEyLyPqFu0rq0QdFFA09b6hwP09kcLrde4DrCtQ
 cS3FliRayVpeEmnPfcI33VFz2YDnDXQ+8E4FMun36yfXlu6WkA1BRpmgsUvZaEIrsqSb
 HKT/6Anz4ZVp1b9H3EMbgymiMQTM7rSs+b1s5ZZhq7u8Sqm/8YZt0GLYx1dTrAfo2N3t
 zqYNrkQ5DmDaoRVBtQ83FAyGI8/pZnRUk8naYnOK4zsVA0Yxe9k8elb0CvnAa//VuUG7
 q8QQmZ5LImjJAd5nmQp4XAmBpq3nInrjsrfzhIRlfpzzHQ0k/XZJloT6Scdtwoc5Ak3j vg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6tvvm7hb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 09:17:39 -0800
Received: from twshared21680.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 09:17:36 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B7BE1F6C27B4; Fri, 20 Jan 2023 09:17:32 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>
Subject: [PATCH] nvme: mask CSE effects for security receive
Date: Fri, 20 Jan 2023 09:17:31 -0800
Message-ID: <20230120171731.652371-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5aNUuowNR7Ebb5hzvklcz_Sw4iJynOzJ
X-Proofpoint-GUID: 5aNUuowNR7Ebb5hzvklcz_Sw4iJynOzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_091758_044775_5731E788 
X-CRM114-Status: GOOD (  18.22  )
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

The nvme driver will freeze the IO queues in response to an admin
command with CSE bits set. These bits notify the host that the command
that's about to be executed needs to be done exclusively, hence the
freeze.

The Security Receive command is often reported by multiple vendors with
CSE bits set. The reason for this is that the result depends on the
previous Security Send. This has nothing to do with IO queues, though,
so the driver is taking an overly cautious response to seeing this
passthrough command, while unable to fufill the intended admin queue
action.

Rather than freeze IO during this harmless command, mask off the
effects. This freezing is observed to cause IO latency spikes when host
software periodically validates the security state of the drives.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7d2c2b342ba4..1b10b27deb999 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3101,6 +3101,23 @@ static void nvme_init_known_nvm_effects(struct nvm=
e_ctrl *ctrl)
 	log->acs[nvme_admin_sanitize_nvm] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBC=
C |
 						NVME_CMD_EFFECTS_CSE_MASK);
=20
+	/*
+	 * The spec says the result of a security receive command depends on
+	 * the previous security send command. As such, many vendors logs this
+	 * command as one to submitted only when no other commands to the same
+	 * namespace are outstanding. The intention is to tell the host to
+	 * prevent mixing security send and receive.
+	 *
+	 * This driver can only enforce such exclusive access against IO
+	 * queues, though. We are not readily able to enforce such a rule for
+	 * two commands to the admin queue, which is the only queue that
+	 * matters for this command.
+	 *
+	 * Rather than blindly freezing the IO queues for this effect that
+	 * doesn't even apply to IO, mask it off.
+	 */
+	log->acs[nvme_admin_security_recv] &=3D ~NVME_CMD_EFFECTS_CSE_MASK;
+
 	log->iocs[nvme_cmd_write] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
 	log->iocs[nvme_cmd_write_zeroes] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC=
);
 	log->iocs[nvme_cmd_write_uncor] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC)=
;
--=20
2.30.2


