Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4689D116F5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L8AeieFimbJam0S0CNFeGMeIZ7Khz9RqxFadk63c82E=; b=mpuSB+72DlB8nJpCrwXatOSCs7
	C0zTLSuo2woysEtPkyOIwSeRceFXEdD8dMh1WC4vO/4FUExe61MsUILcYdh6kCK01toIybSKHaC5S
	+jvaQdumlbXVWfj3Xs4+1m6UUbSW0n8h5XPAzdrjE2GwuzaW+JhRfDM0jECC0kbj5n0aBaufOE7o/
	GuPOQng97GmWtDfQTMm3vLZEhCSnbDS7pqlHl1ByiKlFzM9WtwCtn5Z8hxRXvTzHKF/6pWIAIPKtc
	s2Q+NCXMljOikbZakOYxSICRwuJ+1pYwWPKvKcnba5nd7iCIcX7IpFXZnOZX1tQXkrF+i2bndjemj
	jQ18qaPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImv-00000004ous-0KEa;
	Tue, 02 Dec 2025 05:18:57 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImq-00000004ota-3aRi
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:18:55 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so5141182b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 21:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652732; x=1765257532; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8AeieFimbJam0S0CNFeGMeIZ7Khz9RqxFadk63c82E=;
        b=el5jXGv+ZEaZK4A+LnFTKfzSgut55VpBI4N2w+z7Ytjgff4I/Y/LHFf13E0cCAV6fQ
         DOLVHo0vSMNbpoqDE8gJaHY/88vOdOpCwCNwun5Oq6crbfsL+qQ71DKj5lWeCUXsWjVq
         /DgAQyL33cUQidqwcNzfofoWvKwyzWO6HDoK1x+5ZROoYN65aenNFMk+SH/nKHBn2cqE
         609XuakgFElWf1QFyRdnvEOOnkWVzgKuejKwDAZ+mPkLwT/pJOzGfNqPfCz9v17s8Un7
         xgpIZAxdfylDBrts8hsBT7AEwO1puKjPA0w01y2M07pI+tRit/F6Sjmvqill6KMxxJ48
         jlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652732; x=1765257532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8AeieFimbJam0S0CNFeGMeIZ7Khz9RqxFadk63c82E=;
        b=lHXK8/MxcJqjQlu7QFrQJZbGLF8yeI2yCosJVyJPRjpljgkU73TNJCmAZgAapSKlnY
         mHZVL4gBvn7lhpuwt9WGo9wvPRsj3AlYvIT7aDMKL9lIgCX9ummVfYIONM5kBOnWzfba
         AszsZWq72JhZEV5ZiXbOTcmAl22Z8dkiXG0eMPe0xcnojKbOcwhDaaES2Uj+pRKdk7K7
         x3mWvhZmIodBeZGerxTHVBX6XThuYdjENzeiOcG4OJtLa9Ia9gLs0TwrtcgUbSuoku8X
         N99Es5GEhk22HrGjWV0GJUBHX8qaYVa3H9XBoGidpPO5CnCcX9eYTLlsiJNHftT8EDRE
         rZRw==
X-Forwarded-Encrypted: i=1; AJvYcCW0RA7pvInoxKAB5FkqK+gWQyAHaWISj5rUFR+9pOg2PVPvKHh6HaLwt0WpjhpsL16gS3WFbiftsntb@lists.infradead.org
X-Gm-Message-State: AOJu0YwLqOC3C9FdjzwFIAao+0oc6di/fSeSvTIfI0Jz0y7BXRcw6+z5
	emLiEFoSZHdsj4hqyI2JuT71uMs9XXTnT70vOe12WGqRIJ3xXFJ9OZfE
X-Gm-Gg: ASbGnctKxLkzAKNePshGO/3f6uIkXzhR89gd7b4z7JXYvDL0n6mOjRnVas37VUXsiYn
	pwdOQJW4YL9jirFJIubKxQsFSiMZQxa81ZSRFulDp8EO26EtbEpBKq8fxNnSppYf0Y68BkS+fpa
	WmwlokhF9Nzv2DGNNb1vq+fIRto7nZluSABFPtVTbFAcpSc5Mtzp02adQWNKZuv9WMKniymYqks
	n1reQzUU6VDA+JNqSyoekNp+IzRkooFA5lcPn7FC8Ohw21uS6LWDOU2KAbW8nkbP6u94oMz652R
	CT8X9cAZtCoaqFVi2IEim0Xkxi//ND0EIX1M9TI5NkX/dCo/IPhgjA4BtVpY+HeixextYHi7L5C
	FSKAKMzXeIW9q8Nvm2/rnYJDtxybCNEA/PEQ4Am64JVzZ5OwM483uG88WPPKpKEImjDd1UXc8cE
	zxqWimhPH5zdc5U7eukR4y+JXzymVe7uN0FUwyB44ed3s4rQOVeFQjORqKflZ2rFWxRtez+xEW7
	p3bT3Y3Y8tm3DFKu+4=
X-Google-Smtp-Source: AGHT+IHXVR9xVqBIrHlKRJuSEqFKZhKcMiSMOEuD9Pp+8nI+9Q5D6jsp+oEpdwDlwMv3XltMeSu20w==
X-Received: by 2002:a05:6a20:4306:b0:342:44f3:d1bc with SMTP id adf61e73a8af0-3614ed922b6mr46138429637.35.1764652731971;
        Mon, 01 Dec 2025 21:18:51 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm15206433b3a.42.2025.12.01.21.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:18:51 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 2/4] nvmet-tcp: Don't free SQ on authentication success
Date: Tue,  2 Dec 2025 15:17:53 +1000
Message-ID: <20251202051755.1312158-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202051755.1312158-1-alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_211852_925829_0A48F27E 
X-CRM114-Status: GOOD (  13.94  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

This patch ensures we don't free the TLS key on success as we might need
it again in the future.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
v4:
 - No change
v3:
 - No change
v2:
 - Don't call nvmet_auth_sq_free() in nvmet_execute_auth_send() either

 drivers/nvme/target/fabrics-cmd-auth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 2e828f7717ad..0cd722ebfa75 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -397,9 +397,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto complete;
 	}
 	/* Final states, clear up variables */
-	nvmet_auth_sq_free(req->sq);
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
+		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
+	}
 
 complete:
 	nvmet_req_complete(req, status);
@@ -575,9 +576,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
-		nvmet_auth_sq_free(req->sq);
-	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.51.1


