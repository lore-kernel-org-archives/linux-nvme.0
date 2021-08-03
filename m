Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E52C4338F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 06:29:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F3D6023F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 06:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78F3D6023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7TrsK68VOqxTOWSPHwQNVGK0TbSNkng51Vzu64JXesk=; b=Qa6KLLKC51HPY3
	QNr35AVqK30kQiGBzHcTg+4U07x7iE9cuSk1ExdIPevrfgB420idGxZvLgTFbI6YA462syQNJTFjw
	Tg4Uz5vkSujggtuftCEvIiCaB1IBwf7IieQSOqYmOm8kn474XXO7f6lJAoR5eIiNmPL9qnaoazwwm
	TWEtom7KaoN5bI8mpKCrp2Fzm5/JRBonAkvs1fpSCCzKi9YlZtAt7Xvxpjv9mRKXPgsmb9nbUD5yx
	6rKGWIZx3XCMzIZaWzIH3BkDq15fRjlgLOOd8w1hRxJhPM7KbRCqHx+2lZ/vBJ0d73aAaSamqznWW
	ybUkypzMEdT5A3o78+pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAnvW-001HcT-S5; Tue, 03 Aug 2021 06:29:22 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAnvT-001HbI-A5
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 06:29:21 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210803062908epoutp01a5e80fbe9d3587e3e62470880e304b0f~XuAsVIOj83217332173epoutp01m
 for <linux-nvme@lists.infradead.org>; Tue,  3 Aug 2021 06:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210803062908epoutp01a5e80fbe9d3587e3e62470880e304b0f~XuAsVIOj83217332173epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1627972148;
 bh=zjowDuYWHSgl2X+NFSdef4KuhNjZoVk/17hQz2JdfjE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=W9jSaoGzRsfNMYwboXSbfJ9560z3XMzA6hlL3gQD+amnZsV36nt6hya3IpHLLNyXE
 9xVbgKUCVplxU8XOc0SPlLCB6fskvU4MtF9JEehtjb13g/Hso7oxnFnW+TBTp8QsIA
 I13yPnyDLoq0ZH+1kwI+jEX6fNh636xNGYvSv514=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210803062907epcas5p49a6338c8164793e45147c4d4a7226912~XuAr4fyDF2257822578epcas5p4n;
 Tue,  3 Aug 2021 06:29:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Gf4hY0r5xz4x9Pw; Tue,  3 Aug
 2021 06:29:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BB.E8.41701.422E8016; Tue,  3 Aug 2021 15:28:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9~XtxiPltj81575015750epcas5p4p;
 Tue,  3 Aug 2021 06:11:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210803061146epsmtrp26b627c87726afdb615c68d0fcb016bf3~XtxiO8tFM2165021650epsmtrp2W;
 Tue,  3 Aug 2021 06:11:46 +0000 (GMT)
X-AuditID: b6c32a4b-0c1ff7000001a2e5-30-6108e224881e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 68.63.08289.22ED8016; Tue,  3 Aug 2021 15:11:46 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210803061145epsmtip2b141305beb888baaf0ea9514b90f4d0f~XtxhhLiCo2412224122epsmtip2s;
 Tue,  3 Aug 2021 06:11:45 +0000 (GMT)
From: Sathyavathi M <sathya.m@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: jg123.choi@samsung.com, kbusch@kernel.org, Sathyavathi M
 <sathya.m@samsung.com>
Subject: [PATCH] Formatted LBA SIZE[FLBAS]
Date: Tue,  3 Aug 2021 10:59:12 +0530
Message-Id: <1627968552-32502-1-git-send-email-sathya.m@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7bCmlq7KI45Eg7k3tS2Wzte3mHToGqPF
 /GVP2S22Xl7A7sDisWlVJ5vH5iX1Hn1bVjEGMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
 mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
 FqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe0rj/HVjBHqKJ5x0OWBsYvfF2MnBwSAiYS
 bf0XGLsYuTiEBHYzSmw+MokFwvnEKPH17Qwo5zOjxL6LB4HKOMBaPi5whYjvYpR4+2M+O4TT
 yCTxbs1FVpAiNgEtiVdPeUBWiAgoSfxd38QCYjMLhEosej0LrEQYqGTGngqQMIuAqsT2pSsY
 QWxeAReJWTfPsUBcpyAx5eF7ZpDxEgLt7BIPG18yQyRcJGb+ucQGYQtLvDq+hR3ClpL4/G4v
 VLxe4lDHNBaI5g5Gif8bzzJBJOwlLu75ywRyBLOApsT6XfoQYVmJqafWMUHcySfR+/sJVDmv
 xI55MLaSxInPb6FsCYk1+/eyQtgeEnumrAPbKyQQK7F24V/mCYyysxA2LGBkXMUomVpQnJue
 WmxaYJyXWg6Pp+T83E2M4CSk5b2D8dGDD3qHGJk4GA8xSnAwK4nwht7gSBTiTUmsrEotyo8v
 Ks1JLT7EaAoMtInMUqLJ+cA0mFcSb2hiaWBiZmZmYmlsZqgkzsse/zVBSCA9sSQ1OzW1ILUI
 po+Jg1OqgWkO24p3PpGb3n4Jy5I3VvOstVTdUFFRGbbZT7t6+kLWfok9dfq9NkeNi4WyRTyM
 6mdXlaZ5Fxzw3Pub1dNnl6ke73N5+e0ZN47kqG3RLjwbV/SuUC3kd96kNZe/PL20ujHPtPUc
 i+Jjo+1+0/YkhsTtbmHRy+mMNb3maPxC8/as4j+qKW27udOl7/LaKOld+JkinuklbH5zzbJD
 y86FrdpR+NjjheaqhDnHln0M1WGcZht2q6OAe84y51VMdouO8aXGRtbc8JJe1zlRr/T03ORL
 5SoRvJw9yqz62aX7OQ/MU31ensQe/P+jvNQK10CPDR6sbXdapAyWTQ1euPVZg+17aaF551we
 LTzy7fERJZbijERDLeai4kQAKFlCvcsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJMWRmVeSWpSXmKPExsWy7bCSvK7SPY5Eg3NTxSyWzte3mHToGqPF
 /GVP2S22Xl7A7sDisWlVJ5vH5iX1Hn1bVjEGMEdx2aSk5mSWpRbp2yVwZbSuP8dWMEeoonnH
 Q5YGxi98XYwcHBICJhIfF7h2MXJyCAnsYJT49UUBxJYQkJDYvfo9C4QtLLHy33P2LkYuoJr/
 jBIt188xgvSyCWhJvHrKA1IjIqAk8Xd9E1g9s0C4RNPkuWAlwkAlM/ZUgIRZBFQlti9dwQhi
 8wq4SMy6eQ5qvILElIfvmScw8ixgZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc
 ClpaOxj3rPqgd4iRiYPxEKMEB7OSCG/oDY5EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7G
 CwmkJ5akZqemFqQWwWSZODilGpi2tv6LZ4+84aMcNmHzCv7cltx+m+ych29TtzrcXSXbq/M6
 a2KFiZjiwz2b771oUWGrko/j84xmeSss1d8eHZJ3bNPUN89uzD6S/FFzBfv2J3ZfF+i+XN12
 ZcLbvPnZ0pytH+N2JyQ8/ztX5+T18ttCHxMzpv5iVGDxl89T6r+iuf3tpQ11W77ey3dsznfu
 3api2rebIXDNTZZ2plkOTf293iUSEVP+3e98bSbWMlOzSiM77bK5VNJ8X7VPPbOO+txdtV7/
 2I6aG6+iHD3Lfb9sUpuzI8gj0ymHqdPdsvLS6iPeWfGP1k/UdHNM63jJfuC32/3gy3ZGqpaN
 zGnyciJfknVY/n+d9XPFvGN3NiuxFGckGmoxFxUnAgCSJWhIdAIAAA==
X-CMS-MailID: 20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9
References: <CGME20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_232919_811487_5702DCA0 
X-CRM114-Status: GOOD (  17.15  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The NLBAF(number of LBA formats) support in older spec was 16, but the new spec says the LBA support can be extended to 64.
The namespace data structure FLBAS(Formated LBA size) field bits have been changed to support more LBAF.

Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be..49cca79 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1683,6 +1683,9 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	unsigned ls_lbaf = id->flbas & NVME_NS_FLBAS_LBA_LSMASK;
+	unsigned ms_lbaf = (id->flbas & NVME_NS_FLBAS_LBA_MSMASK) >> 1;
+	unsigned lbaf = ms_lbaf | ls_lbaf;
 
 	/*
 	 * The PI implementation requires the metadata size to be equal to the
@@ -1855,7 +1858,9 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+	unsigned ls_lbaf = id->flbas & NVME_NS_FLBAS_LBA_LSMASK;
+	unsigned ms_lbaf = (id->flbas & NVME_NS_FLBAS_LBA_MSMASK) >> 1;
+	unsigned lbaf = ms_lbaf | ls_lbaf;
 	int ret;
 
 	blk_mq_freeze_queue(ns->disk->queue);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c41..e64194a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -376,7 +376,7 @@ struct nvme_id_ns {
 	__le16			endgid;
 	__u8			nguid[16];
 	__u8			eui64[8];
-	struct nvme_lbaf	lbaf[16];
+	struct nvme_lbaf	lbaf[64];
 	__u8			rsvd192[192];
 	__u8			vs[3712];
 };
@@ -395,7 +395,7 @@ struct nvme_id_ns_zns {
 	__le32			rrl;
 	__le32			frl;
 	__u8			rsvd20[2796];
-	struct nvme_zns_lbafe	lbafe[16];
+	struct nvme_zns_lbafe	lbafe[64];
 	__u8			rsvd3072[768];
 	__u8			vs[256];
 };
@@ -454,7 +454,8 @@ enum {
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
 	NVME_NS_FEAT_IO_OPT	= 1 << 4,
 	NVME_NS_ATTR_RO		= 1 << 0,
-	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_LBA_LSMASK	= 0xf,
+	NVME_NS_FLBAS_LBA_MSMASK	= 0x60,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_NS_NMIC_SHARED	= 1 << 0,
 	NVME_LBAF_RP_BEST	= 0,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
