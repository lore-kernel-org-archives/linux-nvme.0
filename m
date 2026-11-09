Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F0606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pkhIIuIe;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGrai2Cb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=RHv3gURbuO2W+jg43SVbmYLuoiZHrEg+KszD86+zH04=; b=pkhIIuIegSSLDjuhqi2pbeiIXy
	IMITEiWFScC7ROnOykO3wWTs029uZkv3jc5nhHVIAcMS4UkRk7wRauDjVtkHpQiCj0ZjjbFbHM1YV
	OepedWuDK0ec7a9PeQZPa1g7ANM0bITrDsv9jyUc9MnzAauR6BrhesCPXyjfwj8pzCx9AmQZgTNqU
	biH1zLsNyOj/Zv38UHJ4MEwwhe13lsb9e/DNTV2x1YANJqAqlKsDkDhwLx422h7WPqARR6GnUJ3LN
	sckQiiT+Zo6Xo5Bl7RYTcfZT2kO3T87vrWkN6mK6Wfk3FurVNse/zQmv40xyXOALkSk5Ay5KbgVVQ
	GKsm8AkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQPr4-00000000tiq-3Vzv;
	Mon, 09 Nov 2026 13:56:14 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQPr1-00000000tiV-3JA5
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 13:56:13 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1614292c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232570; x=1794837370; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RHv3gURbuO2W+jg43SVbmYLuoiZHrEg+KszD86+zH04=;
        b=sGrai2CbmFcMOzHu677dKV2cE5fH6ukBkMZovelEpToWRk+2Ws9fnk/h+ANki3QimA
         qkbvDJXTDgXeeS+qZAqiUCTz22qxgENwuSxjMd2gQWt6YE4+qyk7sTkeLYTVjOUfcRPe
         CYHwgcmsAmv95i9MnrXvEURGxQB3g4J3qxPluYw+KGkazhBK+hes9UDQ2RT6SvFKlCw/
         gNSLGffajEuXxrRHcKAqskixMNdR04p0s7abHBdXrJYl0ohsmG8Rfq2ue20+nRWF7Dkb
         ESlRB2tmgUDizsO5EdBQFC/iWzPGN+rOstTPigKznJqozGkpB28tCIg4apuspIZ4fIxP
         5y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232570; x=1794837370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RHv3gURbuO2W+jg43SVbmYLuoiZHrEg+KszD86+zH04=;
        b=PZMFN8y1/VOsKxBDEzfU3DvSHPjgPWueESztvDdMcw23PiZ7t9VQuoJ5Qmxs8cZwex
         82pKVbwDTrVIfQ8Gx3Q3XziB5ABusBRK/BIFMestxCvBSjKrJGUuotS7jfam3iIZm3GB
         OBTh6wsLs42/z56CQqd/m+6CzCClXanJS7fNuGpDyxwPpAfIXiWXcicvO2DNhCDtVU9H
         xTuYqDeBshasFSeaWOYxjsYIpFxzIyuYHGFHPhxYW1xSYK67j8BTc9mUCrFWFxIbNks5
         BSrQqQ07zH66G+0wnrGcVntFvU3jEjT2FiLCEtCnk+Y0l+V5DBy43hELUYITJ8RrappN
         Wv4Q==
X-Forwarded-Encrypted: i=1; AL+hErF9uqB/0ByPBF4Nk+4Ja/v2exL4oXzEaCbdoayTOYDraHnJY1tLlBLIpZa0eLszhhR92+ns2hZeC4+6@lists.infradead.org
X-Gm-Message-State: APuU4Z/YXUAhgEeuK6IX3Yw/h492/9QW2oeqvLJHRrgV7gsleg4xNf04
	cdNHEDsprUbdeK9PzgfN4zMH0tvNzC3mIrNHKGQQcCZN1jwKnh6b+h4p
X-Gm-Gg: AYBFou111u/lk3Wolbsx6+ITiV649qOtitbd1+OnQZUnGcp20PhvkSxkJWGCT1/evDj
	wsVi5PRr0PqNzfRgWyJT6MWSu20DS7C20iiluYOyT9lcBJWEtgYJQx5Pbpbm/HTHxB0e6p13ryb
	S84PiKTP5FZIC+eGQUQDYShcOyivVnUMtuu+HiKXVTvdqKXWM/L6sGf3kcCZkf0yYdwpEXRoTkS
	XOZ6gH1TQSkQIuYWa840Kwx6r83rrYVSPkmoR2hbFIGvLpQUQ8G7/bW6C69H1+ACKh3ADm0Dmf6
	g7Daq7+C6zFtdKrg9hO+tP7G4wEFjQMsyygtRBtRfAqP8IkHBGqb21IbPMymsizwnOyCsvpb/DD
	zpItDHDH0GQs2JxBU16ajqmHwjRxPkzAmWCwihTPDg7Gf4ip3q71tB6SOc750rzs/CFb/ZdMwEb
	3PvDxqCIai+WhgBQqWN+kwr1bPmdt2107LbvQ4my0UrA6uNFhCDYQz0tqC6i5skBFlXEYogaRY+
	CsDuE6LO9Alhw3TpxXuPqSRFzEJ3Aw1rJMMFVGYwrEmI7ap1g+4w0zN2naDBkwkE2ORAxsDlnKH
	merjuyD2uKYe8qQYnFZLLu31BqECPvABBJYKVW12fQ/L38Oubw==
X-Received: by 2002:a05:7301:f10:b0:36e:a11a:b2f1 with SMTP id 5a478bee46e88-372573cd51dmr7024741eec.30.1794232570369;
        Mon, 09 Nov 2026 05:56:10 -0800 (PST)
Received: from localhost.localdomain ([103.170.54.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm21677471eec.28.2026.11.09.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:56:09 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org,
	hare@kernel.org,
	hare@suse.de,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] nvmet: reject invalid write-protect feature values
Date: Mon,  9 Nov 2026 13:55:36 +0000
Message-ID: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_055611_829159_CA46E2DD 
X-CRM114-Status: GOOD (  10.66  )
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

The Set Features handler for namespace write protection currently
accepts unsupported values. The default case in the write-protect
switch leaves the status unchanged, causing the command to return
success even though no valid setting was applied.

Return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR for unsupported
values. This also prevents issuing a namespace-change notification
for an invalid request.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f12d83098644..ee8be237485e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1223,6 +1223,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 		status = 0;
 		break;
 	default:
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
-- 
2.55.0


