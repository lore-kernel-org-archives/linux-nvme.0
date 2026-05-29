Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270EACD4F54
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:
	From:Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Old2ZBfu5/f6+8T0WIP99FhOmU/UUs/ZTf09PeYkFpA=; b=HpJtdZdhti3EX1KfjWOMaPgNqg
	IL4TiEnyM//ANc+rRRuzk+5aM0P6X3XVPkBYi1gjGbqVdtj10MsEeDURF0oqkGY2uGsAgFInvIiHI
	GVAwwjB7v4Ours+tg0fFIFWCxqUUnRY9YoYwiPgIYKGPf+93fbzZc4sSpuWntdOuDGmabi2jYqaJ9
	wXzqI59mnkyc5zq3CJE+dTIScy/BOzANZBN5k+C4AALpJtGqV/FviqMKDEReVqZIi/It4ieK7h7p9
	b7a/Dm5J/X4LOc9kPH73D7vgBaZC0y8ffH06O8vgPK5s/1WSzP4/ZvUhKigmEoIT2pxbgaDigP/KM
	umPEICag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSy2x-00000007Vbv-1VN7;
	Fri, 29 May 2026 14:18:47 +0000
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSy2u-00000007VbG-2bdT
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 14:18:46 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780064321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Old2ZBfu5/f6+8T0WIP99FhOmU/UUs/ZTf09PeYkFpA=;
	b=g8PtUux1KbEuz1rCh+RBoWjElpt4H5nmwuirbu97o6nWtzuQxFl3BI6Q+H+OsMfLPFSzeV
	9wQt8SIormeF3P6HuRpFcac5dE5Q6C8o7FkuQro1XDK162lxe7JmZpq6O0GYFBw9qkrPg0
	ifu4K1BbAFyNMpKNJwVHpG4NcfWd/xA=
Date: Fri, 29 May 2026 14:18:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
TLS-Required: No
Subject: [PATCH] nvmet-auth: validate reply message payload bounds against
 transfer length
To: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_071844_803364_4B8FDAD7 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

From: Tianchu Chen <flynnnchen@tencent.com>

nvmet_auth_reply() accesses the variable-length rval[] array using
attacker-controlled hl (hash length) and dhvlen (DH value length) fields
without verifying they fit within the allocated buffer of tl bytes.

A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message with a
small transfer length but large hl/dhvlen values, causing out-of-bounds
heap reads when the target processes the DH public key (rval + 2*hl) or
performs the host response memcmp.

With DH authentication configured, the OOB pointer is passed directly to
sg_init_one() and read by crypto_kpp_compute_shared_secret(), reaching
up to 526 bytes past the buffer. This is exploitable pre-authentication.

Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <=3D tl befo=
re
any access to the variable-length fields.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target=
/fabrics-cmd-auth.c
index f1e613e7c..0a85acf1e 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -132,13 +132,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *re=
q, void *d)
 	return 0;
 }
=20
-static=20u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data =3D d;
-	u16 dhvlen =3D le16_to_cpu(data->dhvlen);
+	u16 dhvlen;
 	u8 *response;
=20
+=09if (tl < sizeof(*data))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	dhvlen =3D le16_to_cpu(data->dhvlen);
+
+	/* Validate that hl and dhvlen fit within the transfer length */
+	if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %u\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 data->hl, data->cvalid, dhvlen);
@@ -338,7 +347,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
=20
=20	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		dhchap_status =3D nvmet_auth_reply(req, d);
+		dhchap_status =3D nvmet_auth_reply(req, d, tl);
 		if (dhchap_status =3D=3D 0)
 			req->sq->dhchap_step =3D
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
--=20
2.51.0

