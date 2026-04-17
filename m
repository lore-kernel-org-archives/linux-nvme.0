Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE035F8E497
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EUBcOJvdzrg04mlLi/Lj3lm62FWLU6fMfvXH1a9ncMU=; b=1Hdg0aV4SUSZn3KOITv4W5VyzZ
	5e+VOsKXT7u6iaUdXbWfHEOFo3AfiKCNlEHZ+G+96t8tRgzwGuDMRMdvu03DHSlYvL7HBkBX1RulR
	12ubGSC/9XLhfzYBY3IK2ZtUJB/kr1Cx4togz5g8WqzlBwX71CFhsfgRzT7OJqh8xEitQhr/mCpE6
	I3DqYXVl2dQOS9eiZM9L0nqldomGyq1KGArHCegRyzn3YQdOASYYBwxh+bBYEt3HDAJ4snj3x0/yQ
	gV80rw87wDMuTZle7sX8A/mqbl8hoGhBqOOuXGvcolc/804aEkp60effOmydM1RKFOIn3b96B8M4g
	DZqXNo7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXNl-00000003F8D-3vJe;
	Fri, 17 Apr 2026 00:48:29 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXNj-00000003F7n-0eNZ
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 00:48:28 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso117327a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386906; x=1776991706; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUBcOJvdzrg04mlLi/Lj3lm62FWLU6fMfvXH1a9ncMU=;
        b=RMVm1zg0aBYIQV6FquXG9xzKILfS8y4hGNB7eZadLifm2SCwE9UrZX6sjJjugMwhaL
         MXiqJULfmQAIL1JSMD1GnjaCZrl+Tex+XYzveRnw5g/aPfSHJFJx3552j5nPfeTVodXD
         1D2otpmOav+zBMUV5a9EFZMF0mobevhczDOWt6mkmFeWkWwmC89zbxuxLloCmhAb8VtX
         2USW7BOf/xM86oJ7OkpvRhUPNMez0d+55JK363UEf7uqzB6VCRoIdV6imZIl5IjbJ5tk
         ONuqsIWeBhXd8LUH6vX4kxeqbqDGGgjgZO61Tfe+O0nwyAMbc2TAkgQI/OlpdAQZCPy4
         Qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386906; x=1776991706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUBcOJvdzrg04mlLi/Lj3lm62FWLU6fMfvXH1a9ncMU=;
        b=rVPFC5sNy7JWwYIwVZrKR9rhnqugc4SRcKcWZtvEbmRkuu3Cw4gLcqI604nQQLKSsZ
         GNLSnoZJSgzlEixsVTaxKJTH3MSPZf0YPXS2YNBLRGhGrF3HZIrDsuWEqiNxIuz9rJEw
         KB2spwn5vry9G14jS9xwZJqv56PK7+DTcXKSW0UPWF1hh4HyC6llYSYl/+qsMyy/mhvy
         tBKRCDY8PlW0rCWiRNWXxI11hh6DUDpf7TyDJzrvOGPLUQg++2VL4csW+W5urMshc0wm
         VVjf5VDYTJsacFdoQ5Gl6ngLfVwEEIuTtnHrQ26BuXf6B2Jdnmyt9odlLkziLKbmckyG
         mi6A==
X-Forwarded-Encrypted: i=1; AFNElJ+7I2vD3/Mi9FqBUocu/vKLbubBAmKhW/oJB+wb4DfjcdReOfgsu+8jgRTeaj5gM3u61qjlp4OIjaHB@lists.infradead.org
X-Gm-Message-State: AOJu0YyXPAOHOJ54u2aaZ6w/wR5S5zhwc3f4YOY9q5GYJ1mZRjO2kZmd
	cY2CoQyTyIJ9BX+J1ZrEbXcxINmJFc2tXBzfp7Mj3CEVG0H17YD8WmYG
X-Gm-Gg: AeBDietcvN6oB/4MCuc4aEeRA8rA4/uNGCbCffPd7Ox6O9jkZ85M310vXwbjX/Pw4zt
	0vlBErvFW2n0/0emZjEChSD0eOjkUO9NHbCaLviwREyaln8YoqfztZT6t1L6d86LnNFsAbaMGBF
	Me0HZM0lMQeOj2rpiVarkbcbhTI626cT42a5+fNLDNsvZw/t6wsT1bbkheBw9tdDhT2so5kDMyN
	sr8JDB2/3d2WF80KuNe/bVQNNMXchRVTg7rpdOd3QK4pvDfAiqHtQVwTl4I2Gi/xZfqIyntA11W
	C5EYyzzoyh+5nJI0jeJau3Muoum+zyvLYmPwjsgpBVYPKYeeq1DpRXMxORn2G58WlZHT9Hc5fje
	CQJQ4NpLGlsmQlT9410rQJ4MsVnX0kHb2lZYxAgoAvcezDq3LyBFi1jENIy7I+AevRc2LajR12+
	2VUhIfGILqW/ysP8q2mP1agMCQfw3wPoyYeLQ5Lan/f9FzNsbuG1r+
X-Received: by 2002:a17:90b:3e88:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-3614048e396mr568374a91.19.1776386905830;
        Thu, 16 Apr 2026 17:48:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3c067sm1057345ad.76.2026.04.16.17.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:48:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	mlombard@arkamax.eu,
	linux-block@vger.kernel.org
Cc: alistair23@gmail.com,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication success"
Date: Fri, 17 Apr 2026 10:48:08 +1000
Message-ID: <20260417004809.2894745-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_174827_222536_8A814851 
X-CRM114-Status: GOOD (  10.43  )
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

In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
successful connections. This resulted in memory leaks in the kernel, so
let's revert the commit. A improved fix is being developed to just avoid
clearing the tls_key variable.

This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index b9ab80c7a6941..f1e613e7c63e5 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -395,10 +395,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto complete;
 	}
 	/* Final states, clear up variables */
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
-		nvmet_auth_sq_free(req->sq);
+	nvmet_auth_sq_free(req->sq);
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
 		nvmet_ctrl_fatal_error(ctrl);
-	}
 
 complete:
 	nvmet_req_complete(req, status);
@@ -574,7 +573,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
+		nvmet_auth_sq_free(req->sq);
+	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.53.0


