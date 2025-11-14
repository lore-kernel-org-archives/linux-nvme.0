Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B8DCDE001
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 04:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPi3F894ayLOXIZaJVbMAjWwHmlVBJZBqgf+lTbKGUE=; b=TVrVh/8vdFVYqySBw5gVkmuTcW
	NCBXMWFCSRIunC+Bq3RZ8lEsv9bqTEns8/rbZbx6RrU/07RWZX6Ra905c9sOT6taQhzYKGbI15rJ1
	SZP59Lku8sYgICQCyS8xSHBUwqoiJb3MicEa1xiQ14qxbRxOUjWP7ELlmrZIKGqpmkvQZDEjDe6Mw
	JUsB2uTWjf+Jj6d63PZVOdr80/l+PQETcuQ4Du2MKaZQEnGEGHutluMDjqYK65X+iC8NFaE0Zos+L
	Y9iOhuAMc0DfaioMaPC6ekHK+NLx9p57Rz5FMkpKtC0GS3AIFukbK0PBWlmPspcA2372vc2NKFGhk
	w8XTp6Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJlu8-0000000BZLc-22bV;
	Fri, 14 Nov 2025 04:59:24 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJlu6-0000000BZKg-1tEp
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 04:59:23 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-343ff854297so315764a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096362; x=1763701162; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPi3F894ayLOXIZaJVbMAjWwHmlVBJZBqgf+lTbKGUE=;
        b=lwVRfxz3bX86QsLGgabd7DaLADaswqYkZhSsgJqEuK9xyT3DUreOFKiVxhr8AIXmLE
         RZnU5FfdwjmTLwko2uvmqAh+7Z72DooU7mfNbb0NVUbSRKWukPH2i9rcYuGZsrXkPZz9
         fgRO/UxQ5l/6CbTNfW72Y1B7EJ7JF59j5xAwa+bRPXC27WZRpUs0iCS7Q+4TGyuGLSL2
         rimNQW+Wz9WI8hOEfmJ8anj80iBTOIJPyNuNxhxUUd88wohAc5yTgI6RjsbmHUMHu35S
         d1tAnmzIN8m0CqY9t8mPluVp2yGsGtMMMJuMrTmIWP0S5tQDgzXEpliUr9+KjSetBBdN
         Gxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096362; x=1763701162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPi3F894ayLOXIZaJVbMAjWwHmlVBJZBqgf+lTbKGUE=;
        b=kwykIjCIsEknQCE2f4C7ndZCx/zKs1T2TBtEMFHRxuj/XFT344Ar01AS7xzk+LCo+K
         sf3ffbGabY9Whn+gIQgTYYZHywa11X9t4LUptpbbMfatcOCocoj7PJAX/14fmjV2mO1v
         zlW6vPnfXXmwvWhKNvCBxR9ESK3KNVlBNNorYzBgJ6y3aq7Fj6NTNy2s0a/V/5lDoCtY
         3gqyQG6LZQe9cbtzgJf9Y8sKM/qQ4ikL3AYQNNWQvT5cM4Dz/ZHAcFWWqxEA3atR/raI
         u6772zE12q3+UO4q/+o1ICWHF8wSQRhU1abFCHuL18TEC4/knHGhO9nmfsAJ9MNtlg3m
         xDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVXo1hWT2zyE4hBT+WXfGFZE5jFnjjpgk7dq7Rof+42Ad41UOcJKDjKTYbRa7DDUmvfL417oj5nkQBW@lists.infradead.org
X-Gm-Message-State: AOJu0YxDauTcIvVwmoByJdqOOhLJ4AnuBueb/Nb0Is7Vq0hxzcG8hXwq
	U7KKQzdpMXRue6LREfNdszh/zJV/qhrDenr7e5sogMiv1PxZ4k1rBj0b
X-Gm-Gg: ASbGnctQXn3ZmwEyF3XbwiTu17Ox2yaiu05I1Psw35vLVQP31ZmJZbwE7dh4raBTG+R
	XBxDL459vw+o18fbC3AS9x9Endxg09tmQQpbdxWKs5cJA7zPuiFdvZP00npYfJw/VlOamQ0YCau
	mqJE4fmaNZeFVBbDZJ43rEGz9oPhalyd7kJVgNtzOMy0pWPo53L03mjlzzliUW1aVlsIqYUdg4H
	HeDIYRjW+bGOwL28maOAAyCHxruGaOT2FnwSPtspMrHXHkw096n+JRDNDXldDgUFlUmtlsYQMUw
	nXfEq7WBUnW5/Xm0aVjqaXZ5lbl2yWky0Sd1RT1ADiPGb2lOptVNdc/uEoYwCeizZ+IedsDL/jK
	N4DOwDAs5ztmNp2tQD61LGsB+sy3qTuhVBFe0boYFYwvSqliLYFKzjgzWST51riiz/4B9Qck8Ih
	q9PzLpkUBZRtn57QUE7tykXZ5rTXnTcc3R45NJRCr+GD1aKYVliXRGEBeqWX/D2zxho9XgM6YNw
	Kl2Sze3HLb0X4rinxY=
X-Google-Smtp-Source: AGHT+IG/CUbYBy7X/vSgOAn0DUmr39OaqXkpQeM8jQZ3Ml0Ear6KLmAFRVmA1pO8xdVrK+XORTR7qA==
X-Received: by 2002:a17:90b:3b45:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-343f9edf47dmr2009966a91.14.1763096361610;
        Thu, 13 Nov 2025 20:59:21 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1061189b3a.53.2025.11.13.20.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:59:21 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/4] nvmet-tcp: Don't free SQ on authentication success
Date: Fri, 14 Nov 2025 14:58:48 +1000
Message-ID: <20251114045850.1898865-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114045850.1898865-1-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_205922_492266_5135FE2A 
X-CRM114-Status: GOOD (  13.67  )
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
---
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


