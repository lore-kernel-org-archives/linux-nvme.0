Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32953CD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nZ4xsWjsbWnXm3RQEz3hdKHfG6kaTnLOtHhVB+yWDzM=; b=Ew8LGeR0SZSTty1OSaleAIzDFE
	RBiAGqjlzFdGzrf0yKKWKgz5vgYj5Kn/AQFWwvUs5DjAENnyue1DQ1HUFsc9ZLws6xaINBmqdTd6L
	fj6PUbocK2yvrzAdl/1UBhWHh9+TpP6cVZtvUGYtrmC+msV8Rm2ICEeQEmP2XCevn91QfIiHh2vq+
	UuOem3vvZbYpFheDBTt/meCZm74hAjfMadsZUM8b3jCofhu8MShuq7V/dBzic89xtoLvmeByBlIMV
	tqhqWBX8MC/VXFW7U473m4dnwDb0qXtPQwlFr3pIysLaAi4XaR38TWhpOTDumja9YF/uw0GffNlUk
	g030HNnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX18J-00000006Bu0-0Xnl;
	Tue, 09 Jun 2026 18:25:03 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX18G-00000006Bsl-19gl
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 18:25:01 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-517a5cafc3dso38462111cf.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029498; x=1781634298; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ4xsWjsbWnXm3RQEz3hdKHfG6kaTnLOtHhVB+yWDzM=;
        b=FYtBcnFfRHImAIWR942J2SKc7oPUZK0GwnoUgsGLLNXLMDm2mXv24ZjIAULRg3wLHe
         URh7p0i3gaOpYyyouvmRVWLwhwXTLtJCa/nh2tBSZ+qcZA2QB/reUtsi0guIp5oFDmwj
         K19kxjDLFTkzlliQBBWXNM90Jenx7jS3AiXlvWwm0SlMrAgp7+GHKMvwhpyrK6oouVc5
         xgsXAPz8eFwUt7ck4U772HvDOFCZ7GZRfkDZ6vxAoFW5OdqeR3Ukq9lscfjOPly7YSmE
         boTx2dmW9OKUxdAapmZWlYpbPctj+gtObkJXSwM/FrFVDq+QkxPJex1eilWOgGozcLfV
         OHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029498; x=1781634298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ4xsWjsbWnXm3RQEz3hdKHfG6kaTnLOtHhVB+yWDzM=;
        b=VdRsQzdKO+ptxZa6nxgM7O+v6Ii2sqS1K0TUfCjq6JR/r5QH4v42QJtUQaQSrJmnX7
         lCl3nHefNZawQG131LJPDWV5HQtGPqvXIpJOPzoBV0V1Gxf2i8w4yx8x5jvwo4Je1h1p
         3rH9vhdUaGk/G/9/BuwanT2PlqetfeTPzxl0cqVEsp6r4YnuSsZYUPqDtaY3DazTWiyd
         3aH18xBVX/bQ5KQyqY9sbjJYP3NOrsk+lZ4LJfXKGE727Rt8dH6MAb9I1NnmVAKpgtlF
         egmWz+zf8EHgK45cMcLtC4BRAvpmNoWQmtcebO0mEOceVrz1eJ3aTH/29MJQ9lJSla5W
         ZhkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TQU1qQIzvfVkKixwP6M5X4sV1xTIWxaaq6C0oU3cbNAGnKT0AN2tXDkEAu1ibdVcTz3dMYiWDFiJ5@lists.infradead.org
X-Gm-Message-State: AOJu0Ywixq/yTOi9A/lYVb9JdzndJUhe6bCQioIBmzdLZSja/HLELqYd
	xvBLXsInJsH+98mkRY3xDkI+1l4Pv+ksFVg/5LByGeu8neQILNrMj2ov
X-Gm-Gg: Acq92OH6I6WET2vd2E2e6nXV6KY/Q4NdMlydjX39iZiiCDJoPqHCJGg1rKdImRsKy3z
	42hbjy+r8o0cnHauEo0Y6C+66lg79Yh7ZCpAoKCfZJ8kMB9w9ho4X/HyO2kb2sWqvboO5KqiHho
	6VUtA8UdpmavzM02oGNi8jBY6LCqLUkoJjSFAWgK1JwMfOeJFOj12Hj7Wl+k3L3zd76cRedgAPQ
	YBfXUd6FMXM3DXDlNaugb99jbXGau89v3uSYIae629eu6zf+ry4WIKcSyMEM9m1obTq5q43r3Bw
	J863/beXNjUNh11HWWfEYBNKbePd9NOtzGtlo8VxVqVwoR31u25DXAZSnl+g2Z7LoBbZi1axL/l
	IlqtnPAOglSAzxKX3fG6L4GMoI9HFrJRJvmhoOkMoHco4CwehTAyeAD9pJTdu0FwkSr4xE9FBgc
	gtPqgSz2Q63HVejOTXl5E5aSJLGUGvTaAWGnyXwsSTjfn2j0v3khQCcQqVGPmb01rnue1Q6oTSR
	Xoe406vrDV6miynS7fbYALEfcoOmWs=
X-Received: by 2002:a05:622a:4818:b0:516:e01f:523a with SMTP id d75a77b69052e-51795bf3cf3mr319055121cf.43.1781029498000;
        Tue, 09 Jun 2026 11:24:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm2174297385a.43.2026.06.09.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:24:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmet-auth: reject short AUTH_RECEIVE buffers
Date: Tue,  9 Jun 2026 14:24:31 -0400
Message-ID: <20260609182431.2437882-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_112500_401027_05EDB07A 
X-CRM114-Status: GOOD (  19.51  )
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

nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
after checking only that it is nonzero and matches the transfer length.
In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach the fixed-size DH-HMAC-CHAP response builders with a
kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
nvmet_auth_failure1() write past the allocation; both only WARN_ON the
short length and then format the message anyway.

Impact: A remote NVMe-oF initiator with access to an auth-enabled target
can trigger a 16-byte heap out-of-bounds write via a one-byte
AUTH_RECEIVE allocation length.

Compute the minimum response length for the current DH-HMAC-CHAP step in
nvmet_auth_receive_data_len() and report a zero data length when the
host-supplied allocation length is shorter, so the existing zero-length
check in nvmet_execute_auth_receive() rejects the command before any
builder runs. The SUCCESS1 minimum is sizeof(struct
nvmf_auth_dhchap_success1_data) plus the HMAC hash length, because the
response hash is written into the rval[] flexible-array tail, so the
minimum is state dependent rather than a flat sizeof. CHALLENGE keeps its
existing variable-length guard in nvmet_auth_challenge().

This is reachable only when in-band DH-HMAC-CHAP authentication is
configured on the target.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
  - Move the length check into nvmet_auth_receive_data_len() and reject
    via the existing zero-length guard in nvmet_execute_auth_receive(),
    per Hannes Reinecke's review. No separate helper, and
    nvmet_execute_auth_receive() itself is unchanged.

With CONFIG_FORTIFY_SOURCE and KASAN enabled, a short al (for example
al=1) on the SUCCESS1 path aborts in the sizeof(*data)=16 header memset
in nvmet_auth_success1() with "memset: detected buffer overflow: 16 byte
write of buffer size 1". After this change the same input is rejected
before allocation and the abort no longer occurs. Validated with a
KUnit/KASAN harness under UML: the stock kernel crashed and the patched
kernel passed; the in-tree nvme-auth KUnit suite still passes.
---
 drivers/nvme/target/fabrics-cmd-auth.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e5..d4271fc43a95c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -484,7 +484,31 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 {
-	return le32_to_cpu(req->cmd->auth_receive.al);
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 al = le32_to_cpu(req->cmd->auth_receive.al);
+	u32 min_len;
+
+	/*
+	 * Reject too-short al before kmalloc(al), since the SUCCESS1 and
+	 * FAILURE1/default builders write fixed response headers into it.
+	 */
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return al;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		min_len = sizeof(struct nvmf_auth_dhchap_success1_data);
+		if (req->sq->dhchap_c2)
+			min_len += nvme_auth_hmac_hash_len(ctrl->shash_id);
+		break;
+	default:
+		min_len = sizeof(struct nvmf_auth_dhchap_failure_data);
+		break;
+	}
+
+	if (al < min_len)
+		return 0;
+
+	return al;
 }
 
 void nvmet_execute_auth_receive(struct nvmet_req *req)
-- 
2.53.0


