Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D14CCF9E3
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 00:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ieq2pzSGnW75Op8Np7tibpnFckQjh+KVuzI2ctJLUrg=; b=xGyoSmT+etKw0zn8MZaxjEPgaR
	fdKXnkw9D+dRGD1qZUfqA1nT1cTtyNpslnmjohdYh/ucBWKqWQZ6qE75jv57iE4an7e50XAAw66U9
	u0HJVPqZPuEqwBFTzgbl/o8ynw8vpZjR1BQZSZZZo72PzR23FDPlS+jpcQvuj+AXBLgZ7C/WawxlZ
	X29BEIS7Kbz/agU6WBe5bIwRGcoOpkwu8LsaLXa3hI42OZAOCFy4Gqqsp2oeWuvutcv+1202iwGTF
	HHRCEdiHYgVq8mzZRMTZYOOMz1+jlbFQrH+jMwXIkz8VRYErd8ZMrmR7vmt7/hsWXZci1znFfQ4KQ
	A87VOZKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEczG-00000005BDm-1ATa;
	Fri, 31 Oct 2025 00:27:26 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEczA-00000005BCx-1x6W
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 00:27:24 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UM42je1895408
	for <linux-nvme@lists.infradead.org>; Thu, 30 Oct 2025 17:27:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=ieq2pzSGnW75Op8Np7
	tibpnFckQjh+KVuzI2ctJLUrg=; b=nYUsBm6WQ1E4KO/3R2b4oHbu8k+cxuNDZS
	9+3pqB4U7Nid3d4VYJoveN/ZKh2dCRsgyB/MzZ2Y+ReDqOq5e23UogzGWiuS85RG
	ft9yniDfzt0ikiJn2xqtqtqM1Ltxi3DiU1tomso1P9Hd2mHLGeDlLxHk25FFF94s
	//cACXIQo8mE1tn3qtlR7ygXJFouMh6wXvUwSy7XkO84zNJ7oVn4qXC+muXkjOXp
	IotgXUptLX/IG7F6pweFfzpVE4l59tU8pUXN7h3rm4+gmETehglaMLFJvie3KA7Q
	XhwhXdl1moMhiwiFw2fZkqx7qVZJMv0OIQ4zfnBDO11lkHNOWSYQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a4aakce3v-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Oct 2025 17:27:18 -0700 (PDT)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 31 Oct 2025 00:27:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CF49A34276F0; Thu, 30 Oct 2025 17:26:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        kernel
 test robot <lkp@intel.com>
Subject: [PATCHv2] nvme: fixup nvme auth host/target dependency
Date: Thu, 30 Oct 2025 17:26:55 -0700
Message-ID: <20251031002655.2999568-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: geIefO3l40xzj10IWH2CYc9TErXNl_Yb
X-Authority-Analysis: v=2.4 cv=MKVtWcZl c=1 sm=1 tr=0 ts=69040266 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=6S4nWPHjoEwrC51Yl-YA:9
X-Proofpoint-ORIG-GUID: geIefO3l40xzj10IWH2CYc9TErXNl_Yb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAwMiBTYWx0ZWRfX+nuEP9csdwO+
 xduTJHRpuSUbgWRUBFMxxIZxJ98NRCfGJZZvXJbBckzRI7HYnrE7U0kWm9ARO9nquFC5X9NDGmM
 pjHKl5gv2BpsaBEwoaGCmaA6esTOQp9vvlJC5aTfcCWpyvZUUuuoixiCYQ9+IXchRandq9JhT96
 Owd38EHvA+DoFBeK9V7Sg4B2hJ+OMflztECIUrfoeZpGCWcRYb3h+FJqhvcWwg6hOhNZpnih9vY
 7INK1NKtX+PJe8lXDlwhe/lA4fKaitPe4egJF9xX19hwvcHvGSXevy8j+foqcN9ryZe+vwft3GF
 b3vxoFGF4eKge3895M2un58APR3aNkh7s5a8XqED+9lETFuG6D5+pmKYTqMXY7pDGuUOaOlxFbl
 hkEI3l2ZN/dLexsl2u4OxGDzrN8gsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_172722_629936_D26FFAAF 
X-CRM114-Status: GOOD (  13.48  )
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

Converge the enabling of nvme-auth for both host or target into a single
selection and implementation. The selection must inherit the strongest
config selection of either target or host, so some Kconfig trickery is
used to make that happen.

Cc: Hannes Reinecke <hare@suse.de>
Fixes: f59ae5c9e356b5e ("nvme: parse dhchap keys during option parsing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@i=
ntel.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Instead of keeping auth support for host and target split, their
  destiny is converged and so is the implementation.

 drivers/nvme/common/Kconfig | 18 ++++++++++++++++--
 drivers/nvme/host/Kconfig   | 10 +++-------
 drivers/nvme/host/nvme.h    |  9 ---------
 drivers/nvme/target/Kconfig | 10 +++-------
 drivers/nvme/target/nvmet.h |  7 -------
 include/linux/nvme-auth.h   | 11 +++++++++++
 6 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 8a5521c038c53..67deb1eaea705 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
+config NVME_COMMON_BUILT_IN
+	bool
+
 config NVME_KEYRING
        tristate
        select KEYS
=20
-config NVME_AUTH
-	tristate
+config NVME_AUTH_STATE
+	bool "NVMe over Fabrics In-Band Authentication"
+	depends on NVME_CORE !=3D n || NVME_TARGET !=3D n
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
@@ -14,3 +18,13 @@ config NVME_AUTH
 	select CRYPTO_DH_RFC7919_GROUPS
 	select CRYPTO_HKDF
 	select NVME_KEYRING
+	help
+	  This provides support for NVMe over Fabrics In-Band Authentication.
+
+	  If unsure, say N.
+
+config NVME_AUTH
+	tristate
+	depends on NVME_AUTH_STATE
+	default y if NVME_COMMON_BUILT_IN
+	default m
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 6d350ef617bfb..3c39657bcac25 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NVME_CORE
 	tristate
+	select NVME_COMMON_BUILT_IN if NVME_CORE =3D y
=20
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
@@ -112,14 +113,9 @@ config NVME_TCP_TLS
 	  If unsure, say N.
=20
 config NVME_HOST_AUTH
-	bool "NVMe over Fabrics In-Band Authentication in host side"
+	bool
 	depends on NVME_CORE
-	select NVME_AUTH
-	help
-	  This provides support for NVMe over Fabrics In-Band Authentication in
-	  host side.
-
-	  If unsure, say N.
+	default NVME_AUTH_STATE
=20
 config NVME_APPLE
 	tristate "Apple ANS2 NVM Express host driver"
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8dfd3db8761d0..de24185dfbea4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1179,8 +1179,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int=
 qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
-struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
-				  size_t secret_len, bool *generated);
 #else
 static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1204,13 +1202,6 @@ static inline int nvme_auth_wait(struct nvme_ctrl =
*ctrl, int qid)
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
-static inline struct key *nvme_auth_extract_key(struct key *keyring,
-						const u8 *secret,
-						size_t secret_len,
-						bool *generated)
-{
-	return ERR_PTR(-ENOKEY);
-}
 #endif
=20
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 3edb089a89e83..d2728c0b77079 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -6,6 +6,7 @@ config NVME_TARGET
 	select CONFIGFS_FS
 	select NVME_KEYRING if NVME_TARGET_TCP_TLS
 	select SGL_ALLOC
+	select NVME_COMMON_BUILT_IN if NVME_TARGET =3D y
 	help
 	  This enabled target side support for the NVMe protocol, that is
 	  it allows the Linux kernel to implement NVMe subsystems and
@@ -107,14 +108,9 @@ config NVME_TARGET_TCP_TLS
 	  If unsure, say N.
=20
 config NVME_TARGET_AUTH
-	bool "NVMe over Fabrics In-band Authentication in target side"
+	bool
 	depends on NVME_TARGET
-	select NVME_AUTH
-	help
-	  This enables support for NVMe over Fabrics In-band Authentication in
-	  target side.
-
-	  If unsure, say N.
+	default NVME_AUTH_STATE
=20
 config NVME_TARGET_PCI_EPF
 	tristate "NVMe PCI Endpoint Function target support"
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 49d397e1b6786..2df4f422326ee 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -939,13 +939,6 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl =
*ctrl,
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return N=
ULL; }
 static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
-static inline struct key *nvme_auth_extract_key(struct key *keyring,
-						const u8 *secret,
-						size_t secret_len,
-						bool *generated)
-{
-	return ERR_PTR(-ENOKEY);
-}
 #endif
=20
 int nvmet_pr_init_ns(struct nvmet_ns *ns);
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 98652e7ee92ca..afc84a4cd94ad 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -18,8 +18,19 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
=20
+#ifdef CONFIG_NVME_AUTH
 struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
 				  size_t secret_len, bool *generated);
+#else
+static inline struct key *nvme_auth_extract_key(struct key *keyring,
+						const u8 *secret,
+						size_t secret_len,
+						bool *generated)
+{
+	return ERR_PTR(-ENOKEY);
+}
+#endif
+
 int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
--=20
2.47.3


