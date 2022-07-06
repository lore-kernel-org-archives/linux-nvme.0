Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5C0C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3wcL0LCYAY3rgOh7oSjReEZINEqf6r/0lM26HA2IRL0=; b=zWtpSkuiPFgtmym6VWKTGTQVcR
	anD8RKN/JU4n/qCNvUJW+ouFqPEVvPOl14gtDmZlxlEq3nJU59yF+tBIHa8Uuq20LuyC/xF94ErgO
	/ip9ba+0Cw1dshzan54RWol9EFPPsqfWd/rfbC1wSfJU7+xKLwHn0wi2EnkP2PxCCunlOqT1K/E62
	QJdKSSQaiddub1L6+UJNQ5BuLBd4G3QXSaKdulQ/4MfmSr4qTPVEFz0RaeDbeADSJ4aiEaeL9Rzed
	hHkAvUCd7wMEJTFYJbv8z8dHJAMbTc+6kfrxuKVwbXLJ/ALLrkYQFTMn2zioBInHlGUiLu1GOfWbH
	DHmnHbWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o98eP-00Bejr-8R; Wed, 06 Jul 2022 17:17:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o98Sr-00BZkm-CJ
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 17:05:28 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GsKhR018132
	for <linux-nvme@lists.infradead.org>; Wed, 6 Jul 2022 10:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=3wcL0LCYAY3rgOh7oSjReEZINEqf6r/0lM26HA2IRL0=;
 b=e7k1q6RkcpzHkibCazDrLp6+B4wDQ0E9OzZFG5qwlqBJZ5aVEgNjh+3/V181cttBe2dj
 nksUjtuS629o6W1j+qDfgBHgENFUFMfsnC9+JxVkHqBSbk2Qfi/FII46QJAzjR4ZWs20
 s3PilE4rq+5n2FC/BnWPLNltvKZ+qfsft2U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uck74v9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 10:05:19 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 10:05:18 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 94E0E5CC88E1; Wed,  6 Jul 2022 10:05:05 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: use struct group for generic command dwords
Date: Wed, 6 Jul 2022 10:05:05 -0700
Message-ID: <20220706170505.1624225-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6UoQepZSs_fqkpweRj1f5d0sQWllMwXk
X-Proofpoint-ORIG-GUID: 6UoQepZSs_fqkpweRj1f5d0sQWllMwXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_09,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_100525_646299_7D5DAA8C 
X-CRM114-Status: GOOD (  16.57  )
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

This will allow the trace event to know the full size of the data
intended to be copied and silence read overflow checks.

Reported-by: John Garry <john.garry@huawei.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/trace.h | 2 +-
 include/linux/nvme.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..37c7f4c89f92 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -69,7 +69,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata =3D !!blk_integrity_rq(req);
 		__entry->fctype =3D cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->q->disk);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.cdws,
 			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=3D%d, cmdid=3D%u, nsid=3D%u, flags=3D0x%x,=
 meta=3D0x%x, cmd=3D(%s %s)",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e3934003f239..07cfc922f8e4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -906,12 +906,14 @@ struct nvme_common_command {
 	__le32			cdw2[2];
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
+	struct_group(cdws,
 	__le32			cdw10;
 	__le32			cdw11;
 	__le32			cdw12;
 	__le32			cdw13;
 	__le32			cdw14;
 	__le32			cdw15;
+	);
 };
=20
 struct nvme_rw_command {
--=20
2.30.2


