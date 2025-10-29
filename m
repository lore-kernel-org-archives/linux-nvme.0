Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB7CCF9F0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i5/wEkoI+hVNcBxwptf2Q4xkJbKsnnWovvmwEi2boYM=; b=M0eH5JZhsGQkK88PMzrlYTa3K6
	jxL1AZYeX+P0xZ/8QwF8S3AXKR9dEQ7bk1FQO1c21y5GT8++e+AlMR9wBhhp9BfMDPRaBvbFKAS3T
	moHbT0Bvgzw3NtvCzPkG9ChOUWskoix7u9YFXhUlgscHHmMDQNf4qyNt8wyUFnlI/euByQ5UQOw6K
	IlzYG8ytXdkYvR4grMtU0/W2/1xMqEnu+CxMIv865kSu2jAZvLeN7kaytoA8jo8KJTJDXpdb3ChGC
	aKUkR8sTbmPXa1F3YPDLyzcIp7ZlrHUJv1T7sizKqhalHjtEYb5VikmXPPOKXRBjWO0mQJjh94E7J
	1UULtBVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE7cs-00000001h6B-06W5;
	Wed, 29 Oct 2025 14:58:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE7co-00000001h5I-1fgd
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 14:58:11 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T8KX2I4054836
	for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 07:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=i5/wEkoI+hVNcBxwpt
	f2Q4xkJbKsnnWovvmwEi2boYM=; b=bFGxc5ieWx5hY1v1Y/rDsx/EC9pG157iwM
	WQJ2AOyHQyU2nipn3HMM+8UACORuH+5BhqpWjhUiJ+Fkc9OVsZPx+IPDUu1GbA00
	eJlhNTH/DwWIERmNHbhB/DJaGTVmhLCGcJz4FeUocJMK59fXNM2X4YvadXvbfOQM
	2z7TG4TQW7+49RLNPDJuFtukhcgctqR1pIUN2ClRHy+pqpdMC2/OY9z78DSlsO10
	8TUPSdvsLGLNeHhnOOLCtVwPCFGowOlWZwJbcTluyU/SoZeT1NWAFmQe5UmvHCnH
	uHC7hiQ5U267xvIMfML+pKlQe1dDI7T5xe4+cAwEhQOHy3Rqysmg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a3fb1jfmf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 07:58:08 -0700 (PDT)
Received: from twshared41381.33.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 29 Oct 2025 14:58:06 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AB66F33597B4; Wed, 29 Oct 2025 07:57:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hare@suse.de>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH] nvme: split host and target nvme_auth_extract_key
Date: Wed, 29 Oct 2025 07:57:45 -0700
Message-ID: <20251029145745.3723258-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gd_q3YuP4jIP2ulJxw-Ap21SGXf1BDaB
X-Authority-Analysis: v=2.4 cv=W9E1lBWk c=1 sm=1 tr=0 ts=69022b80 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=qfJaxdeI0GlAKEM0L5gA:9
X-Proofpoint-GUID: Gd_q3YuP4jIP2ulJxw-Ap21SGXf1BDaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExNyBTYWx0ZWRfX7qfRZGma6S8j
 Kj+o2KJ9t9E4VSLBiYsf/53hJFCghyBXz7B2EaU+UKN8gxAXYC51euIXF6jBRgrsp4uMqGQPgoC
 B6/m/kjvbvUg8PgGPyIafDSgVWv1Fif+X10WfkCvd9nW6UTYKc+c7achGNm7tYSoPlkSvblUucB
 +V3+cHvC6G8XrJYyvv/TZoYxYat6kh158wqGiuGINvhiXZueZ2JYD0igvrtbw3+uawwPxtJ8f54
 jhIC09xtB9xWurh53B/aWIxVCLIw+jOFz4+gQ9ru1eOneM7Y1hb7Tc8jWu8V8qeNxwn6oyNaUBz
 mpFOouVf1dtwbvTwcdnU9wA5wewbYtWNdJ+GBZz3zI204TvNswNUTz5qUGV3IXPUYgguIq3uu+e
 FrnkycRl5P4ZqEZ6vzYJsTOMygla+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_075810_537195_8DFAED90 
X-CRM114-Status: GOOD (  16.88  )
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

The host and target share common code, but the config allows you to
disable support for one and not the other. When support is disabled, a
stub implementation needs to be used, but that would clash with the real
implementation that the other relies on.

Split the host and target implementations into uniquely named stub
functions that either call the real implementation or return an error if
their config option is disabled.

Fixes: f59ae5c9e356b5e ("nvme: parse dhchap keys during option parsing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@i=
ntel.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fabrics.c |  4 ++--
 drivers/nvme/host/nvme.h    | 12 +++++++++---
 drivers/nvme/host/sysfs.c   |  4 ++--
 drivers/nvme/target/auth.c  |  2 +-
 drivers/nvme/target/nvmet.h | 12 +++++++++---
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d4d6d8e88c48..c6b83da6b12b4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1107,7 +1107,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
=20
 	if (host_secret) {
 		pr_debug("lookup host identity '%s'\n", host_secret);
-		key =3D nvme_auth_extract_key(opts->keyring, host_secret,
+		key =3D nvme_auth_extract_key_host(opts->keyring, host_secret,
 					    strlen(host_secret),
 					    &opts->dhchap_key_generated);
 		if (IS_ERR(key)) {
@@ -1123,7 +1123,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
 			goto out;
 		}
 		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
-		key =3D nvme_auth_extract_key(opts->keyring, ctrl_secret,
+		key =3D nvme_auth_extract_key_host(opts->keyring, ctrl_secret,
 					    strlen(ctrl_secret),
 					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8dfd3db8761d0..3e6273ec0707d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -7,6 +7,7 @@
 #define _NVME_H
=20
 #include <linux/nvme.h>
+#include <linux/nvme-auth.h>
 #include <linux/cdev.h>
 #include <linux/pci.h>
 #include <linux/kref.h>
@@ -1179,8 +1180,13 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, in=
t qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
-struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
-				  size_t secret_len, bool *generated);
+static inline struct key *nvme_auth_extract_key_host(struct key *keyring=
,
+						const u8 *secret,
+						size_t secret_len,
+						bool *generated)
+{
+	return nvme_auth_extract_key(keyring, secret, secret_len, generated);
+}
 #else
 static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1204,7 +1210,7 @@ static inline int nvme_auth_wait(struct nvme_ctrl *=
ctrl, int qid)
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
-static inline struct key *nvme_auth_extract_key(struct key *keyring,
+static inline struct key *nvme_auth_extract_key_host(struct key *keyring=
,
 						const u8 *secret,
 						size_t secret_len,
 						bool *generated)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5c7dfff2e5460..2b4748fa1bf75 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -648,7 +648,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct d=
evice *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key =3D nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+	key =3D nvme_auth_extract_key_host(opts->keyring, dhchap_secret, len,
 				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
@@ -735,7 +735,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(str=
uct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key =3D nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+	key =3D nvme_auth_extract_key_host(opts->keyring, dhchap_secret, len,
 				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index a77ec88a19415..656eca9a370ea 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -69,7 +69,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const c=
har *secret,
 	}
=20
 	len =3D strcspn(secret, "\n");
-	key =3D nvme_auth_extract_key(host->dhchap_keyring, secret, len, &gener=
ated);
+	key =3D nvme_auth_extract_key_target(host->dhchap_keyring, secret, len,=
 &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 49d397e1b6786..cf15d97444aa4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/uuid.h>
 #include <linux/nvme.h>
+#include <linux/nvme-auth.h>
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
@@ -895,8 +896,13 @@ void nvmet_execute_auth_receive(struct nvmet_req *re=
q);
 void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
-struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
-				  size_t secret_len, bool *generated);
+static inline struct key *nvme_auth_extract_key_target(struct key *keyri=
ng,
+						const u8 *secret,
+						size_t secret_len,
+						bool *generated)
+{
+	return nvme_auth_extract_key(keyring, secret, secret_len, generated);
+}
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
 u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
@@ -939,7 +945,7 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *=
ctrl,
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return N=
ULL; }
 static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
-static inline struct key *nvme_auth_extract_key(struct key *keyring,
+static inline struct key *nvme_auth_extract_key_target(struct key *keyri=
ng,
 						const u8 *secret,
 						size_t secret_len,
 						bool *generated)
--=20
2.47.3


