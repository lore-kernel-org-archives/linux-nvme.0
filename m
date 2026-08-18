Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F73C5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G88Ko5HBVTHhFRR2TE2Youz5qooeeU01EKul632rERw=; b=D3jHb/OK5XKYsM
	+xOLv4QU8DpuBniLEb+Cf+LMLFSGRZO6euWf57Qw6ZLmKNcxt7EMy95akHQmmNXpm1MXZ0ouG1Fw8
	QsTSA2dcnUN3ZLO9QYKJ27uUQKG911j+0u51na+hd+DESR/heJovdrZvvSmTdKrdgP3PeAyqjdfKy
	RPWbLmPpnpJ+FYxhNjo3q5hKkVqKkCWcnltsPYhe8MxJd19M4PH5zqtkqpeKeeyr1JMg21PGeQR58
	oIitV3S78lRf2Xyglp0JtMSNXljkG9rT0ovtDO8D4NDPSEAS2RPLPJIh7hzBkR6OuKGabRxY9PMfV
	+ECCINqbaTMhtm+ErIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMiS-00000008Lmz-0RYh;
	Tue, 18 Aug 2026 16:31:08 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMiQ-00000008LmV-00YW
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 16:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070663; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=G88Ko5HBVTHhFRR2TE2Youz5qooeeU01EKul632rERw=;
	b=hAHFmrbOmS2PEx/ISI+4kqqVOLVbL659RCUQwg3xrr8LAHFUo33oRnX29PPSaDinyAaPdc6fOEHbTjWPE5geWRGw4nxcO/W6jA9z6nEX5NBEGDCHqEWlOO/PvOX6Kg/kR0bOwaIoZnKl3+WqT8IvXBMC9EcmkBxMATjQtFzTR0I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0X9E4qry_1787070662;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E4qry_1787070662 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:31:03 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: validate NEGOTIATE message length against the
 transfer length
Date: Wed, 19 Aug 2026 00:29:38 +0800
Message-ID: <178707057800.2645263.18339408043463141529@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_093106_195123_A239F2A4 
X-CRM114-Status: GOOD (  13.55  )
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

nvmet_auth_negotiate() reads the protocol descriptor and then iterates
over the hash and DH group id lists using the halen and dhlen counts
from the received NEGOTIATE message, without checking that the lists
fit into the buffer that was actually received.  The buffer is
allocated with the transfer length from the AUTH_SEND command, which
the host controls.  An unauthenticated host can therefore send a
NEGOTIATE message with a small transfer length and large halen/dhlen
values and read out of bounds from the heap buffer before
authentication completes.

The path is: the host issues an AUTH_SEND command with the DH-HMAC-CHAP
protocol identifier, nvmet_execute_auth_send() allocates a buffer of
the transfer length tl from the command, copies the message into it and
dispatches the NEGOTIATE message to nvmet_auth_negotiate().  halen and
dhlen are single bytes, so the id list loops can read up to about 300
bytes past the end of the kmalloc(tl) buffer.  The buffer is a heap
object, so KASAN reports the over-read.

The REPLY and other received messages are already validated against
the transfer length; do the same for NEGOTIATE by checking that the
protocol descriptor and both id lists fit into the transfer length
before reading them.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fab=
rics-cmd-auth.c
index ccd5dd3dac85..61a36724bae8 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -31,11 +31,19 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
 	sq->dhchap_step =3D NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
=20
-static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data =3D d;
 	int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fallback_dhgid;
+	size_t proto_off =3D offsetof(struct nvmf_auth_dhchap_negotiate_data,
+				    auth_protocol);
+	size_t idlist_off =3D proto_off +
+		offsetof(struct nvmf_auth_dhchap_protocol_descriptor, idlist);
+
+	/* Validate that the protocol descriptor fits the transfer length */
+	if (tl < proto_off + sizeof(union nvmf_auth_protocol))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
=20
 	pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen=
 %d\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
@@ -53,6 +61,10 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void=
 *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
=20
+	/* Validate that the hash id list fits the transfer length */
+	if (tl < idlist_off + data->auth_protocol[0].dhchap.halen)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id =3D data->auth_protocol[0].dhchap.idlist[i];
=20
@@ -78,6 +90,11 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void=
 *d)
=20
 	dhgid =3D -1;
 	fallback_dhgid =3D -1;
+
+	/* The DH group id list starts at idlist offset 30 */
+	if (tl < idlist_off + 30 + data->auth_protocol[0].dhchap.dhlen)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
 		int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i + 30];
=20
@@ -265,7 +282,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		} else if (data->auth_id !=3D req->sq->dhchap_step)
 			goto done_failure1;
 		/* Validate negotiation parameters */
-		dhchap_status =3D nvmet_auth_negotiate(req, d);
+		dhchap_status =3D nvmet_auth_negotiate(req, d, tl);
 		if (dhchap_status =3D=3D 0)
 			req->sq->dhchap_step =3D
 				NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
--=20
2.43.5

