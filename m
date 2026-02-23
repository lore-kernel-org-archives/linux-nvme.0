Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD12EC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P90vw/KWtem1WCNNgNpg1BwJkR7vXWZPVCTvb7IRCEA=; b=IZ3YXaVcYPgMVI4RpSNzAuGVGB
	bt2PfAseBG3G4rAWjWYs3b+fL3eeogEAtz/lpsIganf7axXQ865w2wkOhBxOzkh3sdkqlF61cWE/A
	qYQKw7i1O6OhvfM5ZzpPHXDuOJpzDnnJ7I7SYrpc12osxXQhemYH1paO+38yj6HfRfF5KbH1NMjXM
	WqgeAIhiSYRnqe117zsjzTjemX4NRftuYlQlORUiGQqVKeysc6mWLhLU0N+iIHpO0kFVc13I5tPgl
	/Ao+kel6oVLLgwjIC9n1Vn4k+aVC1CPD2/br12XxqTOPS5WZAp31u/Rr/Cp84AO2GTfS3mPsd61WG
	1ssJerbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZe9-00000000lbZ-1QPp;
	Mon, 23 Feb 2026 17:23:01 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZe6-00000000las-2Vjg
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:22:59 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so1086928a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867378; x=1772472178; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P90vw/KWtem1WCNNgNpg1BwJkR7vXWZPVCTvb7IRCEA=;
        b=SzD7l9j4JsG0DhqkdgSZyCZlFSGcZjGn6MFh1TmD82QIESg7X0p1NCfxX/DXFnB2Ca
         ogENd7jDjW2IJojqkXdfx7nhgjP4ApnGOie4cBhqg/liyFEQG6zD5A5Dx6prQxjA8k33
         ttuSv244GRGVAYiFehXVUWX+y9iY8zfEEkf9YtEZulAIlZOKPV3rNHNeLea0vUy3uGau
         d9q5SDzOdcgh0WV55mZ+r/SeQTk4qaQAYUK9PpgORsGLWx5/DLIj0EmceXa9eybQd6V7
         8nPhHWAvZCpC5lhZ6SVUCZcyaEddHLnlF/P3VQYELu0XsnorxnSARwmcemfPHfTvSOOB
         UzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867378; x=1772472178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P90vw/KWtem1WCNNgNpg1BwJkR7vXWZPVCTvb7IRCEA=;
        b=aS+xeGKfQi1+k62ikHQLnPVbvMFPHX5WEQf6wCb5v6qUjACZOsXqPp5x3lZk9P3FjQ
         wE5tgu0PAVa9jksXtJFlbmM7+CqZEvqJ75vWBgp0/88INYtx1KTAMEyokU4S3jd2RSHn
         iwWk0TTZCaokrRnuJSu8Sf6VNAs77aA+70IhGk4BJ2IlnyMSLyFwlfOJWGFEsGnuXfrY
         +IP8hA74YI0kpazJiBKXM9i3wCm08idsDFPVajsdDtXn5mgOsBN+TZ4NSGmWpP4LON6b
         vvM9IdU+hhWoP0wmFcHLe71j7hxy7D42RdOmu2WFJMiU76UH3WDBlkPoJIipyy2qMucP
         EoVA==
X-Gm-Message-State: AOJu0YxAlnfO5C692Zy+J0kFe8ySyr3sMKLqIg98fjD5o5DkU8uBzTHq
	Rw8jwQvQnW6nRL9r54ESdMqSpyUzKrx0LGdywra8mNxVqxMqmFD21vOAcJJEuNsoMyM=
X-Gm-Gg: AZuq6aJJtDcOCFVng9fx64RYqezpfKL0EUIaDkz1OwSnbgG3AV5Njnt9gOdbPygmri7
	msKEYpA/IlQgJfCM2X2akkiZvmhYsIp9fDYZ81kshWyDHipgvFTmeLVIpEcjbBjigGg9xra0dQ1
	fZGHcr+PF0TkM+TmEvw+mjsYhh+f+Trken7GeMC/jGDHCme5MVEEsBZjDoafKud0XGl5McRKcyZ
	wNgnC6PPJINqMSsjlSoWaWHdXYLbc5TBQ5LmNd7tVI0xwd6hhFmVyMo2fIwCQBbCfd3xFH+/1O9
	jnqycBH71T5XEc97Zqzj7KF8oOA4rkbT83/i/aINMfz3r8Imgf1UAqdiFEOQ8ewJ833t9Ghxp1f
	F8gX/mhyncPOv5FNCcFemuijr7sc+bB7qca5aaGquluU4zXMZe8bZs1N7eaUy5SMvOS74r5IhJs
	W1i/ZL618MQvFZpJnf0PzKvrVJQbJCmtE=
X-Received: by 2002:a05:6a20:1595:b0:393:73e5:7404 with SMTP id adf61e73a8af0-39545f88f2bmr8621279637.52.1771867377615;
        Mon, 23 Feb 2026 09:22:57 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7269771sm7942918a12.30.2026.02.23.09.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:22:57 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.10.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:52:40 +0530
Message-Id: <20260223172241.291649-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092258_639917_E304164A 
X-CRM114-Status: GOOD (  11.85  )
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

This reverts commit 3d78e8e01251da032a5f7cbc9728e4ab1a5a5464.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Revert this commit so the correct fix can be applied.

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index db905c30fbc6..31a9ae0eb2a7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3259,6 +3259,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3322,7 +3323,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


