Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545BDF9EDDC
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+85+/qtKB8ggKITaU+CCZi9HH3+YeCpidOHYHuEZ04=; b=UgIuhr6nxi/+3JWIKaT8HaJNxP
	E8Te6TtmSq5dzGZsVSRbTwpltI7DAkBbIVeLcQs56AibvPsBMp/ZFvCGHQYeZ1hMRly6/9kTqHInq
	NRojM93jAp/x07kBcvLDo3rupK6RgHy20rNqmRLK7cTq9UEmeQ6i1LqRBN07Gpy9XumvPH+0R+tYh
	52BIkd9uEBAgZS9w48Ucw9tmmm2vf5faAlncjXRXBw7GXTU034n8gO9pXkRnavEZGbSLLoeNJjmHS
	cA+bYNpCaw1F9c6Cub0UTZYShOks9PMVDyInijlrBrtuqWQikYtoTStNvVpzOw9283rosAnqdFjwY
	DRKDuppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJS-0000000ALMB-3C4n;
	Wed, 22 Apr 2026 14:12:22 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJJ-0000000ALIq-29Vv
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 14:12:21 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82f8892d4d6so2403851b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867132; x=1777471932; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+85+/qtKB8ggKITaU+CCZi9HH3+YeCpidOHYHuEZ04=;
        b=fnj4PH5QqisvcrYxuPC+oKJDUzF9/cp/wN3HoUFaoJxVhqjdLoIggHHuILmOZau9EB
         tBb0Ykt47GtFGwjH8JQKRo4/eREy6w7OPRA/pN4NNu7L8JT+MUTOaDGy9PdsJ0zrtLPn
         jRE9i8FvMzaGZUixhXE9qtbAd3BMCqWhyiKO8Pmq9aFuyuXlMrAfMzl3PsrVRPnn3go8
         q0sHpBTvrGYuY7dzE2AlzffBqhgAzq/5xQMq4TuHc4UAGZLhNuq5ifDEKsR3ppb+w3Sc
         s+nGNyKLfLCPb13MguTddE6wQSEJCiNaerTDnlV9zw/DlEJBo/5ej66B/anE9YKgI8uS
         fysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867132; x=1777471932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+85+/qtKB8ggKITaU+CCZi9HH3+YeCpidOHYHuEZ04=;
        b=KndmhkwnEVmPpXnloP4JFhvZCzW4zv0wSIe+zpzUebQw+KtVBersXsEiHuLEy4ihdz
         mmqHGfxwWp9R2PfrtQGqoBV2y065UxIbvDftepghU3PyyAGWFSfBBOjtuloSl1UqkRoD
         fVf4DENyQ1RslCXFmQ6rNox+AwJ/6trWFLJxI7FkYSC3I1Qb4RkIbIEDc1+CPBpt0GVv
         dsG/0sKPCok2MxlxitucPb9aNp5/BU1UUf0e1snWTbp3Y9OIgaKvqOVMoBV//PdH3lhL
         eso01rTAJoFx+eB5FAulTUtj+g+ULcBrN5uwcNE0WnghbNj++HthXkie0Vh3nXIg7A81
         sIkA==
X-Gm-Message-State: AOJu0YyQ/EjxhHNbf6miq0k1d0rkgoq0HoKGX5lgXC31MOmyE0uJ9hB1
	SdWU/i8X5xRvsuxdoWmosZ8aA7jQbXvzKHHoDgSy/7NUDcVsu1pWumeX
X-Gm-Gg: AeBDietZmhUDcZg5GWe3//Q9Rg8Kheneomlqa3aBOHu9VX+QMrQX+1XNDapT3bUEEOM
	DxIldqoOFmoMaS+ecHnJZNX8fWVI1WOEq4umyXN3I+WcAfwnzRG7GaSYVIQymU1uWaF5goC0w6H
	RyXStsdHkNIiViL+dBAT9s3Uh2m98s2TEmVtzfztQPaO3JeQUNmNDwCcB9aU0N/mk7YJjHPVitt
	1khr0u2S4OMg695MFCaW41e48IsgIrzlT3SGSpM9dHNLKdXvehjExsnSifnDRcCH1Qc071FfNWb
	tLB85WJbywppAIfDMjEPtWQ4wuzYQ2Ez3RLu69zRLPGfgO79qFgySHRzYAxBoupTGbsi5CaaKNt
	65vcN0LWmfjOgaMzTeHOfPBMXfe3nvQalTUXqJQfGDQQPpaGdPj0nq/cnInqfoVYXTgNDU8P085
	yO0bUCAqK0Yb1oB2R/sFlAR5EGH4sDlKSV3UY7U9YVt+U0zOM=
X-Received: by 2002:a05:6a00:2d01:b0:827:28ba:ff00 with SMTP id d2e1a72fcca58-82f8c838ef9mr22454621b3a.18.1776867132429;
        Wed, 22 Apr 2026 07:12:12 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:5cdd:bd85:7f37:6252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm17974824b3a.60.2026.04.22.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:12:11 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2 2/2] nvme: initialize known effects to set ns_mgmt NCC and ns_attach NIC
Date: Wed, 22 Apr 2026 23:11:48 +0900
Message-ID: <20260422141159.10881-3-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260422141159.10881-1-ikegami.t@gmail.com>
References: <20260422141159.10881-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_071215_545273_7DE14F47 
X-CRM114-Status: GOOD (  12.03  )
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

This is to make sure scan_work done for the commands.
Since nvme_passthru_end called when effects set.
Also scan_work is flushed when NIC or NCC effects set.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f973d88c830..1ed1fc866f3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3448,8 +3448,10 @@ static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
 
 static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 {
-	struct nvme_effects_log	*log = ctrl->effects;
+	struct nvme_effects_log *log = ctrl->effects;
 
+	log->acs[nvme_admin_ns_mgmt] |= cpu_to_le32(NVME_CMD_EFFECTS_NCC);
+	log->acs[nvme_admin_ns_attach] |= cpu_to_le32(NVME_CMD_EFFECTS_NIC);
 	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
 						NVME_CMD_EFFECTS_NCC |
 						NVME_CMD_EFFECTS_CSE_MASK);
-- 
2.51.0


