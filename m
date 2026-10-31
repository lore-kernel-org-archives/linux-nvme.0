Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF14606A31D
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rgyPL9uE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=upMdKAus
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=tQ4FhDe1qrYboFjeabFnH5KpqmE7vXwUyr01Er17IVU=; b=rgyPL9uEERxaekuDvqK76z9z3a
	9Ju9BqWkDgUh20LryOZ3Uj9TgRjkUX54SQv0HuaUZhgUxFP9mQwuWc+b0dBq+VBrQSIrHneEGQtuf
	rFVUZx0VUEnRCpDZ+OFPtlweOFdHXvGHPxAdy3gCCVxT5WdjNF3dEY6G0ubnGgfTvx9pIh4qTaZTH
	SO1bLlLeW1zNt25xupRWacrU2f/RsILDNC4Q3p/Trey7bmURuz4PN+VJugHHYr0hX1dVdyqO4zsrs
	8Bwd7EPcWqde4y5aHJpfVOl/g7h2lEfREYwSY8Tk/mfIBSOTOmRuiIXEv9lyiT5XfXOIXgNqt14s/
	owJibcHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN429-0000000D1zx-3O6K;
	Sat, 31 Oct 2026 08:01:49 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN41l-0000000D1cV-1jJ8
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:01:26 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1ae18eb9b69so796701c88.0
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433684; x=1794038484; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQ4FhDe1qrYboFjeabFnH5KpqmE7vXwUyr01Er17IVU=;
        b=upMdKAuskwAfQEhzVenFvfvzaQRlAt+xtT3s0wsFRjkCplr3qhLuIzZCas1OpZOYgz
         pfnN4Qixcu6E8uXR+zqIJdNxnN94vtJ2Yz0J+WBFRQvrVLnkTKA9IpyGhxrAJ8JMyu5T
         2OL+xgqorbTfGlv27IctiMLMQe0b/lKSYasqHJ+StdLDFp3dhJuHgPtZP1klj+TxxQJD
         VyHaNsw25b1LY91DsarLAXWp375Em6oShEvBiNbit62VOrGhoMSVcfVOb+BXcsoH7T0m
         9U7bqeZDmu6Y93ujFg7EsQTBwXfadddfjY4boLbpWwagdSXUzBhSaGPKDmp1pWE9m33p
         4tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433684; x=1794038484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQ4FhDe1qrYboFjeabFnH5KpqmE7vXwUyr01Er17IVU=;
        b=KQEXb5gVTWtrQTgVk8Z+FLgQNQnGnmYRq+w9fDeZpTiutHujnsU6///PnLmI5qDg9h
         WVLcwfC3OXZWvOVCKzqIv7eFS+Od5Bsic+ylWuK/GZdpwHmqPIhG98CZ7q1Q9s0RGyRT
         H+lCmYVldqaf8i93scgEl0oYXjkF9bcA8aLtg1C2J+H8qpNM22cqLL1J4Osfoq/eTPEo
         1Od+Ts7UBSJdmsSQhg7weiYOnF1/qJfH7VBppwSxBGB1LjC04aeUV3xpy/JmrRVRUpnU
         73TSVwWbB8vlIXEnJaUmR1UDQhdydllRXeGaNps/RqHzfPUYXHeNqOmb+JXby5frF9gk
         Oo5Q==
X-Gm-Message-State: AFq9FYLKVWHS0lswv2RphkSsrpRNC0/l2j7GhdY+UhrMK1eXjx8n3RtW
	jZz44SsJu5eUXZu+5baGPk7vTZSOCUDiyS9v7sB6aoeCU7/5om6J8zjg
X-Gm-Gg: AYBFou17yjDvyBGcXGxeTa7WGA7EPdtPaqxYFgE/2YolWE46OAVUPGUYwvZlTybMIpX
	/5QBqWzHRhL0gOIpN6VMlTehZKLq4iCqPgghZZd80pJ6L5Hct8x0KW6LZY9Jk2JLSIOzjJ2S+K5
	3ve4nAE4/uQ0ZtWdz6YCtGc/A4KwVklF/JpZcXmZG4r7Gjqn3kNW1N9fZp0xXiy3WZA6P/HyZs0
	Pnbqq9MpXZx+j0t4S8lx2OoVSvDXhkc7a594jEtcKjCLkdAYX1l6JHjx4g3YbcBun+8MFa/lIa8
	bPxsVpXG8sj1gjFE3ZeJUgWMvvE2CQez8bTS7cBg1W+oHpx3t67a5MBO0VG+7gWHtDOiShL+yWI
	XmQf8KE8UBiwAU8sl7AL0aFqKiRkvFD29oDg5SQczcuoDGomCVfznoxZWDjzjv6cOLcJv5VQkYo
	PwsgmZztS6e7UwFNFeed+3yEM/bwOgLjYkny3qMNTxBKhh3HQwd+9HPIGODxktJj3obZ6WWn1Sm
	Q7feSqSrk2ol8s9BnVlMV9/bDoA5ZaRDnGJZoJhPxOmRYnjz42ASosiM8lzd66f44OIdxtswWzh
	mKCiIASXLoUzMbPnlgaK6hZbh2Elchfu1OJ5z4Bj69X7NE2x/Q==
X-Received: by 2002:a05:701b:4206:20b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1ac5fd08905mr6380563c88.45.1793433684316;
        Sat, 31 Oct 2026 01:01:24 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm18515038c88.6.2026.10.31.01.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:01:23 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] nvmet: use appropriate types for authentication payload lengths
Date: Sat, 31 Oct 2026 07:59:32 +0000
Message-ID: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_010125_460078_1951CC0B 
X-CRM114-Status: GOOD (  11.49  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The authentication payload length is obtained as a u32 value from the
NVMe command, but nvmet_auth_challenge() and nvmet_auth_success1()
accept it as a signed int.

Use u32 for the payload length parameters in both functions to keep
their types consistent with the value returned by
nvmet_auth_receive_data_len() and avoid an unnecessary conversion
from unsigned to signed.

Also, use size_t for data_size in nvmet_auth_challenge(), since the
calculation includes sizeof(), which returns size_t. This avoids
implicitly narrowing the calculated payload size to int.

These changes make the payload length handling consistent with the
underlying types and avoid potential signedness and narrowing issues.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 70136f6c22e8..99caad6fb87f 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -448,13 +448,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
+static int nvmet_auth_challenge(struct nvmet_req *req, void *d, u32 al)
 {
 	struct nvmf_auth_dhchap_challenge_data *data = d;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret = 0;
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
-	int data_size = sizeof(*data) + hash_len;
+	size_t data_size = sizeof(*data) + hash_len;
 
 	if (ctrl->dh_tfm)
 		data_size += ctrl->dh_keysize;
@@ -488,7 +488,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	return ret;
 }
 
-static int nvmet_auth_success1(struct nvmet_req *req, void *d, int al)
+static int nvmet_auth_success1(struct nvmet_req *req, void *d, u32 al)
 {
 	struct nvmf_auth_dhchap_success1_data *data = d;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-- 
2.55.0


