Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008D606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lDfMCmf7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvFpqett
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GbH9hEkRxL7poVnfKttfcF7GkxvjJPt+uCTzdn29ebA=; b=lDfMCmf70E9qad
	Qnq9PVsuGTAETIzFJejuTGWBx7dORBbssrRdFL/qxsEwQZe1hV2NW5LUzKO5TjBxPT538SAb2JZTA
	1DEK9ZtHfSiTfARzFzX/ttzPXKWuOCiZgtAWZ1wDHRzG39Kc586P3fpISIQVvAUAE7yzfi35y4FnA
	Hb8wMoCQWeLV9KbhXZaNwBcnukr2f16l5JHum4Pd/R/4xy3oe+dHWObuTDfxxKzTP3aT3mrnBHGBT
	cH+kn3ZRDmhnw2B1TrbdStTOXFz4G+qMM9Q9ZePEFN4EWDMJrLr7E5pGUjZjZq/vO2mQrky+xnfbH
	Bv9ZJb1LybpQ6cDcg0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQJ1-00000000wEW-44OB;
	Mon, 09 Nov 2026 14:25:07 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQIx-00000000wE5-3Wf0
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 14:25:06 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36a315ed211so1058098eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794234303; x=1794839103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbH9hEkRxL7poVnfKttfcF7GkxvjJPt+uCTzdn29ebA=;
        b=VvFpqettVSO8Yl2eSD/zcxpnURYofVIKli/Tn+7Gw6cG4z+yKQTbx7oEZmrLDvoxNn
         Hul22xN1rs9OFJOqyN7D+oOLEOU946yinhMtMoFCsNXXZM2r18oEMFkxVzbZDVoMqkdN
         zFaXxoBNeH8vrNlzvKxjg/CR3NQ0jpfZa2z9HNDYd5ByLMNgx3ojq7Oz9fnhWocwvQFu
         iCFMoxDOvOM0bdgzIiPlC0NrtSsyB6ITwMORIB8bnOIsNMfGkmLzL87ZZ59V+Cb7etR3
         A6r59A4s+YrVt1Idti4/WyE+Uac/XhmU/r26vvNd3oOeNNdufdrppJbaO4noaEpCpDfu
         pLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234303; x=1794839103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GbH9hEkRxL7poVnfKttfcF7GkxvjJPt+uCTzdn29ebA=;
        b=tiIJNPi1TT2VXhdOzNsxx39BUCq+5GyQQFdhgELIKgQHJ06ZfkzPBVfN7S97l6Fxyb
         XY2UjSfNg4wOfcAI4v4Xrvw2Z5YqnmBzJX1L+ZQri05MF92YQEHE3xKxNIhmPpGw805l
         fJNqwdEmtQ6M96ElOZmeGFtM4M7clkSXC1ASPCWBBDx1IswPXnnKjOOIQkBqc6Nkqsu2
         t8ezG/eLuSVVc3yEIQZzVLI4lRN+51Fm+FpARQL9aHdHDyhyhNVTQmyYKbVXYu+cPxer
         9m4QyqaIbC/N2ZvUzfpjGuDrwTGN1QHudMOTAlmS15y/WwAEr3RYc5OkryelRMbXRm3+
         2ArQ==
X-Forwarded-Encrypted: i=1; AL+hErGgN2rPrt28orx5TfTmPDfaDpQHI+b+ri9B1mKZWQ1+TmFvx5oXfxuPvhVxvkAd12XqhLVN1rDxpfjf@lists.infradead.org
X-Gm-Message-State: APuU4Z8jY8tbw9x6JaqQIscXgpgZU+h41KzMjq5IOsuNYdyTYDSTVhRh
	TComkOTglTOPLdOEJcQvyWUrb1HIWTUS+eah9q0ej2MlTclFA442WS1H
X-Gm-Gg: AYBFou3ZCpWReFy/PiLwtP3og5T/gByapPTB+4x9s/MY24DfiRd2ziwDegohdISd3Wi
	hbZ8HUH4XQGYfcJuyb2XCJ2YYq6XC+iZBhGA/4t6p7+TMkzWEfFgNGsx+l0YLhEMkHu7ZxqsHud
	AnAJW9PBStUKmsDgiImR9Wif/G3qlnnzs8rmGFm/N1XrThEIcJDLGtqUnc5DlcFUWbUQnXryLp0
	JhnceUz1FSFYRjR2HuwQYNwHZitWDX2dzjtvNiL6PlTxLte8fKn2L9qorSzwTV0RSX2p0X08HGv
	ZlA2aiNJRuUKcNi5wmrTJwJl1JYJfKGFtBdaFnL2LxiuqcRCoh9c/sjIZ5sxXkMScfmbJ9f2sVw
	HOqh9I9yzzdoxiuHO9D0NZ/nL2dHxohSVdvLDFft/GAIzcRCVQdlH1zraT2aGmZ+ni4iy7NoZrd
	ZzvpLPPbasdOkhHklD5BQ8Ln/UGk1u3AY4zYbp8nZLKe14hl0uMIsxpCQJBS5pV6ZoZ6dTGbMuE
	NdV1Zpr+dLSX5g6qp67sbWsgArESsz98bPINixNdhhaSO5ChC97UnV8w7QMZ4rAyQ9gmwCEj8ZI
	lcmuit2iQC1/1D0s0hPi5BCKuB13VI3aCKWAt1GsX/RN/U2qVw==
X-Received: by 2002:a05:7301:dc1:b0:362:2e2f:c261 with SMTP id 5a478bee46e88-370f8269e2cmr10965596eec.27.1794234301815;
        Mon, 09 Nov 2026 06:25:01 -0800 (PST)
Received: from localhost.localdomain ([103.170.54.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm16138027eec.21.2026.11.09.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:25:01 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com
Cc: hare@kernel.org,
	hare@suse.de,
	hch@lst.de,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH v2] nvmet: reject invalid write-protect feature values
Date: Mon,  9 Nov 2026 14:24:28 +0000
Message-ID: <20261109142428.2612-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
References: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_062505_381435_582D1BF0 
X-CRM114-Status: GOOD (  10.99  )
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

Fixes: 3a1f7c79ae6d ("nvmet: make nvmet_find_namespace() req based")
Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v2:
 - Add Fixes trailer

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


