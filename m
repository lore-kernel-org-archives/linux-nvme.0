Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD383CD3424
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lv+ZGd3EhDURuWvaLfctXiyHqPTyN6wojg6rj6QBPCE=; b=33S+XRzOsI/lQ797vZOKDhhUPk
	o/fsbaeLAA07He8tzIwGMff3cc0NPpMzDmr6wmsfh6/GwKkjgHyc3lpydkGSif8OLkY8gClJuesyD
	HCbzOE7QAZdQTPlxClXMaL8aBtVNPdd3RDxtB67Ry6+5+xTc896q+wwOPXlpUQT4XpK1qUUYJNn4B
	GXXgdOtbXqDJNM4nDkPQGrXEHbQ7bQKfsblWKd62sIqw7qK1xR8fCnIxNglBkl8sYLpy/edVvl4Iz
	u5BdwYUzy9Pn+J2hlnI7V+gLeWPqoMR14C2i0wtSUlQQsv7bDZ/8rnJaROtvhX4Znuc2jdWXK22Mp
	WPV7ILnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapc-000000066oW-34dt;
	Thu, 30 Apr 2026 23:30:08 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapZ-000000066kx-1Mor
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:30:06 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so14388015e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591804; x=1778196604; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv+ZGd3EhDURuWvaLfctXiyHqPTyN6wojg6rj6QBPCE=;
        b=gtXb414i7gNqHArUpygYJyOAtazKtitZfJotmGNymp37rmaVVRiR0kL9ZEKBTQR8tt
         wFwawKacB3YFUaeszb7jkgT8/G6dP/+VdZFW+/rwMGsugHj29Fx7G/0gZ7/FIkkAj2Vl
         0nAz/tEzAvRBn7yIrgjH5oewMIomD5c8i9eqMCqcYn4KU4u36zPySb+YyQMEZNUwjDky
         0iK+4hKjJfD8Phw+6p45RRHDEZ27ClxYDWl1C7jJ5hpZIpLTMvRKWS9k/dkTxO5fWvYN
         5f2Pd3Ohfg9rITOtsn09Tm5yTUygNoyoHoItKF10qb3yT0likPPklTtyocxpeJS5EzhA
         xLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591804; x=1778196604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lv+ZGd3EhDURuWvaLfctXiyHqPTyN6wojg6rj6QBPCE=;
        b=Q05viKYtcdAnlaM7SbLh3xN4QcdXShCBsMdrANkREvt4h35/s6GiIGHFbK7Or94VRp
         PfWy8dERICBGQNMB7Uao79s9WM3dWGNhp4rDTJFcOxO6NRyZzz7rL7VYtt5Z+XRmNPrE
         oOV5Yomp/a48rO2UCO5IYoTkI9SGPkVwPLsMYMszxV0LA+0Tg+2co9MD2+Mee6B7eHkg
         rFLxpurbEIwPk/m4OfziYAYzqIVR/obfq5s2msn4hqiLlzLTPhDJrssWGQZlCcP6LHTN
         i+KEvORFKULRaQtQNuebKL2UneX9P7ukEBATKAjPkSa0bfh86dqp/gSdaDKSNT4Do0XG
         Y8SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ph+o0myTOCvywmo2zPYto/Am/7gau9/vTemAm3JYAn1xdjJITbRpOuuDkyPKmxy3OzlUJeLgPh96c@lists.infradead.org
X-Gm-Message-State: AOJu0YyKRPLX85nlSzpBrDQCrLtVsCRM8L+iIYPzZyP2izAESrRQYS7t
	THqhcHK0VoGZb+AlkZ4ojraSzFHJnB8AoaVmuK50lVxwDwXNO7omlC2wdSVUprokmMM=
X-Gm-Gg: AeBDiesHr3ixp2ZuDzWlfdSWjVJibyG/BfUEaHijn0oVZrE1ueYzODESef5v8eRGJU2
	voOqg7h3ENU62hkhPs+F99CQ1nRexLSnjABdsqCM2uWq33ITQ5qVMb11sQRihRnbtY+dVR+41uT
	SdlCEyH6Tqp8wxghrhjmtOX6TtNhzy/Ab6DfnhTySYGDnDVDaMu5hGYq7Sn8j6+cdJK/AA6aemr
	HJHQLYnCnTrXcXMY0hHUDUEpUveoAQhhtBwbO4JbDoXpXFkISamP5+Bxh/lB8XRrN1R067PAKLP
	qmt8SJNZIC5PPsHsHkkTqU0S9u+aceHLHBFhlnZebT964THx/ZPvD9hI8izqrszBlwDr5xyeKPh
	0HaFPEZYJ528EuuVgpE65+1VArdiN5Rci9DwHtlGMyE7VWF25m7Olx8Mvy3LPzOV0br2hScQ8Fv
	oNGva2nGeLxMwzoqF5PHxakiMYjXjLuVyln9F/x+Gs1uft8C1Q0txPSszmZXgpHeYEaXgxmlzIo
	l7cpxNZQK3YIki9fK3zm/yz3EHTjGKEOGd4WbNpJqKz0lEF/fI=
X-Received: by 2002:a05:600c:19c9:b0:488:b749:8482 with SMTP id 5b1f17b1804b1-48a83d66bb4mr79988745e9.4.1777591803658;
        Thu, 30 Apr 2026 16:30:03 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:30:02 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 7/7] Force CCR operation to fail
Date: Thu, 30 Apr 2026 17:29:13 -0600
Message-ID: <20260430232913.129271-8-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_163005_384318_298AB0EB 
X-CRM114-Status: GOOD (  10.60  )
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

From: Mohamed Khalfella <mkhalfella@purestorage.com>

---
 drivers/nvme/target/admin-cmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 53ec682f27b0..04369ce79ad0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -626,13 +626,11 @@ static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
 	mutex_lock(&ctrl->lock);
 	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
 		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
-		u8 status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
-					NVME_CCR_STATUS_SUCCESS;
 
 		log->entries[index].icid = cpu_to_le16(ccr->icid);
 		log->entries[index].ciu = ccr->ciu;
 		log->entries[index].acid = cpu_to_le16(0xffff);
-		log->entries[index].ccrs = status;
+		log->entries[index].ccrs = NVME_CCR_STATUS_FAILED;
 		log->entries[index].ccrf = flags;
 		index++;
 	}
@@ -1725,8 +1723,11 @@ void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
 
 out_unlock:
 	mutex_unlock(&sctrl->lock);
-	if (status == NVME_SC_SUCCESS)
-		nvmet_ctrl_fatal_error(ictrl);
+	if (status == NVME_SC_SUCCESS) {
+		nvmet_add_async_event(sctrl, NVME_AER_NOTICE,
+				      NVME_AER_NOTICE_CCR_COMPLETED,
+				      NVME_LOG_CCR);
+	}
 	nvmet_ctrl_put(ictrl);
 out:
 	nvmet_req_complete(req, status);
-- 
2.54.0


