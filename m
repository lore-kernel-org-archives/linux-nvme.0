Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44714FF886F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWVPzbJ+hzRiSpfV84BmI6t4Bdsj7asQyGKFmRfvROY=; b=zktNtIkFS7XJHHSAsuEf9TbTkK
	rGuTLbKnUU3z/pq/aUnO95hzspnwPHKDgwou+agZxjYV6bcm/756eTpW3ai88yzOvZSXvjkDNCvo8
	1MD1wgyyYaWX+tejkmONetXGPQrUECS/Gv5J92iBgHN6Wm7S6MwrOuJLsCSU9aK/M8fwzAY8i9qKa
	lInsLJvr/8wnd4SFiQs4y6oXgN+jUpuG5SGGgIWvilBLp0sxJg+YL98KaLK9+GrUboBTrB/zIy5lx
	ErUzA0m9L0FsuFB7UYQhVIJwyqH0ytdpE/bnnUeURdWh44X4agF3gO8sbY0O6JWrX2bqWXAt8sJV8
	Xdai8oig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapb-000000066m4-1g4C;
	Thu, 30 Apr 2026 23:30:07 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapX-000000066ip-0PbV
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:30:04 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso16679155e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591801; x=1778196601; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWVPzbJ+hzRiSpfV84BmI6t4Bdsj7asQyGKFmRfvROY=;
        b=IJyIeDUtrl1KtT9krRkLH6XKh4o/ugN0qjRw8HTdKaWHkJWia+VzwCfC+BS34h7TLX
         QFGZYN+O7jioOilc2+5QxH+hObcysjAwUvykS1vxdY/Pt5CI9fZsVr6LE6MswzI1sADQ
         xNHfWUs1a9npqxVLY0Ezthauv4/2uR/Cgxtnasqsv2cNSC6zgmLJVBWybdm1/06lzsc2
         xH9v3nLVQS0sUl2jT5m5//4JKaPjq1EKiBYLEqAaDy4LeVN3LRDcKZAHh4TMsDRX0UZd
         5m2dUDuUgOxkJnLwr7pXUsi6K+Wx5XzLCYUnjuFBQaD1hrzhhJ/gFw9hkH/A4BBpk+B9
         XQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591801; x=1778196601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWVPzbJ+hzRiSpfV84BmI6t4Bdsj7asQyGKFmRfvROY=;
        b=F21GdV+QAjNaPbDHssLzMJDX5KiZchicQL4P2M9oHbAnnWdfOswlPIShcIQGTM0Hcr
         eOH1z0ow5G6gaM7efKqPde+gU/xNxfcTr/3Kh9fxcmOp09flcvoregcmHS4adUI9njAB
         3eZczxT9L4b+i9/lz4sfBTFmCPL5pg1ECC76LyVD+Ok6jIl1fGCXCNALML6Hd5oWBEsv
         uulnpUUpB202hZkCIiQkRKmLhjA1iA6439T8O5FSXwy/wvxo1slB3Ui/iyhTlGuVUwil
         HpU3eMzYon65n4MLKqzFCMsDczI+SgM5vcU0YDOLcE7kj8z/L9Jucz9rOg24HpigmgNL
         oqxw==
X-Forwarded-Encrypted: i=1; AFNElJ/H1vlfU5OfXy8bm3FQnLWmeayQ1oNzPjwmmPCHGD9jCnqTsvTgQF7GRrygonQZQhkZr7aHchEVnv/6@lists.infradead.org
X-Gm-Message-State: AOJu0YwExvGyyBn24WlpPBs5JEAaKT50P+iH5DIcRECeIpLQBFESXDTP
	IAKsyPAZQEIdwPoW+ZwRRR7uRCYIQx4JKAVfNs9gl8GVzuBscixlG+DtDJRwFj80Psw=
X-Gm-Gg: AeBDieuQ3Db3dypZ5BMbziS8aVICauYVjObqDmF1Py3Km78oinHAKzLm1hZV9dbD3XY
	aErHHVMsmhxV421jOR+GE+KmTj9PuBjgnHhbRXyrxFMiNW4Nu8Ct8X8cyGhSaKD7zyVCfZkBROi
	7gTHShhR0XExOAfdA8uvXBFkgEu1Vs1iilPCMLMkTqp0hdw1VkOlUK59qZmYcuYhZ7NNYeSSLT+
	Jt2szYSSXVmDLkNA5ej7ArRD502850vU+yTAcW1dAcGKG9XYbIesFbzbgp5/e+LxgYS0KTn0Vff
	hrCzIplY0p6vf+cOY2acijUTiBPGwF+dTaMiWZh3X/IFIHPaX1JzExlFqUjJPMoXPXGK/CfchhH
	OXGqaQOVJ8IsQzV/4oewTQmmZYcRV1zre9I6c1Tetzd5ZtyK5f13me49OXE6NulGXzZyckKBM9G
	iEfTS2eq10JYdvv7ND5hQCBq6ysF/eDIGq9KH9n7OJe2BJryGmodVWfRoyH/sYo4TCvmWWC7RUT
	e351KxCFlxY5VrfYBHnW3YZyYnGzcWK6Vqfhhy/j+w52TGlj0M=
X-Received: by 2002:a05:600c:5253:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48a8446d877mr82270025e9.16.1777591801236;
        Thu, 30 Apr 2026 16:30:01 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:30:00 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 6/7] nvmet: kill nvme controller when fatal opcode is received
Date: Thu, 30 Apr 2026 17:29:12 -0600
Message-ID: <20260430232913.129271-7-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_163003_142917_1807253A 
X-CRM114-Status: GOOD (  10.08  )
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
 drivers/nvme/target/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c5028f1fc458..866c8736b60c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1909,12 +1909,19 @@ void nvmet_execute_request(struct nvmet_req *req) {
 		return req->execute(req);
 
 	if (ctrl) {
+		if (req->cmd->common.opcode == ctrl->fopcode) {
+			delay_msec = ctrl->fopcode_delay_ms;
+			nvmet_ctrl_fatal_error(ctrl);
+			goto delay;
+		}
+
 		delay_count = atomic_dec_if_positive(&ctrl->delay_count) + 1;
 		delay_msec = ctrl->delay_msec;
 	}
 	if (!(ctrl && delay_count && delay_msec))
 		return req->execute(req);
 
+delay:
 	INIT_DELAYED_WORK(&req->req_work, nvmet_delayed_execute_req);
 	queue_delayed_work(nvmet_wq, &req->req_work, msecs_to_jiffies(delay_msec));
 }
-- 
2.54.0


