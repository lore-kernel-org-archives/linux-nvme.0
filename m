Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E3C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4e5OF42yOV4V8ZXhk0L/fWuL9+wq7tH/QeuR/zg4+7w=; b=zFio4kF8wBsDvwxupGkuMgyAyY
	P/sFp0FF6xpqjBfLF6c8D2294A+HnLMjBf3/uen5r5mba7gO5QKxWVlmyAG3YTIvaAa75v9mko9xn
	3WTdTLbIM4eTJK1LSHE3b/89+AabPcrAj6BbK4lppqWbPYZU+cbVAe9FHXx+steeXvQFiaJThZSii
	6m4KtfvfHAlbDErqf8nDUJLYtPNNSWRdk8EOpa5LuIhIwFwVCA6nMxY1aFPUfPMqZlSQZgC6P9bLy
	CSx93/l/f50EZn8uWytw/NkFEm8XArTlbIoR6WA8+/T9IsVMjbhM8CqAYHpw8SEpMV6Msrk/F1lHJ
	QpdoZ7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqqg-0000000Eitx-104E;
	Tue, 11 Aug 2026 18:05:14 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqqd-0000000Eipl-466B
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 18:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4e5OF42yOV4V8ZXhk0L/fWuL9+wq7tH/QeuR/zg4+7w=; b=ECLnXUIjhA+S1IKll3kHKR9Lce
	6qtDdPK2FCRWPsmudKBxiSHeSccdBRBQATRbla4FZvOEbVi8BMBKkHWekI66VwfLY2ovFbTKpXQkF
	o82LGXLAlnY8mL2LqjTpho1bGgZtS2TXD04Kt79S131J+LZbX4xTsdD7/Zr4ejEqGGQ1L2pRlUC3o
	s5vL23N7BvKLBxy0Jj9XR7QiklENk1GilA2WklnjcQyOmtTkqUMhHaFKELrP7VLvci9INWFyPQKBA
	X5VeBPoTNo2VXjFfKvYdiUW8b0c6VsRfAYmrNWsdDG9RrvWSQ5R5gw7EbkPtD040+6yEv7GYjdqaH
	exrhtkkA==;
Received: from [151.115.150.205] (port=41088 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wtqpw-00000004JeJ-2kWg;
	Tue, 11 Aug 2026 20:04:27 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] nvmet-auth: reject short AUTH_SEND buffers
Date: Tue, 11 Aug 2026 18:03:35 +0000
Message-ID: <20260811180335.4161138-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_110512_164548_EAF713B7 
X-CRM114-Status: UNSURE (   6.71  )
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

nvmet_execute_auth_send() copies the host-supplied transfer length into a
fresh allocation, but only rejects a zero length before treating that
allocation as a DH-HMAC-CHAP message. A one-byte AUTH_SEND therefore reaches
the auth_id read past the end of the allocation before any complete message
header has been validated. KASAN reports a slab-out-of-bounds in
nvmet_execute_auth_send().

Reject payloads shorter than the smallest fixed DH-HMAC-CHAP message header
before reading any common fields.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 92f8a76f10ff..d12ff9cb3dad 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -275,7 +275,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done;
 	}
 	tl = nvmet_auth_send_data_len(req);
-	if (!tl) {
+	if (tl < sizeof(struct nvmf_auth_dhchap_failure_data)) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
 			offsetof(struct nvmf_auth_send_command, tl);
-- 
2.47.3


