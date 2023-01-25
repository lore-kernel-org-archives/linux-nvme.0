Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A65C54E94
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jan 2023 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=golsx8hCLO+i/GVnvmiue6JOKB/cCBraHBUxkUaORzA=; b=G8HXebCLNUOfox7/heRcdZUmiJ
	iDnBCgqQQQ2Iti+FHxhAXtnuifJReHfRIBpkC9vMNOButWaUjUchw5n8tcJj+sZQmQ7zojdFMKcGU
	53KKrh2z0gaheVzbXstPh8QFz/gRT02YrCIFEF+iXGHnjGjW+aPdZz/u5pEYMouDCPg5O9Ym1EDzy
	XyUuBZk/bC2vsQN5tHzUirX5qDDfguRFkVIxyMtP3v+tYt5QPiAIphTFatK25E164qT8PPh6ianNu
	8H8W5Gt84BXL23cdpN9xruHuc8miSxAuHAGp+lt33p5AsT9QQmu+MM3BWeWEKje341o71Ve8yDBCl
	+vY9x4yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFP-008Idm-L3; Wed, 25 Jan 2023 18:11:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFM-008Ic1-04
	for linux-nvme@lists.infradead.org; Wed, 25 Jan 2023 18:11:45 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGQ9Er019509
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=golsx8hCLO+i/GVnvmiue6JOKB/cCBraHBUxkUaORzA=;
 b=NNokPKn2Yq9qC7Zb9AWjaC8zb42RxEg2plJkAGzQDUC+U7kolwq1Ch4ah9uty+Feo0xI
 Kuzj7F3iPcCeEBsNZFT/Csb3H38pxBTKql1UYYJyOh14m4/PVXHPHpR/y7yXVL68d3+m
 FXMcmn5yTC7Qm1lGBxDZE9KmH2KOu4iDcUkNeENOtn4v+K83rmIpAlmICEq8C/Nda5vk
 e8hckWEjl4d61HjcGWIJUpmIRNBhScHiWjEe3pWD3BV+63kIVe+XzXEa1KZxexWjfve9
 hq2rIlETj1geRxNToU2VK0SMXSRUiexUkS6ywnocdGQOsqnOiS5PGo6v4SGAxri2zUeM Hw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3najv1qkym-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:43 -0800
Received: from twshared9608.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 10:11:42 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id DA603FD0E9A1; Wed, 25 Jan 2023 10:11:26 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@list.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>
Subject: [PATCHv3 2/2] nvme: mask CSE effects for security receive
Date: Wed, 25 Jan 2023 10:11:24 -0800
Message-ID: <20230125181124.395668-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230125181124.395668-1-kbusch@meta.com>
References: <20230125181124.395668-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GgfHnuoms4XstVvXaOHKQm2ETXy57JJz
X-Proofpoint-ORIG-GUID: GgfHnuoms4XstVvXaOHKQm2ETXy57JJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_101144_183152_DD730EA0 
X-CRM114-Status: GOOD (  19.25  )
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

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index df929ba9bcc21..89ef7abb0910c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3091,6 +3091,23 @@ static void nvme_init_known_nvm_effects(struct nvm=
e_ctrl *ctrl)
 	log->acs[nvme_admin_sanitize_nvm] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBC=
C |
 						NVME_CMD_EFFECTS_CSE_MASK);
=20
+	/*
+	 * The spec says the result of a security receive command depends on
+	 * the previous security send command. As such, many vendors log this
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


