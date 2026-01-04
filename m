Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E68C2A069
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xOuESBykRjwInDeyHixzVLD+QYGInpmQJHsDXEQedTE=; b=r4geqPz8GorlI0Oaz2j6XxZ82e
	1uvAjkRYBpS9Vsye2HR9A81MaSN2tctpKGv43y4RXk+2PLZ4g0QENQkQDjMK1yqRAG8Xa9OGAclxa
	738DWx4A4rCA6dmn54BZMNFh65ize49GWtFj0vgUiZjiv0VcMeH/IqLOm+YgUvPSLy8YqQpX1fs6K
	QaaP+F4NR+jyyk7MH7hmcLPAWY7/bLnStFnPT8V80BETODcnQ8PfJA/Zwrs7Hq2vBcWa0cq0dYJ9x
	EB0UTTH3bYvyoeMAMuc8jlqfSTr97A9t8va0f40dYci0kQRiXZxTal+x2H8ixOmgzTeYVsCAzIhjo
	iIaEdXMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcCLs-00000009vBz-3Nj0;
	Sun, 04 Jan 2026 00:52:12 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcCLl-00000009vBb-0HkF
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 00:52:07 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso160595875ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 03 Jan 2026 16:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487923; x=1768092723; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOuESBykRjwInDeyHixzVLD+QYGInpmQJHsDXEQedTE=;
        b=UMIZ+5pMYJl7Mb58/WDDG3LkZ9+8oOHfIKyizCNpZuzoSrEo+FqQEkO+dXgfcMq+1m
         T2xHuC94HXQAdM3Mx8IySQvw4z2Jv5flro/C4q/yFUzhLA8J+DHpxRHlW3y8kVhaJm/I
         JIydAjLMGbw2VODQwn+AtnBahsLMXBEBHYCDMJqhQrkLEGHS/PIlzjPRtHj4JBByoMBe
         CSW5MlS4n/knX8Pq7qEbqYCEGALW9RVKrBsKULWG/oqAR656yDKo5A0Jz9D7AkTfiIl3
         zBqntlppE25eq9G/M+Keq25vwoFb5OtfAbP5fj+6j8OlTY9pvuWRmrYRpZ+1KiIOBz7Q
         8XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487923; x=1768092723;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuESBykRjwInDeyHixzVLD+QYGInpmQJHsDXEQedTE=;
        b=gLTGHxPTNrrk8j0Dc2yU4Ts16aVyrkeO/skJWSDINkw1SulAn6Y92CZLZTRHF3LQYW
         4kevbuOGErcWpoMYTeC7iFpTJEtEePZu6gdMMhYmDp1wkIFvoN/tGtoBCHlRKK5FVe2a
         iGQZ7u4ucp3OW7AJHj2+HEsK33PRH2LkxE8PQU8lnfrR2QCHzaAcUBYY9USY53dmhDeZ
         JvThUE2xTL0ngPs3rF+2G4iRQDrtPYHUJPQPaeD+4HmmiU4XmiXTB+BTOxxkNfYh6nOO
         r/CB5ULDU1tn+2m1HIrBrfsjQwadAPjmRaltJE19zeItwos+m+BVjkgHZkMWYPHU1ZYl
         PDaA==
X-Gm-Message-State: AOJu0YzqI07Xn29MXhykQLrUqlpe2l3t2ck1exIszscGmm0esxByzi41
	Y/B4OVo4MwgCTkaaB3k+S27QBpzARi4RGfm0efOe2KeOV/gxrfBL3qe+
X-Gm-Gg: AY/fxX4s05/45Z7H0dJRKyCaCgiUyPnk20Ld55aCZfl/H1PqSAHzcP6RGEVJPW6PB/7
	g+LJrb9+vnNRBarKPw6fIxwBnYk5o+XBZWQSalHxs1qxEByJlQH29CigEvKj5cCKoVn8FNOWkex
	FaDltIMZlHoCLKGY+1S45UWpgwck3jrvEzyasx0AXw965jtSMcdFiWrzgqPs+5vWl70XWyOVdt2
	QiB3t2AhGAIRj/gc0o6QtrTSYklJnEe0AzdznxcttdlzZ3wM2LqR2s3l01SHN1Tn43MZ3Vp1pQb
	g29gcW2MweXMU+b997yH3zbnWHENFunV4bhgHsbPwdLsHbh3CotjrCYIlgyOZjymjHuIeSqjDZP
	HZ3WSXF/cK1AcIIW3LWa5LjIoYha5i9d9kW6DiBPwQ20p1DFWdUvK6XF+yOXMpq/zY+BzRVUO79
	fLgETUJQRuOUu9WHQ=
X-Google-Smtp-Source: AGHT+IEM5YAVp1hO4jI8G+b/4iCizVJHAgrtd7TCV9On/0SPTxyMk5C5L+hZm5jw6QCdCoo6CaArJg==
X-Received: by 2002:a17:903:2441:b0:2a0:b02b:210c with SMTP id d9443c01a7336-2a2f2208e65mr421259995ad.1.1767487922746;
        Sat, 03 Jan 2026 16:52:02 -0800 (PST)
Received: from [192.168.1.83] ([61.71.57.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82a10sm409701275ad.26.2026.01.03.16.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:52:02 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sat, 03 Jan 2026 16:52:00 -0800
Subject: [PATCH v3] nvme/host: add delayed retries upon non-fatal error
 during ns validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-nvme_ns_validation-v3-1-c9ce67393261@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK+5WWkC/22NwQqDMBBEf0X23JRk07Slp/5HEVl1qwsaJZHQI
 v57U6G3Ht8w82aFyEE4wq1YIXCSKJPPYA8FND35jpW0mQE1OoPolE8jVz5WiQZpacl1ZY0mfSG
 61lhDHs6Bn/LapY8ycy9xmcJ7/0j4TX+68z9dQmWUZlNbMid0zt67kWQ4NtMI5bZtH6LV73m0A
 AAA
X-Change-ID: 20251225-nvme_ns_validation-310a07aa8b2b
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=Cmmmomj8lhHqur2QMx2mor83y6/OVMYkXUWMVB/Tmio=;
 b=owEBbQKS/ZANAwAKAXT5fTREJs3IAcsmYgBpWbmyrRM6uJeouHP8gKRBMipO5IqvBgyoSZQAa
 2mS+CmKMkiJAjMEAAEKAB0WIQQAohViG04SVxUVrcd0+X00RCbNyAUCaVm5sgAKCRB0+X00RCbN
 yK2LD/9QzRtiQ0VrzSGxW6r4k89QDB3aDqGnWajqOBMpVu5HJ+clfTbKqwtMB305Dug6OXiQjvk
 NxnVECJ9fFqA98XaVWVgWDvu9tzOJ601l2cZjNQyXvqQePtujt3F7Jpf8sWL19Ia30m5SMkB+Qw
 zuKm2Vl7wI9rPxyZdgK3VNgBfyVwYrYi31P9FSuruznX8Xxr5Cn2QTRm4KCdUXPCoV9/oH7F3Fn
 rdcYNyv1B8sH0HBWDFhcqy9UZQhfQPGR9UhlqgrxXellgy17CDxpaH6NyU5HOFSUeDc+d7JIQHH
 rh0Km2cG03vz4Zr2yErixNOibYm+Sr5bLEUsrZPXeAQT5fQ6HruCU9A5+NzBvbwh+vOW8u+sVZX
 iD6FvTxXzivIxNHf6ThBl25M9Dz2OpGAoKGKRdLnDdGelcC8BWBnQQHbPwXqDuoF0dfmactDvjj
 v1Ae46NKJq/rG09IbhP7vQFelyvSlxq22d3sbDmaLPp9jcVzgaKWiAmeJAPvVkBor7dI5YMjPsx
 OHOXgt2LuN2LH15jr0xlWvcGTvKyTvCvi1Wln+f1623Bw+F1w4DjAU/buhOL9dU1MXIRokxUv9a
 OBWki/z/oyMx3sbZFWKYMwRxAY5knr1LMSgI+FE7szMlD4XpJ/PYiPmRGa+owWjTb+562xEQDKX
 aOwH9uhC/UctraA==
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260103_165205_412680_61D30F7D 
X-CRM114-Status: GOOD (  21.75  )
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

If a non-fatal error is received during nvme namespace validation, it
should not be ignored and the namespace should not be removed immediately.
Rather, delayed retries should be performed on the namespace validation
process.

This handles non-fatal issues more robustly, by retrying a few times before
giving up and removing the namespace. The number of retries is set
to 3 and the interval between retries is set to 3 seconds.

The retries are handled locally. Upon success then end. Upon fatal error
then remove the namespace before ending. Upon non-fatal error, retry
until the max retry amount is hit before ending and removing the ns.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v3:
- Simplify retry loop to i < NVME_NS_VALIDATION_MAX_RETRIES
- Use dev_dbg print
- Remove ns when still receiving non-fatal error after max retries
- Link to v2: https://lore.kernel.org/r/20251226-nvme_ns_validation-v2-1-0e1b3a142553@gmail.com

Changes in v2:
- Simplify retry logic with local loop instead of delayed work.
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f1f4d0b3c570de285a5eb17bb08e..ed28abb6462e46ca1203a6a8b16894d36817db2c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4289,23 +4289,38 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+	unsigned int i;
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
+		dev_err(ns->ctrl->device, "identifiers changed for nsid %d\n",
+			ns->head->ns_id);
 		goto out;
 	}
 
-	ret = nvme_update_ns_info(ns, info);
+	for (i = 0; i < NVME_NS_VALIDATION_MAX_RETRIES; i++) {
+		ret = nvme_update_ns_info(ns, info);
+		if (ret == 0)
+			return;
+
+		if (ret > 0 && (ret & NVME_STATUS_DNR))
+			goto out;
+
+		dev_dbg(ns->ctrl->device,
+			"validation failed for nsid %d, retry %d/%d in %dms\n",
+			ns->head->ns_id, i + 1, NVME_NS_VALIDATION_MAX_RETRIES,
+			NVME_NS_VALIDATION_RETRY_INTERVAL);
+		msleep(NVME_NS_VALIDATION_RETRY_INTERVAL);
+	}
+
+	dev_err(ns->ctrl->device,
+		"validation failed for nsid %d after %d retries\n",
+		ns->head->ns_id, NVME_NS_VALIDATION_MAX_RETRIES);
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
+	 * device or if a non-fatal error still appears after max retries.
 	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
-		nvme_ns_remove(ns);
+	nvme_ns_remove(ns);
 }
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c5c42777bd9309a983ef0196c1b95..dcbdc7fa8af0cb838b3f1a774d4c67fa69a00050 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -46,6 +46,12 @@ extern unsigned int admin_timeout;
 #define NVME_CTRL_PAGE_SHIFT	12
 #define NVME_CTRL_PAGE_SIZE	(1 << NVME_CTRL_PAGE_SHIFT)
 
+/*
+ * Default to 3 retries in intervals of 3000ms for namespace validation
+ */
+#define NVME_NS_VALIDATION_MAX_RETRIES 3
+#define NVME_NS_VALIDATION_RETRY_INTERVAL 3000
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;

---
base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
change-id: 20251225-nvme_ns_validation-310a07aa8b2b

Best regards,
-- 
Alex Tran <alex.t.tran@gmail.com>


