Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110F6C79F99
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nnDhSP6bczUTSkcaT5CjAbh23zZRgnhTqPeZ+Pxp09E=; b=0qSabyWe6llZCSECrMxJrLchd1
	2C9kRMD9ddW78Fh1/EJ1N2g1eS+NrlSMkekGYfflbuGckRzK4ZSa9Cko7k7hcyj9S22V432t6tLuB
	sYncFwtP2qpaTDMFYBOS0cpx/ifCMTNDpaZ+Sga6EucNZtdlS5ho090qYdHIHiq+PN64zb7AHBD/S
	jbu9JThHd9sMTKaXjF8wW28KLcopqA8mvRvhSUzXmOFFX2F0I3BD+28v9NCTzldrJqvojBojwnmG2
	YtEyz+g0IH8nMCRd4qt/aGUqNOD1/kG+9prynpLRp1InzDEfuuy3eV6L9drO/t98MGzmCZrYFnoVq
	3TohBqJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41b8-0000000A561-00Ej;
	Tue, 08 Sep 2026 19:35:14 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41b5-0000000A55M-13wx
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 19:35:12 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2d94c868ea5so50042515ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788896109; x=1789500909; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnDhSP6bczUTSkcaT5CjAbh23zZRgnhTqPeZ+Pxp09E=;
        b=PTwrGx7OYpwmBXZoWzORAE+i42qwersiYr3/mIpW3cElku82YcBmNawxRqODHmHIU7
         gLGXkjro/x471vUqttY1Qr5Td16Cxu78qU6mXuFlv3B47Ur9cZ3CqdQtT3l+UlU0NF3L
         KvasdzxKnpCr/6j1YO/CkI+2EJxvSCSkgFmJPExDbtXAtNGSpdQwWxc1w41UuORWFGej
         DF+2bfTVKHxXN1ttTNJ8m/QueNrN6vSwSUJqL912RBqiyIwY74dtqPF93kHGWCFHkNFj
         14f/YjRdNF7L/JWt9xKuIDLGHuuY4k1m/pnq3Rymy9ae7XygpksgPsR7FIAYEyZqIsoN
         dkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788896109; x=1789500909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnDhSP6bczUTSkcaT5CjAbh23zZRgnhTqPeZ+Pxp09E=;
        b=hljZOagPVTNLi77s8PaRN+YmxV4uVzruR8T/olNOMpaGINRFRKDJ/uaAaMdGT8mZ+w
         Dny1HdEpZIiIGuKolUlJCKezW+S8n50/MX3V+B/aIhtqWT8OsRcY4Z1PSkUSvIn8nYsW
         LGCR5UcpXKVardOjsmvxp5YSFFEuWg/mNbgHpluDaImvg4QhCKCEKyzHRoU8B6DPlkXK
         CiQHMRXZwQj8FEHnWgRxVbNWR16r/nR2H3xDDGOtMTPUFqKfvKny6ibV+AbdcIB53H77
         j0e28rZidXptls1j9Zat6fDFRb6U91+QyNvlxNCG6yx9wpP1x3QN297zrF47oUk4w7l2
         E6xA==
X-Forwarded-Encrypted: i=1; AKwUvBxEz4IAfgWIP6yJ3Vzt7Amb8jpckg87xQZ734xh1euZqOr2TkKV18t5InA3bIwDpNpdwIUCGPhPoXIR@lists.infradead.org
X-Gm-Message-State: AFuF++lE4XIp3HMZe7M3AVOIrdF5t6gJlSsPwdmGRQCT/MZ8I1QK6/oF
	aXD5Espc+KoFiyC1qmqAegP8ycfHThQ052X7Ehak/KUwDDKLEIB3XLnt
X-Gm-Gg: AYBFou1uvqo2l4bqhMD+YT/118c79tEW61Vurg4shKjheUsqHgUtxCh/EmkA4GLONee
	kFkdgyjgxObY9d/4/Xdif58E3F3UCH5c7tUtUPCwoP+J5GsroVd0P5UxtQCpBaGhLSCva24dB2u
	0K5DnKyKCr86FbBexQq2KxIqb4tJlxfej3aIRfS+VlQQs1Zv7fpSmZpxd/Ncx/UGAmqM/1RuGLz
	G/2GEf1XxSGBcYsGeTxzH0LNe7NPUP+RuzFFD35L1+vg4hh6qgwmz2t8N8DwQK7cSGX18kpZhwF
	km05B/bJtpR8pv4Zkm5RI+PQyHZD6t0un1x+GgPOc/0wiFj2CZZ8nFrj7mCvIKw1h7bWBMtyMxv
	laTfWdDdUr1ZCbRBKBAeR3rJznQRq0qjgqvT0YotFP85wBr4FwuESaWHJDCHyeatqrSEdDrovHl
	Txd5Qw4HQl3lRpITX1jIQITdGV8nceM7Kqo7/VUeaMzWyLD2Xk9SoV8Be62vMxeOtQTCOT5g==
X-Received: by 2002:a17:90a:1189:b0:39b:2c55:365 with SMTP id 98e67ed59e1d1-39b2c55287dmr26428765a91.12.1788896109392;
        Tue, 08 Sep 2026 12:35:09 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:4b36:fe93:5f92:db19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd2aasm27319660a91.3.2026.09.08.12.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:35:08 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>,
	syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Subject: [PATCH] nvmet: validate device_path before enabling namespace
Date: Wed,  9 Sep 2026 01:04:52 +0530
Message-ID: <20260908193452.53347-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_123511_334599_612F5509 
X-CRM114-Status: GOOD (  11.27  )
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

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When buffered_io is enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
without checking whether device_path is configured. nvmet_ns_enable()
then falls back to nvmet_file_ns_enable(), which passes the NULL
device_path to filp_open() and causes a NULL pointer dereference.

Validate device_path before attempting to enable to namespace and
return -EINVAL when it has not been configured.

Fixes: 6f6d604b4ef8 ("nvmet: allow bdev in buffered_io mode")
Reported-by: syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c46a179b56c651c4c96
Tested-by: syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
 drivers/nvme/target/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f19..336013139ef6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -591,6 +591,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
+	if (!ns->device_path) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.43.0


