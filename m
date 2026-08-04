Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C82C55182
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=paBtj0zlUSaEs3KW7jQ14mpvl5GDxtkmPS+NKFJ7JBI=; b=rmJPO3DAX63rkKQ3E2G1kQbaEs
	d89/nDDxG6KJ19HVSvtVr5GcNPMYGVXGGEbZZE2JQcbq0XvhZ/MlDCE5J22UjPHDITWhGgNWXVoms
	as1grsAUcjAX/A+p2PHO1IDVuqxTSPAwIRVRtDUb2W/8sUaBLAjmyAwNrR54XC5QJk6fUXiZc5mXe
	og9Z4RQ1FcZEg3Bg+6YbfIPSMd6Z7BnVrh2xuWo01e9gydx4AoSDj/bgTKJFSxnQUbBNgR1yMyqxK
	XdEoNYGC1QDattHftCdQQrKixpRGWxL/J9PCJFfLaRNGP2KOAM88s9YforK+1mTbE3KAk4WvsXgtA
	Y+CaOReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr5yf-00000000vsp-2bOR;
	Tue, 04 Aug 2026 03:38:05 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr5yd-00000000vsS-1DLx
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 03:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785814681; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=paBtj0zlUSaEs3KW7jQ14mpvl5GDxtkmPS+NKFJ7JBI=;
	b=YAwms0pfi1/ETgBWhQRUVT339sTnnja0nFGzP62NCXd9adJgLA37r2MpelrfTiaYszSXaN0lXzDiDhYNPTBKtgObZrCwGTNHaAglYjvXEgty/fk0/ireW/12lM770Pgl6wR2h7OEK4u3rBmbf91XobD0cvrMUi0ImxdfXA+zBqE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8MUSBm_1785814680;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MUSBm_1785814680 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 11:38:00 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
Date: Tue,  4 Aug 2026 11:38:00 +0800
Message-ID: <20260804033800.3975537-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_203803_502596_22A319EB 
X-CRM114-Status: GOOD (  13.82  )
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

nvmet_execute_auth_send() allocates the DH-HMAC-CHAP message buffer with
the host-supplied transfer length (tl) and hands it to
nvmet_auth_negotiate() without passing tl along. nvmet_auth_negotiate()
then reads the negotiate header and, for each of the halen hash
identifiers and dhlen DH group identifiers, indexes into the fixed
idlist[60] array (hashes at idlist[0..halen), groups at idlist[30..]).

Neither the transfer length nor halen/dhlen is validated. A malicious or
non-conformant host can report a tl smaller than the negotiate structure,
or a halen/dhlen larger than the array (both are u8, up to 255), making
the loops read past the end of the allocated buffer (heap out-of-bounds
read). The sibling nvmet_auth_reply() already validates tl against the
structure size; the negotiate path did not.

Pass tl into nvmet_auth_negotiate(), reject a tl that does not cover the
negotiate data plus one full protocol descriptor, and reject halen/dhlen
larger than NVME_AUTH_DHCHAP_MAX_DH_IDS.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index d1b39e64d877..d015968bae2d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -31,12 +31,16 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
 
-static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
 	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
 
+	if (tl < sizeof(*data) +
+		 sizeof(struct nvmf_auth_dhchap_protocol_descriptor))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 data->sc_c, data->napd, data->auth_protocol[0].dhchap.authid,
@@ -72,6 +76,10 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	    NVME_AUTH_DHCHAP_AUTH_ID)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
+	if (data->auth_protocol[0].dhchap.halen > NVME_AUTH_DHCHAP_MAX_DH_IDS ||
+	    data->auth_protocol[0].dhchap.dhlen > NVME_AUTH_DHCHAP_MAX_DH_IDS)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
 		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
 
@@ -317,7 +325,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		} else if (data->auth_id != req->sq->dhchap_step)
 			goto done_failure1;
 		/* Validate negotiation parameters */
-		dhchap_status = nvmet_auth_negotiate(req, d);
+		dhchap_status = nvmet_auth_negotiate(req, d, tl);
 		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
-- 
2.43.7


