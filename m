Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E8CD10372
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+I4ImapQBrzyuEizr600XxZNr5XxxSLizDI0ARnZn/M=; b=EY3OGP6SkZes6O4d09bXHFuset
	FDy00aTklsBi3nAwV2gz/npUCezeYpK4YcbHMb2a7FpxeqyVd8mJTIbwyR+w9D2vZ7piCHZz+E44f
	nrAH6BM1vPynC+J1x3Cv+7x5WblMJBtEm7kpCKOKt+tcDXrcTX7lkkEDJRLQsKyk8kUKiqjmzVyaW
	qrX2qR7wpl91U9nDDzr7afflI1R5cIq3Pzunaf9PYljd4njBG5xEDAbrtyhFVzvdvwX7s3sdHa/b4
	WioUH5JMUJIxneHnQ9TaqNea7zdeqkFiA6IgOw2un39IuH+QRbWD0osPZMiJA1UIwC3l9o3Mt4bEB
	0CQUWeAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52D-0000000EDTI-42IG;
	Wed, 26 Nov 2025 02:13:33 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO528-0000000EDNP-1M4L
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:29 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7b9387df58cso9775129b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123208; x=1764728008; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I4ImapQBrzyuEizr600XxZNr5XxxSLizDI0ARnZn/M=;
        b=bBf2kQcpoMrrka7ZHoP3u2qLtRz4nHEU8Lx3KCE64lyoYFVe+mp4FFyH+6XFdy1zSp
         ion8yFWENwqKTjMC7UHh6b3461OwF+3pX52AWWOQVnMGlQWW9KOTqHFIgQcGpCvWpNar
         UeNlcEMyosr+drJc4mnrhZpuMOX/JOMbxYx6GFpoH2ER6S1Cb8Y7XH1lwOxwFj0euAT4
         QW/ImL4zeLLGiy0DABFi7xg6fggnChhZ+mEYAR/ZQQc08uk6HwuyrsdcUcncpjMztDRw
         jAzL+N+KPvXev57az8kd2UAc0YAfIEziNOT7iEJxVNhkSoRk3zyt1OKO5rMo0E7YuUdx
         8Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123208; x=1764728008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+I4ImapQBrzyuEizr600XxZNr5XxxSLizDI0ARnZn/M=;
        b=YHwdoalqw++m8nSh457kqQFgK6NBsyHtGGfMw7g2ziN7fwzwySBA/SmTK6PizM2PM3
         thtvbORtkc/I6E6jsRRSCwUNc9H02Zi5l0sqxbhSd4NrpnC/9tEJXQGHjWZMM9VA+3Fw
         sOO2nYX4H89JaAs6vIiVkSV29angWRNhmJ/aQxxXi8T9tKCk44vWq5Ysb09xgAKf16NW
         XSlsLgrsvBKUJpO9sVKSed6pZzg+AIfwBItBlT9cAtUT/tNoKrIP3qQom3ihTs8ciPXx
         BtKDunM24DHj16uwO/AjO2KANniAH29v66kRJEvp78eucR8BZ7rHRYdFOL5VoRNk1vjN
         NGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1SaOxQXbfluhB1IGlZTxYcbyuWcVu70H1SuDW+RjoOvlZOAs8f/3QokdND+IHY+uynhD9/pQUUuFI@lists.infradead.org
X-Gm-Message-State: AOJu0YxE2z64iY6Bpujck2HJ4B/WRsTUWxaXYdHht0248TWDQMl5rQzP
	XyJFpbA1c1R/RjC0SuT8Lvf71FZ4RD0XouJkWMMUThDrfXAAallYEhH2cq2sAL9ecQU=
X-Gm-Gg: ASbGncuhzpd6DiEShyDucdHJs+vAN7zoAFrItH+ym8ZNvSZNue55Aj/GocEOaH4dVwr
	djUYIso6ZBvPARGsbw4R015QDFAxm9RVNwczuVx6i/gPTN/eeA4MK/SFpXFaXqTuPoqpIeBNC6+
	wIOQSBOs74L0nHB/Fidai72Got4yOIAYWNFqJcz4F2zGKosuhcnXHVYU8C+tmyg4wwvC6LhEd51
	grtl90KiBFIbBQ1OWJEAi9NQ4Srlvg7f65iPt0bPbtJMlmbacVUyJBk5taLXyB6S4aIjACsFuuU
	XTpiXtRfu09Li5F28v9gS+J9abhlMsttA+u5qKDPRYxMEmS/+TpyPFTWFBzxXKrBJJErTciN39e
	CFeOBY3VTZAPNWdKdO0PAKk8wZq08T7vvA89GSo0NVFSn8mnEqnlKLNUSFE0pb1sb5kC85VreMh
	lMfQvsLLh1+BEYhbfKMioFrLLfHRwV2Yj9ng==
X-Google-Smtp-Source: AGHT+IFUalrTLmoXcAJDo3arJsqQ+UxGMbo4/XplRRBL96NzTQ9qPQ+9cU3UaRbqugcq/gua0Spoww==
X-Received: by 2002:a05:7022:3d08:b0:11b:9386:7ecf with SMTP id a92af1059eb24-11cbba59308mr4282110c88.44.1764123207411;
        Tue, 25 Nov 2025 18:13:27 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:27 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
Date: Tue, 25 Nov 2025 18:11:54 -0800
Message-ID: <20251126021250.2583630-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181328_365731_EAA0D93F 
X-CRM114-Status: GOOD (  18.10  )
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

Add NVME_CTRL_RECOVERING as a new controller state to be used when
impacted controller is being recovered. A LIVE controller enters
RECOVERING state when an IO error is encountered. While recovering
inflight IOs will not be canceled if they timeout. These IOs will be
canceled after recovery finishes. Also, while recovering a controller
can not be reset or deleted. This is intentional because reset or delete
will result in canceling inflight IOs. When recovery finishes, the
impacted controller transitions from RECOVERING state to RESETTING state.
Reset codepath takes care of queues teardown and inflight requests
cancellation.

Note, there is no transition from RECOVERING to RESETTING added to
nvme_change_ctrl_state(). The reason is that user should not be allowed
to reset or delete a controller that is being recovered.

Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
about to schedule delayed work for time based recovery.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  | 10 ++++++++++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aa007a7b9606..f5b84bc327d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -574,6 +574,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_RECOVERING:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
+			changed = true;
+			fallthrough;
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_RESETTING:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
@@ -761,6 +770,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
 	    state != NVME_CTRL_DEAD &&
+	    state != NVME_CTRL_RECOVERING &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5195a9abfadf..cde427353e0a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,7 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_RECOVERING,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
@@ -275,6 +276,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 	NVME_CTRL_FROZEN		= 6,
+	NVME_CTRL_RECOVERED		= 7,
 };
 
 struct nvme_ctrl {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ae36249ad61e..55f907fb6c86 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -443,6 +443,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_RECOVERING]	= "recovering",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
-- 
2.51.2


