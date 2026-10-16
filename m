Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C979CCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=; b=Hi08Q731zZBvx8IAh6mVZbniZm
	08rHWt6jy2Kd579fxQir2MOloTUy+iVz0r6wPrW/LAXlVwELouYW+Eh37U3DX1ZDK8Zdw8wzIn/Ru
	oc51iV+yqjqTqrg5fns7EtRozfuPsDU8WPmzFi5kBYT2Cz+E8s0Wn6qUfPMZZogpqIXxxTWsDS9mD
	VAbwu1XApbZ4PETrMWRElQiV0lcixp5glEEuIcjV129CJoRk/MKxF3WIRx2FJH3NuWbWV4DmvTlgq
	Rn2FAyQvFYhA4x6kgP2MGjhpMwiwFPn/geSDcEJdRxu/sSrXPKIl6UIYbiHOT6dXN1ZCrzf9wODAC
	/KV/nt6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkBD-00000003KKk-15Yn;
	Fri, 16 Oct 2026 15:49:11 +0000
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkBB-00000003KKI-070r
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 15:49:10 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-6faddda49e7so65104eaf.3
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165747; x=1792770547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=;
        b=T2mtPl9tmfsuVsZDN9jXTaDtqUzpepXTSqT30Kt07h3Ylfgt3Q80MngmKVGnxBp+O/
         +h1Mjwi721iciI9oburFF7JPG2aO0kCRqIjcfsOulm64uXqDZzy8u5YSHxdMPR3J3bG0
         BuavKfkVeOOCxzjLo1aitbh/Uq7S5znYRwedlV3drPez0mKsfQPwM53vX0hdRVgSsgmD
         9KwMS4VxsLHfmqtei2KWtgVecJ4MTP9PI0D8W2etc+czxAAPIR5d4kjBcP1QlXUnEzTJ
         krek1VZgnYrn+ZAz+M1oUZC3eznr/9ayZsdfBC8ulW8flxRlU53R1RP7parD/I5E8+b/
         iIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165747; x=1792770547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DGvHsg3p95DZsVwADiFfgXPnEb5RStlDyPXgePKJCs=;
        b=hVqIRzkxKy78hVouCVxeoD7JnIC442Qbm8/SXkOOdp8z7gvlp4GpTXom883xX6kq+8
         X1GYHtjTc9lMTAVrany9zH5Z7l1Dv95ANVjWfY4QplRkxVjdF7d92Z+IPTdyZHphGJDD
         Z4XF7uPGwPM7XlYKyOV4Q5Ozv0An7wWq61EoOFQ8IxTVl6veooMjO/PnZOdT1FIS4OdF
         ajCrcvlUi8F75vflkcSGRb6zeKdEg8/i+E2wsQm2wFcTedlX9mnf36MYYjfWWk6undRI
         BzjZpjKFTaUX36pNCOQbwQl7T4HdtKrXMJE/Pr1S0kzA536PAbXo1HvI0XYPzDWLSw5c
         +XDw==
X-Forwarded-Encrypted: i=1; AKwUvBziJZdwc7q5R5PZvOON6ylroPavcgz7hvTgarG03LEIxo7Sa8WdU5vP8VmgcxRN0eOkW0OXiatpbWAs@lists.infradead.org
X-Gm-Message-State: AFq9FYJxvTnUzYn3cfGACo9o78a8bOp446nfN/l1hoIgcZnWsPvl9I+u
	Me3s9PGroYMlLYJ5vN9TvC0hhCibD0CoJVdhCHF49WWCk5Lis7upMAec
X-Gm-Gg: AYBFou1H35ydwazgmSYP5wUkqSfuhyD0hUKyVaqw2HccaVjeH0rhzzbh3ZvisEOlWFH
	mgr7sNmciCVor/MMKlaqEIIWVTKGlZCbfTNbN9k8hOxsqahu5qGb92KivXk7CLiu9llWhuwbzDw
	2zkXCvrc9Z4rFh3SMdBCJGLwVkQgQ4ThWJFCDzqWHiAUDAqqb6kw5lpjgnzuVWuKG1GI/1c9ws8
	SrqtS7S1TFTlW1Ab+54paLq/1vLvBMHWd+i6Ta6AwVL9lLCGpSUlFjuOB4GtNUBWe90VgvmIujd
	Cyn9wYIzh5Kzt3qNfK+aIpcz3YJ4YMjf0aJ4Z506lPRtKjfrallDsJhlli3zkeFahf8pbY7kDVs
	0fxlchpq8m1qObhfF9B1UNgqe5bWI/2BEBues7TnhYpFS3u6rchIDMDh4vvyvegc6UdH3/IHYkT
	yg3+u1KtJzRm5iC7NdUGR/f+BcuQ0ju+M8FFjqj+3AUZSoCwRaGfpjrEfocino044qF5mpDaKmq
	XnLKHNpG1lBG9EtezOwbvjlmSnzTapeGe0Yu5Co6BGCKXS8/Yc=
X-Received: by 2002:a4a:e904:0:b0:6cd:3ffc:acf7 with SMTP id 006d021491bc7-6ef1049f172mr15635413eaf.71.1792165747551;
        Fri, 16 Oct 2026 08:49:07 -0700 (PDT)
Received: from casta ([2401:d800:20b:1196:6a2:5930:14e3:f74b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a55ce9c6sm2084083a34.15.2026.10.16.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:49:06 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: justin.tee@broadcom.com
Cc: nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>,
	syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Subject: [PATCH] nvmet-fc: skip port entry rebinding if already bound to a target port
Date: Fri, 16 Oct 2026 22:48:06 +0700
Message-ID: <20261016154807.9544-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_084909_068642_BF1B5CC3 
X-CRM114-Status: GOOD (  10.87  )
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

In nvmet_fc_portentry_rebind_tgt(), nvmet_fc_tgtlock serializes access to
nvmet_fc_portentry_list, but does not prevent multiple concurrent or
duplicate target port registrations from attempting to rebind to an
already-assigned port entry.

When pe->tgtport is non-NULL, WARN_ON() is triggered and pe->tgtport is
overwritten, leading to kernel warnings and leaking the reference count
acquired by nvmet_fc_tgtport_get().

Fix this by checking if pe->tgtport is already set before acquiring a
reference count and rebinding. If it is bound, skip the entry to prevent
clobbering existing bindings.

Reported-by: syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be62d4b375542ecebd17
Signed-off-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..9b7fd8f5bd47 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1324,7 +1324,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 			if (!nvmet_fc_tgtport_get(tgtport))
 				continue;
 
-			WARN_ON(pe->tgtport);
+			if (pe->tgtport)
+				continue;
+
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
 			break;
-- 
2.55.0


