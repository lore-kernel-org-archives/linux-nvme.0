Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192EC38142
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jan 2023 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=golsx8hCLO+i/GVnvmiue6JOKB/cCBraHBUxkUaORzA=; b=JXR3I7lnnP8thTe9aCyLx4if7K
	q0EnydmworM/eksc4GWxwVL/LjNyiv0O0Qvy9+xnRSZBEUy7Y0Y2ptGKw+4LVnBXes/chYS5LQKP/
	IValU3NcNpX+v9BIhBlpF6ikDIXeOGyEYyGsHjZv4mrPh8Fro0TywdjNOyNSKbMiyn97k9Uh7Q60s
	EcKeHiUO8uXvczF1h3au6phpx62iS4iQEBOGiCHfqQu6+55jjWx5ISeuvCvtob/7B9vGS0trgZDBR
	emH5Bv2EA8d0HduBkm4jZZNf7NdzEJ2Bd23Ph8biXHogAXP64gV8bwlCZ/6JDy3gL+SuB69dWcYjz
	AsKADZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLS1j-00FqAG-55; Fri, 27 Jan 2023 16:56:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLS1g-00Fq8n-Rp
	for linux-nvme@lists.infradead.org; Fri, 27 Jan 2023 16:56:34 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REGPBP022685
	for <linux-nvme@lists.infradead.org>; Fri, 27 Jan 2023 08:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=golsx8hCLO+i/GVnvmiue6JOKB/cCBraHBUxkUaORzA=;
 b=Y4jOovNUwF58HqbyRfPkDGonnykpil0YUH8A1OBetAH+HDgeW4j3pcpjKXxTQEbUdrim
 ulsae1HAuH9xj/cxM1NGPTAXNGWEqbFBgnpF6BIbMIoLKs31uWZLzZ5W4p5XsTdMumZC
 wjjgdYG4zl9RqyHByQwmsM7NKb5/yMTFRDlrLtwaLbSIsdm9oIO+gRBLWzatR29tf4c0
 pR/H92ykB3DoOvxVZmZ9xhcwazEdeuO1kqfcK/FqoM1mZ6OMm63RmMuotHBKMfhk+yC9
 TGTI35iuLvqixPUHV0uk2q2yQpnUmD7ZzqwIDbU1LzjQlgRENc6FAWy6MnSr49lLDiVE 0Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nc35x44ny-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 27 Jan 2023 08:56:27 -0800
Received: from twshared1408.04.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 27 Jan 2023 08:56:26 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 68DF8FF7BD2D; Fri, 27 Jan 2023 08:56:21 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>
Subject: [RESEND PATCHv3 2/2] nvme: mask CSE effects for security receive
Date: Fri, 27 Jan 2023 08:56:20 -0800
Message-ID: <20230127165620.3487918-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230127165620.3487918-1-kbusch@meta.com>
References: <20230127165620.3487918-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lMFxgg8gpd4pxoLxuQGF4rOjwnbFh8aU
X-Proofpoint-GUID: lMFxgg8gpd4pxoLxuQGF4rOjwnbFh8aU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_085632_936506_C0E80BC4 
X-CRM114-Status: GOOD (  18.55  )
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


