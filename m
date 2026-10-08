Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4189DCA600C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bFZEoCSdPazo15nkgP0fWaFGcEpWYF2hCMaNwRwX11o=; b=aj+6JrILUE1pcjoVQzD/2XOQzK
	Sr9NFk7ZTckvANfTVT8TRyRKokMeTqEbQB1P/8EUtSMbwBbINgut+qcKsRN9GRNu0r0LQQxPqfOgR
	QtaiwdTO9GHycEIK857hkYEGaE80ctdqvzetMdZ9UboqEFKdTOo3EHyL4lScDPbup92fEjY1xnYWE
	BS+LXtEV/hnTMVYGhZDVXUEZqhI6SP3GY6/oMJPf+iTxS60Vj0e5NnQ9IVmL5Vujub1EGa86bvm4A
	9Py6EPC3QwwvwtQNMVsCYg16CaYFScR+V7jcXin61SCaXV8IC/Es7X9oSluA7LK3rOwwNCKdoDhmZ
	d+kZoodw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEt0Z-00000004sPd-2KSF;
	Thu, 08 Oct 2026 18:38:23 +0000
Received: from cvsmtppost04.nm.naver.com ([114.111.35.228])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEt0W-00000004sP7-1FNy
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 18:38:21 +0000
X-Originating-IP: 115.136.205.4
Received: from cvsendbo035.nm ([10.112.22.38])
  by cvsmtppost04.nm.naver.com with ESMTP id 3xQlQHTxTBa+bJxlmOiLFw
  for <linux-nvme@lists.infradead.org>;
  Thu, 08 Oct 2026 18:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791484695; bh=D9fJp5RX1ofAzaAZ1VAW0BekstVKkYXmqF1S39dLtoQ=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=UU1eswngKYxGtjBTHVl8Pofpon99Tq83gqjNRHVfJ2QAMpjHDamKute8IaWXT6ZTB
	 N9iQ9HGZvZY9xfrf+X/pgXd/CpxfPFZkb2Uk7B5J7BLA5bb4M5dvGZ6JTazy1ggW+8
	 UduB1T7xP+JC5QERd8Qs7u/vn2ckc2PQy4gLVD9N7ud0oIyrqREQ1UIWl2ZUk6cBDv
	 6CuutfAWCwsQS0wYglrXfluLJqjAWK3vZkILre7hVygK7pj0Ue0e/lfSG4o3w8XTYg
	 zRZFdJUicb90BiePbT1pacMj0sKKZ7Tffk1GhJchotrpOpFZVMigczWyp2zqmCvOW/
	 SRu9QmRpR4wEQ==
X-Session-ID: 0EGft-T9TBexZpC7tNO9KQ
X-Originating-IP: 115.136.205.4
X-Works-Send-Opt: OPRwpzGdjHmdKHFOMr39Ko3YKBm9jAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: sqb9FAulFqJZ+HmdaxUZ+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp008.nm.naver.com with ESMTP id 0EGft-T9TBexZpC7tNO9KQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 18:38:14 -0000
From: tjdqudcks0424@naver.com
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	Sung Byeongchan <tjdqudcks0424@naver.com>
Subject: [PATCH] nvmet-auth: reject undersized AUTH_SEND payloads
Date: Fri,  9 Oct 2026 03:38:10 +0900
Message-ID: <20261008183810.10455-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_113820_721987_93571CF4 
X-CRM114-Status: GOOD (  10.86  )
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

From: Sung Byeongchan <tjdqudcks0424@naver.com>

nvmet_execute_auth_send() allocates and copies the initiator-supplied
transfer length, then reads auth_type and auth_id through a common DHCHAP
message pointer.  The existing zero and transfer-length checks do not
ensure that both common-header bytes are present.

An unauthenticated NVMe/TCP initiator can complete ICReq and admin CONNECT,
then send AUTH_SEND with tl equal to one.  KASAN reports a one-byte slab
out-of-bounds read when auth_id is loaded.

Reject payloads that do not cover the common auth_type/auth_id header
before allocating or parsing them.  The one-byte trigger and
header-minus-one boundary were cleanly rejected in three fixed fresh-boot
runs.  Exact-header, valid DHCHAP, wrong-type, mismatch, and zero-length
controls remained clean, and a following valid AUTH_SEND on the same
connection received a response.  The touched source is unchanged at
0c2669a9f4a1d607e7591ae50ccf3c432a0aff08, where the patch applies and
builds cleanly.

The demonstrated impact is unauthenticated pre-authentication target-kernel
denial of service.  No disclosure, controlled write, RCE, or LPE was
demonstrated.  The source reproducer and complete logs are available on
request and are not included in this public report.

OpenAI Codex assisted source inspection, test design, patch drafting, and
evidence organization.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index dccdb55a367c5..1cdebd580722a 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -285,6 +285,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
 		return;
 	}
+	if (tl < offsetof(struct nvmf_auth_dhchap_success2_data, rsvd1)) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_send_command, tl);
+		goto done;
+	}
 
 	d = kmalloc(tl, GFP_KERNEL);
 	if (!d) {
-- 
2.43.0


