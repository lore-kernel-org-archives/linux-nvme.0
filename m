Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04369606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jg7EiUoA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKmNCBw0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DRIIJZvR3wc7jeqvnffYZMLIW2BsmoDA36GgncS3Xds=; b=jg7EiUoAMXO+vM
	8o8qywbTIh7r5wosjUe013Nacyvr2i8IO+KAHVfqKu1jjUA4997CzQON5WivWUMMISnggALQe0+we
	K6dDer4kuukAdDoOSvUx0yzWvfEPzPwOy5xAOFnAAD513sZNXoLdYGVW7rhxFNOrBvBtH7j0an+TL
	qYjBm9UiVKAOfQeNA1YAvrdhr9vKbZ5qf0rAc3b89pb57DIIfv2QQ1wxSqISjSIl8LajP1CT6IzP6
	qRtX85LwVEIQs3xXRIppNE1086+BGan0vjHMqm9Ee6VltC3A6L6IxOW7fLHvt22I/Q/p84e7rGUY2
	EBcpzGQZ/3+aYiXvwU4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4IT-0000000D38x-28k5;
	Sat, 31 Oct 2026 08:18:41 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4IQ-0000000D38X-48Fw
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:18:40 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1adbf62dd31so1314560c88.0
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793434718; x=1794039518; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRIIJZvR3wc7jeqvnffYZMLIW2BsmoDA36GgncS3Xds=;
        b=gKmNCBw0M5AnskicBHjdI3serQu5yIrp+JtU/psD/MXRxnuNtO5K0cEnNj8d4+qLy5
         xSL9Si3RsNoEJq7MrY7UCsfNzbsS+tHe8UUad0L6I+9wrU1UdZlr3eyAa7uSnfJRtI1E
         X9lpUME+PT4gqEv5y/Mb42t/q25udLn0ExBGF757QT4CYQFtaj5UU2WvMs+jn2L21jgz
         t/0AzUFVPO5QhX7//2KSlszOLwT7FfU7b+c5MnI2QveMw/RrZze2poMQrqIPgFJB15ne
         JwNT/yATz5r5DvoRQ35qg7tVTmqJCBRB0p7ZIpjQ418wnKTds+b0Ma96mPdMUTmPVt6J
         Os0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793434718; x=1794039518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRIIJZvR3wc7jeqvnffYZMLIW2BsmoDA36GgncS3Xds=;
        b=D8Padd/VeV7RgT0Hu/bL5s5EMXpeiUrUpa99cEQQCFnGFXXrEy32eSxe/0Rnddfdxj
         6JenqF8wzeUe62f4mwH++TSZYmn+iYGcWtpNIshtn8WHDp0zaGJJKocSMkLiv9FZPxK1
         TrXVaEdyso7AcRj6tJxT4ZsDbpSfC+TlrAIUNf2eiW/xye5NFWITQZZAwgJZv4poZQQP
         1nowS5nUAQlzUYNx/A9GnqUk2XCxrQnBgOzcHVgoNwpIghT935osQwjZInNjq2jaevdB
         8NCX9H1o96rhk+QTatb5ca1d21KoTQKOc3XGQgwotnZEsAEgjYbQATrl0QV/h7GQhZ/T
         LXkw==
X-Forwarded-Encrypted: i=1; AKwUvBzxHtm2Tc1hrnPZvVW2J7j7dVsqOTnZsAwm6+WKS42whq4eaKjBNAGUs/VfpBhszvq86HJYZ4+bExIb@lists.infradead.org
X-Gm-Message-State: AFq9FYLsFe2EYExyTVIini7QVqcCsnxMcj0dwyNJG6Rq78zLWrc/nb0+
	ednZt8QCjHgkyatMenFskVdVrRrd6fgX2zB9q99VsdWrFeL5kdK1BSTM
X-Gm-Gg: AYBFou0dUD/vkSD63yLZmnmCTJtgabw4KuEESgENvoh7VafI1HRb812CQuXB208lMvT
	ZipCKK+k+/f52IoyPs8fS3yzkIK9IdEWTbMClkRX2GV+OeXVIV2/QyJnvcTqe8N3FX5Ne/+r05v
	rvZC2k+tKZ+hILKpzaK7laWzfp5HojJ7xKae3bUsIQg+9MZJR/dFA5JSsm7uRBNMFbdHh7UbMpz
	F4TRggPSmAVn7N9EsgE9MJA7TIRJY9y3g0Q61vSbarTdCentN4xAoAk9TkZrMSzhr0typBVN5Vf
	hpR32QvcNfgHvRthwhU9FiPO4SXdOtG28CdY8+gO5fQOJtCMUIguQr5wl3ehXDyYMNWuR6HPifq
	S7dNbL0Ir8TjWSaxqafZUkx3CNbAtbO7X+xppAZYtxkVCokJn3guQsksvS6TGy03mrXKcMMIzn8
	Zwc6HhNCPSCr7+Reu+O8rVAiDOtD6lvkOAhq6EMRGuQzINPD5ZkVjpEKQR36foyUL+XWQ8eCA4O
	zJi384+W37mhRteUNh2LWdghpxwWInYD+XR1+9rr3nCN1+mJBkE0Z/FT9T1PydH7Y41lw4z1qbM
	HkrIrxIyjLEtzO7O4h9L2REgS7CF8ed4l18fpwBkAMZB4OKW8JM=
X-Received: by 2002:a05:7022:ec03:b0:1a9:b7f2:3015 with SMTP id a92af1059eb24-1ac5e22a7e0mr7334800c88.39.1793434717941;
        Sat, 31 Oct 2026 01:18:37 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm13112236c88.14.2026.10.31.01.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:18:37 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com
Cc: hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH v2] nvmet: use appropriate types for authentication payload lengths
Date: Sat, 31 Oct 2026 08:17:51 +0000
Message-ID: <20261031081751.4583-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
References: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_011839_028747_3C168315 
X-CRM114-Status: GOOD (  12.68  )
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
v2:
 - Update the debug format specifiers in "nvmet_auth_challenge()" to match the 
   updated parameter types. Use "%u" for the "u32" payload length and "%zu" for 
   the "size_t" data size to avoid format type mismatches and ensure correct debug output.

 drivers/nvme/target/fabrics-cmd-auth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 70136f6c22e8..c90917d26c98 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -448,18 +448,18 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
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
 	if (al < data_size) {
-		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
+		pr_debug("%s: buffer too small (al %u need %zu)\n", __func__,
 			 al, data_size);
 		return -EINVAL;
 	}
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


