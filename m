Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB84C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qQMQ1pG9SK0v+kYQTLBbwwmUScIJzsoVCMjwDC+h6Pc=; b=gTiJzgh4lYH9RByR9akWJmH98X
	u92Uv/mgYxPB/J5b1NRFWV57aSRHIccWS70fhKpGJmIwJemuduNBE+uST3oFrXUn2CC3Dcu8Y1hxE
	MB7SAINCeBq9t1NR6OwJOIGOgWsDgnffpnSRBkYskmkoLUezgZ/psf0ZCCsisxXlNt+BWPqdA4obl
	pE4NEdwqg7Vw6980Oc6chWkIfQ1zGEQxJ35YJApu7tIfCngVzHAYz386ep9sEPKfIEqzZRCw9Gg48
	Th8TnYHDux2U2PLvE4bvaLkqkLBK+5iw2Rh34aXcEcRwBCSRDEgiJl8JwkRaqAT3TrgTyXpklh4rS
	XNRQTRdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Lpc-000000097PA-2TU3;
	Thu, 03 Apr 2025 14:46:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Lmz-000000096yU-21jg
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:43:30 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5335Uiuj016553
	for <linux-nvme@lists.infradead.org>; Thu, 3 Apr 2025 07:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=qQMQ1pG9SK0v+kYQTL
	BbwwmUScIJzsoVCMjwDC+h6Pc=; b=cOv8bEKjke5DMnq45ey+Z2fxmWMKYcW52L
	pLqpYLVbRjHldgGGjhVCPjrgV36d6RhiS1KWDgmorfpJg/NJkemglqC07ceglt4C
	Xu2o6OAdi660TReZYAiUDR0QF6l7yER8Xg/dQf9DWiCZlICFYI4VdD8PrGMyNGkw
	DywGhCkBxG1kNx0XD27eafDbjPPl+8G7F/yVpICO9kvgo60hS55FKP5beT9vJVn0
	AwgArFePd65MDdFkdSFqcT6GLJAaNfmnZzu58HKtGrtFD1pzzWofQN32vgMs6PoL
	xmSV8MX/2iUNwZZaAJbvMXy7whuUnfQ+pMpKHqV93sl5vEYx0cZA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45sm86an3u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 03 Apr 2025 07:43:28 -0700 (PDT)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 3 Apr 2025 14:43:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 563EE19D59C6B; Thu,  3 Apr 2025 07:43:16 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <wagi@kernel.org>
CC: <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] libnvme: do not byte swap command dwords
Date: Thu, 3 Apr 2025 07:43:15 -0700
Message-ID: <20250403144315.2576523-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M8X8v6aymLv8OntiC4ny_l5MBOWqVWID
X-Proofpoint-GUID: M8X8v6aymLv8OntiC4ny_l5MBOWqVWID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_06,2025-04-02_03,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_074329_533466_858B0B41 
X-CRM114-Status: GOOD (  11.51  )
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

The dwords always need to be set in the cpu native format. The driver
will handle setting up the SQE in the nvme little-endian order, and big
endian is never used, so this byte swapping was wrong.

Link: https://github.com/linux-nvme/nvme-cli/issues/2761
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 src/nvme/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/nvme/ioctl.c b/src/nvme/ioctl.c
index 18b228d9..86c2b702 100644
--- a/src/nvme/ioctl.c
+++ b/src/nvme/ioctl.c
@@ -1920,9 +1920,9 @@ static int nvme_set_var_size_tags(__u32 *cmd_dw2, _=
_u32 *cmd_dw3, __u32 *cmd_dw1
 		return -1;
 	}
=20
-	*cmd_dw2 =3D cpu_to_be32(cdw2);
-	*cmd_dw3 =3D cpu_to_be32(cdw3);
-	*cmd_dw14 =3D cpu_to_be32(cdw14);
+	*cmd_dw2 =3D cdw2;
+	*cmd_dw3 =3D cdw3;
+	*cmd_dw14 =3D cdw14;
 	return 0;
 }
=20
--=20
2.47.1


