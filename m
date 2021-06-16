Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4CCC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D0D6105A
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D0D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5yvDSpiOrPdINPmLD3Jiw6LCqhZwpv8A1DKYzzi/W0g=; b=Wfyb+f4CLVFKRC
	LC7+u9cJGLjcUtZovHB1XYAIzDcaZvrPFF94TJNyuhwyU3sCEWkllM4BOyA+952iq+DTY1HhI22tV
	Glb+nzHwI0xKDBug6u1DK/uYsrzDR2eOdCf9kgaUlI7Oy1InvKQmApe66+ParDQ0CJscZr+9Z2IU6
	i09tnzHFsyiogKKpek1Ei7Rss8R1vTKtAf27ps0Y32kQiVPw2srOMQaSoh5TJVWGn1p7mmlR6K04Z
	1s+/CYyU/r4apmMmlfNQwMtQqGtg06246SRUkfWFndSQvg94poYMp3kaop2LJzuH156N673Hfaexv
	bqZ7S5AOa0b7UsgU+saw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltdq0-007qaC-DP; Wed, 16 Jun 2021 22:16:44 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltdpd-007qWk-UO
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 22:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623881780; x=1655417780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gi+bUvdjoJmS8dbai7Y83GPf12CwQ5++byvUDd2lChg=;
 b=AXqpc+lvDsCtraPDUOQohlHJy8emHlJ5PcBEMu7+10WDzFB4WitchQDY
 96DytDWyb5eiM8zI1mUX+A4bWU5ZKcHqAYy8TaUad/0FsATgWN2cvNEsm
 jccvaDdnQpTFgirlb+QddjOZTP87OVxbSbTV2XqA6tgrsJbO9aFyA/gxO
 vkF9GJxq/G2Z/WdRIKmJT5VFjIw8+CYmW2o1rAnNswcvli6HJHYWfPyLV
 SBxQ0uYVsJzMCq+0+Z7YQyoPOkXehjxlGTPLMYa/7UGuqAaJliccpAxEV
 QO1oIrr/g1YqzXcr7BpSGTbzyZJ+GWUMTA0+4nzX9bPkwln5NpZmz7EMT Q==;
IronPort-SDR: HCH+qYiSZdMbg0Gi6QN4uKgRq0LJ+GoVMB1pOZpjMDJ+LgpoYkvIEfdcA8FiShX1hkOKzl//Zp
 cDlXKCS9EnO0cJ5Dab7W8KN0ig4/XC80RDcJ+QCtcNOLRmjXPTjeyFrvkcKgDkTZ+hZaqXJ1Jx
 mGOhTHifEUCxmwesgiQYE1S16nEJElsNwrgMr3XbYnorcABtHpfStm7rPQe4iBHB9P3n/bO693
 /EZyB/QXUxMj1aLdgHXNdbjuvvlnVEDGKDlTAy4XCzVw8KGpaRclOvoEVNEHKZJJm/S8Uabqv1
 vjE=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; d="scan'208";a="172139541"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2021 06:16:18 +0800
IronPort-SDR: /P+IA2U7+P/H3aSROJvssYO+ZPYH6YMhohy7d91RKtM2nGgClLCUigybfJ5cS9SMs1MQr9iO33
 itu+wue3ZG2QFKjROhRHfaSYjaZTC+2tN56Gdewv7unviS5NiJ1uthduL34K0Lr3jBkaF4tgx6
 QcCaCpN8miD2JYM2bXDdgc+wZ+Gtq/DW51MzkwkHl7cMr6MQQjfC0OLp7Zq6eg769clfB+G8gW
 pmFkK7iWVSEK05P35DVCCYVQc4l7f5/ghbG/Hh37KssTe0OnkisaqL/mX4QT080Nz06jYP0OhD
 FmAGkJ9YCgoXRbdDhU/dSdXU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 14:53:47 -0700
IronPort-SDR: 5NCBDaCo0eJ9bfN9n0f670i4icBbGc4dCvEsCmc156Jfs7uf8xMUwWuf2bstR6o/ZEDPC9za+Z
 cR8sEcQjFm6qjeqs2e6ddYL9xsRtLfFvFjvNyVUb3ijt/CWdrFjlReUO3B8ZHvaK4OXvmm2u3H
 uyk00PzEogUp3qTLjl/YBp04v5+OaGf2CJwDv2ukOgbFfjjwf3sUv00yMRREZ3E+2kYMUy+ioh
 s9FrWIFPfMXt0i+ZAcX1J4xxulMy+lKSUEi4rn0XgRaNoLRMZfWIyz/kOYwG9PiPPW0DE01Oaz
 zds=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2021 15:16:20 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/3] nvme: remove zeroout memset call for struct
Date: Wed, 16 Jun 2021 15:15:52 -0700
Message-Id: <20210616221553.55914-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
References: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_151622_038566_EF0762D6 
X-CRM114-Status: GOOD (  12.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Declare and initialize structure variables to zero values so that we can
remove zeroout memset calls in the host/core.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..14d96ee4d341 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -724,9 +724,7 @@ EXPORT_SYMBOL_GPL(__nvme_check_ready);
 
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
+	struct nvme_command c = { };
 
 	c.directive.opcode = nvme_admin_directive_send;
 	c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
@@ -751,9 +749,8 @@ static int nvme_enable_streams(struct nvme_ctrl *ctrl)
 static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
 				  struct streams_directive_params *s, u32 nsid)
 {
-	struct nvme_command c;
+	struct nvme_command c = { };
 
-	memset(&c, 0, sizeof(c));
 	memset(s, 0, sizeof(*s));
 
 	c.directive.opcode = nvme_admin_directive_recv;
@@ -1463,10 +1460,9 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
 	union nvme_result res = { 0 };
-	struct nvme_command c;
+	struct nvme_command c = { };
 	int ret;
 
-	memset(&c, 0, sizeof(c));
 	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
@@ -1594,9 +1590,8 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
 				u32 max_integrity_segments)
 {
-	struct blk_integrity integrity;
+	struct blk_integrity integrity = { };
 
-	memset(&integrity, 0, sizeof(integrity));
 	switch (pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		integrity.profile = &t10_pi_type3_crc;
@@ -1967,13 +1962,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
-	struct nvme_command c;
+	struct nvme_command c = { };
 	u8 data[16] = { 0, };
 
 	put_unaligned_le64(key, &data[0]);
 	put_unaligned_le64(sa_key, &data[8]);
 
-	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
 	c.common.cdw10 = cpu_to_le32(cdw10);
 
@@ -2045,9 +2039,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
 {
 	struct nvme_ctrl *ctrl = data;
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 
-	memset(&cmd, 0, sizeof(cmd));
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
 	else
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
