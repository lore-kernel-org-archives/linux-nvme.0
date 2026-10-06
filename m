Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3569FCA5FED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2026 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9XEy23Wuh2CC0adDPD2wxP8CV5aCTN0+vshsMj048aQ=; b=o6kBJ4sK6nih+6t/CSH3SZgLBP
	qeFki5XDF/bIB8I9CMTu3DniUvv5QVg7RoUJf4TBFQkdUSDCntToVwp26Dd1aD5eMpTbHG9qK0N1V
	aVNlR4D38on891PPuluqmWz3h7+1TysQ8nJ6lvqh5QY0MDcSE3RNum5SWdz+HjI/MR9OI2TPRhahO
	cLMErm80lcOhm1CaX8sxXBV2UgY6XPfiItTJ6JZJofDq9Mz2BrVKo+F7O6F2FYe0bzvZxxvmp+XQa
	dtblUC+yBdOPZLnziGinz7QdLquy8/sHWLdEcgeSAp+pFY4je8RDuDd4Nl/RXkBzEpJrLHjBV6BGl
	rMg/a4XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE5X2-00000000tUR-1320;
	Tue, 06 Oct 2026 13:48:36 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE5Wx-00000000tTG-02Nb
	for linux-nvme@lists.infradead.org;
	Tue, 06 Oct 2026 13:48:34 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc502d509c0so1089213a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791294509; x=1791899309; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XEy23Wuh2CC0adDPD2wxP8CV5aCTN0+vshsMj048aQ=;
        b=h7tKniiED3bODXLc6qMv6vpN69YoWYFO8Fzfkdx2lX5/ug4SFhdxlNhElyNmUTfwEO
         Jpl8zBgm9216i2GzAuXiZUBYFLrbY5Gpuy1sqfR1s7PyUUMesNECLx6Bk5DlUehM+EOT
         oVDu0yBx3zuSHjjcyoHmNyhA9BsV2j3b+02iu12eGuOuYfyE6P+m/V/bpeq6xtXbwbyu
         LbOETFPOaCQTm8mKvSkglU2DJbtIZm0HTkD8ytsunVticOZNTYXl7fyRhj8lcj+BuDQL
         4tgV/T47xesZ5SYxHDzVaVBU5snOjhCQ01goJR0eNj8pYm8J1nRLzQA4WsUJJPO8RT6t
         DUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294509; x=1791899309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XEy23Wuh2CC0adDPD2wxP8CV5aCTN0+vshsMj048aQ=;
        b=Xq05zmebEOHeJtsBg0LsB4Jc4nxod+OcU5Hf1X37jr2JlK8y9qN82Ca1wYy+FuOGu+
         C6ulcXL/NvQkeiePIKE3L9gy/06WsMhH5qXv/rwqaa1Tn7VspnCjm21zVuSqxiPXXQQ1
         g8y3CtasvTJJhTUjU5eLddKdM1EVihFGBQ+5XKLypGTBzGLaUGc/Jdf23+GN6q4YXlMW
         VFogyTjU1tr6hLPXTUXsKptDBZMWvW3GlUa8p/85ikVpfekhTv944eZmdLD0K1jOxFSN
         wBWFEaz1wqpMVGCrEblB2yLabo9U6FesvwCJhLHI9uuAQImoV+pya75GmXgEaAT7ubZX
         VYFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY/KsM+k19hZvzdOhmQXowYhjWIJoppD/fqAvl+wAM/uDjeAoXmdXWD5MdbbeNgZTfteY4DN3cF2nE@lists.infradead.org
X-Gm-Message-State: AFuF++lxf5JrGLHAMfAYQ9MXHevF6RkKVkKD7trCMDKKk0WcDL5Hc08a
	i10QqHQnOqeiQNAZZfBSEnscaxO14zhsBtf76dYROX6qtw/WdTTuSPgVJCcr818XJ5KgSodIJ7G
	sChMhIPg=
X-Gm-Gg: AYBFou120YFpK52eOY2DEcUALUdszy4/4ZnzsvAHsez3W1QFDW+bctUY9vo4sM+EMGH
	BEpbOaefUBoUQpVIJRBG5FVaFHRwCLHhuQkYZ07mmTEan4qMUDCyVOSvqRs3aZmhgQ4YTy6u136
	7DG8rDvOUaDnBM1q0X5KIBmqR+2RgPmwoK6H1XwZNL+9fBeXRdfmgGqVPb2oRB0+poLqjMOgA2f
	Ul2Gyll/HXoynz6r6T7zbtyaAFF5G0nBrTeEFtRIuvKpL4HCaIeR8/GU3Kg6I2UMxcMH0XrmB0e
	XcTHBD2JxwykP2GwQk8VCYGVrLV7ynsFbxtpJMa5WvRZQHEVohg7aFki5TvYoFBNxj3to4clanK
	jlcbkn63ljnSDO54j52AHFCyRUowfz8seoXD3yRF66KmYJw0/QDXmTS+Bm+WyGnB7fv/xP1cP/Q
	hkx4ZW550N8frsjVrdy+2cnNcQUEtH/gVEkP9zu6SgTCZbtA+3vIDpGnzNse/HAKTq+3xAx3fbr
	uJOObqNaOpskypRTD85Zw==
X-Received: by 2002:a05:6a21:6e0c:b0:3da:5eda:d167 with SMTP id adf61e73a8af0-3e0d698c618mr9754395637.5.1791294509614;
        Tue, 06 Oct 2026 06:48:29 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:a229:268f:9226:1ba3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ccf99acacb2sm1167538a12.22.2026.10.06.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:48:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-auth: fail when the controller does not authenticate itself
Date: Tue,  6 Oct 2026 22:48:05 +0900
Message-ID: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_064831_305402_8645CAAD 
X-CRM114-Status: GOOD (  20.30  )
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

nvme_auth_process_dhchap_success1() returns success as soon as the
controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
without looking at whether the host had asked the controller to
authenticate.  A host configured with a controller secret sends a
challenge in its reply, computes the expected controller response, and
sets chap->bi_directional; if the controller then answers with
rvalid = 0 the response is never compared, the host still sends
success2, and the queue is marked as authenticated.

A malicious or man-in-the-middle controller therefore only has to clear
one flag to turn the configured bidirectional authentication into a
one-way one, without holding any secret of its own.  The target side
already treats the mirror image of this as fatal: when the host supplied
a challenge but no controller key is configured, nvmet_auth_success1()
fails the authentication rather than answering with rvalid = 0.

Refuse the connection if the controller returns no response although
bidirectional authentication was requested.  chap->bi_directional is the
right condition rather than ctrl->ctrl_key, because secure concatenation
sends a challenge only to derive the PSK and deliberately clears
bi_directional; a one-way setup without a controller secret keeps
returning success as before.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Reproduced over an nvmet loop target modified to omit rvalid in its
SUCCESS1 (standing in for a controller that does not authenticate itself),
with the host configured for bidirectional authentication.  There is no
oops; this is an authentication-logic flaw, so the evidence is the host's
dmesg.

Unpatched, the host accepts the connection and never validates a controller
response (note the absence of any "controller authenticated" line):

  nvme nvme0: qid 0: authenticated with hash hmac(sha256) dhgroup null
  nvme nvme0: qid 0: authenticated
  nvme nvme0: new ctrl: "nqn.2026-10.test:authsubsys"

With the patch the same controller is refused:

  nvme nvme0: qid 0: controller did not authenticate
  nvme nvme0: qid 0: authentication failed, error -129

 drivers/nvme/host/auth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e55920642f2c1..cbb38935fa227 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -358,8 +358,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 nvme_auth_hmac_name(chap->hash_id),
 			 nvme_auth_dhgroup_name(chap->dhgroup_id));
 
-	if (!data->rvalid)
+	if (!data->rvalid) {
+		/*
+		 * The controller did not return a response.  If we asked it to
+		 * authenticate itself the session must not be used, otherwise
+		 * mutual authentication would silently degrade to one-way.
+		 */
+		if (chap->bi_directional) {
+			dev_warn(ctrl->device,
+				 "qid %d: controller did not authenticate\n",
+				 chap->qid);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+			return -ECONNREFUSED;
+		}
 		return 0;
+	}
 
 	/* Validate controller response */
 	if (crypto_memneq(chap->response, data->rval, data->hl)) {
-- 
2.43.0


