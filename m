Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AA3EE8018
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H36z8Kalw/lYouH43EXrAXGy396V7SSzwgzLFYBdMXk=; b=ZycjtvP76PO0N7CDgiPyIdnLAk
	+8O9fGEHK36x547HVd4+z+fXbaJGwoRaqCTd14a9X0LrBCgbpn2BloLHZe/K20CDZrQfJbb17I1KP
	wTzPZqfwOqte6wZznXo/1Kab20fCb9zz9DpLAWmNjb+wx8W9UIzSlJs7HTQhQZRVl2OS7Ip2fl045
	914t/FqWXALAB23g4iXd5Jt0YY9Y96YhLOZjglTWESZg6fCAgk33JGstJem68nrHai/VVHdhPcJ3T
	nf2GO1LCIF+RKvqbocrqM9HId+25EV8aRuvrXzkVz+o7Kbe3croYRSvxkBzSlrnU9fpn/3Fgnp+aD
	lC6ZfyGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qedpY-00E2Oa-1e;
	Fri, 08 Sep 2023 15:55:36 +0000
Received: from mail.archlinux.org ([95.216.189.61])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qedpT-00E2NB-29
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 15:55:33 +0000
From: Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1694188519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H36z8Kalw/lYouH43EXrAXGy396V7SSzwgzLFYBdMXk=;
	b=rd/7//Goy38Q0g8WTDBIp6yNzVbPWivRD5Z6lNhTVPs+R2Q4ZGybRV1K0fS1egqpxQ/3UR
	Lq7oY23OLhoKmNysoQm6BgpFZoW1mRdTf0YI9Md+v9Y7rw7ZaMZHope4UKhSv/xDL4PG4U
	KESQTsQLhrSIlpqc8VF4XvxU2NnkJzMjxGaR+RLnotwLuaq/s6I9Lp3+08e603kTMk9TBn
	2PMK1V0lTVpoKGrd92+NiDCcmOoPwVwZCkR33LrebJMdCHzRqwV/E2sAiqzK+W3PCONSMc
	x2coU1ISgPYz+7DsyNMvf/+QQ51dUJQfxlLBdZjtzr2FLqhd5GkeEtVC+FPlg4MHHqsho+
	fDk7kNqJmw5nyRY0nK7BbO3RcqEtFkjw4K2uoazoVKCYHu9PGnh9SDmWeIvlEyFvfkYFTl
	tJuu0DHKAP8gv/pTfunh9UqKgW03TI3RPX9NBrKYlP4pLxp/F6zKLj+oNR/habNjk0FRG/
	ElPZJjdLfd+T43xtuEThUZmhVcKH23sY0zeerTZaRv7mtTA1t9Mhn0QhRAuPCsrthmY5tW
	NLupfGx8tYB2Q75nDi+zmiFt4ztwlbVv5rECvtUmV+TwoZhIqqZq4I9Srlgk5vv/U9L1fP
	SF+4Bn2pi0zLDnuq/ld8R1IFa8yPHJ++h/2vOJYkUHI4lyQtRgvUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1694188519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H36z8Kalw/lYouH43EXrAXGy396V7SSzwgzLFYBdMXk=;
	b=zsHuWyCamE0OEQ0Gtpi5DeE0n++7lq+iqQnVeZpK8NIUtL5nWwOqu0VXd9QQIoeJOqhiQP
	wlyNOBOiw5dyd6Cg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
To: kbusch@kernel.org,
	highenthalpyh@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: xuwd1@hotmail.com,
	Felix Yan <felixonmars@archlinux.org>
Subject: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Date: Fri,  8 Sep 2023 18:54:42 +0300
Message-ID: <20230908155442.31423-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_085531_860877_9AECBB5B 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
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

NVME 2.0 spec section 3.1.3 suggests that "Software should not rely on
0h being returned". Here we should safeguard timeout reads when CRTO is 0 and
fallback to the old NVME 1.4 compatible field.

Fixes 4TB SSD initialization issues with MAXIO MAP1602 controller, including
Lexar NM790, AIGO P7000Z, Fanxiang S790, Acer Predator GM7, etc.

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..8ec28b1016ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2255,11 +2255,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 			return ret;
 		}
 
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
+		if (crto == 0) {
+			timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+			dev_warn(ctrl->device, "Ignoring bogus CRTO (0), falling back to NVME_CAP_TIMEOUT (%u)\n",
+				timeout);
 		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
+			if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
+				ctrl->ctrl_config |= NVME_CC_CRIME;
+				timeout = NVME_CRTO_CRIMT(crto);
+			} else {
+				timeout = NVME_CRTO_CRWMT(crto);
+			}
 		}
 	} else {
 		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-- 
2.42.0


