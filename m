Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13578C624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LMuldKzRZKnRRVnCUZ2I1QR7ouYQcPdcuex/lnXCBdk=; b=25iDi/DHXTLuO1BILLthmyvmJ2
	QVfnP42HoC1+om+t6L9cHkQDm5RK9w1fXB6yP3lcoyCoFvusRKf7NIDCci9TLxYjJTuljsUTHslMg
	wbHXDSTK64St6I7fCsyA0Rj0SC5G1ehCjNN7MEYXJBZLVk7ZH9EmkP4fhzel0cy5O5Fu37B2EaV7x
	lBUl9PTsPRtL268jbQW4l34OcjTCqzoSafHo8AFJM9K9nrStQVBRiBHZCH0F9bFii2TDTXWTa3UV5
	1R82ErMHfrBYvkP21TqB8Vp+HaB8nzSvNtXwtLLop7octfuP0jVAdnlfxHJjUN6RSFqMGzT0alsLY
	Lgmi8f0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2S4x-00000001ood-1952;
	Fri, 04 Sep 2026 11:27:31 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2S4v-00000001ons-0Fpp
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 11:27:30 +0000
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-6b1b881a8e9so345120eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521248; x=1789126048; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMuldKzRZKnRRVnCUZ2I1QR7ouYQcPdcuex/lnXCBdk=;
        b=CQiBBOHhYVoDZhS0UMtMQ9JG7zuoedhor0Z+Ck8JyEca+1mrwsIdEAPYef4GOER100
         Mxm+OVOpBCvn+nlt8Uyto9/PX56byo5KfZRHi3vUPeM/DEUMM4+oIlC5cCskqsUQsK1M
         iPYWxrVrrPBfq9Zt1hKztMnPTSgwucGq1dPuqas2FbpKj5qhXCfwwWjrF9qnjpD8Hdz/
         sm8+KUFQmuU8j7NhQ4MIy4DjKj7CgeSaGdoGYWRmWwe1TTE85fBkh/vzDDpgjywTDlrs
         CdKa3xk4zNfcGOPtvGFs/aA2URo0r9Kb8ExX3RmmfhDibYPFBnbYdlDk/z9pVx6O4Sb/
         UNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521248; x=1789126048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMuldKzRZKnRRVnCUZ2I1QR7ouYQcPdcuex/lnXCBdk=;
        b=N+7zF2huAbhtqN935Sp7nMslbWiDvYvB0rZqLl4tzZNkyjA4POpqJCNYZciXvv1BRW
         CNa/lghME2U5B5wbqCAORoACIUI2zvwe78eTP7KqVdptChmOry9LZGgrZHoMaa16ID0g
         liP8eblcX5qMLWP52lEIqNdWaoCr+brZK5dmcHX+5Xgdn0s3x1/668mwPbbRT2ai2jtW
         yPW59RaRNtWtgqBOF+ScrsBnU7/YbYm1LY2ZrNGkV3srpyHutAdyvL7SXJy+s1qOFLGT
         w1pIDoErkE9xLhEWkzTwofJm9AKDw6QJhhCZk/R7UU8wcx7OTCSMntRbm6KVwDbqvMK6
         NiGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAMqptEFux4sVzt6yYC7dbWwi+ZHhGVdsEgfSum1TE2lfZct9uDG3Kat7FVcZTC9JTidzsS1F2V+WH@lists.infradead.org
X-Gm-Message-State: AFuF++nVSHEIFVbllpGVbejCmfOzR37BZCby2sQKTA0P9vdwHgjppdWE
	KqBYFlOmM50Il0cCoAf1ZiAnLQNguyC4nifOrvrMmDFQt+2giMsoieLb
X-Gm-Gg: AYBFou15seztgre7c30dzX+sbJ/dS6rya+RBpzVWrfkQgKBWW9vNC0vEa3EmgoOjvXr
	h1AuwMvn1zsi1UCCPyg4WkLASZuA0HwLfXeSu6XeZk98Arp8lQbEA9vsRUUdBjDN+mDzkYyNQaa
	tEsGT08GBfe3SrgHPyzE/ZBT/8cGUhAGnY6KvmsomIfudcaPBItXRMoWOFByYOqR5vlv+zDgkTq
	QD9VRjswycEv9LYlfMjnzA9ORgu8ZZGFM6fbUZN3EJ0ktiNioNv2lXbSoNe8O5risuXPXNR3ckJ
	tDWM0uY6rLOgs1s238jOd1fCLhdbKtWReoi+rMl0CVgxFChejr6qfGDclLWvQpjwKBrf/HnU9tM
	nuRtml+z/Xb7A9KeXDC+Ddj1sSYt6C0UXvPSWPuat6kw4NWbNN8InjR0ly+n0p4ad9tL1/Iyeyv
	lJsnPsaGT4iRQXoMdcRe7aA+xZ8tPnInzZeYpaK0PyjoCmcPMFrOl/zaMhsUcsYXLOfH3ho+aI0
	CN82/SKHxV6nBuHcGPaTgxhcw==
X-Received: by 2002:a05:6820:2217:b0:6b7:8396:f3c3 with SMTP id 006d021491bc7-6b78396f8dcmr1217555eaf.37.1788521247704;
        Fri, 04 Sep 2026 04:27:27 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm7037586eec.7.2026.09.04.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:27:27 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix typo "occuring" in comment
Date: Fri,  4 Sep 2026 16:57:21 +0530
Message-ID: <20260904112722.5618-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_042729_117514_FBDFE8A1 
X-CRM114-Status: GOOD (  14.22  )
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

Correct "occuring" to "occurring", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..4d931cb1162f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -773,7 +773,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->disk->private_data = head;
 
 	/*
-	 * We need to suppress the partition scan from occuring within the
+	 * We need to suppress the partition scan from occurring within the
 	 * controller's scan_work context. If a path error occurs here, the IO
 	 * will wait until a path becomes available or all paths are torn down,
 	 * but that action also occurs within scan_work, so it would deadlock.
-- 
2.48.1


