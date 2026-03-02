Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B0BD58E78
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7Z1djiE/0GRDla4RyHJA1efkVvJwyFJWL/OCrGVKBk=; b=F2+XEYbhtqhczJPg3I0ALkar6Q
	Ff2oyZxkyCMDC+8t1QDnTiJZYHgp4lrzY2voz0lRtjlBhWXCte0CvK+cnasKQdaEEaNFetOmfwqsD
	K5X0PMx9xuy7ZHoUmQq4nfWfxa4C8Gr5vUSEMKUq3fvP2deIrb7wbDXR8bGEOsHEsX6x7wU0HJhhQ
	zigm3I9laWS38sCKwyvzOQrixu7VklKPuss5Wux3Sz7VAruIf7c/HSO/0xBOucYaTxHipq+8nMRIE
	ZFo0wJJhxgG7VdbsT5Q+H1RxhmMPpgeOAvnTW66qBgmGHEUGEzUykLgxvnrRKb/gkmZ/gr0a0SaJo
	jnp3BPvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDU-0000000CSZ2-0tns;
	Mon, 02 Mar 2026 08:01:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDQ-0000000CSXd-3gcT
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9650840DF9;
	Mon,  2 Mar 2026 08:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27978C19423;
	Mon,  2 Mar 2026 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438480;
	bh=tz1RfI1RIBkWoKN/08BYFSJL2jcKk0SDiHuNGe81jv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtRdtLYtR0wiZuhAQC7Gab7fZtK3xgEoZYQatoYwag+R4c58VGk0lr6s00F5FpHLG
	 Aa6VPlUYS3hIU9WR9RAsJjs4FK5rqeBqSusnY40QoWxqQqcVdd44eHMl2DllahNthS
	 RE13vqA7uYL+IGgeEUI6F4GLagSituI1HAjEeCwU3p5fuHhzhDvX0xAbkKF3DTtapW
	 w4ZQf0WQ2K4zXfAt+JN0gMnrjg01BNXOqpxp4CRofupiqYzkm7T6TZtWpTTp+BF6jm
	 Ux/RoWY0OJ6QH7JnOon8qmXpU1JqJI9LHXTDjmNU3HvBCqB9c3xzEF7rFqCCYKCJCm
	 4H4KCGZR1pBWg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 02/21] nvme-auth: common: constify static data
Date: Sun,  1 Mar 2026 23:59:40 -0800
Message-ID: <20260302075959.338638-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_000121_034482_2A4A5D83 
X-CRM114-Status: GOOD (  10.21  )
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

Fully constify the dhgroup_map and hash_map arrays.  Remove 'const' from
individual fields, as it is now redundant.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 78d751481fe31..9e5cee217ff5c 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -34,13 +34,13 @@ u32 nvme_auth_get_seqnum(void)
 	mutex_unlock(&nvme_dhchap_mutex);
 	return seqnum;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_get_seqnum);
 
-static struct nvme_auth_dhgroup_map {
-	const char name[16];
-	const char kpp[16];
+static const struct nvme_auth_dhgroup_map {
+	char name[16];
+	char kpp[16];
 } dhgroup_map[] = {
 	[NVME_AUTH_DHGROUP_NULL] = {
 		.name = "null", .kpp = "null" },
 	[NVME_AUTH_DHGROUP_2048] = {
 		.name = "ffdhe2048", .kpp = "ffdhe2048(dh)" },
@@ -85,14 +85,14 @@ u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
 	}
 	return NVME_AUTH_DHGROUP_INVALID;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
 
-static struct nvme_dhchap_hash_map {
+static const struct nvme_dhchap_hash_map {
 	int len;
-	const char hmac[15];
-	const char digest[8];
+	char hmac[15];
+	char digest[8];
 } hash_map[] = {
 	[NVME_AUTH_HASH_SHA256] = {
 		.len = 32,
 		.hmac = "hmac(sha256)",
 		.digest = "sha256",
-- 
2.53.0


