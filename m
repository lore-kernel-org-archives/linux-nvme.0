Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5186D3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkS/RPr2SEs1Exq1UJHOC6h1bq5x1O6Htufr4/rLgRQ=; b=ZwlowNkcZ+/fRl36VJZsoBXNCW
	hD8VPN3NHqqa8YSWS10JinvwPAsIZOvtBxzTUJq2yAxSxx4omXh4R7PhEiyL4wcgfJFGCgXLwLQuB
	pW1yfEGdOG9ippaVMznBkZl3gjnwqkR0J1gct67dsS6nx3pQukiiqYIZFs+CO1fwaEYyAu5tCafWq
	ATufefWzMzYgmwwu+wKfehqdKxON6ZzjNhWLa7ZIv00FwDRTeB5567biAVkX9Ud3VYA1j3CBg4VbA
	zlG5gYEMVfxoboBegWxhTj23UTrAvZMY0oKJQOE0ytJeA16YPFhb/Xgnug3YBsBCceqVdfoJzGq3f
	O2wWYlMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgI-00000000Gm0-062A;
	Tue, 05 Nov 2024 17:49:30 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgB-00000000Gfl-14hQ
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:25 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAte021574
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=TkS/RPr2SEs1Exq1UJHOC6h1bq5x1O6Htufr4/rLgRQ=; b=EVE8ZgUC7XmB
	Re5eZoW72zAQ0MrrQNzUg+ZRRE2LRNAtIWLmpchaaGr8l07tZ6dg7cSU/PShqcek
	+dKRBDq7WyclUyyXMUDGOy5wpl0G7kD0HtT3XZvGGiTc901vTvhbq1tbToWTCmIG
	kSwjFIVZU1EAtaaSDG/sODRQunW1ZmccUJSvzTWKdXwnZjlQ7lj3YdSzXGmf8XfB
	yd+87MSRVf2mWYxAVUD37aOXcNYVYnOMAK6W14KESy/5E9e03GyPovdaIMydh+Is
	8p5Id4dFRsNiFBCi4eyZGSNH52M1hzyqVEYgB8U7/rilPh3CDfxeuWPutL4ZwxLF
	hicLC96jmg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42qjyptcpf-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:22 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 747CA14CB3BCD; Tue,  5 Nov 2024 09:49:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 01/11] nvmet: implement id ns for nvm command set
Date: Tue, 5 Nov 2024 09:48:54 -0800
Message-ID: <20241105174904.3612888-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6xVEoaL6tCTuq-GgnHoNwBS8f0QDZ83J
X-Proofpoint-ORIG-GUID: 6xVEoaL6tCTuq-GgnHoNwBS8f0QDZ83J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094923_479601_5C0C1885 
X-CRM114-Status: GOOD (  11.31  )
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

Nothing to report here, but it's a mandatory identification for nvme
2.1.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 081f0473cd9ea..8d06dba42bcb3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,20 @@ static void nvmet_execute_identify_ctrl_nvm(struct n=
vmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
=20
+static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
+{
+	u16 status;
+
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
+				   NVME_IDENTIFY_DATA_SIZE);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -706,8 +720,8 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 	case NVME_ID_CNS_CS_NS:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			/* Not supported */
-			break;
+			nvme_execute_identify_ns_nvm(req);
+			return;
 		case NVME_CSI_ZNS:
 			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 				nvmet_execute_identify_ns_zns(req);
--=20
2.43.5


