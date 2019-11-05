Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA15CA9ED9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731320869
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edW+gfEO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="cQU+0lsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y2GI6EtvcVnWKZLy3d2/RcEdXEjcrGDqipFx1/WJ8/g=; b=edW+gfEO4koPXJ
	DFY0Gvc+guxxqNPKIms5MqZKmnEtSR2CIGm2Hba99WUb+AxdbLyAWvjKghyUEfiZPXdN6/Rj2NkhP
	IemEP1u1lWOYfKc2e9sDGCa1b1AHidJJ9FAF6mfV5vmGeFQBhakvAadNZlbMFRcnlLmpLIERvwE9+
	AxV7INCjJfRpkdHrABKhRKID+J4ZjIIJKCtywy1GixI9k5EEZrCiETznmj+0L4sQ2T73pZ+HVHrx0
	3jciSmEzZ48PLkFaJI2zecFpN6+4tDUVcz/CFuDYIQfdm2+d8Acqa/xpETabqglsD+Scet26jR95r
	nEv2TBR+4hyFwrCvQvtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRtva-00080Q-QZ; Tue, 05 Nov 2019 08:11:02 +0000
Received: from zimbra2.kalray.eu ([92.103.151.219])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRtvX-0007xH-T5
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 08:11:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 90D3427E038D;
 Tue,  5 Nov 2019 09:10:58 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id X7BGO0JOs5hT; Tue,  5 Nov 2019 09:10:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 233BA27E0F36;
 Tue,  5 Nov 2019 09:10:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 233BA27E0F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572941458;
 bh=OO6/C53RSQEGRW5gbObYlTV6VlK1Xu7b7VEhdXSTo1s=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=cQU+0lsxf1ifXf7YTo9z0trPopwa2iBS1PnrOVPgp7LQu9oxD95L7Q7h3nJ5TJDRy
 BejRaUZIYEca7aYbzH/cYZy06VsGGl3/pA3Nkujlnur52mBeBXnCkOL+6jkPZalL16
 UJNxHeP4OZ1T+h3Lwe331o2NjRmNvY9aGHgGrGeg=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id B1IQIsVB_NUV; Tue,  5 Nov 2019 09:10:58 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 0A5BD27E038D;
 Tue,  5 Nov 2019 09:10:58 +0100 (CET)
Date: Tue, 5 Nov 2019 09:10:57 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>, 
 linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <436860210.90381688.1572941457980.JavaMail.zimbra@kalray.eu>
Subject: [PATCH 4/4] nvme-cli: ioctl: support 64-bit ioctls
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Index: MPALW+vVgS7NKHXL4ZwB1QVJmcMmXA==
Thread-Topic: nvme-cli: ioctl: support 64-bit ioctls
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_001100_271318_AF811DCC 
X-CRM114-Status: GOOD (  10.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

The existing ioctl passthru commands had a limit of 32-bit result.
Some commands (like get property for the CAP field) require 64
bits. A new added ioctl in the kernel allows this operation.

This patch adds usage of the 64-bit version for the get-property
command, falling back to 32-bit if necessary.

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
---
 nvme-ioctl.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 35df04d..e9fc158 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -93,6 +93,24 @@ static int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd)
 	return ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd);
 }
 
+static int nvme_submit_admin_passthru64(int fd, struct nvme_passthru_cmd64 *cmd)
+{
+	int res;
+
+	res = ioctl(fd, NVME_IOCTL_ADMIN64_CMD, cmd);
+	if (res && (errno == EINVAL)) {
+		/* If the 64-bit command is not implemented in the system,
+		 * fallback to the 32-bit one. The structures differ only
+		 * in the result that is at the end.
+		 */
+		struct nvme_passthru_cmd cmd32;
+
+		memcpy(&cmd32, cmd, sizeof(cmd32));
+		res = ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd32);
+	}
+	return res;
+}
+
 static int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
 {
 	return ioctl(fd, NVME_IOCTL_IO_CMD, cmd);
@@ -600,9 +618,30 @@ static void nvme_to_passthru_cmd(struct nvme_passthru_cmd *pcmd,
 	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
 }
 
+static void nvme_to_passthru_cmd64(struct nvme_passthru_cmd64 *pcmd,
+				   const struct nvme_command *ncmd)
+{
+	assert(sizeof(*ncmd) < sizeof(*pcmd));
+	memset(pcmd, 0, sizeof(*pcmd));
+	pcmd->opcode = ncmd->common.opcode;
+	pcmd->flags = ncmd->common.flags;
+	pcmd->rsvd1 = ncmd->common.command_id;
+	pcmd->nsid = le32_to_cpu(ncmd->common.nsid);
+	pcmd->cdw2 = le32_to_cpu(ncmd->common.cdw2[0]);
+	pcmd->cdw3 = le32_to_cpu(ncmd->common.cdw2[1]);
+	/* Skip metadata and addr */
+	pcmd->cdw10 = le32_to_cpu(ncmd->common.cdw10[0]);
+	pcmd->cdw11 = le32_to_cpu(ncmd->common.cdw10[1]);
+	pcmd->cdw12 = le32_to_cpu(ncmd->common.cdw10[2]);
+	pcmd->cdw13 = le32_to_cpu(ncmd->common.cdw10[3]);
+	pcmd->cdw14 = le32_to_cpu(ncmd->common.cdw10[4]);
+	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
+}
+
+
 int nvme_get_property(int fd, int offset, uint64_t *value)
 {
-	struct nvme_passthru_cmd pcmd;
+	struct nvme_passthru_cmd64 pcmd;
 	struct nvmf_property_get_command pg = {
 		.opcode	= nvme_fabrics_command,
 		.fctype	= nvme_fabrics_type_property_get,
@@ -613,12 +652,14 @@ int nvme_get_property(int fd, int offset, uint64_t *value)
 	int err;
 
 	gcmd.prop_get = pg;
-	nvme_to_passthru_cmd(&pcmd, &gcmd);
-	err = nvme_submit_admin_passthru(fd, &pcmd);
+	nvme_to_passthru_cmd64(&pcmd, &gcmd);
+	err = nvme_submit_admin_passthru64(fd, &pcmd);
 	if (!err) {
 		/*
-		 * nvme_submit_admin_passthru() stores the lower 32 bits
-		 * of the property value in pcmd.result using CPU endianness.
+		 * If we have the 64-bit ioctl version, we got the
+		 * complete result. Otherwise nvme_submit_admin_passthru()
+		 * stores the lower 32 bits of the property value in
+		 * pcmd.result using CPU endianness.
 		 */
 		*value = pcmd.result;
 	}
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
