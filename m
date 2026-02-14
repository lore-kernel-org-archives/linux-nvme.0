Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE7EF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5ZA7/tV4zDqNdP5WkUsqXWJkCvvpgg6msvp7dtPWuI=; b=fUlczTDROlpmVVG05aYv05rIvt
	EoDvsnz2ppdhmukY7oHM2y8NLMa1crU/Esp8nS8+WLLIBgA0bcLLUGCWW1y0wZYelMqLKoioo7Ypp
	uHxA4bDGUespH7FYvpStHTCPXTNV2dalwHhiBc9EBbrAISRV4eTr+NP6dM4ANQucHZ5DN3pUC0x00
	wfKR074SZ6cn3+p2bPDMBM0ZPQpAj/40rTkwAqF5ZIy6JxCYeNr6FOVoDwQ0m/VKkCr9SKdKojI6p
	PW/7d4WpiLMsVY2K0N764NhKoarFQ2uvpHG2PA9/rdgsPiUFI1y+DWGbZepLVp9S35wVY83k9PVEl
	/OQ9Pg/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gz-00000004FYi-24dR;
	Sat, 14 Feb 2026 04:28:51 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gm-00000004FD1-3EMJ
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:38 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-12721cd256bso2118887c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043316; x=1771648116; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5ZA7/tV4zDqNdP5WkUsqXWJkCvvpgg6msvp7dtPWuI=;
        b=Uj26bBO4y2DC2h0Z3XDuk9esKjf5s4sbutnSup4hzQGI0Ju0QyM05wTsiDqLpZ/7sF
         3IRwaZovIx8PAZTDjBrOGMw3ejJatkVbT4NDHlyjnIAYvc6ge9ZnWNSLsXSc/3Z7STzi
         IgmqYncMhsiA6egktNW+Cbas5N25zWMXPx8POBU2BmLrhA9SITTSypQqhKVpqEgAt6PY
         bO+O7xMnlgqdOTtNyhG6DwCZ7+BkO3OD9T7sh3XhTtEjtlCygpmIfygGSf70eFO7zzQX
         iYM7pfoeZRhhkhQj02vc9ObIcMfID4tXV1v0weCa6USs/RjEObYpST03IKOuljyc7P0h
         W9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043316; x=1771648116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5ZA7/tV4zDqNdP5WkUsqXWJkCvvpgg6msvp7dtPWuI=;
        b=pyZ+d/hd7zMiaY5Hmv8ZR6AVD2wE2RzOl47JqnFbfL2ItOIzuPwkqdAFfjF54PSakO
         JnekUYaBSwZn3Tmbjyaw3gLsPxCEGtvEwleDsIpQDSDaJCKciNeX2Ri9k7AkmW2PGuwq
         i88I7mbYuSUlBeaRtkrZnEtqRdP30tk9QZhF3qEhqimHe9PiSOZgnZQYnrjvTblNfD8l
         7DY6l5L1Z6d1ydR/68MkzXKaUUlKw+qS0xOtlwhCznXADQx/2SioI6QlFOAeNYkKxvQd
         V940WVmuglJ2T3fIudWzm08xPwCDAp/BG8Q7vGgWmc5r6rfg/bA62tLyjyg8byf9Bpkb
         kJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPpKiENpjPcBAh42b7nngkwgky9jIdH9eKAx01M0H5IZYbnedwrk4kg+iAQPq9+XegBkcB+RscxdE4@lists.infradead.org
X-Gm-Message-State: AOJu0YwWwKIMx1RYgvnp0HVdQHxcAeo5mH9gkIq5t88t0cU1heJuUX6T
	M8cqjcEVpeiw3bmTbO2U/BmOqbuqcKfWjegz+MR1GIyvVrDroJlKa9kYv0p/OL66HgQ=
X-Gm-Gg: AZuq6aIG/cyJAtvgdvT9YmAwR7Kfx3PVTxmDMtBkKS/Hm1sB5CsgG02lkHk7FL1ovab
	nHZwyo9Wa3tjF5AOK/GN1Lo0+/1mRqiAPMbXaR6n7EBXixzko7ItbMIJrJYdzErKfGX/lDAMZRZ
	vB8Jj3UA/S18SVDEFrSGoqzoksT/9Z7l0xb0QbnRH5ODCjYUz41tp4ujziC1Xu93ROwNvjE/vyP
	0Ec4RHwjsjgL2KWaqfrJPqsUuYM/laIYMYy/x1hpqa5w/zYH76ggTBLzciOotN9AFtUfeoqBbEa
	mrJ8vtcvjvo9MTWJjTBZaY+L89si6gwPDhdskI3GPi+oQNlFVCVf++vmQqsZaGmikBMjOHXMOxr
	pImagLFc0+efTKoGWFDNLNaxd/nJwD0NkUatJXgXAfEQLrynpRgcg3IDmf7ELTx2YfFkw/t158O
	Tx8FL0jZceLQDHVMtnIj4LOv037r5Nw2Oq9t4gGWRmuaQ1Bg==
X-Received: by 2002:a05:7022:662c:b0:11a:4ffb:9849 with SMTP id a92af1059eb24-12741b925d5mr742340c88.21.1771043315759;
        Fri, 13 Feb 2026 20:28:35 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:35 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to consider CQT
Date: Fri, 13 Feb 2026 20:25:19 -0800
Message-ID: <20260214042753.4073668-19-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202836_843168_CEC2002E 
X-CRM114-Status: GOOD (  13.00  )
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

TP8028 Rapid Path Failure Recovery does not define how much time the
host should wait for CCR operation to complete. It is reasonable to
assume that CCR operation can take up to ctrl->cqt. Update wait time for
CCR operation to be max(ctrl->cqt, ctrl->kato).

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0680d05900c1..ff479c0263ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
 	if (result & 0x01) /* Immediate Reset Successful */
 		goto out;
 
-	tmo = secs_to_jiffies(ictrl->kato);
+	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
 	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
 		ret = -ETIMEDOUT;
 		goto out;
-- 
2.52.0


