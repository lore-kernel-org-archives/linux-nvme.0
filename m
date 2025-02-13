Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A2C02198
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6lEHVr3W6APInv1drXj4r8z2ZhlFNN3qSpXoQZdDfIc=; b=ej0NoC5BbWT0D07VzmZmbZN22A
	kaOak0b7xLgkiTE8gSt3fvY19QkRgF0pvdZhoNezzAtCLAUOMAkf0OlyRmqlaXwgXJrAKPhUoX6/4
	6UGHV1IirqupFxkD53uhVf5aQNwcbdT7lURUo6NcqZ2lp7QAUcFtIYlDybbfT6NC/wbCSiA9XFETg
	vsWsSSdo4Ig+Uv23gWYZGG/FVXUxQwX4qF4nYZlvcnfGm0Eu/beLBX5ZZC7WAXDGtVAxV6VWjZ8pJ
	IK3qPnmWNhqFz/NY/Mg1RDlrzbRjXHENDql0G4eCjV3f1bdZRVfw4XL3SniKgsrp6BCDMMNc1POJ3
	bamy8zrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiNjv-00000009LsN-218n;
	Thu, 13 Feb 2025 01:10:03 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiNjs-00000009Lri-3ruT
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 01:10:02 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-220cd9959f6so729785ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2025 17:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739408999; x=1740013799; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lEHVr3W6APInv1drXj4r8z2ZhlFNN3qSpXoQZdDfIc=;
        b=MSbTCSCY7QkC2jwBaO7Wz5DQlZ67Vtcd2fA1zcO3S6NsWv/qwVHY/nyHAqEKIBlhNi
         d8m9KRlNJYBQQk2GscQdPNfkxPxHfQfwZ3wFX6AAz5amr5uJCmc68zCSwv39eTjT8p8G
         yDn5+mylw0dJ1/I4m3KRzSMfnVr+KZ4fvdEu87uEOitLC2ugcLdj6qtwdnDGDxgSA5Hp
         ejosnXXJFgeo+M9CSGZObycM2vH50ebCoMqYD92+rsOOWZuhTwFh8ijtcksrYRjRL5jo
         0oJWez5RkNRy+gtTfbo2l0cCe9lu+/fijQeYjpa1VuSM/V83FYiBg9+HKtRugzan1/RA
         SrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408999; x=1740013799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lEHVr3W6APInv1drXj4r8z2ZhlFNN3qSpXoQZdDfIc=;
        b=aHk1A9LE82oMefvRa3ccH3c2X2HSNz1zHpaknmmrD9HU7yV7V2zafYcr19wpPPBlfM
         Du2ytJif0TOGlj+dx1O3TjCF3XPYioS4uegu+gOm/FoC6o889knmjPvFyi4sen0nw6jK
         Tan1M2FMu13Vaivam1NxgAQ37Rw0apIvjlAzo4QGKIuSGn4ND7bLjpjs+k8RSjojuORg
         mVGdv4Txm5R0Yi7BlD5s4wes/OMSJTZO/r3RiakaoZfXQTzgzvsKlVZQaQhqSgZO5cyw
         UU8s82p+SnzsbxNUX1IuoY3ODf6ndyeF+vATGmjWuSZQrnak1VqX4jgTJAkeB7AM9rz3
         NgCw==
X-Forwarded-Encrypted: i=1; AJvYcCXd7TrXIHwqkoDRaFYcGkHC0cqOpfHzchd8MIEIkQolva7+5J77UriUwdT3dizI68wvfMvcb5xa1Ize@lists.infradead.org
X-Gm-Message-State: AOJu0YyEnG2Mexy0sRw+La6OOn5wXXMLRp6AzsQIhUXVFkSnHuaKDFbi
	XouAdzYGheg7OcqZ7VJ3S4t0IGUKej5M6j2TCk4ijkDrh/YE6s50LcdeZP2WteNPG5qThuAVsyI
	PAyeSkKNuk7dDY0UB+XhMj4k4MCxjau3FRcOPkLB8cRscdCNn
X-Gm-Gg: ASbGncvojF7xVi2yPTcJXE7EG+URD01sTzMPNnm9EOLzY38H33otplaVuovWDpFUzCt
	azFQnyH65fMWWkXz3+5m7mUFsz5l8SL9owZQ84FvWJt4By+EFN5/x+Ldw0e6LA5AO0OIPvnDHmo
	MKjAAm7L0q4jN6f7lSDYpWb480iwLLGRZYsRw2pwejM7rSJ9mwMy2vZ1WY1JSdXlZtP5l20j6TM
	yjPqdEXZ2Sgz1KmIM+Vx5yL0/xxt+EPEe5lr9vRVlgem8PeGzJ4H4tZDi3bCpbflEEQnSmi3OGN
	++dMEjR6Dc5fo9d9aI+uJuw=
X-Google-Smtp-Source: AGHT+IGga4iLa/voNvhVVA3XMQq1F6Dvcpfeu03mzatdk47G4UcQP1RYPghKpXW8H/XZ9t2Pyd/qCCgRHM19
X-Received: by 2002:a17:903:234a:b0:21f:b7f5:ee58 with SMTP id d9443c01a7336-220bbf33c58mr31451305ad.4.1739408999533;
        Wed, 12 Feb 2025 17:09:59 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d5429559sm159495ad.112.2025.02.12.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:09:59 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CDF103400F6;
	Wed, 12 Feb 2025 18:09:58 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C2AF6E416E5; Wed, 12 Feb 2025 18:09:28 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme/ioctl: add missing space in err message
Date: Wed, 12 Feb 2025 18:09:16 -0700
Message-ID: <20250213010917.3816029-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_171001_102529_6CEE5B5E 
X-CRM114-Status: GOOD (  13.38  )
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

nvme_validate_passthru_nsid() logs an err message whose format string is
split over 2 lines. There is a missing space between the two pieces,
resulting in log lines like "... does not match nsid (1)of namespace".
Add the missing space between ")" and "of".

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e7d4b5493a2d ("nvme: factor out a nvme_validate_passthru_nsid helper")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847a..406c1592dd7c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -281,11 +281,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
+			"%s: nsid (%u) in cmd does not match nsid (%u) "
 			"of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
 
-- 
2.45.2


